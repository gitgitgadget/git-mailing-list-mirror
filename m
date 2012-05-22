From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] completion: remove executable mode
Date: Tue, 22 May 2012 22:46:39 +0200
Message-ID: <1337719600-7361-2-git-send-email-felipe.contreras@gmail.com>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Ted Pavlic <ted@tedpavlic.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 22 22:47:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWvys-0008IK-Cp
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 22:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760397Ab2EVUqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 16:46:49 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:40690 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534Ab2EVUqs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 16:46:48 -0400
Received: by mail-ee0-f46.google.com with SMTP id t10so1847774eei.19
        for <git@vger.kernel.org>; Tue, 22 May 2012 13:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Mhe46+B/6h5LF8JdENIUjDG7+69OBtFTEtv+qE9JZME=;
        b=pJzSL/U3w6ZbSnybCgskbeX606E7Kkru3oQbEWUwILUf35Lhd+jbspm2mkRPUc2Sbc
         ewsjCnonTbUHPltRld8j/ZGLVJsyTXWJMscOd2O+sKJkGBHn9oQo+ma/AxVmu7Gyuv9G
         H49amapiXexfuHQGiUKY3TAoVJj235BpFfXd3PwBnItNwOs95S0KLMwyH6qINwxHpqDx
         2xJm2OPTnoetd265grXMN+3Kk2kNt1GS2eij++6NnVeYzDFbiz/zeZ8Nhx3NBqRNOUzI
         XJ61uZCqIMnrW75ysjhdcb6TTyPW03RhpQ8GeZyH3B/xWQGB8axdT8Iw35baeMG8/JM5
         xsfA==
Received: by 10.14.97.77 with SMTP id s53mr4613551eef.104.1337719607413;
        Tue, 22 May 2012 13:46:47 -0700 (PDT)
Received: from localhost ([46.115.34.169])
        by mx.google.com with ESMTPS id s47sm90968890eef.4.2012.05.22.13.46.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 May 2012 13:46:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2
In-Reply-To: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198250>

No reason to have it executable. Every way this script is intended to be
used includes the 'source' command.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 0 files changed
 mode change 100755 => 100644 contrib/completion/git-completion.bash

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
old mode 100755
new mode 100644
-- 
1.7.10.2
