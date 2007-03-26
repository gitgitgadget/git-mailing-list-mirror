From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Added options NO_TCLTK, WITH_P4IMPORT and --with-tcltk/--without-tcltk.
Date: Mon, 26 Mar 2007 01:36:49 -0700
Message-ID: <7vmz20xuxq.fsf@assigned-by-dhcp.cox.net>
References: <etpuen$2uo$2@sea.gmane.org> <20070326073143.GB44578@codelabs.ru>
	<20070326073250.GC44578@codelabs.ru>
	<200703261030.49382.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eygene Ryabinkin <rea-git@codelabs.ru>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 10:36:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVkhD-0000Sq-KX
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 10:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbXCZIgv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 04:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752691AbXCZIgv
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 04:36:51 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:54786 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbXCZIgu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 04:36:50 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070326083650.ETQS22511.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Mon, 26 Mar 2007 04:36:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id fLcp1W0011kojtg0000000; Mon, 26 Mar 2007 04:36:49 -0400
In-Reply-To: <200703261030.49382.jnareb@gmail.com> (Jakub Narebski's message
	of "Mon, 26 Mar 2007 09:30:49 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43133>

Jakub Narebski <jnareb@gmail.com> writes:

> Thanks a lot for the patch, but...
>
> Eygene Ryabinkin wrote:
>
>> Internal make option TCLTK was added: it governs the location of
>> the Tcl/Tk interpreter, so user can specify its own binary location
>> either with './configure --with-tcltk=/path/to/binary' or
>> 'TCLTK=/path/to/binary make'.
>
> ...shouldn't it be TCLTK_PATH?

Thanks for sanity checking.  That means that the absense of
tcltk would make it impossible to munge the scripts to point at
the wish binary, so makes the NO_TCLTK stuff easier to swallow.
