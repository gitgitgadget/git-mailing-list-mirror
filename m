From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Notes on supporting Git operations in/on partial Working Directories
Date: Fri, 15 Sep 2006 11:15:27 -0700
Message-ID: <450AEDBF.9050307@gmail.com>
References: <4509A7EC.9090805@gmail.com>	<7vu03a2po8.fsf@assigned-by-dhcp.cox.net> <4509B954.60101@gmail.com> <7v8xkl26kb.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 15 20:15:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOIDu-0003u3-Dq
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 20:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWIOSPb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 14:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWIOSPb
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 14:15:31 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:6791 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932136AbWIOSP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Sep 2006 14:15:29 -0400
Received: by py-out-1112.google.com with SMTP id n25so4173137pyg
        for <git@vger.kernel.org>; Fri, 15 Sep 2006 11:15:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=VndftcQ/+mNX7yEUyNZRJeYp7rl5vZgEgvDhZmUNHRsPfts+lpKd4icEyWyaX0cPAgCWTrF/Asco1e92gSvTouHwYvaDhAUFSC2pKNdqamjaoEfQjDnJ3jNiEzE6mLkWgfy/iVZzDQ7cfk0vAy2pwKybe0kEfKpG+RBENgXtr0I=
Received: by 10.35.35.17 with SMTP id n17mr3201887pyj;
        Fri, 15 Sep 2006 11:15:29 -0700 (PDT)
Received: from ?10.0.0.6? ( [24.55.157.69])
        by mx.gmail.com with ESMTP id k13sm4031933pyf.2006.09.15.11.15.28;
        Fri, 15 Sep 2006 11:15:29 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xkl26kb.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27096>

Junio C Hamano wrote:
...
> 
> Having said that, I do not necessarily agree that highly modular
> projects would want to put everything in one git repository and
> track everything as a whole unit.

And yet that's exactly how a lot of developers use CVS. You can argue 
that some other way is better but when they move from CVS they're 
looking for continuity of productivity which often means not radically 
changing how they work. At least in the short term.

> The primary audience of git, the kernel project, is reasonably
> modular (although Andrew seems to be suffering from subsystem

I no longer believe that the Linux kernel developers are the "primary 
audience". They are certainly an important and influential set of Git 
users but there are also a lot of non kernel projects using Git. If not 
now, there will soon be more non kernel Git users than kernel Git users.

[Nice description of how to work with the Linux kernel code base.]

[Nice description of one way a hypothetical project with dependencies on 
libraries under active development could work.]

> I think what truly huge but highly modular projects need is a
> good support to lay-out check-outs from multiple subprojects,
> each of which is managed in its own repository but has loose
> (looser than the level of individual commits) version
> dependency.  That would need to solve three issues: (1) the
> right versions from many repositories need to be checked out in
> correct locations for a build, (2) after building and testing to
> make sure they work together as a whole, these specific versions
> from the subcomponent repositories need to be tagged to mark a
> release, and (3) maybe a single large tarball that contains all
> subprojects' checkout can be made easily.
 >
> So the issue may not be partial repository support, but support
> for managing multiple projects.

There's no question that that may be better for some projects. But I 
believe that the project members (or owners) should decide how they use 
their tools.
