From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH 0/5] some shell portability fixes
Date: Sun, 11 Nov 2007 07:30:42 +0900
Message-ID: <87r6ixag31.fsf@catnip.gol.com>
References: <20071106201518.GA6361@ins.uni-bonn.de>
	<7v8x5bgl04.fsf@gitster.siamese.dyndns.org>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 23:31:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqyr8-0001Qj-VL
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 23:31:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818AbXKJWay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 17:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754795AbXKJWay
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 17:30:54 -0500
Received: from smtp02.dentaku.gol.com ([203.216.5.72]:60191 "EHLO
	smtp02.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754792AbXKJWax (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 17:30:53 -0500
Received: from 203-216-100-114.dsl.gol.ne.jp ([203.216.100.114] helo=catnip.gol.com)
	by smtp02.dentaku.gol.com with esmtpa (Dentaku)
	id 1Iqyqj-0005tT-2i; Sun, 11 Nov 2007 07:30:45 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 728E52FF6; Sun, 11 Nov 2007 07:30:43 +0900 (JST)
System-Type: i686-pc-linux-gnu
In-Reply-To: <7v8x5bgl04.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Tue\, 06 Nov 2007 12\:46\:35 -0800")
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64382>

Junio C Hamano <gitster@pobox.com> writes:
>       /bin/sh on Solaris does not count as you can configure
>       SHELL_PATH to point at xpg4 shell or ksh on that platform.

That's likely to be a rather confusing point for many people trying to
install however (solaris is rather common), unless git somehow arranges
for the right thing to happen automatically, or at least spits out a big
noticeable warning message at install time...

-Miles
-- 
Saa, shall we dance?  (from a dance-class advertisement)
