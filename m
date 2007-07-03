From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Start deprecating "git-command" in favor of "git command"
Date: Mon, 02 Jul 2007 20:50:37 -0700
Message-ID: <7vlkdyuovm.fsf@assigned-by-dhcp.cox.net>
References: <alpine.LFD.0.98.0706301135300.1172@woody.linux-foundation.org>
	<7vy7i1b6bt.fsf@assigned-by-dhcp.cox.net>
	<20070630194335.GK7730@nan92-1-81-57-214-146.fbx.proxad.net>
	<7vtzsoami9.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0706301955560.1172@woody.linux-foundation.org>
	<7vsl8894tc.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.999.0707022253580.26459@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Yann Dirson <ydirson@altern.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Jul 03 05:50:49 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5ZPZ-0003Fy-2P
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 05:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615AbXGCDuj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 23:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753566AbXGCDuj
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 23:50:39 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:63835 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753477AbXGCDui (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 23:50:38 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070703035039.PGAW17683.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 2 Jul 2007 23:50:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Jrqc1X00k1kojtg0000000; Mon, 02 Jul 2007 23:50:37 -0400
In-Reply-To: <alpine.LFD.0.999.0707022253580.26459@xanadu.home> (Nicolas
	Pitre's message of "Mon, 02 Jul 2007 22:56:16 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51447>

Nicolas Pitre <nico@cam.org> writes:

> On Sat, 30 Jun 2007, Junio C Hamano wrote:
>
>> Your patch _closes the door_ for us to implement overriding
>> aliases later if we wanted to; we would need to go back to the
>> scripts and say "git --no-alias xyzzy" again.
>
> I think such aliases would be evil.  Closing the door on them is most 
> certainly a good thing IMHO.

Ok.

Now my 'next' is coming very close to 'master' while preparing
for 1.5.3-rc0, it may be a good time to apply Linus's magic.
