From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 0/3] gettext: minor fixes
Date: Sat, 28 Aug 2010 17:54:20 +0000
Message-ID: <1283018063-4256-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 28 19:54:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpPcD-0001Lz-7G
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 19:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143Ab0H1Ryc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Aug 2010 13:54:32 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35229 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601Ab0H1Ryb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 13:54:31 -0400
Received: by wwb28 with SMTP id 28so5196621wwb.1
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 10:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=uopOYKM6WGTK/Vxcw0pLrMTtVhsR3M81L4gNNu7ck48=;
        b=fT5IAKQVVlWViiHok9byhnRBF+COE8svIJ6cwbTwN81T3EBQb5eo9l/AKiZJrKJnx2
         AMxEuTVDNqJymrawJUrBNYX29THAwN97BvnRFDQ7ja2WRXA7aQtJHF4y0N73nTcpwPHy
         JlBiLNWap6jpU3XFC9TObZqo5fnOucN7T/lo4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=bakNkuDkAZ2Di5gXDU3Ve+0UW985WZjX7NaGJhMaWsKts8uFuCOFPj0nn3MPoFJGBA
         WCKEWdJJw6/jT/KRZ1PNtqQ8YaDSG5/yg4qy5saBadeDUmsrSzQgC5iB6ext/ZVyEXQ3
         u1Z2MGTQGJl41IKHZ4hutR0myAi80bwA1tFiE=
Received: by 10.216.188.197 with SMTP id a47mr2613326wen.70.1283018070519;
        Sat, 28 Aug 2010 10:54:30 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id o15sm78280wer.39.2010.08.28.10.54.29
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 28 Aug 2010 10:54:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.513.g82b8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154651>

Here are some trivial fixes to the gettext infrastructure. I
encountered these while doing more significant work.

It's based on next, and the gettext series I'm about to send soon will
be based on this one.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
  gettext: update test/is.po to match t/t0200/test.c
  Makefile: provide a --msgid-bugs-address to xgettext(1)
  gettext: msgmerge is.po and add Language: header

 Makefile                 |    7 ++++---
 po/is.po                 |   10 ++++++----
 t/t0200-gettext-basic.sh |    2 +-
 3 files changed, 11 insertions(+), 8 deletions(-)

--=20
1.7.2.2.513.g82b8
