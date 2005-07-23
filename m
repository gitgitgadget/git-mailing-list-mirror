From: Junio C Hamano <junkio@cox.net>
Subject: Re: Last mile to 1.0?
Date: Sat, 23 Jul 2005 10:09:43 -0700
Message-ID: <7vzmsdqwiw.fsf@assigned-by-dhcp.cox.net>
References: <7vwtnqhcfb.fsf@assigned-by-dhcp.cox.net>
	<20050723085031.GD3255@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 19:12:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwNXv-0005HQ-EI
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 19:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbVGWRLg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 13:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbVGWRLg
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 13:11:36 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:50156 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S262381AbVGWRJs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2005 13:09:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050723170940.MRVU1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 23 Jul 2005 13:09:40 -0400
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20050723085031.GD3255@mythryan2.michonline.com> (Ryan Anderson's message of "Sat, 23 Jul 2005 04:50:31 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ryan Anderson <ryan@michonline.com> writes:

> How is this for a start?

A very good start indeed.  Thanks.

> Git falls into the category of distributed source code management tools,
> similar to Arch or Darcs (or, in the commercial world, BitKeeper).  This
> means that every working directory is a full-fledged repository with
> full revision tracking capabilities.

I think Kevin's comment is valid and his description is reasonable.

>   o A collection of related projects are building on the core Git
>     project, either to provide an easier to use interface on top (Darcs,
>     Mercurial, StGit, Cogito), or to take some of the underlying concepts
>     and reimplement them directly into another system (Arch 2.0).

I think you would want to drop Darcs and Mercurial from the "on
top" list.  If I understand correctly, Mercurial is
independently written with its own on-disk formats [*1*].  It
would be very unfair to put Darcs in "building on" category.
They've been there for quite some time with their own repository
format and the tools and interfaces are reasonably mature.

Instead, please add gitk and gitweb to the list.  We should not
forget that these "mostly read-only" things are Porcelains.


[Footnote]

*1* It feels that actually it is done right.  Its misfortune is
that many core kernel people have already switched to git.
