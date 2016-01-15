From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v3 15/20] init: allow alternate backends to be set for new repos
Date: Fri, 15 Jan 2016 12:33:58 +0100
Message-ID: <1452857638-25956-1-git-send-email-szeder@ira.uka.de>
References: <1452788777-24954-16-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 12:34:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK2e7-0002PH-Um
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 12:34:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754440AbcAOLeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 06:34:20 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:44040 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751095AbcAOLeT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jan 2016 06:34:19 -0500
Received: from x590d6cbc.dyn.telefonica.de ([89.13.108.188] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aK2e0-00032M-VE; Fri, 15 Jan 2016 12:34:18 +0100
X-Mailer: git-send-email 2.7.0.rc2.34.g28a1f98
In-Reply-To: <1452788777-24954-16-git-send-email-dturner@twopensource.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1452857658.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284161>

Hi,

Perhaps the subject line could benefit from a s/backends/ref backends/.
Or even 'init: allow setting alternate ref backends'

Anyway, could you please squash this in to keep the completion script
up to date?

------ >8 ------

Subject: completion: git init --ref-storage=
---

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c970d3c0d0a3..743d8509a69f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1363,7 +1363,8 @@ _git_init ()
 		return
 		;;
 	--*)
-		__gitcomp "--quiet --bare --template= --shared --shared="
+		__gitcomp "--quiet --bare --template= --shared --shared=
+			--ref-storage="
 		return
 		;;
 	esac
