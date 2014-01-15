From: al_shopov@yahoo.com
Subject: [PATCH 0/3] Bulgarian glossary & translation + terms for git-gui
Date: Wed, 15 Jan 2014 13:07:54 +0200
Message-ID: <1389784077-8105-1-git-send-email-lists@kambanaria.org>
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 15 12:14:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3OQN-0002o8-PB
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 12:14:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbaAOLOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 06:14:17 -0500
Received: from nm21-vm2.bullet.mail.ir2.yahoo.com ([212.82.96.253]:24418 "EHLO
	nm21-vm2.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751046AbaAOLOP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jan 2014 06:14:15 -0500
X-Greylist: delayed 368 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Jan 2014 06:14:15 EST
Received: from [212.82.98.56] by nm21.bullet.mail.ir2.yahoo.com with NNFMP; 15 Jan 2014 11:08:06 -0000
Received: from [46.228.39.110] by tm9.bullet.mail.ir2.yahoo.com with NNFMP; 15 Jan 2014 11:08:06 -0000
Received: from [127.0.0.1] by smtp147.mail.ir2.yahoo.com with NNFMP; 15 Jan 2014 11:08:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1389784086; bh=iNsQbfmdqkmxptyXhjf9xoz/0zIWInNCidbaDEU14J0=; h=X-Yahoo-Newman-Id:X-Rocket-Received:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:From:To:Cc:Subject:Date:Message-Id:X-Mailer; b=Wspz/Cy07bks0g6Rse72bY02ULOtzB5i9h+/dJZhb9AY+S2faaynamnE7k4fP+/07w+fr+WbdCnCObcIP2cSoFZK07S4n6RlU/pzOkNKMyG/L7DD5udxZEFh1OJ+rfC/yC3+QU6iYsAj+iitAxCm66TYsXZ0uLDwwqbmWSv/ZKo=
X-Yahoo-Newman-Id: 466735.73467.bm@smtp147.mail.ir2.yahoo.com
X-Rocket-Received: from localhost.lan (al_shopov@78.83.52.173 with plain [188.125.69.59])
        by smtp147.mail.ir2.yahoo.com with SMTP; 15 Jan 2014 11:08:06 +0000 UTC
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: .c3MYmsVM1nHuJMFUB9_cHU5CROfn2CFfutiutZYxhHPPiP
 97mNy75cY8f0lQZ254UxB_0WqK7QB5Kcp7xa2xIDcLJEpR_h9NDpaHw9Rfjg
 hW0ujVwvP1ikbsz7S0JtOUz1YA118cuKWiW9oCGtdpMJvkFmRhcHohgUUxxc
 oT2WLKTX6Tf8kXzcLL8hmDSly_KxDErG3SzBrhqcN9mFkUSeHGQI31TjBgCc
 wT8jekCG3sU8Vp6SCShE88mB2F2OAw4a.1Znk46DLNdLbTBPIMksN2yWNwPy
 oHQJWP6ErZuv91W3ryw4UbyyxGz4GLpxnx6eJH1M.NglYzkju30rWIz77jzq
 OYcoQhezx1HOfHHiUeBvsztNM6xwxRf_6rkBELpruwWDkyf5iy85XqrhVMYI
 vkQlNcq6u4WAlpCWO7uA7_bmOJpQUG0DlEH_zR3wS47qsNeUQGQwugUX8wGL
 yOFcZWr61dmNsaSqMyyqKojdsjWRfsyVgUpxpY7igFPbfRbU_3wK5BTln21Q
 fRnNrkQ.kROMyHiAqc9R0UQXbLxFLvz00yVcZ0m.rShJKrmk-
X-Yahoo-SMTP: yRWQ8BGswBDCUSC0.xLhuVo_zCa4SQ--
X-Mailer: git-send-email 1.8.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240456>

From: Alexander Shopov <ash@kambanaria.org>

Following 3 patchess add:
1. Bulgarian translation of git-gui glossary
2. Bulgarian translation of git-gui po file
3. Additional terms for git-gui glossary in English
The terms in the 3rd patch are in alphabetic order after the existing terms
in order to make review easier. If necessary I will reorder the whole file
after discussion.

Alexander Shopov (3):
  git-gui i18n: Initial glossary in Bulgarian
  git-gui i18n: Added Bulgarian translation
  git-gui l10n: Add 29 more terms to glossary

 po/bg.po                         | 2694 ++++++++++++++++++++++++++++++++++++++
 po/glossary/bg.po                |  287 ++++
 po/glossary/git-gui-glossary.txt |   29 +
 3 files changed, 3010 insertions(+)
 create mode 100644 po/bg.po
 create mode 100644 po/glossary/bg.po

-- 
1.8.4.2
