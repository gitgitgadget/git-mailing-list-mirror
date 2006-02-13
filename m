From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH 0/2] More git-send-email updates
Date: Mon, 13 Feb 2006 03:22:03 -0500
Message-ID: <11398189232404-git-send-email-ryan@michonline.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Feb 13 09:22:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8Yyv-0002Dc-97
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 09:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWBMIWq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 03:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWBMIWq
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 03:22:46 -0500
Received: from mail.autoweb.net ([198.172.237.26]:40129 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1751344AbWBMIWp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 03:22:45 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1F8Yyp-0001k4-4d; Mon, 13 Feb 2006 03:22:44 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1F8Yyl-000285-NJ; Mon, 13 Feb 2006 03:22:41 -0500
Received: from localhost
	([127.0.0.1] helo=mythryan2 ident=ryan)
	by mythical with smtp (Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1F8YyB-0002pD-Um; Mon, 13 Feb 2006 03:22:04 -0500
In-Reply-To: 
X-Mailer: git-send-email
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Spam-Score: -2.6
X-Spam-Report: Spam detection software, running on the system "h4x0r5.com", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  To follow up on some conversations related to
	git-send-email this week, here are two updates: The first adds a command
	line option to suppress adding the "From" address to the list of
	addresses to Cc, when it appears in a From: header line. (Note that
	git-send-email never looked for From: lines inside the body of a message
	to use as a source for Cc: addresses, which, given the patch formats
	Linus has previously talked about, is probably a bug.) [...] 
	Content analysis details:   (-2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.4 X_MAILER_SPAM          X-Mailer: header is bulk email fingerprint
	-0.0 SPF_PASS               SPF: sender matches SPF record
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	-1.3 AWL                    AWL: From: address is in the auto white-list
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16052>

To follow up on some conversations related to git-send-email this week, here are two updates:

The first adds a command line option to suppress adding the "From" address to
the list of addresses to Cc, when it appears in a From: header line.  (Note
that git-send-email never looked for From: lines inside the body of a message
to use as a source for Cc: addresses, which, given the patch formats Linus has
previously talked about, is probably a bug.)

The second patch adds the mythical "--cc" option.  I say "mythical" because it
has never existed, but both Junio and I have mentioned it (or used it)
recently, so we both *assumed* that it existed.  I think that's justification
for adding it.

-- 
Ryan Anderson
  sometimes Pug Majere
