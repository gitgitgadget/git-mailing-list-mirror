From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Added 'git-rev-list --igrep' option for case insensitive grep
Date: Sat, 21 Jul 2007 22:53:19 -0700
Message-ID: <7v8x99t25s.fsf@assigned-by-dhcp.cox.net>
References: <a1bbc6950707212233h6047ecfas645b71b9b4c6317e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 07:53:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICUNm-0004z9-0J
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 07:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399AbXGVFxV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 01:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751603AbXGVFxV
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 01:53:21 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:65338 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021AbXGVFxU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 01:53:20 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070722055319.BOVV1358.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sun, 22 Jul 2007 01:53:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SVtK1X00E1kojtg0000000; Sun, 22 Jul 2007 01:53:20 -0400
In-Reply-To: <a1bbc6950707212233h6047ecfas645b71b9b4c6317e@mail.gmail.com>
	(Dmitry Kakurin's message of "Sat, 21 Jul 2007 22:33:47 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53220>

Are there notable side effects you would need to warn users
about?

For example, what is the difference between "--igrep=foo
--author=bar" and "--grep=foo --author=bar"?
