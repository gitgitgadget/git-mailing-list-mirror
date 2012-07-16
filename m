From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC] Add a new email notification script to "contrib"
Date: Mon, 16 Jul 2012 21:05:07 +0200
Message-ID: <500465E3.8040501@alum.mit.edu>
References: <1342249182-5937-1-git-send-email-mhagger@alum.mit.edu> <vpqhat7wujb.fsf@bauges.imag.fr> <500445CC.2020404@alum.mit.edu> <7vtxx738dz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 21:05:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sqqbd-0003LO-JF
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 21:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181Ab2GPTFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 15:05:13 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:43726 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753863Ab2GPTFL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2012 15:05:11 -0400
X-AuditID: 12074411-b7ff16d0000008d7-e4-500465e68035
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 7E.8E.02263.6E564005; Mon, 16 Jul 2012 15:05:10 -0400 (EDT)
Received: from [192.168.69.140] (p57A25BFA.dip.t-dialin.net [87.162.91.250])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q6GJ57KV003513
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 16 Jul 2012 15:05:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <7vtxx738dz.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsUixO6iqPsslSXA4PZqCYvjT6+zWHRd6Way
	aOi9wmxx6fN6VovVj++wO7B67Jx1l91j4pfjrB4XLyl7fN4kF8ASxW2TlFhSFpyZnqdvl8Cd
	0dx8nrFgLk/F9KPHGRsYr3N2MXJySAiYSCz88YMVwhaTuHBvPVsXIxeHkMBlRomHd2azQzhn
	mCTetr1iAaniFdCW2PZoAVCCg4NFQFVi0h93kDCbgK7Eop5mJpCwqECYxPSd7BDVghInZz4B
	6xQRUJOY2HaIBWQks8BiRom+J7eYQBLCAs4SK+fsYILYtY5RYu+0BYwgCU4BM4nTj+6B7WIW
	sJb4trsIJMwsIC+x/e0c5gmMArOQ7JiFUDULSdUCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmp
	RbqmermZJXqpKaWbGCFhLbiDccZJuUOMAhyMSjy8N21YAoRYE8uKK3MPMUpyMCmJ8h5MBgrx
	JeWnVGYkFmfEF5XmpBYfYpTgYFYS4W20B8rxpiRWVqUW5cOkpDlYlMR5+Zao+wkJpCeWpGan
	phakFsFkZTg4lCR4dYDxKyRYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPitP4YmCk
	gqR4gPZKgLTzFhck5gJFIVpPMVpyPPly6xYjx4Jd94Bk9xcgKcSSl5+XKiXOywbSIADSkFGa
	B7cOltxeMYoDfS/M+zYFqIoHmBjhpr4CWsgEtNCyhAlkYUkiQkqqgXG+TtKxErYtlcUn/zpe
	rRCJz2F/FVSRtGLrOc3+abwlC88F3g+OPPv31+aJLyMWXzhgolTdmqqidkCd893l 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201547>

On 07/16/2012 07:47 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> It's already supported:
>>
>>      git config hooks.announcelist \
>>          "nosy@example.com, overwhelmed@example.com, phb@example.com"
>>      git config hooks.refchangelist \
>>          "nosy@example.com, overwhelmed@example.com"
>>      git config hooks.commitlist "nosy@example.com"
>
> Sad.  Is the "post-recieve email" squatting on the _whole_ hooks.*
> namespace, not postreceiveemailhook.* or something more reasonably
> limited?

Yes.  I didn't like this either, but I copied this aspect of the old 
script in the interest of compatibility.

If we want to change this, now would be a good time, before the new 
script starts using more of the hooks namespace.  One could choose a new 
namespace and deprecate the old one, optionally in multiple steps:

1. Only read new options from new namespace; read old options from new 
namespace or (if the new names are not set) falling back to the old 
namespace.

2. Deprecate the old namespace, emitting warnings if the old names are 
still set but continuing to use them.

3. Stop supporting the old namespace, but emit warnings if the old names 
are still set.

4. Stop looking in the old namespace altogether.

Though, given that hook scripts have to be enabled/upgraded 
per-repository, usually on a central server, probably doing only steps 2 
and 4 would be enough.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
