From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 0/2] Smoke testing for Git
Date: Mon,  2 Aug 2010 20:24:42 +0000
Message-ID: <1280780684-26344-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 02 22:25:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og1ZG-0002uz-4L
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 22:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755207Ab0HBUY5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 16:24:57 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46098 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754492Ab0HBUY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 16:24:56 -0400
Received: by wwj40 with SMTP id 40so4332662wwj.1
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 13:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=ruOp8SFHlTvfQQTflgD0n1h9D2V7wP0xd20u7G2goEY=;
        b=t2ENYB6K+5etxCyhRC/7gs0+eG+wh9o6YILxBfFmqRArZ/zL7XoIkTYkrHALu5EdLa
         3Rl3ZAT0HIc4TJ7oXUan0UdO0MTEAndiWIU1/sGUJuvouxmPSzBSNfKf0xwdIzHn2OVA
         a7QemxutMcBjidn+2cyPgd1tFplwzn4vdqqxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=mpqqpIk/Mcs2dkWxCG7kUL0h+B+Y082g/leHJ+2F5M8Dd2zDynxT5qYOLMh7nEdxRe
         S31uw48HBTMqqcA/0DJhhCO3rXNPwLsb98pqqnnBG/bst4TL9VCfNekowru6EL2BVKqn
         Djhhnq4/Ksk745QfJhY7kbZLeVuSlQhY20TdA=
Received: by 10.227.155.82 with SMTP id r18mr5537952wbw.70.1280780695146;
        Mon, 02 Aug 2010 13:24:55 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id 2sm3109811wey.0.2010.08.02.13.24.54
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 02 Aug 2010 13:24:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152452>

Here's a non-RFC version of the smoke testing for Git series. It's
like v2 of the RFC aside from a s/sever/server/ typo noted by Junio:

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
  tests: Infrastructure for Git smoke testing
  t/README: Document the Smoke testing

 t/Makefile |   35 ++++++++++++++++++++++++++++++-
 t/README   |   66 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 t/harness  |   21 +++++++++++++++++++
 3 files changed, 121 insertions(+), 1 deletions(-)
 create mode 100755 t/harness
