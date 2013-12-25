From: Wolfgang Rohdewald <wolfgang@rohdewald.de>
Subject: german translation bug
Date: Wed, 25 Dec 2013 20:53:58 +0100
Message-ID: <1573480.3a5WD62Cc4@i5>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 25 20:54:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VvuX4-0002hH-B6
	for gcvg-git-2@plane.gmane.org; Wed, 25 Dec 2013 20:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313Ab3LYTxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Dec 2013 14:53:52 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:58405 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294Ab3LYTxv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Dec 2013 14:53:51 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1388001228; l=379;
	s=domk; d=rohdewald.de;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Date:Subject:To:
	From:X-RZG-CLASS-ID:X-RZG-AUTH;
	bh=+GS0SbulPQt1Sk4FgP54NRzua6k=;
	b=Jxs0RZbOSxCedcwZ6QwugH3ohQzGwYXF2bG3r1mULVCGHXCztdlFtxJSwFSkc7xuOKn
	caeeOm+r8bTPjlyGQNLcUIJe3QIzB45u6nbzzwf/+oWdSkwKzfdySN+wzqNtACtn1C/Ii
	aMbib3TbdlJ3+rCFwcT/bHvAu67DgdAeS6k=
X-RZG-AUTH: :O2MIc0epdfgAjoV+frHI3UhxNCLBO5P+YS73lHhJYRD2uAuzaM+5N8MTpvX1LBI=
X-RZG-CLASS-ID: mo00
Received: from i5.rohdewald.de (p5B3E3307.dip0.t-ipconnect.de [91.62.51.7])
	by smtp.strato.de (RZmta 32.17 DYNA|AUTH)
	with (SSLv3:DHE-RSA-AES256-SHA encrypted) ESMTPSA id i00c38pBPJrmM0e
	for <git@vger.kernel.org>; Wed, 25 Dec 2013 20:53:48 +0100 (CET)
Received: from i5.localnet (localhost.localdomain [127.0.0.1])
	by i5.rohdewald.de (Postfix) with ESMTP id AB4975E0190
	for <git@vger.kernel.org>; Wed, 25 Dec 2013 20:53:58 +0100 (CET)
User-Agent: KMail/4.12 (Linux/3.11.0-14-generic; KDE/4.12.0; x86_64; ; )
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
	shortcircuit=no autolearn=unavailable version=3.3.2
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on i5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239676>

"Arbeitsverzeichnis leer" means
"working directory empty" which is obviously wrong.

It should say

"Arbeitsverzeichnis sauber"

wr@s5:~/src/linux$ git status
# Auf Zweig drm-intel-testing
Nichts zum Einreichen, Arbeitsverzeichnis leer
wr@s5:~/src/linux$ LANG=C git status
# On branch drm-intel-testing
nothing to commit, working directory clean



-- 
Wolfgang
