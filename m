From: Denys Duchier <duchier@ps.uni-sb.de>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Fri, 29 Apr 2005 23:57:24 +0200
Message-ID: <86hdhputyz.fsf@speedy.lifl.fr>
References: <200504292044.NAA28429@emf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: noel@zhtwn.com, seanlkml@sympatico.ca, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 23:53:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRdPR-0008Vp-Ma
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 23:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263009AbVD2V6J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 17:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263011AbVD2V6J
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 17:58:09 -0400
Received: from uni-sb.de ([134.96.252.33]:13797 "EHLO uni-sb.de")
	by vger.kernel.org with ESMTP id S263009AbVD2V6F (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 17:58:05 -0400
Received: from cs.uni-sb.de (cs.uni-sb.de [134.96.252.31])
	by uni-sb.de (8.13.4/2005033000) with ESMTP id j3TLw0mA014699;
	Fri, 29 Apr 2005 23:58:00 +0200 (CEST)
Received: from mail.cs.uni-sb.de (mail.cs.uni-sb.de [134.96.254.200])
	by cs.uni-sb.de (8.13.4/2005033000) with ESMTP id j3TLvxFC025573;
	Fri, 29 Apr 2005 23:57:59 +0200 (CEST)
Received: from ps.uni-sb.de (grizzly.ps.uni-sb.de [134.96.186.68])
	by mail.cs.uni-sb.de (8.13.4/2005033000) with ESMTP id j3TLvwBx026592;
	Fri, 29 Apr 2005 23:57:59 +0200 (CEST)
X-Authentication-Warning: mail.cs.uni-sb.de: Host grizzly.ps.uni-sb.de [134.96.186.68] claimed to be ps.uni-sb.de
Received: from ps.uni-sb.de (localhost [127.0.0.1])
	by ps.uni-sb.de (8.12.10/8.12.10) with ESMTP id j3TLvw2Z017085;
	Fri, 29 Apr 2005 23:57:58 +0200
Received: from localhost (localhost [[UNIX: localhost]])
	by ps.uni-sb.de (8.12.10/8.12.10/Submit) id j3TLvsiA017083;
	Fri, 29 Apr 2005 23:57:54 +0200
To: Tom Lord <lord@emf.net>
In-Reply-To: <200504292044.NAA28429@emf.net> (Tom Lord's message of "Fri, 29
	Apr 2005 13:44:03 -0700 (PDT)")
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Tom Lord <lord@emf.net> writes:

>   > My example had Joe downloading a remote signed tree, reviewing the changes
>   > locally between his own trusted tree and the remote tree, 
>
> In the real world, that "review" step is the weak link.  When it goes
> wrong, the first step is to make sure we are reviewing a tree everyone
> involved *intended* -- and it's only with signed diffs adding up to
> that tree that we get there.

Hi Tom,

I hope I am not speaking out of turn or misinterpreting issues beyond my grasp,
but my perception of git is that when you sign a commit, you guarantee that this
is indeed the next step in the chronology of your own branch.  It's not about
diffs; it's about a singular brachial chronology - of course, additional
information may be recorded about topological antecedents, but that's not what
the signature is about.  The diff from that chronology can easily be generated
and scrutinized by anyone, and imported or not into another branch.

Cheers,

-- 
Dr. Denys Duchier - IRI & LIFL - CNRS, Lille, France
AIM: duchierdenys
