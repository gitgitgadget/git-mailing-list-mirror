From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Test #7 in t9200-git-cvsexportcommit fails
Date: Sun, 22 Jul 2007 15:19:19 -0700
Message-ID: <7vk5ssqdy0.fsf@assigned-by-dhcp.cox.net>
References: <31e9dd080707221241j5c00aaaaqa79c12d3e2a3345b@mail.gmail.com>
	<20070722202121.GA3288@steel.home>
	<31e9dd080707221349g40ff050bue72733f270822603@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jason Sewall" <jasonsewall@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 00:19:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICjlx-0002Ik-7H
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 00:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761733AbXGVWTZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 18:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759193AbXGVWTZ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 18:19:25 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:53690 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760931AbXGVWTY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 18:19:24 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070722221924.JKJX1358.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sun, 22 Jul 2007 18:19:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SmKL1X0061kojtg0000000; Sun, 22 Jul 2007 18:19:23 -0400
In-Reply-To: <31e9dd080707221349g40ff050bue72733f270822603@mail.gmail.com>
	(Jason Sewall's message of "Sun, 22 Jul 2007 13:49:19 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53348>

"Jason Sewall" <jasonsewall@gmail.com> writes:

>> It'll never work, cvs does not commit changes made during one second,
>> as they have the same timestamp.

Heh, racy CVS?

> Why not add a delay in there, like this:
>
> id=$(git rev-list --max-count=1 HEAD) && sleep 2
>
> It makes the test work for me.

Sounds like an acceptable workaround.  Care to send in a tested
signed patch?
