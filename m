From: Junio C Hamano <junkio@cox.net>
Subject: Re: 'git status' is not read-only fs friendly
Date: Sat, 10 Feb 2007 08:27:35 -0800
Message-ID: <7vr6syj7uw.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
	<Pine.LNX.4.63.0702101517360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<e5bfff550702100631w1b6243e7i44039ceaa8d3fe93@mail.gmail.com>
	<Pine.LNX.4.63.0702101536090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<e5bfff550702100648p6db5fc67vb5e4a04d40771922@mail.gmail.com>
	<Pine.LNX.4.63.0702101554170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0702101049480.1757@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	GIT list <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Feb 10 17:27:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFv4t-0008UI-PE
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 17:27:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbXBJQ1h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 11:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbXBJQ1h
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 11:27:37 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:48052 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbXBJQ1h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 11:27:37 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070210162737.HRYN21177.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sat, 10 Feb 2007 11:27:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id MsTb1W00x1kojtg0000000; Sat, 10 Feb 2007 11:27:36 -0500
In-Reply-To: <Pine.LNX.4.64.0702101049480.1757@xanadu.home> (Nicolas Pitre's
	message of "Sat, 10 Feb 2007 10:54:27 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39238>

Nicolas Pitre <nico@cam.org> writes:

> On Sat, 10 Feb 2007, Johannes Schindelin wrote:
>
>> So, what is the big problem about accepting that patching git-status for 
>> one obscure use is wrong, wrong, wrong, when git-diff already does what is 
>> needed???
>
> Because git-status itself is conceptually a read-only operation, and 
> having it barf on a read-only file system is justifiably a bug.

I do not 100% agree that it is conceptually a read-only operation.
