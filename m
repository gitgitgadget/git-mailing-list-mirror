From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-log --full-history renamed-file
Date: Fri, 09 Mar 2007 18:14:10 -0800
Message-ID: <7v6499zvyl.fsf@assigned-by-dhcp.cox.net>
References: <87lki6umts.fsf@rho.meyering.net>
	<Pine.LNX.4.64.0703091339190.10832@woody.linux-foundation.org>
	<7v8xe53ok5.fsf@assigned-by-dhcp.cox.net> <est24q$p4n$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 03:14:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPr69-0007Es-9a
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 03:14:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767725AbXCJCOM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 21:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767726AbXCJCOM
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 21:14:12 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:36978 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767725AbXCJCOL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 21:14:11 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070310021411.JVCN748.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Fri, 9 Mar 2007 21:14:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id YqE91W00W1kojtg0000000; Fri, 09 Mar 2007 21:14:10 -0500
In-Reply-To: <est24q$p4n$1@sea.gmane.org> (Jakub Narebski's message of "Sat,
	10 Mar 2007 02:40:07 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41840>

Jakub Narebski <jnareb@gmail.com> writes:

> By the way, while it is fairly easy to follow one file, it is hard
> to follow directory or glob... and there is a trouble that one file
> might come from two files (as concatenation for example; but I don't
> think git can detect it with default values of rename detection
> heuristics). 

That's why Linus's proof-of-concept is based on the git-blame
engine.
