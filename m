From: Christian Jaeger <christian@jaeger.mine.nu>
Subject: Re: [PATCH (GITK BUGFIX)] gitk: Allow safely calling nukefile from
 a run queue handler.
Date: Sat, 09 Aug 2008 13:24:23 +0200
Message-ID: <489D7E67.5050205@jaeger.mine.nu>
References: <42d19ab224653b2e6988d7209a8d3e87e19858f8.1218207346.git.christian@jaeger.mine.nu> <200808091313.52528.angavrilov@gmail.com> <217ad8e755d8d51e2ec0f06b4bffa0864976f7e4.1218277122.git.christian@jaeger.mine.nu> <200808091441.50444.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 09 13:27:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRmbX-0003ni-V5
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 13:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbYHILY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 07:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbYHILY3
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 07:24:29 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:39749 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751282AbYHILY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 07:24:28 -0400
Received: (qmail 15257 invoked from network); 9 Aug 2008 11:24:26 -0000
Received: from unknown (HELO elvis-jaeger.mine.nu) (127.0.0.1)
  by localhost with SMTP; 9 Aug 2008 11:24:26 -0000
Received: (qmail 17943 invoked from network); 9 Aug 2008 11:24:23 -0000
Received: from unknown (HELO ?127.0.0.1?) (10.0.5.1)
  by elvis-jaeger.mine.nu with SMTP; 9 Aug 2008 11:24:23 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <200808091441.50444.angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91765>

Alexander Gavrilov wrote:
> 	Please test if this patch fixes it.
>   

Yes, with that patch it works reliably.

BTW here's a patch to your patch to make it apply on top of 1.6.0.rc2:

--- patch.eml.1	2008-08-09 13:17:30.000000000 +0200
+++ patch.eml	2008-08-09 13:14:22.000000000 +0200
@@ -96,10 +96,10 @@
  gitk |   14 ++++++++------
  1 files changed, 8 insertions(+), 6 deletions(-)
 
-diff --git a/gitk b/gitk
-index b523c98..18d000c 100755
---- a/gitk
-+++ b/gitk
+diff --git a/gitk-git/gitk b/gitk-git/gitk
+index b523c98..18d000c 100644
+--- a/gitk-git/gitk
++++ b/gitk-git/gitk
 @@ -22,11 +22,11 @@ proc gitdir {} {
  # run before X event handlers, so reading from a fast source can
  # make the GUI completely unresponsive.



Christian.
