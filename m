From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Question about submodules and absolute paths
Date: Wed, 23 May 2012 22:42:31 +0200
Message-ID: <4FBD4BB7.9070704@web.de>
References: <CAOmKuSoYP9fYORDy5twLpFh7SQ7rc6x2A=F8XjfKMqo-ErCauQ@mail.gmail.com> <CAOmKuSpqFrC7G4DbZu=uYDwvU6QqrJUi2aNBnSjy7_PXMMJpjQ@mail.gmail.com> <7vk4043wc5.fsf@alter.siamese.dyndns.org> <CAOmKuSrmxnHKaip2X87Y0Cp=XtLAtpAwUp71QhZ5od3gbDF2sg@mail.gmail.com> <70952A932255A2489522275A628B97C31348C70D@xmb-sjc-233.amer.cisco.com> <CAOmKuSqRHMS+hvCXL4Ok6ReTPW-3xT9SunGeibjCCCgVk9SU6Q@mail.gmail.com> <70952A932255A2489522275A628B97C31348C71F@xmb-sjc-233.amer.cisco.com> <CAOmKuSoxf_mRJRyjXj99NQLoa+fD-HU_oUYPrJYPNTPmvhs46g@mail.gmail.com> <7vpq9w2ae2.fsf@alter.siamese.dyndns.org> <4FBC90C2.6050203@web.de> <CAOmKuSqUm+WoTA5U5ZSgqFS6Oc7q+y8wSR0sMxHW_EPKoz6fwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Matt Seitz (matseitz)" <matseitz@cisco.com>, git@vger.kernel.org
To: Alexey Pelykh <alexey.pelykh@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 23 22:42:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXIOI-0007ed-8Y
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 22:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758841Ab2EWUmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 16:42:38 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:34226 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141Ab2EWUmh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 16:42:37 -0400
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate03.web.de (Postfix) with ESMTP id 00B7F1B4E97B3
	for <git@vger.kernel.org>; Wed, 23 May 2012 22:42:36 +0200 (CEST)
Received: from [192.168.178.48] ([91.3.160.4]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0LnjRP-1RqotR3ebX-00hs57; Wed, 23 May 2012 22:42:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <CAOmKuSqUm+WoTA5U5ZSgqFS6Oc7q+y8wSR0sMxHW_EPKoz6fwQ@mail.gmail.com>
X-Provags-ID: V02:K0:p9MnDDbt/02db6Y9IS7BOcEpMojMy0gChneOZTlc8BE
 9hkreu1NrNyT9HsIg9EQEnbKGEvY4pIizMdjr2DTUdv69QLV1D
 OzvfQb8TBgLIx1ylwOeGgBHTBNi1OIykrOzURcFkubS4gP82nV
 VwA7fn078abkR+KrnETOhbeVjEl4RrLQLWkdP1/euiFdzdRgUT
 va+eLk3n9Cj93LmPsDi/A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198321>

[please do not top-post]

Am 23.05.2012 09:32, schrieb Alexey Pelykh:
> On Wed, May 23, 2012 at 10:24 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>
>> Am 22.05.2012 23:06, schrieb Junio C Hamano:
>>> Didn't the submodule folks worked on the related area recently, and
>>> doesn't the result of their work already in v1.7.10?
>>>
>>> I am thinking specifically about the series around d75219b (submodules:
>>> always use a relative path from gitdir to work tree, 2012-03-04).  Jens?
>>
>> Yes, these changes should fix the problem described by Alexey.
>
> Great! I'll try git from sources then

But don't forget to re-clone the submodules, the paths won't be updated
for existing submodules.
