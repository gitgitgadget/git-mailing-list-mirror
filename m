From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 22/27] struct ref_update: Rename field "ref_name" to
 "refname"
Date: Wed, 02 Apr 2014 07:11:09 +0200
Message-ID: <533B9BED.4050509@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>	<1395683820-17304-23-git-send-email-mhagger@alum.mit.edu> <xmqqha6czuzu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 13:50:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeIP-0006sp-7S
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755658AbaDBFLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 01:11:14 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49684 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752039AbaDBFLN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Apr 2014 01:11:13 -0400
X-AuditID: 12074411-f79ab6d000002f0e-30-533b9bf05498
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 8D.14.12046.0FB9B335; Wed,  2 Apr 2014 01:11:12 -0400 (EDT)
Received: from [192.168.69.148] (p57A25BD8.dip0.t-ipconnect.de [87.162.91.216])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s325B96V026026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 2 Apr 2014 01:11:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.3.0
In-Reply-To: <xmqqha6czuzu.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsUixO6iqPthtnWwwadma4ud6yQsuq50M1k0
	9F5htph3dxeTxY+WHmaLj50LmB3YPHbOusvucenldzaPj8+Ws3s8693D6HHxkrLH501yAWxR
	3DZJiSVlwZnpefp2CdwZTefaGAu+cFWsvsPSwHiTo4uRk0NCwETiTXsnG4QtJnHh3nowW0jg
	MqPElhtCXYxcQPY5Jon2AwvAErwC2hIHlrxiBbFZBFQlZh59BmazCehKLOppZgKxRQWCJA5v
	OMUKUS8ocXLmExYQW0RATWJi2yEWkKHMAqsZJZZOmQE2VFggXOLRrSZWiG1rGSXWbwM5iYOD
	U8BaYk5vFIgpISAu0dMYBFLOLKAj8a7vATOELS+x/e0c5gmMgrOQrJuFpGwWkrIFjMyrGOUS
	c0pzdXMTM3OKU5N1i5MT8/JSi3RN9XIzS/RSU0o3MUJiQXAH44yTcocYBTgYlXh4D5y3ChZi
	TSwrrsw9xCjJwaQkyts50zpYiC8pP6UyI7E4I76oNCe1+BCjBAezkggv5ySgHG9KYmVValE+
	TEqag0VJnJdvibqfkEB6YklqdmpqQWoRTFaGg0NJgnfiLKBGwaLU9NSKtMycEoQ0EwcnyHAu
	KZHi1LyU1KLE0pKMeFD8xhcDIxgkxQO09yrITbzFBYm5QFGI1lOMuhwbtq1pZBJiycvPS5US
	570PUiQAUpRRmge3Apb4XjGKA30szBsFcgkPMGnCTXoFtIQJaAn3OiuQJSWJCCmpBkZtyX2F
	25/2O69LD6yr69v+zlg+30mstGzhqikntf0Pf9LY/f+03teLHM8NP1UyzroZPE1S 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245723>

On 04/01/2014 09:53 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> This is consistent with the usual nomenclature.
> 
> I am of two minds.
> 
> Looking for "\(\.\|->\)ref_name" used to ignore refname fields of
> other structures and let us focus on the ref_update structure.  Yes,
> there is the ref_lock structure that shares ref_name to contaminate
> such a grep output already, but this change makes the output even
> more noisy, as you have to now look for "\(\.\|->\)refname" which
> would give you more hits from other unrelated structures.
> 
> On the other hand, I do not like to name this to "update_refname" or
> some nonsense like that, of course. A reference name field in a
> "ref_update" structure shouldn't have to say that it is about
> updating in its name; it should be known from the name of the
> structure it appears in.
> 
> So I dunno.

I prefer naming consistency but whatever.

When I want to find all users of a common identifier, I usually rename
the identifier at its declaration (e.g., to "refnameXXX") and see where
gcc flags errors.  Or if I'm doing a lot of this sort of thing, I might
even fire up Eclipse, which does a pretty good job of finding instances
of a particular identifier throughout the code.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
