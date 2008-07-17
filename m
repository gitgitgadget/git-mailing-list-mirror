From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 08:52:22 -0700 (PDT)
Message-ID: <m3od4wse30.fsf@localhost.localdomain>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
	<32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com>
	<alpine.DEB.1.00.0807161902400.8986@racer>
	<32541b130807161135h64024151xc60e23d222a3a508@mail.gmail.com>
	<alpine.LNX.1.00.0807161605550.19665@iabervon.org>
	<861w1sn4id.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jul 17 17:54:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJVnq-0005jb-0U
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 17:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756709AbYGQPw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 11:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756545AbYGQPw6
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 11:52:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:21882 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755336AbYGQPw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 11:52:57 -0400
Received: by ug-out-1314.google.com with SMTP id h2so670102ugf.16
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 08:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=m+wcEkHPi3F50zAbP3hG6Ka8klEWbzYQOnC3dmYeBX8=;
        b=p/WY/HipCV1WJe7/XmLo+a9tjO437UlkMAdvon+D7iIl1BSOuBEdCSpy7kbC6JimwV
         VrGWQ7fz9tK6lJVOgYA+aBHad2VjXZZUidIC8ZtBBbFb1pd7Aik1gsYymMAwFSCzpHQg
         axLV5Zj/TfjyaGeYJR2roPbmiR2ruZSrz0cJw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=XM6nIjtmId2CY7BpeTzPVCnRgWBgJ032J3cUWzn2CyuuxKqHV/9FPFWA9oNFk/PBtD
         U06Nsqw5eRYhXnibYaYs6/c7aZN9l97h917lyZ0KfAzSAnM0KoFNpSk6Ojjd7TAAO0cT
         gGr7oJQlWeuVl3TxtUlaai4vudCw1t78UiWn0=
Received: by 10.67.115.18 with SMTP id s18mr3995400ugm.52.1216309943696;
        Thu, 17 Jul 2008 08:52:23 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.254.74])
        by mx.google.com with ESMTPS id q1sm14313713uge.16.2008.07.17.08.52.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Jul 2008 08:52:22 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6HFqKFX011890;
	Thu, 17 Jul 2008 17:52:20 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6HFqJZb011887;
	Thu, 17 Jul 2008 17:52:19 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <861w1sn4id.fsf@lola.quinscape.zz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88866>

David Kastrup <dak@gnu.org> writes:

> Daniel Barkalow <barkalow@iabervon.org> writes:

> > You're simply wrong. A ref isn't a name for a commit (the point of
> > having a ref is that it doesn't persist in naming the same commit). A
> > commit isn't a blob. If you start telling people complicated and wrong
> > things, they're surely going to be confused.

A ref is a pointer.  In the case of branches it is named pointer
to a commit, "tip of growth" of a branch (to stay with analogy from
biology).

> > Git maintains history as a directed graph, with each commit pointing
> > back at its history. Refs are the what holds the newest commits that
> > nothing else points back to. If directed graphs aren't in your users'
> > experience, you can put it this way: git maintains history like
> > knitting, where each new stitch holds on to one or more previous
> > stitches, and refs are the knitting needles that hold the ends where
> > you're working (except that knitting is a lot wider than software
> > development). gitk --all even provides the diagram you want to explain
> > it.
>
> Complicated and right things are not much less confusing...
 
For me the idea that commits contain pointers to state of repository
(state of project) at given "time" and pointers to its parents, and
those make history simple yet powerfull one.

Nevertheless simple ideas not always are easily to explain...

> > SVN branches are incredible confusing because they fail to distinguish
> > the directory structure of the project's source tree from the
> > arrangement of available latest versions.
> 
> That is because there _is_ no difference.  You just store different
> versions in different places.  What they are named is a convention,
> nothing more, nothing less.

Branching by copying (!) and tagging by copying (!!!) is abuse
of the fact that copying in Subversion is cheap.  Distinguishing
between branch part of directory name by _convention_ is design
mistake; the fact that the tool doesn't help to ensure that
(a) tags lie on branch (b) tags _doesn't change_ is an example
of this stupidity.
 
> > And the version numbers for your branch increase when changes are made
> > to other branches.
> 
> You are confusing "version numbers" which are assigned by humans with
> "revision numbers" which are just an administrational timeline for the
> whole repository.
> 
> Really, Subversion is rather simple to understand.  But it is not a
> DVCS.  Moving a history from one repository to another is not really
> feasible unless you are doing straight mirroring.

Subversion is simple if you are limited to simple things; but the
same is true with Git.  I find for example the whole 'properties'
mechanism and its use seriously not simple.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
