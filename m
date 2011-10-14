From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 07/14] is_refname_available(): remove the "quiet"	argument
Date: Fri, 14 Oct 2011 07:35:39 +0200
Message-ID: <4E97CA2B.6080202@alum.mit.edu>
References: <1318492715-5931-1-git-send-email-mhagger@alum.mit.edu>	 <1318492715-5931-8-git-send-email-mhagger@alum.mit.edu> <1318509685.7231.6.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Fri Oct 14 07:36:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REaRC-00041s-Tl
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 07:36:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330Ab1JNFgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 01:36:01 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:60794 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069Ab1JNFgA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 01:36:00 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BED76C.dip.t-dialin.net [84.190.215.108])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9E5ZdBE004909
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 14 Oct 2011 07:35:40 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <1318509685.7231.6.camel@drew-northup.unet.maine.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183540>

On 10/13/2011 02:41 PM, Drew Northup wrote:
> 
> On Thu, 2011-10-13 at 09:58 +0200, mhagger@alum.mit.edu wrote:
>> From: Michael Haggerty <mhagger@alum.mit.edu>
>>
>> quiet was always set to 0, so get rid of it.  Add a function docstring
>> for good measure.
> 
> I would like to know if perhaps it was an unfinished project somewhere
> to propagate the "quiet" option down to this level before removing the
> function argument. Comments?

The is_refname_available() function, including the quiet option, was
added in c976d415e53 (coincidentally the same commit that added
RENAME-REF).  I am unable to find any use of the function with quiet=1
anywhere in history.

>> +/*
>> + * Return true iff a reference named refname could be created without
> 
> Did you really mean "iff" (as in "if and only if") or just plain "if"
> here?

I did indeed mean "if and only if".  Are you asking because you think
that abbreviation is too obscure, or because you think that "if and only
if" is logically incorrect here and I should have used "if"?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
