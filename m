From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 2/7] .gitignore: add git-remote-cvs
Date: Wed, 28 Oct 2009 23:40:21 -0700
Message-ID: <1256798426-21816-3-git-send-email-srabbelier@gmail.com>
References: <1256798426-21816-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Git List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Johan Herland" <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 29 07:41:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3OhW-0003HI-6D
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 07:41:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756474AbZJ2Gl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 02:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756447AbZJ2Gl1
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 02:41:27 -0400
Received: from mail-pw0-f42.google.com ([209.85.160.42]:62904 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756449AbZJ2GlW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 02:41:22 -0400
Received: by pwj9 with SMTP id 9so1251859pwj.21
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 23:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=mMCKlHL8IHf0JUC6cpqrnPCMkSbQz40sOG/Ib2mGycA=;
        b=pMDGS5DruIDonWfpULXgRd8cXW4npa0CIpzdCllYge/NL3cxcO0A2XvT4Fxi6e22YV
         LWjo+teaCpEstYEXYbc4+jhku1vGhiX3BO+6h2fi5Zb46rEXzNswnUXu82jr/yg5uOpP
         REqHp/Fxlcu1VL7vgGQwMvSbMCHnu6rJquuXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ff5laOIPhv+Gn1afXQclpfC0mO7BQWut8s70h9FpjL48GaCVZC0pOuLL4rOuz98wyB
         yljtJKY1omUYD4NIasXhsAPCPbLZO3xAYuzzeYwtb8T0h9cR1p/o2X5VlwKZq3kcNkSV
         3oqXXKFSuJefsqsclqWaRdX1snFRw91rFm758=
Received: by 10.114.237.24 with SMTP id k24mr5995066wah.5.1256798487396;
        Wed, 28 Oct 2009 23:41:27 -0700 (PDT)
Received: from localhost.localdomain (ip67-152-86-163.z86-152-67.customer.algx.net [67.152.86.163])
        by mx.google.com with ESMTPS id 23sm401242pxi.1.2009.10.28.23.41.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 23:41:26 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.2.291.gf76a3
In-Reply-To: <1256798426-21816-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131558>

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---
 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 46c26cd..b8afdf4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -105,6 +105,7 @@ git-reflog
 git-relink
 git-remote
 git-remote-curl
+git-remote-cvs
 git-repack
 git-repo-config
 git-request-pull
-- 
1.6.5.2.291.gf76a3
