From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC PATCH 1/3] Add "vcs" config option in remotes
Date: Mon, 12 Jan 2009 12:25:52 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901121225330.19665@iabervon.org>
References: <alpine.LNX.1.00.0901110332580.19665@iabervon.org> <36ca99e90901120152t7756e6d4n19521cbb7336c5fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 18:27:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMQZW-0001Vt-Sq
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 18:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755879AbZALRZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 12:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755943AbZALRZ4
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 12:25:56 -0500
Received: from iabervon.org ([66.92.72.58]:48205 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755931AbZALRZz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 12:25:55 -0500
Received: (qmail 3637 invoked by uid 1000); 12 Jan 2009 17:25:52 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jan 2009 17:25:52 -0000
In-Reply-To: <36ca99e90901120152t7756e6d4n19521cbb7336c5fb@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105359>

On Mon, 12 Jan 2009, Bert Wesarg wrote:

> On Sun, Jan 11, 2009 at 21:12, Daniel Barkalow <barkalow@iabervon.org> wrote:
> > diff --git a/builtin-push.c b/builtin-push.c
> > index 122fdcf..3fdedba 100644
> > --- a/builtin-push.c
> > +++ b/builtin-push.c
> > @@ -53,6 +53,9 @@ static int do_push(const char *repo, int flags)
> >        int i, errs;
> >        struct remote *remote = remote_get(repo);
> >
> > +       if (remote->foreign_vcs)
> > +               die("Pushing with foreign VCSes not supported.");
> > +
> >        if (!remote)
> >                die("bad repository '%s'", repo);
> >
> Use of remote before NULL check.

Good catch, thanks.

	-Daniel
*This .sig left intentionally blank*
