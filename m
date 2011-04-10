From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 0/7] i18n: mark missing C messages
Date: Sun, 10 Apr 2011 19:34:01 +0000
Message-ID: <1302464048-21806-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 21:34:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q90Os-00032b-I6
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 21:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754821Ab1DJTeS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Apr 2011 15:34:18 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37883 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754242Ab1DJTeR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 15:34:17 -0400
Received: by ewy4 with SMTP id 4so1532438ewy.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 12:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=e1QgsjUr91fXPy50yTqyZR9rBts07flNkSPVP1dcKak=;
        b=RZClNIuXs61oUFuchgvWD0HPtnoo4bpB3iooOowF+dHUs1EP+AchqgiGeJ4u9cEPhF
         oBr8ffEGcV5tKUpoA69DmHsD5Z05uEuCv407CbHfnniEkfjOLWLfiCwNHLPJgj52bd3S
         ZvTSWcZX9a/aEPb7biw1sgb+SLKZa/JP7ux+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=HxLiGSKG1MMOE3GRNq/Zmuhhn9twdAmfbqeAM4Fe4bKVl5/PkuCitn8rkZYeNIeyPd
         pnzhUYu9VvpRoNKfPQfIPIbDqu5CBLHdJOxgDz7PGuQKu76lxwO1HUdrbv9DulVTMBaI
         uA4wdyD133JpK/snXMjiJDVp1BFn6dfx18JIM=
Received: by 10.213.23.7 with SMTP id p7mr683264ebb.60.1302464056126;
        Sun, 10 Apr 2011 12:34:16 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id m55sm1147236eei.8.2011.04.10.12.34.15
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 12:34:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171274>

Some messages fell through the cracks during the later submissions of
the i18n series, hopefully this catches all of the remaining C
messsages.

This is an RFC because the first patch still leaves one remaining
gitdir test failing under GETTEXT_POISON, and I won't be able to find
out why tonight. Help welcome with figuring out why (in which case
this should all be OK), you just need too build with
GETTEXT_POISON=3DYesPlease and run t/t0001-init.sh.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (7):
  i18n: mark init-db messages for translation
  i18n: mark merge "Could not read from" message for translation
  i18n: mark merge "upstream" messages for translation
  i18n: mark merge CHERRY_PICK_HEAD messages for translation
  i18n: mark clone nonexistent repository  message for translation
  i18n: mark checkout --detach messages for translation
  i18n: mark checkout plural warning for translation

 builtin/checkout.c         |   24 ++++++++++++++++++------
 builtin/clone.c            |    2 +-
 builtin/init-db.c          |   12 ++++++------
 builtin/merge.c            |   16 ++++++++--------
 t/t0001-init.sh            |   28 ++++++++++++++++++++--------
 t/t2020-checkout-detach.sh |   15 ++++++++++++---
 t/t5601-clone.sh           |    7 +++++--
 7 files changed, 70 insertions(+), 34 deletions(-)

--=20
1.7.4.1
