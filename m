From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: How to make devs write better commit messages
Date: Tue, 6 Dec 2011 16:08:35 -0800
Message-ID: <CAE1pOi3REHvQjrO+=K+qt5dH60U+Le4Ty_Vq2nFPpWS27h1+Eg@mail.gmail.com>
References: <CAOJsP-X0ZWT5HLHcBc2FmhoMpWFOvEFADiM9jGZ9R1ctqHDJ9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael Schubert <mschub@elegosoft.com>
To: Joseph Huttner <huttnified@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 01:08:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY53x-0008W2-9O
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 01:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754956Ab1LGAIh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Dec 2011 19:08:37 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:65149 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754951Ab1LGAIg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2011 19:08:36 -0500
Received: by mail-gx0-f174.google.com with SMTP id r5so6918921ggn.19
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 16:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=eNiFe22cghya8k2vYC3zBtCr1nwO0vIvV0mB26KDDjw=;
        b=EnXea8+zYtUnzvsrZg/BwGolOu3Vs6xRWimFWbAVxPzB+za1yii41rqRpYMOk5l/E7
         YDdCzakBWiaCtLh7qZlRHGf+uitytKXBxW925Dxc+nAYsCK9HwNqANLSRly8S7bVxUWU
         p+RhRqTchqBXxaW/Z9mtTeYd+Pkr3vHSATCeY=
Received: by 10.100.42.16 with SMTP id p16mr3553747anp.103.1323216516022; Tue,
 06 Dec 2011 16:08:36 -0800 (PST)
Received: by 10.236.174.106 with HTTP; Tue, 6 Dec 2011 16:08:35 -0800 (PST)
In-Reply-To: <CAOJsP-X0ZWT5HLHcBc2FmhoMpWFOvEFADiM9jGZ9R1ctqHDJ9w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186407>

On 6 December 2011 14:55, Joseph Huttner <huttnified@gmail.com> wrote:
> So I know that there is a somewhat standard format of commit messages
> in Git, which Linus outlines here:
>
> https://github.com/torvalds/subsurface/blob/master/README#L164
>
> Trouble is, when most people go to commit, the file that the editor
> opens has no reminder of how to write a proper commit message. =C2=A0=
Often
> I find myself having to go back through the commit log, or consulting
> the above link.
>
> I propose two things:
>
> 1. =C2=A0An optional flag in the Git config that, if set, shows the f=
ormat
> of a typical commit message in your commit message template.
>
> 2. =C2=A0The ability to modify this commit message template. =C2=A0Ma=
ny teams
> use automated tools to read commit messages and then do automated
> tasks based on that data, like comment an RT ticket. =C2=A0Thus, deve=
lopers
> need to be reminded of these team-specific settings as well.
>
> What are your thoughts?

Great idea! These templates would be stored in the Git repo, I assume?
Btw, there is 'commit.template' which you can use locally.

 I was wondering if it might be possible to somehow add project config
defaults to one's Git repo. It would be great to have something like
'commit.template' point to a file in the Git repo by default.
Currently, it doesn't seem possible to have a config parameter "point
to" a file or directory in the Git repo. Nor do I know of a way to
have the Git repo set a config parameter to a default value. Or is
this possible after all?
