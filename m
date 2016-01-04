From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 00/10] use the $( ... ) construct for command substitution
Date: Mon,  4 Jan 2016 10:10:41 +0100
Message-ID: <1451898651-16468-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 04 10:11:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aG1AX-0004hF-G6
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 10:11:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229AbcADJLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 04:11:08 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33294 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149AbcADJLC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 04:11:02 -0500
Received: by mail-pf0-f176.google.com with SMTP id q63so163389359pfb.0
        for <git@vger.kernel.org>; Mon, 04 Jan 2016 01:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=zIdkZ+JHxQoIO9Yk3ngOeuOBeWD0Gwv1taoqsp15qGs=;
        b=BTQwky6j1PxKbBBartQbJTL5ZwVwfavmWxLgNmMD2G6RfpZOn+FDYSzVpiCyAL2Qjf
         yVQjlcg+qEZ3Mc9QDvVcq+YLNVg6aGAIOxaRMMx+6McpBf49YFYLDFGAAkk0dcEIAt1i
         DASSawg0s7Ch3U21PBzQjEPEHiN/SEDyG2iki3439GtwjXZGYLXRZPrI5dHj3QP742sG
         O6QmxpNnFEmswa/UKC2MY1sbLTySC1AfFTI6xPQYbhProfHV/4b0ZqRM4qYidOwx/cnV
         J7ZyJ9LjuIq/bHAj1GdRis3f2oVLoOTuZVGVzL55gCiQPxnBWs7CNoYPEMeDUprFx6M9
         m/oA==
X-Received: by 10.98.44.209 with SMTP id s200mr117114979pfs.2.1451898661884;
        Mon, 04 Jan 2016 01:11:01 -0800 (PST)
Received: from ubuntu14.nephoscale.com (static-67.207.195.141.nephosdns.com. [67.207.195.141])
        by smtp.gmail.com with ESMTPSA id h10sm124416205pat.7.2016.01.04.01.11.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Jan 2016 01:11:00 -0800 (PST)
X-Mailer: git-send-email 2.3.3.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283280>

This patch series continues the changes introduced with the merge
6753d8a85d543253d95184ec2faad6dc197f248:

    Merge branch 'ep/shell-command-substitution'

    Adjust shell scripts to use $(cmd) instead of `cmd`.


This is the fifth series, the other will be sent separately.

Elia Pinto (10):
  t/t5522-pull-symlink.sh: use the $( ... ) construct for command
    substitution
  t/t5530-upload-pack-error.sh: use the $( ... ) construct for command
    substitution
  t/t5532-fetch-proxy.sh: use the $( ... ) construct for command
    substitution
  t/t5537-fetch-shallow.sh: use the $( ... ) construct for command
    substitution
  t/t5538-push-shallow.sh: use the $( ... ) construct for command
    substitution
  t/t5550-http-fetch-dumb.sh: use the $( ... ) construct for command
    substitution
  t/t5570-git-daemon.sh: use the $( ... ) construct for command
    substitution
  t/t5601-clone.sh: use the $( ... ) construct for command substitution
  t/t5700-clone-reference.sh: use the $( ... ) construct for command
    substitution
  t/t5710-info-alternate.sh: use the $( ... ) construct for command
    substitution

 t/t5522-pull-symlink.sh      | 2 +-
 t/t5530-upload-pack-error.sh | 2 +-
 t/t5532-fetch-proxy.sh       | 4 ++--
 t/t5537-fetch-shallow.sh     | 4 ++--
 t/t5538-push-shallow.sh      | 4 ++--
 t/t5550-http-fetch-dumb.sh   | 8 ++++----
 t/t5570-git-daemon.sh        | 8 ++++----
 t/t5601-clone.sh             | 2 +-
 t/t5700-clone-reference.sh   | 2 +-
 t/t5710-info-alternate.sh    | 2 +-
 10 files changed, 19 insertions(+), 19 deletions(-)

-- 
2.3.3.GIT
