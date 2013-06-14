From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [[PATCH v3] 0/2] module_list enhancements
Date: Fri, 14 Jun 2013 17:56:03 +0200
Message-ID: <1371225365-4219-1-git-send-email-iveqy@iveqy.com>
Cc: git@vger.kernel.org, iveqy@iveqy.com, jens.lehmann@web.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 14 17:53:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnWJV-0004r2-9y
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 17:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750Ab3FNPxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 11:53:07 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:57369 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930Ab3FNPxF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 11:53:05 -0400
Received: by mail-lb0-f170.google.com with SMTP id t13so746437lbd.1
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 08:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=ijHfsEIiz4f/R04cHqLDmZZ2xPQqhxGS1Lovf89lEsM=;
        b=BzTUaWRFibKIlTFCTnameNT6CaBllTzjNVM4zx8bnanie/XQzaFaTTG5odIyHdTVeE
         J4snDu6EN/m10ISH9iwSw6LiFlEiAu+jFUtA48jxr8PW/kIzAmAEohz6Aslhnsjset3N
         0aw7nFX/qZZqYzMxHd+S4lew2vPI3C0NtFuNOMU5hb95OH0y4K+XRY0E8yBnjJxZYvMR
         zGUu+SvuGVeMfb7ybFcXwVaK1ow9FRk8ZEcZfFhydF9ku8SBnLLyKjfdumjHokFPLhUu
         iAyp2FrPKlQGuM95oQMFFdnsMJQK8I/vCCgZ92K2tDiNwmcomTP1KzxW0sF3sNKRYaQE
         08zg==
X-Received: by 10.152.120.105 with SMTP id lb9mr1476097lab.20.1371225183785;
        Fri, 14 Jun 2013 08:53:03 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id et10sm1084824lbc.6.2013.06.14.08.53.02
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 14 Jun 2013 08:53:03 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UnWMH-00016d-CQ; Fri, 14 Jun 2013 17:56:13 +0200
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227887>

Reworded commit message for
[submodule] handle multibyte characters in name
as suggested by Junio.

Previous iteration can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/227786/

Fredrik Gustafsson (2):
  [submodule] handle multibyte characters in name
  [submodule] Replace perl-code with sh

 git-submodule.sh           | 53 ++++++++++++++++++++--------------------------
 t/t7400-submodule-basic.sh | 12 +++++++++++
 2 files changed, 35 insertions(+), 30 deletions(-)

-- 
1.8.3.1.381.g2ab719e.dirty
