From: Jing Xue <jingxue@digizenstudio.com>
Subject: Re: gitk fails to parse git log output in 1.5.3
Date: Sun, 2 Sep 2007 21:25:27 -0400
Message-ID: <20070903012527.GB19198@falcon.digizenstudio.com>
References: <20070902223128.GA19198@falcon.digizenstudio.com> <7vzm04odze.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 03:26:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS0hW-0001pX-At
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 03:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbXICBZg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 21:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbXICBZg
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 21:25:36 -0400
Received: from k2smtpout06-02.prod.mesa1.secureserver.net ([64.202.189.103]:36477
	"HELO k2smtpout06-02.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750841AbXICBZf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 21:25:35 -0400
Received: (qmail 25003 invoked from network); 3 Sep 2007 01:25:35 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout06-02.prod.mesa1.secureserver.net (64.202.189.103) with ESMTP; 03 Sep 2007 01:25:35 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id CD8AC100A0D;
	Mon,  3 Sep 2007 01:25:34 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RnO1i97T0ws5; Sun,  2 Sep 2007 21:25:28 -0400 (EDT)
Received: from falcon (ip70-187-196-88.dc.dc.cox.net [70.187.196.88])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 6B1E01000A2;
	Sun,  2 Sep 2007 21:25:28 -0400 (EDT)
Received: by falcon (Postfix, from userid 1000)
	id 8E19B7B520; Sun,  2 Sep 2007 21:25:27 -0400 (EDT)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vzm04odze.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57422>


On Sun, Sep 02, 2007 at 04:16:05PM -0700, Junio C Hamano wrote:
> 
> This will quickly turn into an FAQ.

Indeed. I went and added it to the Wiki/FAQ.

Also I noticed that git-log was missing the descriptions for '--color'
and '--no-color'.


Signed-off-by: Jing Xue <jingxue@digizenstudio.com>
---
 Documentation/git-log.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 5ec547c..c42ca89 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -72,6 +72,14 @@ include::pretty-options.txt[]
 	Note that only message is considered, if also a diff is shown
 	its size is not included.
 
+--color::
+	Show colored log entries. Same as if `color.diff` were set to
+    "true".
+
+--no-color::
+	Turn off colored log entries, even when `color.diff` sets the
+    default to color output.
+
 <paths>...::
 	Show only commits that affect the specified paths.
 
-- 
1.5.3
