From: Alexander Strasser <eclipse7@gmx.net>
Subject: [PATCH v2 0/8] Cleaning up t4012
Date: Mon, 16 Jul 2012 22:40:07 +0200
Message-ID: <cover.1342468069.git.eclipse7@gmx.net>
References: <20120711221140.GA21303@akuma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 22:40:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sqs5o-0006PJ-AE
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 22:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753471Ab2GPUkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 16:40:25 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:33069 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752845Ab2GPUkX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 16:40:23 -0400
Received: (qmail invoked by alias); 16 Jul 2012 20:40:20 -0000
Received: from p5DC37C42.dip.t-dialin.net (EHLO gmx.net) [93.195.124.66]
  by mail.gmx.net (mp070) with SMTP; 16 Jul 2012 22:40:20 +0200
X-Authenticated: #8251126
X-Provags-ID: V01U2FsdGVkX1/KSoU/oyjKKiJLIeyPLQ5pQH2NQIxsP5naLNFQ7y
	l7EaPYTvy8L7wr
Received: by gmx.net (sSMTP sendmail emulation); Mon, 16 Jul 2012 22:40:07 +0200
Content-Disposition: inline
In-Reply-To: <20120711221140.GA21303@akuma>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201568>

Hi,

  here goes the reroll. I corrected the spelling errors pointed out
by Zbigniew and appended another patch for replacing the if-else
"Did the command fail?" constructs with test_must_fail.

  I based this series on the as/t4012-style-updates branch pushed by
Junio. So his fixes are included too.


Alexander Strasser (7):
  t4012: modernize style for quoting
  t4012: Unquote git command fragment in test title
  t4012: Actually quote the sed script
  t4012: Break up pipe into serial redirections
  t4012: Make --shortstat test more robust
  t4012: Re-indent test snippets
  t4012: Use test_must_fail instead of if-else

Johannes Sixt (1):
  t4012: use 'printf' instead of 'dd' to generate a binary file

 t/t4012-diff-binary.sh | 94 +++++++++++++++++++++++---------------------------
 1 file changed, 44 insertions(+), 50 deletions(-)

-- 
1.7.10.2.552.gaa3bb87
