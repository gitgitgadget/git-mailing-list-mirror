From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] allow commands to be executed in submodules
Date: Sun, 20 May 2007 11:25:24 -0700
Message-ID: <7vhcq7mjxn.fsf@assigned-by-dhcp.cox.net>
References: <20070520153908.GF5412@admingilde.org>
	<20070520181433.GA19668@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Waitz <tali@admingilde.org>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 20 20:25:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpq60-0002Fj-BX
	for gcvg-git@gmane.org; Sun, 20 May 2007 20:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757136AbXETSZ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 14:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756942AbXETSZ0
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 14:25:26 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:51805 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756915AbXETSZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 14:25:25 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070520182525.BEUL13995.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 20 May 2007 14:25:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 1WRQ1X00F1kojtg0000000; Sun, 20 May 2007 14:25:25 -0400
In-Reply-To: <20070520181433.GA19668@steel.home> (Alex Riesen's message of
	"Sun, 20 May 2007 20:14:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47880>

Alex Riesen <raa.lkml@gmail.com> writes:

> Martin Waitz, Sun, May 20, 2007 17:39:08 +0200:
>> Add an extra "submodule" field to struct child_process to be able to
>> easily start commands which are to be executed in a submodule
>> repository.
>
> How about making it more generic by allowing to specify the directory
> to change to and environment for subprocess? You probably will be able
> to convert even some of existing code to your new run_command then
> (merge_recursive in builtin-revert.c, for example).

Sounds useful and more generic.
