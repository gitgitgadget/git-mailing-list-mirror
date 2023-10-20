Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571D112E77
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2748B1AE
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 02:36:56 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id E517A23F67
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 05:36:54 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qtlw6-s5W-00
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 11:36:54 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: git@vger.kernel.org
Subject: [PATCH v3 0/3] rebase refactoring
Date: Fri, 20 Oct 2023 11:36:51 +0200
Message-ID: <20231020093654.922890-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.42.0.419.g70bf8a5751
In-Reply-To: <20230809171531.2564844-1-oswald.buddenhagen@gmx.de>
References: <20230809171531.2564844-1-oswald.buddenhagen@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

broken out of the bigger series, as the aggregation just unnecessarily holds it
up.

v3: removed "stray" footer. so more of a RESEND than an actual new version.

Oswald Buddenhagen (3):
  rebase: simplify code related to imply_merge()
  rebase: handle --strategy via imply_merge() as well
  rebase: move parse_opt_keep_empty() down

 builtin/rebase.c | 44 ++++++++++++++------------------------------
 1 file changed, 14 insertions(+), 30 deletions(-)

-- 
2.42.0.419.g70bf8a5751

