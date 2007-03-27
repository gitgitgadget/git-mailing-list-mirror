From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Added options NO_TCLTK, WITH_P4IMPORT and --with-tcltk/--without-tcltk.
Date: Mon, 26 Mar 2007 21:12:17 -0700
Message-ID: <7vejnbtjdq.fsf@assigned-by-dhcp.cox.net>
References: <etpuen$2uo$2@sea.gmane.org> <20070326073143.GB44578@codelabs.ru>
	<20070326073250.GC44578@codelabs.ru>
	<200703261030.49382.jnareb@gmail.com>
	<7vmz20xuxq.fsf@assigned-by-dhcp.cox.net>
	<20070326100344.GV14837@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Tue Mar 27 06:12:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW32z-0006FP-Tn
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 06:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbXC0EMU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 00:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932817AbXC0EMU
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 00:12:20 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:51757 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932487AbXC0EMT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 00:12:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070327041219.XUDF321.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Mar 2007 00:12:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id fgCJ1W0081kojtg0000000; Tue, 27 Mar 2007 00:12:19 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43225>

Eygene Ryabinkin <rea-git@codelabs.ru> writes:

> Mon, Mar 26, 2007 at 01:36:49AM -0700, Junio C Hamano wrote:
> ...
>> Thanks for sanity checking.  That means that the absense of
>> tcltk would make it impossible to munge the scripts to point at
>> the wish binary, so makes the NO_TCLTK stuff easier to swallow.
>
> Sorry, did not get the point. The TCLTK is initialized to the 'wish'
> by 'TCLTK ?= wish', so TCLTK will always be here and initialized
> to the wish by-default.

Earlier I said I did not see a reason for not building wish
applications on a build system that lack them.  I am stating
that you could argue that your rewriting the path to wish is a
good reason (I would say it is half-good, as you can still tell
the build procedure where wish will be on the deployed system
without having it on your build system) for not building wish
applications in a build that lacks wish installation.
