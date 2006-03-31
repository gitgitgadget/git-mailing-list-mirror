From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: windows problems summary
Date: Fri, 31 Mar 2006 12:25:47 -0700
Message-ID: <m1acb6a01w.fsf@ebiederm.dsl.xmission.com>
References: <81b0412b0603020649u99a2035i3b8adde8ddce9410@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 31 21:26:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPPGq-0000Qg-Hn
	for gcvg-git@gmane.org; Fri, 31 Mar 2006 21:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWCaT0i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Mar 2006 14:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWCaT0i
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Mar 2006 14:26:38 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:11716 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751435AbWCaT0h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Mar 2006 14:26:37 -0500
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k2VJPm3A015620;
	Fri, 31 Mar 2006 12:25:48 -0700
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k2VJPm6A015619;
	Fri, 31 Mar 2006 12:25:48 -0700
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: "Alex Riesen" <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0603020649u99a2035i3b8adde8ddce9410@mail.gmail.com> (Alex
 Riesen's message of "Thu, 2 Mar 2006 15:49:24 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18228>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> This is just to summarize all the problems which make porting to that
> thing so boring. Maybe if we have them all on one page, it'd be easier
> to locate the workarounds (it can be one thread, for example).
>
> 1. opened and mmaped files can't be removed or renamed
>   (caused workaround with reading index in memory)
> 2. command can safely contain only one argument
>   (breaks and complicates passing things between processes)
> 3. no fork
>   (slows down and complicates passing things between processes)
> 4. non-unix permissions model
>   (breaks x-attr)
> 5. real slow filesystems and caching
>   (makes everything slow. I noticed I'm trying to avoid git status!).
>   Caused workaround with manual checkout)
> 6. real slow program startup
>   (makes everything slow, eventually may cause everything being put
>   in one super-executable, just to avoid spawning new processes,
>   with all associated problems. Makes scripting harder)
>
> I hope this message can be a start of a big porting thread,
> even though it is only about windows at the moment.

Not to forget make install gets confused when there
is a file named INSTALL in the git directory.

Eric
