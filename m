From: Steven Drake <sdrake@xnet.co.nz>
Subject: Re: [PATCH 1/2] Add `init-db.templatedir` configuration variable.
Date: Mon, 18 Jan 2010 16:54:09 +1300 (NZDT)
Message-ID: <alpine.LNX.2.00.1001181627220.2911@vqena.qenxr.bet.am>
References: <alpine.LNX.2.00.1001131719050.22639@vqena.qenxr.bet.am> <7vljg2pewo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 05:01:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWini-0008Mu-S2
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 05:01:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857Ab0AREBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 23:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752452Ab0AREBJ
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 23:01:09 -0500
Received: from ananke.wxnz.net ([58.28.4.122]:43311 "EHLO ananke.wxnz.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752257Ab0AREBG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 23:01:06 -0500
Received: from idran.drake.org.nz (ip-118-90-76-252.xdsl.xnet.co.nz [118.90.76.252])
	by ananke.wxnz.net (Postfix) with ESMTP id 83692170F50;
	Mon, 18 Jan 2010 17:01:01 +1300 (NZDT)
In-Reply-To: <7vljg2pewo.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137366>

On Wed, 13 Jan 2010, Junio C Hamano wrote:

> Steven Drake <sdrake@xnet.co.nz> writes:
> 
> > Include `init.templatedir` as an alias for `init-db.templatedir`.
> 
> This describes what the patch adds, which we can read in the diff *if* we
> wanted to.  The primary job of the first paragraph of the proposed commit
> log message is to convince reviewers why it might be worthwhile to read
> the diff, and to explain whoever reads "git log" output in the future what
> motivated this change to be made.
> 
> Your log message doesn't say anything about why it is a good idea to add
> this feature, which is much more important to talk about [*1*].
> 
> The target _may_ be probably to have this in $HOME/.gitconfig so that your
> personal templates in $HOME/.gittemplate/ are used in all repositories you
> will create.  But you shouldn't make me, anybody who reviews, or readers
> of the documentation for that matter, *guess* what problem the new feature
> is meant to solve.
> 
> IOW, code talks what it itself does, but it often cannot say why it does
> what it does, nor why a particular way it does what it does was chosen.
> You help your code justify itself by describing the motivation in your
> commit log message.

Thanks for the advise if you cann't tell I'm used to writing spares message
both in log messages and email, so this is a great help as to what to
write.  I'll resubmit some improved patches with better log messages.

On that subject do you prefer resubmits as replies to the originals or new
email? 

Do you accept email that use inbodyr-headers and/or scissors?


-- 
Steven
"won't be big"
	-- Linus Torvalds, 25 Aug 1991 - in his first post about linux.
