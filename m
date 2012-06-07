From: konglu@minatec.inpg.fr
Subject: Re: rebase [-i --exec | -ix] <CMD>...
Date: Thu, 07 Jun 2012 22:44:59 +0200
Message-ID: <20120607224459.Horde.GLRVL3wdC4BP0RLLE1gTU0A@webmail.minatec.grenoble-inp.fr>
References: <4FD0D375.9060902@web.de>
 <1339087582-10040-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <4FD0EB76.90501@web.de>
 <20120607200731.Horde.xzrpWHwdC4BP0O3jZ46SyWA@webmail.minatec.grenoble-inp.fr>
 <4FD0FCAC.3070408@web.de>
 <20120607215512.Horde.RVmScHwdC4BP0QcggMBjKUA@webmail.minatec.grenoble-inp.fr>
 <m2k3zivp0c.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=";";
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?b?QsO2Z2Vyc2hhdXNlbg==?= <tboegi@web.de>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Jun 07 22:45:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScjaI-0008Sv-OV
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 22:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757138Ab2FGUpF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jun 2012 16:45:05 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:34168 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754880Ab2FGUpD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jun 2012 16:45:03 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id A06471A02FC;
	Thu,  7 Jun 2012 22:44:59 +0200 (CEST)
Received: from reverse.completel.net (reverse.completel.net [92.103.38.66])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Thu, 07 Jun
 2012 22:44:59 +0200
In-Reply-To: <m2k3zivp0c.fsf@igel.home>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199449>


Andreas Schwab <schwab@linux-m68k.org> a =C3=A9crit=C2=A0:

> konglu@minatec.inpg.fr writes:
>
>> As you pointed out, the problem seems to come from this line
>> 	tmp=3D$(sed "/^pick .*/i\exec $i" "$1")
>> I think that the dquote here doesn't work on MacOS, though i've
>> never tried it. Anyway, even if it's not the problem, this kind
>> of quoting is quite odd so it will be removed in the next patch
>> (I do not see other reasons of the issue, as sed's i command should
>> work on MacOS).
>
> You need to put a newline after the backslash.

That's what we originally did. Though we did it with indentations:
         tmp=3D$(sed "/^pick .*/i\
                            exec $i" "$1")
Should it be put that way (without indentations) ?
         tmp=3D$(sed "/^pick .*/i\
exec $i" "$1")

Thanks,

Lucien Kong
