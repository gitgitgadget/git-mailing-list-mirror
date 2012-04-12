From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/4] completion: trivial cleanups and fixes
Date: Fri, 13 Apr 2012 02:49:59 +0300
Message-ID: <1334274603-3277-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 01:50:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SITmd-00051j-0l
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 01:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758027Ab2DLXu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 19:50:28 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:56331 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197Ab2DLXu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 19:50:27 -0400
Received: by lbbgm6 with SMTP id gm6so2046018lbb.19
        for <git@vger.kernel.org>; Thu, 12 Apr 2012 16:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=RjbbvEc1IeZMY5e2fq/+LYqnLSCMxty6x9o2YRQ2/BM=;
        b=SAsqA8DQgJ51yzdfmmI7yjQC0et7vajBM1+rVHb87amGzEcSWIAU3PUG212yZa9jkt
         Z3Kr3nNCMemExejMjMwk8uTROILrqnLkiGwgnTAGNi6HsggxPT4/RUo08/w1rkKYeB3k
         fajmh8Yp13MKMNEW+VPaIzR0f+YTQXxgHW2VM/6ZwTOVyLrDHPFf++pXrDsp8p5pa2Tg
         +C63DyCliOfMNJY1C0cvLaYXURTHR/1qKe86C3vS33dhUqqcgJrtAouqt8RhoqklQyBi
         nZhrXLHMJSslsA8tENoMHEk9o+O60JWO/i9J1DGSKVcbgdHJqDcuR7uOaRHxHJkL3z17
         pIAg==
Received: by 10.112.44.105 with SMTP id d9mr45078lbm.69.1334274626187;
        Thu, 12 Apr 2012 16:50:26 -0700 (PDT)
Received: from localhost (84-231-136-182.elisa-mobile.fi. [84.231.136.182])
        by mx.google.com with ESMTPS id ph8sm7658176lab.15.2012.04.12.16.50.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Apr 2012 16:50:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.1.g1f19b8.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195391>

Hi,

Just a few simpliciations, improvements, and add some missing options.

This series depends on the bash completion tests patch.

Felipe Contreras (4):
  completion: simplify __gitcomp_1
  completion: trivial simplification
  completion: add missing general options
  completion: improve 'git --exec-path' completion

 contrib/completion/git-completion.bash |   16 +++++++++-------
 t/t9902-completion.sh                  |   18 +++++++++++++++++-
 2 files changed, 26 insertions(+), 8 deletions(-)

-- 
1.7.10.1.g1f19b8.dirty
