From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 0/2] New zsh wrapper
Date: Sun, 18 Nov 2012 12:08:07 +0100
Message-ID: <1353236889-15052-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Marc Khouzam <marc.khouzam@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Marius Storm-Olsen <marius@storm-olsen.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Peter van der Does <peter@avirtualhome.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 12:08:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta2ju-00065J-L5
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 12:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442Ab2KRLIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2012 06:08:25 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:63037 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab2KRLIY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 06:08:24 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1601033bkw.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 03:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=CbFBOrhmDGi+7BxSgNFQKqfRPNFHD/71juqQpTfFf4Q=;
        b=NhE6P3lJlcrimn2CdMWgr2WyP7TPUEI+2msYDV8FYicUECD4eTdEifCcAEVJtKgit4
         uikTNMgcbvI2DMrPlRvRKoXVLMx5VAPv5J8F19WCky1nTfUrUb/fvHRHcvAuMfM4tjZy
         2HlkIiDxsyTAW226LgUn3iCyZzUeispkoIEF3sjvGlRcbsVYdGIF956DYPPg7XqDouNC
         /XIgxYeZkIFrXdJyVaLFSxqJuzAOKrveb6UmPsToNM5L/LATWdhOjsK/83z3WovNZZlq
         ENW74tCAqincuhfKHjejp0zNBRAgmlhaBLU3nO5RHkqhn7xxHiF4A5kMPO0BxDeVpKi+
         z/mA==
Received: by 10.204.147.6 with SMTP id j6mr3748953bkv.61.1353236903293;
        Sun, 18 Nov 2012 03:08:23 -0800 (PST)
Received: from localhost (ip-109-43-0-81.web.vodafone.de. [109.43.0.81])
        by mx.google.com with ESMTPS id a5sm860796bkw.8.2012.11.18.03.08.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Nov 2012 03:08:22 -0800 (PST)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210022>

Hi,

It looks like there's some resistance with the other patches this series was
depending upon, so lets get rid of them, they are not really needed.

This version should be ready to merge.

The second patch is new, in order for users to get the same features when
sourcing the bash script (they don't need to change anything). They'll get a
warning suggesting to check the new script git-completion.zsh. Eventually, that
support would be dropped from the bash script.

Some people were suggesting something like this, so here it is.

Can we merge the zsh wrapper now?

Felipe Contreras (2):
  completion: add new zsh completion
  completion: start moving to the new zsh completion

 contrib/completion/git-completion.bash | 104 +++++++++++++++++++--------------
 contrib/completion/git-completion.zsh  |  78 +++++++++++++++++++++++++
 2 files changed, 139 insertions(+), 43 deletions(-)
 create mode 100644 contrib/completion/git-completion.zsh

-- 
1.8.0
