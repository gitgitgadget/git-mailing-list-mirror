Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_50,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A17E52018A
	for <e@80x24.org>; Mon, 27 Jun 2016 13:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbcF0NV7 (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 09:21:59 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:58301 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbcF0NV6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2016 09:21:58 -0400
Received: from pflsmail.localdomain ([37.123.123.67]) by
 mrelayeu.kundenserver.de (mreue004) with ESMTPSA (Nemesis) id
 0LjODj-1buQrz46VL-00dZMU; Mon, 27 Jun 2016 15:21:41 +0200
Received: from localhost (localhost [127.0.0.1])
	by pflsmail.localdomain (Postfix) with ESMTP id 4D15BB00E5D;
	Mon, 27 Jun 2016 15:21:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at pflsmail.corp.cetitec.com
Received: from pflsmail.localdomain ([127.0.0.1])
	by localhost (pflsmail.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9NTmpW9qCE18; Mon, 27 Jun 2016 15:21:38 +0200 (CEST)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
	by pflsmail.localdomain (Postfix) with ESMTPS id 2DBE7B00E58;
	Mon, 27 Jun 2016 15:21:38 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (10.10.11.230) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.847.32; Mon, 27 Jun 2016 15:21:37 +0200
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)	id
 A38C6804B0; Mon, 27 Jun 2016 15:21:37 +0200 (CEST)
Date:	Mon, 27 Jun 2016 15:21:37 +0200
From:	Alex Riesen <alexander.riesen@cetitec.com>
To:	<git@vger.kernel.org>
CC:	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] Support for $FILENAMES in tool definitions
Message-ID: <20160627132137.GC4194@pflmari>
Reply-To: Alex Riesen <alexander.riesen@cetitec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.10.11.230]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
Content-Transfer-Encoding: 8BIT
X-Antivirus: avast! (VPS 160627-0, 27.06.2016), Outbound message
X-Antivirus-Status: Clean
X-Provags-ID: V03:K0:0AUlVSjikolu0mKW6aa16TOzeh/dI96BLyYdNkxHqnIL+F3H6/U
 hyfPZFEOnNeJlpRIKA+CWgzh6MD30xMcsOiVhZCDvsN320OEOQ39uZuUlVfn+HpMuCf3zcJ
 Xt+nK2UNTl69/hDgki0IWinUp/Q3WVHiPQHXgwJTlxEF9y8xy1vvVC4EgGSrSoW9Hx4kALK
 zPhIPKmpNjb3dR+h76u1A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:bgOpt7ZLpFE=:aNpqEJgMphZqSv4v9D1iva
 z4//aLM9/h8DA/+RYeSAWIpvKjMtzTHuWsI3ty+XrVDbzfUrI9zYeCnzW1eDEbZxYrqk+tK6H
 f2lBkPFpoUEmZr76Vc+HsHUYa/MSgtHnAOM9eFBUchPowLWrnlldjgh8SpLwJKQoF0aL/MpHi
 5mvvrO5EIYW+VOn2vTBzedHkSI/xpsfHwDLWj1/ahU9ZvoRCwJXMGeUn0kNCGki8OTXcB3F0l
 dpU5sM8nlzMir2fmZxMArEyxdjjGfDqNTttKb+iXNEDWlxM8Y3pitIj5DKBod+pFBLWNeHW/B
 xFGhkl7BR5m32DS5ZcuWdtXYXKVFLFLvtGukXZyOcEUdPRlBMlese0tXjcEN9N5KkR3Q1w9tz
 FqaZG3p17k/AJWcahLHf522ZA67cfZXEAhURPHzOYwSjcgTa2DBwlt4QHIf0fZnD6U/3LKigQ
 A2Mc5RyX9FnneypBXO+1apHqigc1IhJv9/AKiMVmM7n5+ggTUUv7ZdmIBGfQ+QbzWfJ+FMRPu
 LPfvA851uixEZsvro+C+cgDD+PvhPF+AYKuvPMtTyX5FStiWESq5SLPi8vX35I3KuOnRR0Stl
 WFcjcRB0AkosG6Fu7vA5StG761z/ic3R7V0hQRFaru62dHB5MwDxp7YUP9W1IPf4Q0NZYJTm1
 cG2vWMObUA3UWXO+eYd1nEfMLhZKij5fh7IU+iou+3J8vG93UCM+s2+BCY3v5zGY1MEE=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This adds a FILENAMES environment variable, which contains the repository
pathnames of all selected files the list.
The variable contains the names separated by spaces.

Similar to the FILENAME it is broken yet, if the names contain spaces.

Note that the file marked and diffed immediately after starting the GUI up,
is not actually selected. One must click on it once to really select it.

Signed-off-by: Alex Riesen <alexander.riesen@cetitec.com>
---

One day the FILENAME and FILENAMES will have to be fixed to properly pass the
file names with spaces. Sorry, I couldn't find how to do it this time around.

 lib/tools.tcl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/tools.tcl b/lib/tools.tcl
index 6ec9411..14d556f 100644
--- a/lib/tools.tcl
+++ b/lib/tools.tcl
@@ -69,6 +69,7 @@ proc tools_populate_one {fullname} {
 proc tools_exec {fullname} {
 	global repo_config env current_diff_path
 	global current_branch is_detached
+	global selected_paths
 
 	if {[is_config_true "guitool.$fullname.needsfile"]} {
 		if {$current_diff_path eq {}} {
@@ -100,6 +101,7 @@ proc tools_exec {fullname} {
 
 	set env(GIT_GUITOOL) $fullname
 	set env(FILENAME) $current_diff_path
+	set env(FILENAMES) [array names selected_paths]
 	if {$is_detached} {
 		set env(CUR_BRANCH) ""
 	} else {
@@ -121,6 +123,7 @@ proc tools_exec {fullname} {
 
 	unset env(GIT_GUITOOL)
 	unset env(FILENAME)
+	unset env(FILENAMES)
 	unset env(CUR_BRANCH)
 	catch { unset env(ARGS) }
 	catch { unset env(REVISION) }
-- 
2.9.0.45.g28c608e.dirty


---
Diese E-Mail wurde von Avast Antivirus-Software auf Viren geprüft.
https://www.avast.com/antivirus

