From: konglu@minatec.inpg.fr
Subject: Re: [PATCH] git-status: Show empty directories
Date: Sat, 09 Jun 2012 23:47:17 +0200
Message-ID: <20120609234717.Horde.I9rYUXwdC4BP08RlFRO2w_A@webmail.minatec.grenoble-inp.fr>
References: <1339270806-65013-1-git-send-email-muhtasib@gmail.com>
 <20120609221315.Horde.fN5FP3wdC4BP065b3FviijA@webmail.minatec.grenoble-inp.fr>
 <CAA3EhHJ9WnisF21iFfsjQKYFSY0t0jFvNV3aBjx0eGFPm8aoGg@mail.gmail.com>
 <877gvgrxw7.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Leila <muhtasib@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jun 09 23:48:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdTW9-0002bK-2N
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jun 2012 23:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250Ab2FIVrl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Jun 2012 17:47:41 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:36474 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750843Ab2FIVrl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Jun 2012 17:47:41 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id A5A091A0E04;
	Sat,  9 Jun 2012 23:47:17 +0200 (CEST)
Received: from reverse.completel.net (reverse.completel.net [92.103.38.66])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Sat, 09 Jun
 2012 23:47:17 +0200
In-Reply-To: <877gvgrxw7.fsf@thomas.inf.ethz.ch>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199560>


Thomas Rast <trast@student.ethz.ch> a =C3=A9crit=C2=A0:

> Leila <muhtasib@gmail.com> writes:
>
>>> The structure is
>>> =C2=A0 =C2=A0 =C2=A0if (...) {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*code*/
>>> =C2=A0 =C2=A0 =C2=A0} else {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*code*/
>>> =C2=A0 =C2=A0 =C2=A0}
>>>
>>> Do not forget braces in the "else" part as the firt block needs it.
>>
>> I was under the impression that one liners didn't require parenthesi=
s
>> according to the style guidelines. I didn't realize that if the 'if'
>> required it, then the else required it. I will make that change and
>> remember it for the future. Thanks!
>
> It's not required, there's plenty of precedent, even one case within
> wt-status.c, of '} else'.  Try running
>
>   git grep '} else$'

It's not because "there's plenty of precedent" that we should not try
to improve the format of the code. That's why there're coding style
rules so that we can keep the improvements consistent.

Thanks.

Lucien Kong
