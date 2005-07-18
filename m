From: Junio C Hamano <junkio@cox.net>
Subject: Re: Barebone Porcelain.  Where to stop?
Date: Mon, 18 Jul 2005 11:59:40 -0700
Message-ID: <7v8y04q6sj.fsf@assigned-by-dhcp.cox.net>
References: <7vek9yirdi.fsf@assigned-by-dhcp.cox.net>
	<42DB32F1.5020900@gmail.com> <tnx3bqcxvkm.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bryan Larsen <bryan.larsen@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 21:00:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DuaqE-0002M8-5y
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 20:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVGRS7n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jul 2005 14:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVGRS7n
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jul 2005 14:59:43 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:18853 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261510AbVGRS7m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2005 14:59:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050718185942.CACU19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 18 Jul 2005 14:59:42 -0400
To: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Catalin Marinas <catalin.marinas@gmail.com> writes:

> I don't see git going towards stgit at all. Indeed, it gets closer to
> cogito but I still like cogito over plain git since it's easier to use
> (my goal, though, is to add pull/clone commands to stgit so that one
> doesn't need to rely on directly using other tools).

All good to hear.  I do not speak for Linus, but I think core
should not be competing with Porcelain.  To me, there are four
purposes for the barebone Porcelain layer:

 (1) provide the end user a minimum UI to do essential things.

 (2) codify the BCP/convention to use the core by higher level
     SCMs to help them stay compatible with each other where
     possible (e.g. "what .git/HEAD means, when it gets updated,
     and to what" was discussed recently).

 (3) serve as an example for people interested in learning the
     core GIT (i.e. they may be starting their own Porcelain).

 (4) implement operations that are heavy on logic/convention but
     does not have much UI need so that higher level SCMs can
     implement their own UI by just being a thin wrapper around
     them (e.g. clone/fetch and push).

> I am aware that, probably, the biggest problem with stgit is the
> documentation (and also a lack of regression tests). I hope I will
> find some time soon to write a tutorial and improve the command line
> help. I will setup a wiki in the next few days so that others can
> easily fix/update the documentation.

Wonderful.
