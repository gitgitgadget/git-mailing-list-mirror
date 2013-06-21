From: "Eduardo R. D'Avila" <erdavila@gmail.com>
Subject: [PATCH 0/4] git-prompt: cleaning and improvement
Date: Thu, 20 Jun 2013 23:25:25 -0300
Message-ID: <cover.1371780085.git.erdavila@gmail.com>
Cc: felipe.contreras@gmail.com, artagnon@gmail.com,
	s.oosthoek@xs4all.nl, gitster@pobox.com, szeder@ira.uka.de,
	"Eduardo R. D'Avila" <erdavila@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 21 04:32:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upr9f-0006el-0P
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 04:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758162Ab3FUCcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 22:32:47 -0400
Received: from mail-yh0-f46.google.com ([209.85.213.46]:56282 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758085Ab3FUCcq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 22:32:46 -0400
Received: by mail-yh0-f46.google.com with SMTP id i57so2898171yha.19
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 19:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Xrq+0uFcgeIcyW63AYGBwoqJRbOcb2lKs2SWdGQjD1E=;
        b=yBD0achhDGP1FgCil4t3c+p/uEyBY15678u+ktnu7w3QGRZWIFFU0VAOLf1AU0Lo5w
         8MJTb65ZeE6v/wZcmVnhOaulcYmEVSR6uIkyVI2tu5KCOVXwOCfAqDn0cz1Z9yfuwZMX
         lllSOSPZeg50Ufp6IqzuhjzjlnEMc/7hzMx9ZNvI/fZ2VZVz72sKbvh7i8wZsiswU3ol
         2cD3coDUoEXzy/IgRG0yREC0r+rvHYellO2aEgZ+iA1XdNQTe3ya7LTbO1xvc2QErUFh
         CuK63s43V97RSVqA6/TOVeKZLnxBtstkqQ7V3YP/gMcTL7FkV35kqCRPqOW+Kh094F8g
         7Gbg==
X-Received: by 10.236.113.110 with SMTP id z74mr6478413yhg.14.1371781575339;
        Thu, 20 Jun 2013 19:26:15 -0700 (PDT)
Received: from localhost.localdomain (201.86.243.62.dynamic.adsl.gvt.net.br. [201.86.243.62])
        by mx.google.com with ESMTPSA id s65sm4968400yhs.14.2013.06.20.19.26.12
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Jun 2013 19:26:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.487.g28387b2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228566>

The previously proposed patch set to enable color
prompt in non-PROMPT_COMMAND mode
(http://article.gmane.org/gmane.comp.version-control.git/228017)
introduce some problems with command line editing/browsing/completion,
as explained by Simon Oosthoek, in
http://article.gmane.org/gmane.comp.version-control.git/228308 .

Some of the patches could still be used, so I'm
reposting them with an additional one to add some
missing information in usage comments.


Eduardo R. D'Avila (4):
  t9903: add tests for git-prompt pcmode
  git-prompt.sh: refactor colored prompt code
  git-prompt.sh: do not print duplicate clean color code
  git-prompt.sh: add missing information in comments

 contrib/completion/git-prompt.sh |  94 +++++----------
 t/t9903-bash-prompt.sh           | 254 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 285 insertions(+), 63 deletions(-)

-- 
1.8.3.1.487.g28387b2
