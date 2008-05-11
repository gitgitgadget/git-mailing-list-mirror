From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Verilog/ASIC development support is insufficient in git , help!
Date: Sun, 11 May 2008 02:23:54 -0700 (PDT)
Message-ID: <m363tl5h41.fsf@localhost.localdomain>
References: <EB66C79C87CF49E59CB39EA4C286AE05@justinuTop>
	<BA7F9A3C7EDA4CDD99016093B0DB55C0@justinuTop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, <justin0927@hotmail.com>
To: "Justin Leung" <jleung@redback.com>
X-From: git-owner@vger.kernel.org Sun May 11 11:24:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv7nZ-0004Vv-Ex
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 11:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509AbYEKJYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 05:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752491AbYEKJYC
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 05:24:02 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:33515 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752320AbYEKJX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 05:23:59 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1402538fgg.17
        for <git@vger.kernel.org>; Sun, 11 May 2008 02:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=m5CdSXXTxXJ+wtyb2wbkdlSAZT7UctarMfmWyyTBSJY=;
        b=WmOpRQzxvFPpYtJ7VodttPlKHTboFkvhpl73t5l8Sx+KertGChQoa1Ad2MFi51do1sQ33JLeOVjAMRELwL4JzYRLpnHmPX2hAH295I4a4TiqL1ixsLmAT5rspEi+ylh6ReZa7j3JW7DQEi5GVxOcGW9K7BmLFv9cJSJ6qIfll8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=Ll+iuvsLyok10qduKNN8ubZzy2mZ9xOjRuzVThsJuDiI/rz2cvFEnK8lBnB/15YsDUl3g8Z8TWf7tIui6DHYRz0EEvaK8KuAWMj/TrNlctbepMRV6xQj+GZyYvB0X5jz3c6Xmc7VvRWspi/sOa6OJalfBl/DTbE1Rj0QAeypioI=
Received: by 10.86.96.18 with SMTP id t18mr12004020fgb.2.1210497836171;
        Sun, 11 May 2008 02:23:56 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.226.146])
        by mx.google.com with ESMTPS id e11sm5169898fga.1.2008.05.11.02.23.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 May 2008 02:23:54 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m4B9Nj7w002763;
	Sun, 11 May 2008 11:23:49 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m4B9NgtA002760;
	Sun, 11 May 2008 11:23:42 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <BA7F9A3C7EDA4CDD99016093B0DB55C0@justinuTop>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81753>

"Justin Leung" <jleung@redback.com> writes:

> Hi all,
> 
> * This email probably represent the whole hardware ASIC community
>   about git *
> 
> I'm evaluating Git as the replacement of CVS for the ASIC group in
> my company, but things are moving along very bumpy.
> 
> I (and many others doing the evaluation) love the tool dearly; we
> love the local repository and inter-db sync'ing .  I see a lot of
> potential in productivity and changes in work model that helps
> efficiency in ASIC dev.

Please note that Git is not the only OSS DVCS.  There is Mercurial,
which has repute of being easy to use (in my opinion: at least for
mainly linear development), and there is Bazaar (formerly Bazaar-NG).
Both are mature products.

IMHO the main strength of Git (besides performance, but now I think it
is less of an edge, especially for not very large projects) is deling
with nonlinear history and branch-based (topic  branches) development.
If that is the worth paying essential complexness (as opposed to
accidental complexness, which unfortunately Git also has some) for...

> BUT, my managers, some veterans, and directors are EXTREMELY
> concerned about the ease-of-use..  so much that they are going to
> pick SVN !  uh-oh....i m serious =(
> 
> Alot of people argued, why not SVN ? it's CVS++ and it's ease of use
> not a problem when comparing to Git.

Perhaps Subversion is the right tool for you.

> Here are the things not fitting right in ASIC dev:
> 
> - no incremental revision numbers (they are so scared of the 40hex SHA1)

Incremental revision numbers _require_ single, central authority
assigning them.  You cannot have simple revision numbers in truly
distributed development.

Both Mercurial and Bazaar allow to use incremental revsision numbers,
at least for revisions (commits) along trunk (mainline).  Note that
revision numbers are either local to repository (Mercurial, Bazaar),
or require treating one of repository as special, i.e. use different
commands for central repository from commands used when merging in
other repositories (Bazaar).

> - Inability to reference without SHA1, they want simple numbering (ie,
> version 100, 120, 120.1, 130.4.5)

You can tag, and use git-describe output, i.e. v1.4.2, or
v1.5.5.1-182-g7480b28.  Or you can use transitional "reverse"
numbering, counting from latest revision, like HEAD^, master~10,
or master@{2} (the last has only local meaning, and only if reflogs
are enabled which is now default).

> - Inability to refer to a file by a simple number

Errr... refer to _file_ by a number? Why not a pathname, or revision
and pathname (<rev>:<path> format)?

> (the backend guys will be confused by SHA1; they can't work with
> anything more than 4-5 digits)

You can use shortened sha1, usually 7 characters... but I think this
is an artificial fear.  When using git you almost never have to use
either SHA1, or shortened SHA1 identifier.

> - Complexity of commands (although we can have warpper, but real git
> commands for non-sw guys is not going to happen)

Now that Cogito is unmaintained, you can try EasyGit (eg) or Pyrite,
although AFAIK both are in early development stages.  And there is
also git-gui and other commit tools there...

> Most hardware chip designers were using CVS since their first job.
> It suited the purpose very well.

And is probably responsible for some SCM bad habits...

> Most RTL design veterans only use less then 5-6 cvs commands in their
> whole life (LOL, i m serious)
[...]
> We don't use branches.

Bad habit!

Probably because branching in CVS was very complicated, error prone,
and just plain uncomfortable to use (sticky tags, blehhh...).

Subversion makes it easy to branch, but developers forgot to make it
easy to merge (this is to be corrected in upcoming 1.5 release, and
you can migitate it using third party tools / extensions like svnmerge
or SVK; the last also gives replicability, and beginnings of
distributed development).

> Our model is strict forward with a centralized, one main branch model
> to avoid mistakes .
> We see branches as evil ; some merges in Verilog codes means another
> 10+ hours of simulation and regression.

Bad habit!

Branches are there to not stomp on each other changes when deveoping
independent features.  They are also a must have if you plan to
maintain fixes to old releases.

When merging is easy it allows you to merge early, or do a try merge,
and fix conflict early, when they are easy to spot and resolve.

Please watch Linus Torvalds opinionated Google Tech Talk on Git:
  http://www.youtube.com/watch?v=4XpnKHJAok8
  http://git.or.cz/gitwiki/LinusTalk200705Transcript

> I'm a verification engineers for the hardware chips designers, there
> we use Vera and SystemVerilog which requires much in
> depth use of SCM functions.  So, the choice of tools is much more
> important on our side (the designers only checkin and out, diff, and
> minimal merging)

Could you elaborate? What SCM functions do you need?

> I m frustrated about the situration, i truly want Git in ASIC world !!!
> (yell out loud... no p4, no svn, no clearcase... or i rather keep cvs)

Subversion _is_ improvement on CVS, some brain damages of it aside (as
for example lack of _unchangeable_ tags; and no, unchangeable by
convention doesn't count).  You can use git-svn to interact with it.
 
> Is there a way to specify the use of a simple GIT model in config,
> or like, info/attribute, such that (in git main repository model of
> course):
> 
> (1) SHA1s are hidden, but replaced by simple numbers
> (2) Simple, incremental numbers (like 'git-5432' ; what we use
> 'git-describe' to generate)
> (3) Reference of simple revision numbers in all git commands and tools
> like gitk, not SHA1

I think you can get it by heavy use of tags from within hooks, even
without changes to git core, and without using any wrapper /
porcelain.  But this might affect performance.

Note (again) that "simple numbers" for revision names are possible
_only_ in centralized development, with centralized authority
assigning those incremental numbers ("monitor" in parallell
computing).

> I personally have no problem with the SHA1 . but many are allergic to it .

Again: in my use of git I almost never need to use SHA1, or shorthened
SHA1, even for copy'n'paste.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
