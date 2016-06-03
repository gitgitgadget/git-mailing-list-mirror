From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: [PATCH v4 0/3] support completion for git status
Date: Fri,  3 Jun 2016 20:34:23 +0200
Message-ID: <20160603183426.13140-1-thomas.braun@virtuell-zuhause.de>
References: <xmqq8tymp385.fsf@gitster.mtv.corp.google.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: peff@peff.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 20:34:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8tvn-0000UP-It
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 20:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbcFCSen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 14:34:43 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:55781 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751749AbcFCSej (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 14:34:39 -0400
Received: from p4fc87c53.dip0.t-ipconnect.de ([79.200.124.83] helo=localhost.localdomain); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1b8tvX-0005jY-Oj; Fri, 03 Jun 2016 20:34:35 +0200
X-Mailer: git-send-email 2.8.3.windows.1
In-Reply-To: <xmqq8tymp385.fsf@gitster.mtv.corp.google.com>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1464978879;8cb2c9d1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296365>

changes since v3:
* support short version -u of --untracked-files option
* introduce __git_get_option_value for general usage
* fix style issues
* support order dependent statements like
  git status -uno --untracked-files=all
  properly

Thomas Braun (3):
  completion: factor out untracked file modes into a variable
  completion: add __git_get_option_value helper
  completion: add git status

 contrib/completion/git-completion.bash | 98 +++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

-- 
2.8.3.windows.1
