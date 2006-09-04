From: Junio C Hamano <junkio@cox.net>
Subject: Re: What does "properly support iconv" in git Makefile (NO_ICONV) mean?
Date: Mon, 04 Sep 2006 16:31:13 -0700
Message-ID: <7v4pvnky4e.fsf@assigned-by-dhcp.cox.net>
References: <200609050108.57695.jnareb@gmail.com>
	<20060904231609.GA6855@ferdyx.org>
	<200609050126.56423.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 05 01:30:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKNu0-0005oK-7a
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 01:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbWIDXat (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 19:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbWIDXat
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 19:30:49 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:27579 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S965021AbWIDXas (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 19:30:48 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060904233048.FLIN6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Mon, 4 Sep 2006 19:30:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JPWi1V0031kojtg0000000
	Mon, 04 Sep 2006 19:30:42 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200609050126.56423.jnareb@gmail.com> (Jakub Narebski's message
	of "Tue, 5 Sep 2006 01:26:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26453>

Jakub Narebski <jnareb@gmail.com> writes:

> Gaah, I have some problems accessing the Gentoo bug database.
> Is the problem that iconv does not exist in libc, or it exist but 
> misbehaves?

In small configurations that do not care about i18n, it is often
done to give iconv routines that is noop/ident in order to make
the programs compile and run.
