From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 4/8] git-gui: there is no "mode *" diff header line
Date: Thu,  9 Dec 2010 21:47:55 +0100
Message-ID: <cc7284fbd48c589af26dd8f3905fb4244fedbfda.1291927657.git.bert.wesarg@googlemail.com>
References: <babc4fe91e54e3923baa6f08cc92ee8ea494e704.1291927657.git.bert.wesarg@googlemail.com>
 <56141ad4622dfc1ee991c9ee3be90dbf3e99b744.1291927657.git.bert.wesarg@googlemail.com>
 <ae1d2af4dad878c54959a72989cb170376b7fb95.1291927657.git.bert.wesarg@googlemail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Dec 09 21:48:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQnPo-0003RY-Gm
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 21:48:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757195Ab0LIUsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 15:48:15 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:50756 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756838Ab0LIUsN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 15:48:13 -0500
Received: by mail-fx0-f43.google.com with SMTP id 18so2916089fxm.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 12:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=husYlT3BewxAIQnUsfKihddkdE443Z+oXEkSqX/t9dc=;
        b=siR4i9pD//6mfg7GdTzT07mz5P2GgnmNAaupquvHJShI4lzl1xY0QDHPymmP7BjdLK
         dGK4ImejWiJdSWlfiXfzoQOWMSDRRJaOHF5O1XcUCxowTuQ8w6Bf8PoGDWTE3nLmJvqG
         nCajc99EsqISoMmz0DCCJLM1FJy8rctD97YSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kaL+PGYvbyPCgJQ7nhDitUONkFStuhLYOjKxo55BZ/DRQBOfxFVL4/34zS4F9zg/xn
         G5nMa8+5G9agI3ruB3RyGEqf1cYKeYopBHgXN2+aa8AE3IVHuG+CpspZ53EwXo69uBR0
         EOEcg2NETXZIRIjgZG9U3LPxBelP1ETO3IwcU=
Received: by 10.223.83.14 with SMTP id d14mr2874259fal.22.1291927692922;
        Thu, 09 Dec 2010 12:48:12 -0800 (PST)
Received: from localhost (p3E990761.dip.t-dialin.net [62.153.7.97])
        by mx.google.com with ESMTPS id n7sm682509fam.35.2010.12.09.12.48.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 12:48:11 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.1200.ge4bf6
In-Reply-To: <ae1d2af4dad878c54959a72989cb170376b7fb95.1291927657.git.bert.wesarg@googlemail.com>
In-Reply-To: <babc4fe91e54e3923baa6f08cc92ee8ea494e704.1291927657.git.bert.wesarg@googlemail.com>
References: <babc4fe91e54e3923baa6f08cc92ee8ea494e704.1291927657.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163314>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 lib/diff.tcl |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/lib/diff.tcl b/lib/diff.tcl
index aa30089..20f50dd 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -417,8 +417,7 @@ proc read_diff {fd conflict_size cont_info} {
 		#
 		if {[string match {@@@ *} $line]} {set is_3way_diff 1}
 
-		if {[string match {mode *} $line]
-			|| [string match {new file *} $line]
+		if {[string match {new file *} $line]
 			|| [regexp {^(old|new) mode *} $line]
 			|| [string match {deleted file *} $line]
 			|| [string match {deleted symlink} $line]
-- 
1.7.3.2.1200.ge4bf6
