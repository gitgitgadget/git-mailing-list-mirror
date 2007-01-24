From: Junio C Hamano <junkio@cox.net>
Subject: Re: Deleting remote branches with git-branch and reflog questions
Date: Tue, 23 Jan 2007 17:46:31 -0800
Message-ID: <7vbqkpkxhk.fsf@assigned-by-dhcp.cox.net>
References: <200701231259.27719.andyparkins@gmail.com>
	<45B6076F.5060503@op5.se> <200701231314.53361.andyparkins@gmail.com>
	<7v1wllo2p6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701231649520.3011@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 24 02:46:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9XDg-0002Ay-Mf
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 02:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933158AbXAXBqd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 20:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965100AbXAXBqd
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 20:46:33 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:36901 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933158AbXAXBqd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 20:46:33 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070124014632.CLBO25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Tue, 23 Jan 2007 20:46:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Epmq1W00K1kojtg0000000; Tue, 23 Jan 2007 20:46:51 -0500
To: Nicolas Pitre <nico@cam.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37591>

Nicolas Pitre <nico@cam.org> writes:

> On Tue, 23 Jan 2007, Junio C Hamano wrote:
>
>> And we might want to allow reflogs on detached HEAD someday,
>> although I personally think it goes against what detached HEAD
>> is -- it is of a very temporary nature.
>
> Didn't we agree already that reflog with detached head was simply 
> insane?

Perhaps, perhaps not.

	$ git checkout v2.6.14
        $ git checkout v2.6.15
        $ git checkout v2.6.16

Ah, which one did I check-out the last time?

	$ git describe HEAD@{1}

I suspect that we could re-implement "git bisect" without using
the special "bisect" branch (we would still be using refs/bisect
namespace).
