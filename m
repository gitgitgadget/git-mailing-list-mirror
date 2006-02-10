From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Fri, 10 Feb 2006 22:47:23 +0100
Message-ID: <20060210214723.GP31278@pasky.or.cz>
References: <20060210195914.GA1350@spearce.org> <20060210211740.GO31278@pasky.or.cz> <20060210213818.GB1604@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Feb 10 22:47:00 2006
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1F7g6V-0005Ng-00
	for <gcvg-git@gmane.org>; Fri, 10 Feb 2006 22:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWBJVq4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 16:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWBJVq4
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 16:46:56 -0500
Received: from w241.dkm.cz ([62.24.88.241]:24793 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932209AbWBJVq4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2006 16:46:56 -0500
Received: (qmail 14602 invoked by uid 2001); 10 Feb 2006 22:47:23 +0100
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060210213818.GB1604@spearce.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15889>

Dear diary, on Fri, Feb 10, 2006 at 10:38:18PM CET, I got a letter
where Shawn Pearce <spearce@spearce.org> said that...
> But two things happened:
> 
>   1) Cogito didn't run well on a Solaris box I wanted to try and
>      use it in; apparently we don't have enough GNU shell commands
>      available and Cogito fell over.  (But right now I'd bet pg
>      will behave the same if not worse. I haven't had time to try
>      it. *sigh*)

I'm always listening for bugreports. Besides requiring bash, Cogito _is_
expected to run on POSIX stuff!

>   2) I found myself suddenly typing 'pg-log' and 'pg-diff' rather
>      than 'git-log' and 'git-diff'.  Call it future muscle memory?
>      I hadn't written either of these scripts so I was getting a lot
>      of '-bash: pg-log: command not found' errors from my shell.
>      So they both became 1 line wrappers around the git-core
>      versions, just to save my sanity.

I see. IIRC Catalin gave the similar reasoning. (Obviously, my
egoistical me might be just hurt by it not wrapping Cogito. ;))

> > But while it claims to be compatible with all the porcelains, it at
> > least cannot be clone by them. ;) The GIT repository is not quite a
> > valid GIT repository since it is missing the HEAD and Cogito clones
> > based on this file instead of just assuming that your head is on the
> > master branch.
> 
> Fixed.

Thanks.

> > Also, when cloning it gives me a little unnerving errors like
> > 
> > error: File 6427c0154400f578d9cdff178e01e946db6f714f
> > (http://www.spearce.org/projects/scm/pg.git/objects/64/27c0154400f578d9cdff178e01e946db6f714f)
> > corrupt
> 
> I've seen the same.  I think it is either a bug in my rsync script
> or a bug in the GIT http clone code; because that is the current
> tip commit of the master branch.  And I've only seen that error for
> the tip commit, and only if the object doesn't exist in the object
> directory because I've done git-pack && git-prune-packed.

On a second thought, this is probably simply caused by the web server
not reporting 404 on missing files.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
