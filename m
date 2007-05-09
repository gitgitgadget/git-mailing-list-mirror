From: Petr Baudis <pasky@ucw.cz>
Subject: [PATCH] gitweb: Do not use absolute font sizes
Date: Wed, 09 May 2007 03:41:50 +0200
Message-ID: <20070509014150.7477.48489.stgit@rover>
References: <6efbd9b70705071613p23017509qaf9af12c1d14f9cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 09 04:02:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlbW1-0002up-5f
	for gcvg-git@gmane.org; Wed, 09 May 2007 04:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S969264AbXEICCr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 22:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S969182AbXEICCr
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 22:02:47 -0400
Received: from rover.dkm.cz ([62.24.64.27]:32896 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968747AbXEICCq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 22:02:46 -0400
X-Greylist: delayed 1253 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 May 2007 22:02:45 EDT
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id C5BD78B69E;
	Wed,  9 May 2007 03:41:50 +0200 (CEST)
In-Reply-To: <6efbd9b70705071613p23017509qaf9af12c1d14f9cb@mail.gmail.com>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46651>

Avoid specifying font sizes in pixels, since that is just pure evil.
Pointed out by Chris Riddoch.

Note that this is pretty much just a proposal; I didn't test if everything
fits perfectly right, but things seem to be pretty much okay. repo.or.cz
uses it now as a test drive - if you find any visual quirks, please point
them out, with a patch if possible since I'm total CSS noob and debugging
CSS is an extremely painful experience for me.

Note that this patch actually does change visual look of gitweb in Firefox
with my resolution and default settings - everything is bigger and I can't
explain the joy of actually seeing gitweb text that is in _readable_ size;
also, my horizontal screen real estate feels better used now. But judging
from the look of most modern webpages on the 'net, most people prefer
reading the web with strained eyes and/or a magnifying glass (I wonder what
species of scientists should look into this mystifying phenomenon) - so,
please tell us what you think.

Maybe we might want to get rid of absolute sizes other than font sizes in
the CSS file too in the long term.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.css |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 6c662a1..df12d78 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -1,6 +1,5 @@
 body {
 	font-family: sans-serif;
-	font-size: 12px;
 	border: solid #d9d8d1;
 	border-width: 1px;
 	margin: 10px;
@@ -31,7 +30,7 @@ img.logo {
 div.page_header {
 	height: 25px;
 	padding: 8px;
-	font-size: 18px;
+	font-size: 150%;
 	font-weight: bold;
 	background-color: #d9d8d1;
 }
@@ -113,7 +112,7 @@ span.signoff {
 
 div.log_link {
 	padding: 0px 8px;
-	font-size: 10px;
+	font-size: 70%;
 	font-family: sans-serif;
 	font-style: normal;
 	position: relative;
@@ -204,13 +203,13 @@ table.blame {
 
 table.blame td {
 	padding: 0px 5px;
-	font-size: 12px;
+	font-size: 100%;
 	vertical-align: top;
 }
 
 th {
 	padding: 2px 5px;
-	font-size: 12px;
+	font-size: 100%;
 	text-align: left;
 }
 
@@ -232,14 +231,14 @@ tr.dark:hover {
 
 td {
 	padding: 2px 5px;
-	font-size: 12px;
+	font-size: 100%;
 	vertical-align: top;
 }
 
 td.link, td.selflink {
 	padding: 2px 5px;
 	font-family: sans-serif;
-	font-size: 10px;
+	font-size: 70%;
 }
 
 td.selflink {
@@ -416,7 +415,7 @@ div.index_include {
 }
 
 div.search {
-	font-size: 12px;
+	font-size: 100%;
 	font-weight: normal;
 	margin: 4px 8px;
 	position: absolute;
@@ -444,7 +443,7 @@ a.rss_logo {
 	background-color: #ff6600;
 	font-weight: bold;
 	font-family: sans-serif;
-	font-size: 10px;
+	font-size: 70%;
 	text-align: center;
 	text-decoration: none;
 }
@@ -455,7 +454,7 @@ a.rss_logo:hover {
 
 span.refs span {
 	padding: 0px 4px;
-	font-size: 10px;
+	font-size: 70%;
 	font-weight: normal;
 	border: 1px solid;
 	background-color: #ffaaff;
