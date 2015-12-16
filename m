From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/2] t3404: fix typo
Date: Wed, 16 Dec 2015 13:24:55 +0100 (CET)
Message-ID: <ba93b8e0876628d24faaaf41d2dd7d2b2cbfe728.1450268673.git.johannes.schindelin@gmx.de>
References: <cover.1450268673.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 13:25:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9B8v-0001GE-Nd
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 13:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934132AbbLPMZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 07:25:04 -0500
Received: from mout.gmx.net ([212.227.17.21]:56961 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934083AbbLPMZC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 07:25:02 -0500
Received: from virtualbox ([37.24.143.114]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LvQkh-1aIMP50rT9-010g6r; Wed, 16 Dec 2015 13:24:56
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1450268673.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:m19yqrv3w1rZ9cXNOE8ZILc1OkfmKslgYDzpQXL9zQifshW6Wki
 NBS34536FJAoO4EOk/CYI+pEkCEJ3xHYgjWm5nT82S4ueca/B2L+VJGHNwe3HxIjFO6Q9CA
 GcMaW0gcG2/480qJi/FzKTS2lYfZAH5DRGtKVQGlnVXhmmpChl5m7Y+R2f/Jl+GTwC/3uPI
 GlUx6z/VekKfOEcEJaU9A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:I0GhIbgUIiY=:mep//4M9b3jwAtBY0OCkTS
 eBIVyTkbVgf4r6uLImH5wY+GqGCBJ1hmkjiXZEwiUSC8TEkDLNSeqHDZMHd0IadkzGqGUV54i
 ujTS5oXW5Zx55KiGQxySMXU+S6MQA56UUw24wcDgGyrKZWjYSFkcRgcp7hlazkWFJkwInJgav
 IsFuy3FVgjQbrPwszigeKT8xgQ5UPMWzVMmoGukPB77pbN5OXaoDCk8udr5DHYdWzz6HwlW0/
 y5rk9InD7XSPGN2nQH7BX+q4AOFtteRFwt3fgiha16x6j5xRP358pIYhhnuvsE5q0s/3wC2wL
 lK+LKEXDRCmTqPYvOf26QBLTyzcykkJQISwMgdCrxf9pXK0jpZYEcIAfd0CsVCRqsA3z3Q1QN
 qt3B8Z8AQmWOk1WMVpztitwOdDSWO8QIhYS/lh568vgAGpCvH4Pa2UPiKU6DqRmUF6iHV3LhH
 paRS0FIPHoRSAlzyC8HiTR72Dz3kVQOU/r1KPvNdVKQSFIzGNix3uySNOP+xbHPM3KeJDWeYx
 l0k9yy3Jq7G3FuPiYxcRvwH6mT6Q7TZgywdFxu88U4Oouxv5AZHpn6qHi7yqft+Zz+Np58qI+
 AgSfWeSPZJy9Q/lNvFwleTvhfV9tVcZPI1HRvOEJ/1duMqPa+A4FJd0nFp+iFhNhE4Vynv/Xf
 /71kJvYYwOX/1qUicKLSGtQMgR9KybZ/0rqOVloJvSCxXRMw0hXvuprViWeKMMQQonCjdwNx0
 7CjTp5zXHvqaPncPJoTLQNbgctPZwQ3PlnXOjydnZXcIn19+pmZ8dLmmaK/QFzHboNa0pk/Q 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282554>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3404-rebase-interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 544f9ad..11dde66 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -62,7 +62,7 @@ test_expect_success 'setup' '
 
 # "exec" commands are ran with the user shell by default, but this may
 # be non-POSIX. For example, if SHELL=zsh then ">file" doesn't work
-# to create a file. Unseting SHELL avoids such non-portable behavior
+# to create a file. Unsetting SHELL avoids such non-portable behavior
 # in tests. It must be exported for it to take effect where needed.
 SHELL=
 export SHELL
-- 
2.6.3.windows.1.300.g1c25e49
