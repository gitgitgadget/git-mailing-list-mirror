From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: [PATCH 4/4] Declare that HP NonStop systems require strings.h
Date: Fri, 14 Dec 2012 23:45:38 +0100
Message-ID: <kaga6l$pp8$1@ger.gmane.org>
References: <CAEvUa7mSOe6gs8JqkewYV=CXt78Y68nTFbFEfEOuCzaV5-DO8A@mail.gmail.com> <50CB8C80.6040802@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 23:46:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tje1M-0001RR-Vf
	for gcvg-git-2@plane.gmane.org; Fri, 14 Dec 2012 23:46:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485Ab2LNWqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2012 17:46:03 -0500
Received: from plane.gmane.org ([80.91.229.3]:54377 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932396Ab2LNWqB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2012 17:46:01 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Tje1B-0001Gx-3q
	for git@vger.kernel.org; Fri, 14 Dec 2012 23:46:09 +0100
Received: from dsdf-4db522c0.pool.mediaways.net ([77.181.34.192])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Dec 2012 23:46:09 +0100
Received: from jojo by dsdf-4db522c0.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Dec 2012 23:46:09 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4db522c0.pool.mediaways.net
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211509>

Johannes Sixt wrote:
> Am 14.12.2012 20:57, schrieb David Michael:
>> This platform previously included strings.h automatically.  However,
>> the build system now requires an explicit option to do so.
>> 
>> Signed-off-by: David Michael <fedora.dm0@gmail.com>
>> ---
>>  Makefile | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/Makefile b/Makefile
>> index fb78f7f..e84b0cb 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1357,6 +1357,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>>      # Added manually, see above.
>>      NEEDS_SSL_WITH_CURL = YesPlease
>>      HAVE_LIBCHARSET_H = YesPlease
>> +    HAVE_STRINGS_H = YesPlease
>>      NEEDS_LIBICONV = YesPlease
>>      NEEDS_LIBINTL_BEFORE_LIBICONV = YesPlease
>>      NO_SYS_SELECT_H = UnfortunatelyYes
> 
> If NONSTOP_KERNEL is the platform that defines __TANDEM, then this
> should be squashed into the previous patch, shouldn't it?

Patch 4/4 does not work without 3/4, Not for HP-NonStop.

Bye, Jojo
