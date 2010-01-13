From: Mark Hills <mark@pogo.org.uk>
Subject: [PATCH 3/5] gitk: Set the font for all listbox widgets
Date: Wed, 13 Jan 2010 20:40:20 +0000
Message-ID: <1263415222-5911-3-git-send-email-mark@pogo.org.uk>
References: <alpine.NEB.2.01.1001132030010.15349@jrf.vwaro.pbz>
 <1263415222-5911-1-git-send-email-mark@pogo.org.uk>
 <1263415222-5911-2-git-send-email-mark@pogo.org.uk>
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Jan 13 21:41:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVA1D-0003qp-PJ
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 21:40:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204Ab0AMUkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 15:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200Ab0AMUkg
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 15:40:36 -0500
Received: from mailout.ijneb.com ([212.13.201.26]:58949 "EHLO wes.ijneb.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932159Ab0AMUkd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 15:40:33 -0500
Received: from cpc1-acto2-0-0-cust60.4-2.cable.virginmedia.com ([82.28.218.61] helo=stax.localdomain)
	by wes.ijneb.com with esmtpa (Exim 4.69)
	(envelope-from <mark@pogo.org.uk>)
	id 1NVA0t-0000ab-CR; Wed, 13 Jan 2010 20:40:23 +0000
Received: from mark by stax.localdomain with local (Exim 4.69)
	(envelope-from <mark@stax.localdomain>)
	id 1NVA0s-0001Xv-MM; Wed, 13 Jan 2010 20:40:22 +0000
X-Mailer: git-send-email 1.6.6.5.ge408
In-Reply-To: <1263415222-5911-2-git-send-email-mark@pogo.org.uk>
X-SA-Exim-Connect-IP: 82.28.218.61
X-SA-Exim-Mail-From: mark@pogo.org.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136879>

This affects the font chooser.

Signed-off-by: Mark Hills <mark@pogo.org.uk>
---
 gitk |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index e010010..3cdc31e 100755
--- a/gitk
+++ b/gitk
@@ -1880,6 +1880,7 @@ proc setoptions {} {
     option add *Entry.font uifont startupFile
     option add *Labelframe.font uifont startupFile
     option add *Spinbox.font textfont startupFile
+    option add *Listbox.font mainfont startupFile
 }
 
 # Make a menu and submenus.
-- 
1.6.6.5.ge408
