From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH v4 0/6] completion: __git_complete and other stuff
Date: Mon,  7 May 2012 03:23:14 +0200
Message-ID: <1336353800-17323-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 03:23:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRCfl-0004DP-7V
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 03:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755170Ab2EGBX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 21:23:28 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:42182 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755153Ab2EGBX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 21:23:27 -0400
Received: by werb10 with SMTP id b10so959659wer.19
        for <git@vger.kernel.org>; Sun, 06 May 2012 18:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=bM1JG0L8/76ddbsrDSkC3s5mfk5m5qvIV5qMpyf4Fik=;
        b=lOJqR/H1m83VVy+p4ZbT9b2QJaqU+k3bGVLecgsugKBT/25748YvGXY87EGs2jysfb
         bfBU2e69GkOTx+voj1o4TaysjhSjdeSlheY+Fh/QZTi56EzKnEXNFgr3ZJ03ie+GjlHG
         6Y3qLZez9NNaaVae+qIQIwhb5YjNCqSJyegPbrvfMSgvoCq6G5h1SU0sk/x/wL4BEexJ
         jbeB/n19upH22itHr67u1pShZSE6D6MTCuh87fl2/4NMDsv83yXRVj602EqikHz7+JOx
         iIB2Fq5qof0TkjYZIPVTg3c2wMWpcx0MmgWyKdnfk6gB3f/8y366/Pgf4DNEdAoCIv7P
         F/gw==
Received: by 10.180.80.104 with SMTP id q8mr30689743wix.14.1336353805795;
        Sun, 06 May 2012 18:23:25 -0700 (PDT)
Received: from localhost (ip-109-43-0-55.web.vodafone.de. [109.43.0.55])
        by mx.google.com with ESMTPS id r2sm10326358wif.7.2012.05.06.18.23.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 May 2012 18:23:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197226>

Hi,

In order to simplify the discussion I've cleaned up my patches related to
_GIT_complete, aliasing stuff, and such.

I'm only intending the firat patch for inclusion for now.

Cheers.

Felipe Contreras (6):
  completion: add new __git_complete helper
  tests: add more bash completion tests
  completion: simplify _git_bundle
  completion: simplify command stuff
  completion: calculate argument position properly
  completion: add public _GIT_complete helper

 contrib/completion/git-completion.bash |  103 ++++++++++++++++----------------
 t/t9902-completion.sh                  |   85 +++++++++++++++++++++++++-
 2 files changed, 135 insertions(+), 53 deletions(-)

-- 
1.7.10
