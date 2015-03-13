From: Cody Taylor <cody.taylor@maternityneighborhood.com>
Subject: [Documentation] Submitting Patches
Date: Fri, 13 Mar 2015 02:31:30 -0400
Message-ID: <CAHWMk2YuUvYYb-nxdANVxZ0tLsyttnqNzpF74Nxz1zpFcGEnGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 07:31:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWJ8E-0005Bl-Kf
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 07:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbbCMGbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 02:31:34 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:34973 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324AbbCMGbe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2015 02:31:34 -0400
Received: by ieclw3 with SMTP id lw3so87155852iec.2
        for <git@vger.kernel.org>; Thu, 12 Mar 2015 23:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc
         :content-type;
        bh=iRyIskYvmWUYttfpeozgYbMhKa9CwOaeNMs+ZYc68vk=;
        b=Patgt36zHIT6mrpg2dQVFD4ZMzasLJFX1W5A9bqRvFLf12NMkrqYd7sU9bF+luo0I9
         R5n+wy+fICffUpG+6H4ItbsscQreP+PSa/++ldn3JdDC0o6LPbd7qgZVaWs4zl6sk9YQ
         j+ZGCVnPTAf7FiJRDGsBoPm5Bo7OhgzI7ucoP+kQpNqAGUF51NDtGJ3dN3U6MmQvyHCt
         6MdMbhp40awn1ybbKk1eg+Y2gYpYlcDYnYbnRD7Cr48C5pNLv11VAHkx8Vdp4IrPvkNr
         v/ADIXs70plPLnp+tLzwDK1FaDk1B98LBqYNTpzJg6gSqJDiwA3m3kfT048yc5+NzZ5D
         k/1Q==
X-Gm-Message-State: ALoCoQkLZMdbutkO0Exr0aaSMk42JWfjDbJ3+6m/xldpuCuvxeKjf1GTuw57maSVJw2C91m/sgOr
X-Received: by 10.202.194.212 with SMTP id s203mr35258509oif.115.1426228290749;
 Thu, 12 Mar 2015 23:31:30 -0700 (PDT)
Received: by 10.76.109.37 with HTTP; Thu, 12 Mar 2015 23:31:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265405>

Apologies for the poorly formatted e-mail. I realized after I sent the
message that the `git send-mail` command was an option. I was trying
to use python to modify the e-mail before sending it, and the three
different "From" fields got mumbled.

Anyway, this brings up the point that `git send-email` should at least
get a mention in the "Documentation/SubmittingPatches" file. Likely
the best place for this is a paragraph after `git format-patch` is
mentioned in section 4 ("Sending your patches.").

On Fri, Mar 13, 2015 at 2:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Cody A Taylor <cody.taylor@maternityneighborhood.com> writes:
>
> > From c861d5cb401110ce7d86b76c1eaa8e89e80f484e Mon Sep 17 00:00:00 2001
> > From: Cody A Taylor <codemister99@yahoo.com>
> > Date: Thu, 12 Mar 2015 20:36:44 -0400
> > Subject: [PATCH] git prompt: Use toplevel to find untracked files.
>
> All of the above four lines are unwanted in the e-mail body.
>
>  * The first line is a separating line to make format-patch output
>    look like a mbox file, and does not even belong to this patch.
>
>  * From: line, when you are not relaying somebody else's patch,
>    should not be necessary, as long as you set up your MUA correctly
>    so that the e-mail shows a correct From: in its header.
>
>  * Date: is the same; unless you are relaying somebody else's patch,
>    in which case you might want to preserve the author timestamp,
>    the first time _we_ the recipients see your patch matters more,
>    which should be available from the e-mail header.
>
>  * Subject: should be in the e-mail header.  Sometimes when sending
>    a patch to an ongoing discussion that has its own subject, it is
>    handy to be able to override the title with in-body Subject:, but
>    this patch submission is not such a case.  The subjects are the
>    same in the fourth line in the body (which should be dropped) and
>    in the header anyway in this message, so please edit it out.
>
> In short
>
>  (1) If you cannot convince your mailer to show your @yahoo.com
>      address on the e-mail header From: line, then having the
>      in-body From: line above (i.e. the second line) is OK as a
>      workaround.  We however would prefer if you didn't.
>
>  (2) Edit the other three lines out.
>
> > The __git_ps1() prompt function would not show an untracked
> > state when the current working directory was not a parent of
> > the untracked file.
>
> Good find, and nicely explained.  I wonder if we can add a test
> or two to t9903-bash-prompt.sh?
>
> The patch itself makes sense.  Thanks.
>
> > Signed-off-by: Cody A Taylor <codemister99@yahoo.com>
> > ---
> >  contrib/completion/git-prompt.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> > index 214e859f99e7..f18aedc73be9 100644
> > --- a/contrib/completion/git-prompt.sh
> > +++ b/contrib/completion/git-prompt.sh
> > @@ -487,7 +487,7 @@ __git_ps1 ()
> >
> >               if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ] &&
> >                  [ "$(git config --bool bash.showUntrackedFiles)" != "false" ] &&
> > -                git ls-files --others --exclude-standard --error-unmatch -- '*' >/dev/null 2>/dev/null
> > +                git ls-files --others --exclude-standard --error-unmatch -- ':/*' >/dev/null 2>/dev/null
> >               then
> >                       u="%${ZSH_VERSION+%}"
> >               fi
