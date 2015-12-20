From: larsxschneider@gmail.com
Subject: [PATCH v1 0/2] git-p4: kill watchdog and suppress irrelevant output
Date: Sun, 20 Dec 2015 17:44:27 +0100
Message-ID: <1450629869-49522-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, sunshine@sunshineco.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 20 17:44:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAh66-0007la-LV
	for gcvg-git-2@plane.gmane.org; Sun, 20 Dec 2015 17:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933451AbbLTQoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Dec 2015 11:44:34 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35087 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754190AbbLTQod (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2015 11:44:33 -0500
Received: by mail-wm0-f66.google.com with SMTP id p187so8335452wmp.2
        for <git@vger.kernel.org>; Sun, 20 Dec 2015 08:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=DknBg1StvZKV7pcSdzawOjJKxCz6TYqgB/FHCTpYHdM=;
        b=Jj/SIZZWYWdtojjX+DbHSnmcqCeSRQzQJtpKn3zXEMgeplzuCdlfoJevxFHm/F4HUk
         hW8YH+OEXarsfUQ3044omGaZx9mvhNZGwBQiIIDa6zO2d8iXxqmHT2QRvE5xPF03kIpm
         TRK5AfElhTdiDnyQeTILZnumws8bkufX2pbw3Vlzjbu8j9ffaaJozIQtDcXUzMkn7FGe
         NuMwsfk6jbBPj8/Q+NIfNVyNH51wFfnrlJHRXSW7+qAVKurMQOSnv1RahtIJyLL4rJ5K
         Md1SIIivzpiur/6xW/OJHOlq8+iuF1osmI/g+esWHj4Z4m7R5WfuVmuUyRWpdUMV4BUI
         ZAIg==
X-Received: by 10.194.117.68 with SMTP id kc4mr15581892wjb.77.1450629872342;
        Sun, 20 Dec 2015 08:44:32 -0800 (PST)
Received: from slxBook3.fritz.box (p508BA24E.dip0.t-ipconnect.de. [80.139.162.78])
        by smtp.gmail.com with ESMTPSA id g127sm16057280wmf.24.2015.12.20.08.44.31
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Dec 2015 08:44:31 -0800 (PST)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282772>

From: Lars Schneider <larsxschneider@gmail.com>

Hi,

these patches extend "git-p4: add trap to kill p4d on test exit" (dfe90e8)
and therefore should be applied on master.

Thanks,
Lars

Lars Schneider (2):
  git-p4: kill p4d watchdog on cleanup
  git-p4: suppress non test relevant output

 t/lib-git-p4.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--
2.5.1
