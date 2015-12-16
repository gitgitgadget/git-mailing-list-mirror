From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/2] Fix tyop in the 2.7.0 release notes
Date: Wed, 16 Dec 2015 13:25:02 +0100 (CET)
Message-ID: <cebfb615e63be990a77ea61aae1ef7433274a53d.1450268673.git.johannes.schindelin@gmx.de>
References: <cover.1450268673.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 13:25:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9B8w-0001GE-9X
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 13:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934139AbbLPMZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 07:25:08 -0500
Received: from mout.gmx.net ([212.227.17.21]:55762 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934083AbbLPMZG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 07:25:06 -0500
Received: from virtualbox ([37.24.143.114]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MXIGf-1Zf9xq0mmL-00WFqX; Wed, 16 Dec 2015 13:25:03
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1450268673.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:TqjxXcPrx8LsSBPwZjHaWzIj8T8hhv+cyib2gAbmljPsvDvvDZ8
 lPVUBqjkh4XpgSvnDpYWh9ynVptSbJ5TO0PKrgtRpfjSXSmBLRMMugkt/gEynaWYWg/xle6
 C84+rFPq50NCvbZljuHYX2fW71TIyZhsTSZYlDFVKFQVJ8Gxz2LZ8HvvWKb1BLp2KzCxLgp
 kmk88GG/ybWHmV1pOdAow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tujLOh41Xnk=:6GT139UcsfnEXEm5yX1VBs
 gkT6NY8OEDdqHiMIqipiLcYx7bKl0ke3mzPV8gxGvuqQ/bV5mkEpu+tVvk0BaNJDEpWukwS0F
 P1NRRDzffL3AzOoPRdEyTpj3Tg7xgeb8otjkl5DGcZbqPxcpDqpkqZn1NO1Mbr5WFQffYPSDh
 pQC/lGnSzxrb8f0ZtTckMMtTE0p3tQ66MCzdNIS+8Dfxl79aDdGdeV0S6+4QKeh2aNTDdc6Zd
 hXh9oP5B0fS3piS9OfohdGkFU2XKXfJmYSP2tDVOXoaTaDJa2cmUxQYydMXrHZzogeGAqSIpm
 A5bxCrABrepoNJLgLd2nOnuW5E48CHwxT0b+91L0LP+nGGKmcr7c1JW+3JGa8FEWgVOF8rlRC
 fG9jElAvaAUVJanGF06Qjpz6hvequb6w8nqPzJE1Ni2xxPzr8svaa4+bkc/4zXMbBMyLsi4f6
 UEec41RoHuahOT3/OERhH9Och22uETJRRRMwDyDt2eX0UI2WTKhcjg2Mw4xeD5eyZuVOI43oS
 9eW9BO/D7M4JPustfBc2FYEhoQhsgcwEvI6xSS+L5WxAkw91bJd+aqMeGkMPi65eyFYpyBImu
 LTnS+943l8mZJEM/6yayas69TV/sTPWlpXXC0WoNkSizClXtI15cpyGA78+atdamCPhj45G0o
 GF7c80YTrVZ/mmafZ9jkfhQniFL4Doez9RjL+7PW9/L+z2mL/H7o09j0BmKPlzq8Uf+SvsMSq
 PrLtArEgUcv0H8juXATV0FaweQPhmn2llaDO5FbB5c+FnuPhc2hAUAFb2jf5Y6Cfpa/EKipU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282553>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/RelNotes/2.7.0.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.7.0.txt b/Documentation/RelNotes/2.7.0.txt
index a84caba..eb179cc 100644
--- a/Documentation/RelNotes/2.7.0.txt
+++ b/Documentation/RelNotes/2.7.0.txt
@@ -22,7 +22,7 @@ UI, Workflows & Features
 
  * Users who are too busy to type three extra keystrokes to ask for
    "git stash show -p" can now set stash.showPatch configuration
-   varible to true to always see the actual patch, not just the list
+   variable to true to always see the actual patch, not just the list
    of paths affected with feel for the extent of damage via diffstat.
 
  * "quiltimport" allows to specify the series file by honoring the
-- 
2.6.3.windows.1.300.g1c25e49
