From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 0/4] completion: couple of cleanups
Date: Thu,  2 Feb 2012 22:30:21 +0200
Message-ID: <1328214625-3576-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 21:31:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt3JM-0000Cr-Be
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 21:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754808Ab2BBUbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 15:31:11 -0500
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:37881 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751766Ab2BBUbK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 15:31:10 -0500
Received: by lbom4 with SMTP id m4so436917lbo.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 12:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=IeF6WbfObfJNcly0HFrk/AiQxI1LTRUzVX8bgHNq6wA=;
        b=CbdOMMI1/jmeB4fLEc7fJasA1b7dTqiE7xgjESIV65BDwztuQOyQW5er4H7lXKcZVJ
         lldCdt7bfSNPenmKDgYzwnaIi0kzX2LLXqCvMlAp6th1PfwrWt2UlixIAPcMMHbp7BMj
         suE2LM3uH3qTbyVz8EzGMtw1iZd56fVdySoDg=
Received: by 10.112.98.103 with SMTP id eh7mr1111300lbb.81.1328214668422;
        Thu, 02 Feb 2012 12:31:08 -0800 (PST)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi. [91.153.253.80])
        by mx.google.com with ESMTPS id d6sm2886401lbj.2.2012.02.02.12.31.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 12:31:07 -0800 (PST)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189699>

And an improvement for zsh.

v4:

Same as v3, but with an improved commit message with input from Thomas Rast and sending directly to Junio.

v3:

Junio: I see you already picked most of them for 'pu', but I've made further changes based on the feedback:

 * completion: be nicer with zsh
       Improved the code-style

 * completion: simplify __gitcomp*
       Fix
       Improved commit message

Felipe Contreras (4):
  completion: work around zsh option propagation bug
  completion: simplify __git_remotes
  completion: remove unused code
  completion: simplify __gitcomp*

 contrib/completion/git-completion.bash |   66 +++++---------------------------
 1 files changed, 10 insertions(+), 56 deletions(-)

-- 
1.7.9
