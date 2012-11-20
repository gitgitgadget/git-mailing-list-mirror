From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] tcsh-completion re-using git-completion.bash
Date: Tue, 20 Nov 2012 16:15:17 +0100
Message-ID: <CAMP44s1i59VtX9xMmM-j3Gzcufg6jtKy34MMuwrfenmSw3oLAg@mail.gmail.com>
References: <CAFj1UpHgPvdDeKZ-Ap7-aVx6p_pxT4a2F01ajmNa00txPyS=Qw@mail.gmail.com>
	<1352980269-15569-1-git-send-email-marc.khouzam@gmail.com>
	<CAMP44s0Guq0nYJEfbvNDyt8Oqaux-cXbTsyro6pxUnEpA4+XOw@mail.gmail.com>
	<CAFj1UpEdft+L5KW+tMy6Lqm1eUkHQgwWuXaC0UTUdqwW=ohk-Q@mail.gmail.com>
	<CAMP44s1RtOj6LKCNJ8SX8KSA8eNCMZ+4D-VfQ+WtXju-KhG8ng@mail.gmail.com>
	<CAFj1UpHLf2je_+b1e5B_5thZ03UYVmW=CWhAh63kNRCbke0kQw@mail.gmail.com>
	<CAMP44s1RvMSBu2RJqKw9ne4cJyMO4dbFc-gW2HgsN2-uviv=fA@mail.gmail.com>
	<CAFj1UpHMc-bHJgSZKY13YH_69TXkz-50g5xpLA6C+Eh0aqcN9A@mail.gmail.com>
	<CAMP44s3S4c7ciJNurxGdS2o_TDJJDkGK73dtCGji+C1NoV+Jvw@mail.gmail.com>
	<20121116204017.GX12052@goldbirke>
	<7vr4ntkzy4.fsf@alter.siamese.dyndns.org>
	<CAMP44s0y3UPVT+ndELaKNsWXAPG3kv-Xq_Wf6ONDF3Z99A5zMQ@mail.gmail.com>
	<CAFj1UpFbuHVhPOQVB9-sPjW2aBN=H+OUyYnz00qASZ5ssbwmGw@mail.gmail.com>
	<CAMP44s30wYnkQdq8yup3z-t=FEf1R+k8OC-o7-uY=19z9VHDPg@mail.gmail.com>
	<CAFj1UpHs08seVH8Kb3CuoNTaF+x6vA+ybVTEu0TyLX8NYuuidQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Marc Khouzam <marc.khouzam@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 16:15:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TapY4-0007YC-84
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 16:15:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236Ab2KTPPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 10:15:22 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35885 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847Ab2KTPPS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 10:15:18 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so6007329obb.19
        for <git@vger.kernel.org>; Tue, 20 Nov 2012 07:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Dp115x6H4A5Mc222IEoydpLdHOoPK7Ggbhj8u043b4g=;
        b=Sg6Ap8eZXZGLyWDMd7OkTqS69SDLmNW2ONjhNSubrJknFO+imbE8jXNYQ4uNYiMD0W
         xUwNppTY+Pd6gWXudgUwR+0vMn+CbBu5qO+WNVmIV89+6ORAbrnF+px/mzMTEKBCpznq
         VmEOSOnm4vCi32Sr52MZxjeHvTpEEm6On5MUteV+/i6L/eL4CZE2wr4zv9OlZl/iSGo6
         7Ixon3V7EKJVL756AR0NkW455RJSxYKUHgB8c6Hw01DvCWUmRgWQSwTEfM3nJBy0T9iq
         SdOxP5GrhdVp62/9yZzL/aUXewAmcVzl2lMeaKN9m+PWQkO6BTw2w4B7p3KpIWpMu3z2
         1kKg==
Received: by 10.182.245.20 with SMTP id xk20mr13560307obc.89.1353424517450;
 Tue, 20 Nov 2012 07:15:17 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Tue, 20 Nov 2012 07:15:17 -0800 (PST)
In-Reply-To: <CAFj1UpHs08seVH8Kb3CuoNTaF+x6vA+ybVTEu0TyLX8NYuuidQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210102>

On Tue, Nov 20, 2012 at 3:58 PM, Marc Khouzam <marc.khouzam@gmail.com> wrote:

> Hi,
>
> since there doesn't seem to be an agreement that the approach to achieve tcsh
> git-completion would be useful for zsh (the other possible shell that could use
> it is ksh, but I haven't looked into that), maybe the simplest thing
> is to keep the
> tcsh solution contained in a tcsh-only script.  This is the latest solution as
> proposed here:
>
> [1] http://www.mail-archive.com/git@vger.kernel.org/msg12192.html

This one is already merged to 'next'.

Cheers.

-- 
Felipe Contreras
