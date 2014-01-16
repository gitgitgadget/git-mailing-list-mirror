From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v4 2/6] submodule: Document module_clone arguments in comments
Date: Wed, 15 Jan 2014 20:10:23 -0800
Message-ID: <9d4a3470ef426ea8f93db33ad0e2f11f668a6d26.1389837412.git.wking@tremily.us>
References: <20140114224246.GA13271@book.hvoigt.net>
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 16 05:11:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3eIq-0001Lu-4M
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 05:11:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbaAPELd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 23:11:33 -0500
Received: from qmta06.westchester.pa.mail.comcast.net ([76.96.62.56]:56414
	"EHLO qmta06.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751203AbaAPELa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jan 2014 23:11:30 -0500
Received: from omta11.westchester.pa.mail.comcast.net ([76.96.62.36])
	by qmta06.westchester.pa.mail.comcast.net with comcast
	id EU4f1n0030mv7h056UBVvj; Thu, 16 Jan 2014 04:11:29 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta11.westchester.pa.mail.comcast.net with comcast
	id EUBT1n00S152l3L3XUBUqu; Thu, 16 Jan 2014 04:11:29 +0000
Received: from mjolnir.tremily.us (unknown [192.168.0.141])
	by odin.tremily.us (Postfix) with ESMTPS id AD034EFE489;
	Wed, 15 Jan 2014 20:11:27 -0800 (PST)
Received: (nullmailer pid 18547 invoked by uid 1000);
	Thu, 16 Jan 2014 04:11:03 -0000
X-Mailer: git-send-email 1.8.5.2.8.g0f6c0d1
In-Reply-To: <20140114224246.GA13271@book.hvoigt.net>
In-Reply-To: <cover.1389837412.git.wking@tremily.us>
References: <cover.1389837412.git.wking@tremily.us>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389845489;
	bh=yMFoLETQNPjbVy2QY7ZQJvwAo4aM4Hfp1i2VXxsXEqo=;
	h=Received:Received:Received:Received:From:To:Subject:Date:
	 Message-Id;
	b=HMMQclIBHa28zIf/ld1AzNeC61Nzt+SdTtnpRMitACDxMi8/+TPeUKIQcwe1Io9nV
	 BZ95THyYP32lmvRO0UcufKkvyHjBYcI4+yhCbBp9f8r9gBQT/j9nt8st7Tzy7dsd3w
	 ltJMtX+dPHIXPa0fSE84U2DCnsbt8gCc4y2skW2yLAnzQMwexrnz10acL41784uBpZ
	 q6wJCyqwPSNurAAfaphuErKpUCx5Tjh4FZPHNEV4fqAARfn+LcloL6M91HGPvInH7q
	 1CySDn6JwJTZiAYzVVjJ/6D5rKgplISIEZu1RVBIOvlciTDp0miekp5TQEKOXCnXjy
	 BFQIZIbJVM+UQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240499>

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 git-submodule.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index 5e8776c..68dcbe1 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -241,6 +241,12 @@ module_name()
 #
 # Clone a submodule
 #
+# $1 = submodule path
+# $2 = submodule name
+# $3 = URL to clone
+# $4 = reference repository to reuse (empty for independent)
+# $5 = depth argument for shallow clones (empty for deep)
+#
 # Prior to calling, cmd_update checks that a possibly existing
 # path is not a git repository.
 # Likewise, cmd_add checks that path does not exist at all,
-- 
1.8.5.2.8.g0f6c0d1
