From: Marc Khouzam <marc.khouzam@gmail.com>
Subject: Re: [PATCH] tcsh-completion re-using git-completion.bash
Date: Sat, 17 Nov 2012 12:15:54 -0500
Message-ID: <CAFj1UpFbuHVhPOQVB9-sPjW2aBN=H+OUyYnz00qASZ5ssbwmGw@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 18:22:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZm5y-0004Wl-1u
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 18:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015Ab2KQRP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2012 12:15:56 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:55226 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab2KQRPz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 12:15:55 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so5063034iea.19
        for <git@vger.kernel.org>; Sat, 17 Nov 2012 09:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=eEP5aiBrpq1Jexi1tm237mh5R6/Xf/7ebEsE5WKkbE8=;
        b=nR7qPd67uAQ/oCBb7eyRlVY2J07DHGUkyw3mWmScD+iU64BLFnNJx6dkDZwSFw/Xog
         JQLOMAhs9asGP7YaH4NfkoeIsEBBopc/PcyZgkF5jN876Ng2zawCWbF/ieIqdOvS4CrZ
         OkhTW2oNX+8Mrcltzcni8RsCz+jkkiENJ5vYzEKRla2FjN72aKEALEznCf5yPQXis1tJ
         OcDh8XK4vywlnF7yE4P80PPKTgoG7VsZ6WI4LkLE089xubq1y1X8PdDnv9RAisfXAbBb
         v55CpH0T0IwL8TRVVHS+iB0xMu4i78eauuonhGZhifGautxkgMZNbulsgkbWQadapTbn
         2YNg==
Received: by 10.42.176.194 with SMTP id bf2mr7184387icb.50.1353172555118; Sat,
 17 Nov 2012 09:15:55 -0800 (PST)
Received: by 10.64.132.39 with HTTP; Sat, 17 Nov 2012 09:15:54 -0800 (PST)
In-Reply-To: <CAMP44s0y3UPVT+ndELaKNsWXAPG3kv-Xq_Wf6ONDF3Z99A5zMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209965>

On Fri, Nov 16, 2012 at 4:56 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Fri, Nov 16, 2012 at 10:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> The point is not about the quality of zsh's emulation
>> of (k)sh when it is run under that mode, but is about not having to
>> have that logic in bash-only part in the first place.
>
> As I said, that logic can be moved away _if_ my wrapper is merged. But
> then again, that would cause regressions to existing users.

Please forgive me as I don't know the background of the efforts for
zsh git-completion or
the syntax for zsh completion, but I thought I'd mention another
approach I tried for tcsh
which may work for zsh.

I gather that using a wrapper for zsh causes concerns about
backwards-compatibility.
So, what could be done is have the bash script do both jobs: setup the
zsh completion
commands, and output the git completion using bash itself.  At the top
of git-completion.bash
(or it could be even pushed at the bottom using if/else) we could use:

if [[ -n ${ZSH_VERSION-} ]]; then
  # replace below by zsh completion commands calling `bash
${HOME}/.git-completion.bash`
  complete git   'p/*/`bash ${HOME}/.git-completion.bash ${COMMAND_LINE}`/'
  complete gitk 'p/*/`bash ${HOME}/.git-completion.bash ${COMMAND_LINE}`/'
  exit
fi

That way the zsh user would still simply do 'source
~/.git-completion.bash' which would
only execute the two zsh completion setup commands.  Then, when completion is
triggered, it calls `bash ${HOME}/.git-completion.bash ${COMMAND_LINE}` and
processes the output like tcsh does.  This limits the zsh-specific
code to 2 lines for
the entire script.

I got this to work for tcsh (solution (B)) adding the following a the top of
git-completion.bash:

test "$tcsh" != "" && \
   complete git  'p,*,`${HOME}/.git-completion.sh
"${COMMAND_LINE}"|\sort|\uniq`,' && \
   complete gitk 'p,*,`${HOME}/.git-completion.sh
"${COMMAND_LINE}"|\sort|\uniq`,' && \
   exit

but I didn't think people would go for that since those lines have to
work in both bash
and tcsh syntax.  I thought this made the script a bit brittle.

Just a thought.

Marc
