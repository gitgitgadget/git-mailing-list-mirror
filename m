From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] daemon: Skip unknown "extra arg" information
Date: Sun, 07 Jun 2009 13:29:16 -0700
Message-ID: <7vfxebaiub.fsf@alter.siamese.dyndns.org>
References: <20090604220824.GT3355@spearce.org>
	<7vbpp3tsg0.fsf@alter.siamese.dyndns.org>
	<20090605013332.GV3355@spearce.org> <200906072056.08680.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Jun 07 22:29:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDOzd-0006my-Rp
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 22:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754401AbZFGU3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 16:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754295AbZFGU3Q
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 16:29:16 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:63138 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754205AbZFGU3P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 16:29:15 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090607202917.QYFC20976.fed1rmmtao102.cox.net@fed1rmimpo03.cox.net>;
          Sun, 7 Jun 2009 16:29:17 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 18VH1c0024aMwMQ048VHaw; Sun, 07 Jun 2009 16:29:17 -0400
X-VR-Score: -200.00
X-Authority-Analysis: v=1.0 c=1 a=86Vp4Fqyi4EA:10 a=0a0hY8H0wKQA:10
 a=A9qS8gIqAAAA:8 a=4FQ_ZY0aZZZ1nY8ZNKQA:9 a=zub2SzJIyg5zbBH3_3grLw6yrwkA:4
 a=Kj4G0JfAssAA:10
X-CM-Score: 0.00
In-Reply-To: <200906072056.08680.j6t@kdbg.org> (Johannes Sixt's message of "Sun\, 7 Jun 2009 20\:56\:08 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120999>

Johannes Sixt <j6t@kdbg.org> writes:

> On Freitag, 5. Juni 2009, Shawn O. Pearce wrote:
>> Actually, we're already f'kd.  We can't change the protocol like
>> we had hoped.  I still think this should go in maint.
>>
>> --8<--
>> daemon: Strictly parse the "extra arg" part of the command
>>
>> Since 1.4.4.5 (49ba83fb67 "Add virtualization support to git-daemon")
>> git daemon enters an infinite loop and never terminates if a client
>> hides any extra arguments in the initial request line which is not
>> exactly "\0host=blah\0".
>
> I see you applied this to maint. Since this patch actually fixes a 
> DoS-exploitable bug, shouldn't it be applied all the way back to 1.4.4.5?

I personally do not have the bandwidth to worry about anything older than
say 1.6.0.  Interested parties (read: distro packagers who pride
themselves for their LTS) can do that themselves.
