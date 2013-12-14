From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] Add test-hashmap to .gitignore
Date: Fri, 13 Dec 2013 18:05:26 -0800
Message-ID: <20131214020526.GC2311@google.com>
References: <52851FB5.4050406@gmail.com>
 <528521E2.7090305@gmail.com>
 <20131214020413.GB2311@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <tr@thomasrast.ch>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 14 03:05:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vrebm-0001Tu-0h
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 03:05:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395Ab3LNCFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Dec 2013 21:05:30 -0500
Received: from mail-yh0-f53.google.com ([209.85.213.53]:46787 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958Ab3LNCF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Dec 2013 21:05:29 -0500
Received: by mail-yh0-f53.google.com with SMTP id b20so2121945yha.26
        for <git@vger.kernel.org>; Fri, 13 Dec 2013 18:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=tdY6JJv+sPC4cwOW+iDYLEAbw2pXkR4CX23P0W0g27U=;
        b=l/30rTLn08iKpx04WxWhexlOzm9rsrfKyXLuPgg9+2oksbh2PIjzO2NVhBuIwU9XXi
         P3xX98fg3MaUidXq6l3Su1+Ke1w8NuVPCCOcAL8sZ6XuhRXncAKJe57bN4yxL5MIYf8B
         c6ZWrvIGT2lmesEfcNrf5sH3BM1EKJC4Qk4K8oRFpyRbN9oBEsmQfgL6x7kc11G+hTZH
         ch1kWEpkKlEb8Apvy/PX8SNlkPNG6ptNF/GunI50O9fMxC261YccslTwTjp4+jG/HTHS
         cF9tbTIHXl+kqSK/TkuRoE3xCNq9TZyoj1Wr+GjFe0a162UPZULdrSjSiC2bQjgcbz/E
         Eurw==
X-Received: by 10.236.0.193 with SMTP id 41mr4776944yhb.82.1386986729299;
        Fri, 13 Dec 2013 18:05:29 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id l65sm6226915yhk.1.2013.12.13.18.05.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 13 Dec 2013 18:05:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131214020413.GB2311@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239274>

Prevent the "test-hashmap" program from being accidentally tracked
with "git add" or cluttering "git status" output.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index b5f9def..dc600f9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -182,6 +182,7 @@
 /test-dump-cache-tree
 /test-scrap-cache-tree
 /test-genrandom
+/test-hashmap
 /test-index-version
 /test-line-buffer
 /test-match-trees
-- 
1.8.5.1
