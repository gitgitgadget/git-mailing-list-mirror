From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Jun 2010, #04; Wed, 23)
Date: Thu, 24 Jun 2010 16:48:15 +0200
Message-ID: <4C23702F.8030707@viscovery.net>
References: <7viq59e6zn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 16:48:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORnjA-0007mC-6E
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 16:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755566Ab0FXOsV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 10:48:21 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:15188 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755464Ab0FXOsV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jun 2010 10:48:21 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1ORniy-00065V-HP; Thu, 24 Jun 2010 16:48:16 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 3B46D1660F;
	Thu, 24 Jun 2010 16:48:16 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
In-Reply-To: <7viq59e6zn.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149598>

Am 6/24/2010 0:09, schrieb Junio C Hamano:
> * cp/textconv-cat-file (2010-06-09) 4 commits
>  - [DONTMERGE] git gui: use textconv filter for diff and blame

This git-gui patch needs a fixup.

-- Hannes

diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index b02d2e5..c628750 100644
--- a/git-gui/lib/diff.tcl
+++ b/git-gui/lib/diff.tcl
@@ -280,7 +280,7 @@ proc start_show_diff {cont_info {add_opts {}}} {
 			lappend cmd diff-files
 		}
 	}
-	if {![is_config_false gui.textconv] && [git-version >=F1.6.1]} {
+	if {![is_config_false gui.textconv] && [git-version >=3D 1.6.1]} {
 		lappend cmd --textconv
 	}
