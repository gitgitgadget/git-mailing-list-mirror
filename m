From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: [PATCH v5 0/3] completion: add git status
Date: Fri, 10 Jun 2016 12:12:03 +0200
Message-ID: <20160610101206.5760-1-thomas.braun@virtuell-zuhause.de>
References: <xmqq8tymp385.fsf@gitster.mtv.corp.google.com>
Cc: peff@peff.net, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 12:12:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBJQh-0005dt-KN
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 12:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbcFJKM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 06:12:27 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:36173 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752078AbcFJKMZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2016 06:12:25 -0400
Received: from p4fc87c53.dip0.t-ipconnect.de ([79.200.124.83] helo=localhost.localdomain); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1bBJQL-00037D-Cm; Fri, 10 Jun 2016 12:12:21 +0200
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <xmqq8tymp385.fsf@gitster.mtv.corp.google.com>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1465553545;6e6a5725;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296962>

Changes since v4:
- Add SP before backslash at EOL
- Fix line continuation issue in __git_get_option_value,
  now t9902 passes again

Thomas Braun (3):
  completion: factor out untracked file modes into a variable
  completion: add __git_get_option_value helper
  completion: add git status

 contrib/completion/git-completion.bash | 98 +++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

-- 
2.8.4.windows.1
