From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] annotate: Support annotation of files on other revisions.
Date: Sun, 05 Mar 2006 22:16:36 -0800
Message-ID: <7vpsl0ayij.fsf@assigned-by-dhcp.cox.net>
References: <20060305111334.GB23448@c165.ib.student.liu.se>
	<440B751F.5000801@michonline.com>
	<46a038f90603051629ke34a0a6u89dad995bbd777b0@mail.gmail.com>
	<20060306024353.GA23001@mythryan2.michonline.com>
	<440BC92E.4060306@gmail.com> <440BCB67.4070406@michonline.com>
	<20060306055036.GB26820@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Mar 06 07:16:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG91O-0007Vg-HC
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 07:16:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWCFGQk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 01:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWCFGQk
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 01:16:40 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:56227 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751359AbWCFGQj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Mar 2006 01:16:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060306061517.XZVP15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 6 Mar 2006 01:15:17 -0500
To: git@vger.kernel.org
In-Reply-To: <20060306055036.GB26820@spearce.org> (Shawn Pearce's message of
	"Mon, 6 Mar 2006 00:50:36 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17277>

Shawn Pearce <spearce@spearce.org> writes:

> 	git-diff Makefile
> 	git-diff HEAD Makefile
>
> ?  (Which is rather ugly as what if you have a tracked file actually
> called HEAD and you want the first form when the commit-ish is
> omitted.)  So accepting an optional commit-ish before the filename
> would be in line with what git-diff accepts today.

The use of "start of filelist" marker "--" is optional when
unambiguous, and that is why "git-diff Makefile" works.  To view
the change you still haven't update-index'ed to the path called
"HEAD", you would naturally say "git-diff -- HEAD"
