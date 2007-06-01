From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add basic test-script for git-submodule
Date: Fri, 01 Jun 2007 12:50:21 -0700
Message-ID: <7vmyzjzc76.fsf@assigned-by-dhcp.cox.net>
References: <11802980992216-git-send-email-hjemli@gmail.com>
	<7v7iqs6r6p.fsf@assigned-by-dhcp.cox.net>
	<8c5c35580705292348q74281f7eu15b3b61f45b2c6f5@mail.gmail.com>
	<7vzm3kz5w9.fsf@assigned-by-dhcp.cox.net>
	<op.ts8d71b89pspc6@localhost> <465FD11C.6B1D5172@eudaptics.com>
	<op.ts8g4dsa9pspc6@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Sixt" <J.Sixt@eudaptics.com>,
	"Junio C Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 21:50:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuD9F-0002YU-Hu
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 21:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762504AbXFATuZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 15:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763574AbXFATuZ
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 15:50:25 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:42981 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763628AbXFATuX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 15:50:23 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070601195023.LIXB5800.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 1 Jun 2007 15:50:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 6KqM1X00c1kojtg0000000; Fri, 01 Jun 2007 15:50:22 -0400
In-Reply-To: <op.ts8g4dsa9pspc6@localhost> (Lars Hjemli's message of "Fri, 01
	Jun 2007 10:13:15 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48878>

"Lars Hjemli" <hjemli@gmail.com> writes:

> This test tries to verify basic sanity of git-submodule, i.e. that it is
> able to clone and update a submodule repository, that its status output is
> sane, and that it barfs when the submodule path is occupied during init.
>
> Signed-off-by: Lars Hjemli <hjemli@gmail.com>

Micronit...

> +test_expect_success 'the --cached sha1 should be rev1' '
> +	git-submodule --cached status | grep "^\+$rev1"
> +'

What's the purpose of that solitary backslash?
