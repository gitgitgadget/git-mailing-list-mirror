From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 00/10] use the $( ... ) construct for command substitution
Date: Wed, 23 Dec 2015 14:45:48 +0100
Message-ID: <1450878358-7422-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 23 14:46:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBjkE-0002CZ-E9
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 14:46:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933793AbbLWNqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 08:46:17 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34109 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270AbbLWNqR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2015 08:46:17 -0500
Received: by mail-pa0-f53.google.com with SMTP id uo6so28632965pac.1
        for <git@vger.kernel.org>; Wed, 23 Dec 2015 05:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=dgWxfajvgMQYU3ZZICwSjyu4VithTPL4LpE6zcluous=;
        b=p3C3JG46M0X2eaMQv39GpuaQD4aulIak5eeBDc9VYVrB8TeJiWCewpye+PlxVfR4Zu
         ACwOpHwuW4Szp4h4awPxiayOOUte1LLoQDXJ1acOUiKttz+OySu20XlGMyapUmAvwFeG
         fcP0w7+fdWGI4AnTglea9t/AXf3wZiqlI+cYxvlPzZkEiVk1I7jsK7o6X2C7UH31JS3/
         i/G/zlbAtrAzTQegkzBlj9p4ksJxxPIuiLeOB8pu/8onoUyL37aC1Eb3RdSTOsPEcLwH
         vpxCQJR9ClS1KRfJtj3EunkWG6pFFUUFhQ9QD1SzFOLX3NVBkiB+tDYOzA45sztHT2+x
         tXZg==
X-Received: by 10.66.160.168 with SMTP id xl8mr44630453pab.116.1450878376558;
        Wed, 23 Dec 2015 05:46:16 -0800 (PST)
Received: from ubuntu14.nephoscale.com ([67.207.195.141])
        by smtp.gmail.com with ESMTPSA id p83sm48250443pfi.96.2015.12.23.05.46.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Dec 2015 05:46:15 -0800 (PST)
X-Mailer: git-send-email 2.3.3.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282938>

This patch series continues the changes introduced with the merge
6753d8a85d543253d95184ec2faad6dc197f248:

    Merge branch 'ep/shell-command-substitution'

    Adjust shell scripts to use $(cmd) instead of `cmd`.


This is the fourth serie, the other will be sent separately.


Elia Pinto (10):
  t/t5303-pack-corruption-resilience.sh: use the $( ... ) construct for
    command substitution
  t/t5304-prune.sh: use the $( ... ) construct for command substitution
  t/t5305-include-tag.sh: use the $( ... ) construct for command
    substitution
  t/t5500-fetch-pack.sh: use the $( ... ) construct for command
    substitution
  t/t5505-remote.sh: use the $( ... ) construct for command substitution
  t/t5506-remote-groups.sh: use the $( ... ) construct for command
    substitution
  t/t5510-fetch.sh: use the $( ... ) construct for command substitution
  t/t5515-fetch-merge-logic.sh: use the $( ... ) construct for command
    substitution
  t/t5516-fetch-push.sh: use the $( ... ) construct for command
    substitution
  t/t5517-push-mirror.sh: use the $( ... ) construct for command
    substitution

 t/t5303-pack-corruption-resilience.sh | 16 ++++++++--------
 t/t5304-prune.sh                      |  2 +-
 t/t5305-include-tag.sh                |  8 ++++----
 t/t5500-fetch-pack.sh                 | 20 ++++++++++----------
 t/t5505-remote.sh                     |  2 +-
 t/t5506-remote-groups.sh              |  2 +-
 t/t5510-fetch.sh                      | 10 +++++-----
 t/t5515-fetch-merge-logic.sh          |  4 ++--
 t/t5516-fetch-push.sh                 |  4 ++--
 t/t5517-push-mirror.sh                |  2 +-
 10 files changed, 35 insertions(+), 35 deletions(-)

-- 
2.3.3.GIT
