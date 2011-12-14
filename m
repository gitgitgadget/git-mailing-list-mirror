From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH 3/4] Introduce a performance testing framework
Date: Wed, 14 Dec 2011 17:04:31 +0100
Message-ID: <201112141704.32052.trast@student.ethz.ch>
References: <cover.1323876121.git.trast@student.ethz.ch> <91630874c45015e74cf72df03b6011856fd0fe4f.1323876121.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 17:04:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RarK4-0000yS-Pd
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 17:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757344Ab1LNQEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 11:04:37 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:30972 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755424Ab1LNQEe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 11:04:34 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 14 Dec
 2011 17:04:29 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 14 Dec
 2011 17:04:32 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.3-1-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <91630874c45015e74cf72df03b6011856fd0fe4f.1323876121.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187137>

This patch actually needs the below fixup on top.  Old files from
previous runs had fooled my testing...

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index ee6c083..f2a0b73 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -154,7 +154,7 @@ test_perf () {
 	then
 		base=$(basename "$0" .sh)
 		echo "$test_count" >>"$perf_results_dir"/$base.subtests
-		echo "$1" >"$perf_results_dir"/$base.descr
+		echo "$1" >"$perf_results_dir"/$base.$test_count.descr
 		if test -z "$verbose"; then
 			echo -n "perf $test_count - $1:"
 		else

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
