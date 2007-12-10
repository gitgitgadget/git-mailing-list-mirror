From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Adding Git to Better SCM Initiative : Comparison
Date: Mon, 10 Dec 2007 07:47:49 -0800 (PST)
Message-ID: <m34peqtuuj.fsf@roke.D-201>
References: <200712101357.49325.jnareb@gmail.com>
	<87ve76mwos.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shlomi Fish <shlomif@iglu.org.il>
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Mon Dec 10 16:48:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1krh-0003Ua-CG
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 16:48:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbXLJPrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 10:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752474AbXLJPry
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 10:47:54 -0500
Received: from wr-out-0506.google.com ([64.233.184.233]:22770 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125AbXLJPrx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 10:47:53 -0500
Received: by wr-out-0506.google.com with SMTP id c49so1322046wra
        for <git@vger.kernel.org>; Mon, 10 Dec 2007 07:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=Vk4xIIPPiUr1guPwnrCTjAq+e+ioOzXV7HZrblIdTPI=;
        b=ceYOh48gBpoDz66W50zIb1i+a8bleNZcu/UB69zDAJR+PJ5/TyjydVhXo46S476QZbnblIexNy9kv8XpdfZm2WE4b/qoVZlM8jrPwGKh47IfzuVZzg4RUwlSGx47G+OIo97VSINpy++KSzVW150FtEqS07wBZSO4I+OUCfyP4bw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=KwIi6+EaJSAKIE68K+CEEeU++9TwQekVKZrNH8uqwG9Vr/MoDdGm5W73IIyL7xZVxogPXXj8fuytRXeECJhVvRPgeWeGFqwCcMdpJn8hsqbDK0xzMHZmlem+FGdXtSDxtiwNSGQL5ulPVDyOLyc2ZBt+JyTNJXXBCLMG3+YpdUQ=
Received: by 10.78.186.9 with SMTP id j9mr7237082huf.1197301670831;
        Mon, 10 Dec 2007 07:47:50 -0800 (PST)
Received: from roke.D-201 ( [83.8.241.16])
        by mx.google.com with ESMTPS id i5sm8401589mue.2007.12.10.07.47.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 10 Dec 2007 07:47:49 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lBAFldcK028986;
	Mon, 10 Dec 2007 16:47:40 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lBAFlXdA028982;
	Mon, 10 Dec 2007 16:47:33 +0100
X-Authentication-Warning: roke: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <87ve76mwos.fsf@mid.deneb.enyo.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67725>

Florian Weimer <fw@deneb.enyo.de> writes:

> * Jakub Narebski:
> > @@ -214,6 +225,13 @@ <title>File and Directories Copies</title>
[...]
> > +                <s id="git">
> > +                    Yes (or no depending on interpretation). Git
> 
> This should be "No." (same for copies below).

I would agree to "N/A" or "Partial", but with 'git log --follow'
implemented at least for single file I wouldn't say that that git
doesn't support file and directories renames (copies).  It does, in
it's own fashion, using rename (copy) detection instead of rename
(copy) tracking.

By the way, the explanation for "File and Directories Copies" section
itself is a bit imprecise; well at least it doesn't lead to easy
answer for git.  I took it as question if we can examine _history_
of a file (or directory) across renames (copies).  Other
interpretation would be if version control system in question
correctly handles renames and copies during merges... but it is in
TODO (Add intelligent merging of renamed paths.)
 
> > +                <s id="git">
> > +                    Partial (?). It is possible to lock down repository
> > +                    (access to branches and tags) using hooks.
> > +                </s>
> 
> I doubt this works reliably.  You still can access data once you've got
> its SHA1 hash, for instance.

So what? The data is not visible, so it is as if it didn't
exist. Besides if you are truly paranoid you can I think remove
downloaded pack.

By the way the default 'contrib/hooks/update-paranoid' implements ACL
restricting access to branches and tags, but I think that you can
write a hook which would refuse update if there are changes outside
specified subdirectory for example.

Note however that "repository permissions" are much more important for
centralized SCMs than for distributed SCMs, where you can form
"network of trust" (like Linus with his kernel's lieutenants and
subsystem maintainers).

> > +                <s id="git">
> > +                    Yes. Changesets are supported.<br />
> > +                    Actually Git is snapshot based which means Git records
> > +                    the full state in every commit.  This means that any two
> > +                    commits can be compared directly very quickly, although the
> > +                    repository is typically browsed as a series of changesets.
> > +                </s>
> 
> I don't think this explanation is necessary.  What does Subversion say?

Subversion has the following currently:

  Partial support. There are implicit changeset that are generated on
  each commit.


Well, we could follow Mercurial, Monotone and Darcs and simply write

+                <s id="git">
+                    Yes. Changesets are supported.
+                </s>

> > +                <s id="git">
> > +                    Yes. (git blame, git gui blame).
> > +                    It can also detect the origin of copied and moved source
> > +                    lines, and can ignore whitespace changes.
> > +                </s>
> 
> A simple "Yes." should suffice.

Each SCM names the command for displaying line-wise file history,
if it of course exists.

While "can ignore whitespace changes" is not that important, detection
of contents movement and copying is important differentiation,
possible (or at least implemented) because Git uses rename detection
rather than rename tracking.
 
> > @@ -636,6 +677,10 @@ <title>Tracking Uncommited Changes</title>
> >                      Yes, using "darcs whatsnew".
> >                  </s>
> >                  <s id="aegis">Yes. Using aediff</s>
> > +                <s id="git">
> > +                    Yes, of course. Using git diff.
> > +                    Note that git uses staging area for commits (index).
> > +                </s>
> 
> Simply "Yes.".  "git diff" is wrong, it's actually "git diff HEAD".

Actually it depends on the definition of "uncommitted changes".
Besides "git diff HEAD" _is_ "using git diff".

But it's true that 'of course' there is not needed.

> > @@ -681,6 +726,11 @@ <title>Per-File Commit Messages</title>
> >                  <s id="darcs">
> >                      No.
> >                  </s>
> > +                <s id="git">
> > +                    No.  The message applies to the commit as a whole.
> > +                    But you can tag (with description) given contents
> > +                    of a file (blob).
> > +                </s>
> 
> Have we got any real tool support for this?  This should be "No.".

True. But I'd rather leave it as "No. The message applies to the
commit as a whole." because that is important property.

> > @@ -1006,6 +1075,13 @@ <title>Command Set</title>
> >                      but since the model is different most commands are
> >                      unique.
> >                  </s>
> > +                <s id="git">
> > +                    Tries to follow CVS conventions, but deviates where there
> > +                    is a different design (following BitKeeper for DVCS).
> 
> I don't think this is true.  Is there any command that closely matches
> what CVS does?

Yes: init, add, annotate (alias to blame), checkout, commit, diff,
status, log, version. At least in principle, if not in output format.

I don't think that Mercurial and Monotone follow CVS much better than
Git. (But that was one of answers I was having problems with.)

> > @@ -1203,6 +1286,11 @@ <title>Portability</title>
> >                      Very good. Supports many UNIXes, Mac OS X, and Windows,
> >                      and is written in a portable language.
> >                  </s>
> > +                <s id="git">
> > +                    Good to very good.  Portable across all POSIX systems.
> > +                    There exists Win32 binary using MinGW (msysGit),
> > +                    or you can use binary provided by Cygwin.
> > +                </s>
> 
> Isn't Windows support still a bit lacking in terms of performance?

That is more a problem with Windows, than Git ;-)

-- 
Jakub Narebski
Poland
ShadeHawk on #git
