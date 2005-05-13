From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] update README and #include in git.txt
Date: Sat, 14 May 2005 00:13:06 +0200
Message-ID: <20050513221306.GB32232@pasky.ji.cz>
References: <4283CB19.3050208@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 14 00:15:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWiR0-0001oT-4r
	for gcvg-git@gmane.org; Sat, 14 May 2005 00:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbVEMWTJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 18:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbVEMWSE
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 18:18:04 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48264 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262580AbVEMWNP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 18:13:15 -0400
Received: (qmail 4516 invoked by uid 2001); 13 May 2005 22:13:06 -0000
To: David Greaves <david@dgreaves.com>
Content-Disposition: inline
In-Reply-To: <4283CB19.3050208@dgreaves.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, May 12, 2005 at 11:31:05PM CEST, I got a letter
where David Greaves <david@dgreaves.com> told me that...
> Makefile understands the includes git.txt #includes README
> README reformatted to asciidoc to allow inclusion in git.txt
> 
> Signed-off-by: David Greaves <david@dgreaves.com>

Is it just me or this commit message is really weird? :-)

> Index: README
> ===================================================================
> --- 3c79088f1832d78012ccdb63e5da1ab88fcf408e/README  (mode:100644)
> +++ e0e578bb02a7d8db1c105fddf5b5168ad0c79088/README  (mode:100644)
> @@ -1,9 +1,13 @@
> +////////////////////////////////////////////////////////////////
> +	GIT - the stupid content tracker
> 
> 
> -
> -	GIT - the stupid content tracker
> +Note that this README is written in asciidoc format and is #include'd
> +in the git.txt docs
> 
> 
> +The rest of this README is #included in the git.txt file
> +////////////////////////////////////////////////////////////////
>  "git" can mean anything, depending on your mood.
> 
>   - random three-letter combination that is pronounceable, and not

I'd probably prefer this being much less prominent. Can it be rather at
the bottom of the file?

> -the object (i.e. how it is used, and how it can refer to other objects).
> -There are currently three different object types: "blob", "tree" and
> -"commit".
> +the object (ie how it is used, and how it can refer to other objects).
> +There are currently four different object types: "blob", "tree",
> +"commit" and "tag".

You're reintroducing the "typos" fixed before, apparently.

>  A "blob" object cannot refer to any other object, and is, like the tag
>  implies, a pure storage object containing some user data.  It is used to
> @@ -48,7 +50,7 @@
>  directory structure. In addition, a tree object can refer to other tree
>  objects, thus creating a directory hierarchy.
> 
> -Finally, a "commit" object ties such directory hierarchies together into
> +A "commit" object ties such directory hierarchies together into
>  a DAG of revisions - each "commit" is associated with exactly one tree
>  (the directory hierarchy at the time of the commit). In addition, a
>  "commit" refers to one or more "parent" commit objects that describe the
> @@ -62,12 +64,17 @@
>  just going to confuse people.  So aim for the notion of "one root object
>  per project", even if git itself does not enforce that.
> 
> +A "tag" object symbolically identifies and can be used to sign other
> +objects. It contains the identifier and type of another object, a
> +symbolic name (of course!) and, optionally, a signature.
> +

I think those changes should be either sent as a separate patch or noted
as being done in the commit message.

> @@ -245,216 +274,209 @@
> 
> 
> 
> -	The Workflow
> -
> -
> +The Workflow
> +------------


Cannot at least the newlines be preserved?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
