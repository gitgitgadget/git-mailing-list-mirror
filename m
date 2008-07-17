From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 13:04:32 -0700 (PDT)
Message-ID: <m3k5fks2et.fsf@localhost.localdomain>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
	<32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com>
	<alpine.DEB.1.00.0807161902400.8986@racer>
	<32541b130807161135h64024151xc60e23d222a3a508@mail.gmail.com>
	<alpine.LNX.1.00.0807161605550.19665@iabervon.org>
	<861w1sn4id.fsf@lola.quinscape.zz>
	<m3od4wse30.fsf@localhost.localdomain>
	<86k5fk1ooq.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jul 17 22:06:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJZjd-0002db-5i
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 22:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932758AbYGQUEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 16:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932744AbYGQUEi
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 16:04:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:59663 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932712AbYGQUEg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 16:04:36 -0400
Received: by ug-out-1314.google.com with SMTP id h2so700493ugf.16
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 13:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=jcaTmzK+2KYDa2oBCuPNtDA95Lwcn4DJGZXRWNh62NQ=;
        b=JsKqtsPDlTLsA9OELn2dBcm/4wWhWj3TQooRS2VvJ6W84ZCnNioAQdKS+FRLFRKCSk
         w8CnRlB6pq50qcAfajpwn9H3QCCjnWz1PJBgUfmEVV5maXiVji5v/UQRDvlnz6RrG3iN
         7VPIaCchoEZf380svJgZ9CtULh0I76Zk+d+vs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=ubVyqIe/6ugIzlf5Udt4wutWURi1Rgm/e1Q/jNQPLUknLsrAqIjk2AXBnNBAp3AwGK
         QWt39q95GrdheVg/r25xNjn2u+tNSw9XMn62LI2zy5fzNZdMVQ0dsqYcqR7klkcz7qQG
         /uIcPt65Ac/QhD9yAZQzIew4g2QgWkRClzm0Y=
Received: by 10.66.236.16 with SMTP id j16mr4201400ugh.31.1216325074330;
        Thu, 17 Jul 2008 13:04:34 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.254.74])
        by mx.google.com with ESMTPS id k1sm14893661ugf.21.2008.07.17.13.04.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Jul 2008 13:04:32 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6HK4VZQ013402;
	Thu, 17 Jul 2008 22:04:32 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6HK4RiB013399;
	Thu, 17 Jul 2008 22:04:27 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <86k5fk1ooq.fsf@lola.quinscape.zz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88906>

[I'm sorry about turning this subthread into Subversion vs. Git rant]

David Kastrup <dak@gnu.org> writes:
> Jakub Narebski <jnareb@gmail.com> writes:
>> David Kastrup <dak@gnu.org> writes:
>>> Daniel Barkalow <barkalow@iabervon.org> writes:

>>>> SVN branches are incredible confusing because they fail to
>>>> distinguish the directory structure of the project's source tree
>>>> from the arrangement of available latest versions.
>>> 
>>> That is because there _is_ no difference.  You just store different
>>> versions in different places.  What they are named is a convention,
>>> nothing more, nothing less.
>>
>> Branching by copying (!) and tagging by copying (!!!) is abuse
>> of the fact that copying in Subversion is cheap.
> 
> Uh, no.  A lot of work has been invested into ensuring that copying in
> Subversion in cheap _exactly_ because of the design decision to
> implement branching and tagging via copying.
> 
> It is not an accident that copying is cheap.

I guess that idea of implementing cheap tree copying and idea of
implementing branches and tags as "full-copies" went hand in hand.

My feeling is that it looks like designing around implementation,
instead of implementing design.

Implementing branches as copies, or in general as directory in
filesystem hierarchy is not that bad idea... provided that one
can flawlessly distinguish between branch and path in project,
can detect where branch name ends and in-project path begins
(perhaps with project/module name in the middle).

Neverheless designing around idea of graph of revisions is, IMVHO,
much superior design :-)
 
>> Distinguishing between branch part of directory name by _convention_
>> is design mistake; the fact that the tool doesn't help to ensure that
>> (a) tags lie on branch (b) tags _doesn't change_ is an example of this
>> stupidity.
> 
> How much have you worked with Subversion so far?  I am doing quite a bit
> of work with it, and the do-everything-via-copying paradigm does not get
> in my hair.  It actually means that I have to remember fewer commands.
> And it is pretty easy to understand.

If you know what you are doing, and have good established workflow...
I was talking there about possibility of mistake (either accident,
or invalid workflow) of either having tag which is not on a branch,
or changing the tag (treating it as branch).

Branches and tags _are_ different.  And should be, IMHO, treated
differently (well, up to a point) by SCM.

>>> Really, Subversion is rather simple to understand.  But it is not a
>>> DVCS.  Moving a history from one repository to another is not really
>>> feasible unless you are doing straight mirroring.
>>
>> Subversion is simple if you are limited to simple things; but the
>> same is true with Git.  I find for example the whole 'properties'
>> mechanism and its use seriously not simple.
> 
> Granted, particularly concerning the external property. OTOH, it makes
> the equivalent of git submodules rather cheap (and I actually still have
> no idea how git submodules properly work and what implications they
> have).

Git submodules are roughly equivalent to svn:externals with peg
revisions; I mean here that they refer not to some branch in some
external repository, but to specific revision.  This is the only sane
design, as it assures that when checking out some historical revision,
the state that is checked out will be the same for everybody.

Please take into account however that submodules are quite new
feature, and while underlying engine is solid, interface (UI) needs
some polishing (and use cases).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
