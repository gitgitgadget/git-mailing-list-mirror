From: Tor Arntsen <tor@spacetec.no>
Subject: Re: Lost association between TAGS and COMMITs when rebased a git(1) repository
Date: Sun, 4 Sep 2011 20:16:50 +0200
Message-ID: <CABNEGjyXLnSvjhBewNDsjW=rthRh0HY+KgC05vPNPu5QCaAgXQ@mail.gmail.com>
References: <FF0364F3D5244CA4987EDDCFE7244BF3@urbanjsPC>
	<CACx-yZ3tav1sJnLtJOn_YugQOsM9ERi7Cc7SowunyobxxX5YdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "John S. Urban" <urbanjost@comcast.net>, git@vger.kernel.org
To: knittl <knittl89@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Sep 04 20:16:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0HFY-0006xX-5B
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 20:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422Ab1IDSQw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Sep 2011 14:16:52 -0400
Received: from mail-iy0-f194.google.com ([209.85.210.194]:63206 "EHLO
	mail-iy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343Ab1IDSQv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Sep 2011 14:16:51 -0400
Received: by iadk27 with SMTP id k27so2000187iad.1
        for <git@vger.kernel.org>; Sun, 04 Sep 2011 11:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=C09x3VePPkOa2gU80JJtT98eECe0wgWCQabPk/FE2wc=;
        b=aQPLpcGlXzAnzkxYpbHawfrfOxKD5wwfd0cTuNtddHnKxu6tUpTbukaFgFrAqlhii3
         iO9WqVTzH9E1OpbVB+rQ2pLcRjQUJDUw2JFuhZD/HTbC8pSqwJlemC/HNCElg4jDtNvm
         QGY5OeS01sY/RSjX3Snz2oAj+eoYNnK1B+xgk=
Received: by 10.231.58.8 with SMTP id e8mr6129490ibh.25.1315160210407; Sun, 04
 Sep 2011 11:16:50 -0700 (PDT)
Received: by 10.231.202.84 with HTTP; Sun, 4 Sep 2011 11:16:50 -0700 (PDT)
In-Reply-To: <CACx-yZ3tav1sJnLtJOn_YugQOsM9ERi7Cc7SowunyobxxX5YdA@mail.gmail.com>
X-Google-Sender-Auth: X42H-e6YGLOk3tfUs3mCTOZwmKE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180691>

On Sun, Sep 4, 2011 at 4:30 PM, knittl <knittl89@googlemail.com> wrote:
>
> On Sun, Sep 4, 2011 at 3:32 AM, John S. Urban <urbanjost@comcast.net>=
 wrote:
> > With my first use of git(1) I =A0created a small project with about=
 200
> > "commits". =A0When this was complete, I needed to label each commit=
 with
> > information pointing it to a section of a document. I used tags for=
 this.
>
> Use git notes[1] to attach additional info to existing commits. Git
> notes will by default be copied when using git rebase or git commit
> --amend (cf. notes.rewrite.<command> config)

Is that true? I've always lost the notes when rebasing. I just tried
that again now (1.7.5.4), and after a rebase the notes attached to any
commit that was rebased just disappeared. I've always had to hunt down
and re-create the notes. It would indeed be much more convenient if
the notes would tag along.

-Tor
