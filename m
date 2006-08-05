From: "Ramsay Jones" <ramsay@ramsay1.demon.co.uk>
Subject: RE: update-ref logs: problem with committer info?
Date: Sat, 5 Aug 2006 21:23:40 +0100
Message-ID: <001a01c6b8cd$0a7b5860$c47eedc1@ramsay1.demon.co.uk>
References: <20060805025600.GA18223@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 05 22:23:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9SgM-0002R7-TD
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 22:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWHEUXc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 16:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWHEUXc
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 16:23:32 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:32019 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751323AbWHEUXb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 16:23:31 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-34.mail.demon.net with smtp (Exim 4.42)
	id 1G9SgC-000PXP-FQ; Sat, 05 Aug 2006 20:23:29 +0000
To: <spearce@spearce.org>, "Junio C Hamano" <junkio@cox.net>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.2106.4
Importance: Normal
In-Reply-To: <20060805025600.GA18223@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24931>


On Sat 2006-08-05 at 3:56, spearce@spearce.org wrote:

> Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:
> > diff --git a/builtin-update-ref.c b/builtin-update-ref.c
> > index 00333c7..83094ab 100644
> > --- a/builtin-update-ref.c
> > +++ b/builtin-update-ref.c
> > @@ -12,6 +12,7 @@ int cmd_update_ref(int argc, const char
> >  	unsigned char sha1[20], oldsha1[20];
> >  	int i;
> >
> > +	setup_ident();
> >  	setup_git_directory();
> >  	git_config(git_default_config);
> > diff --git a/refs.c b/refs.c
> > index 713ca46..a4060d8 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -379,7 +379,6 @@ static int log_ref_write(struct ref_lock
> >  			lock->log_file, strerror(errno));
> >  	}
> >
> > -	setup_ident();
> >  	comitter = git_committer_info(1);
> >  	if (msg) {
> >  		maxlen = strlen(comitter) + strlen(msg) + 2*40 + 5;
>
> These two changes were already fixed by me in 0b0fe4a6 on July
> 10th.  That change is in `next`, in `master` and in v1.4.2-rc3.
> So I expect it to be available in a final release real-soon-now.
> Maybe you should consider running a newer version of GIT?
>

Yes, I am quite a long way behind, at version 1.4.1, which is light-years
in git-time!  Unfortunately, since I can't pull from the git repo (I don't
have internet access from Linux), I won't be able to update until the v1.4.2
tar-ball is posted. Yep, not exactly ideal.

OK, for now I will refrain from contributing, at least until v1.4.2 is out.

Sorry for the noise.

Ramsay
