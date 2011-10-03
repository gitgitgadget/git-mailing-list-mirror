From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 0/9] i18n: add PO files to po/
Date: Mon,  3 Oct 2011 18:58:08 +0000
Message-ID: <1317668297-2702-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?q?Marcin=20Cie=C5=9Blak?= <saper@saper.info>,
	Sam Reed <sam@reedyboy.net>,
	Jan Engelhardt <jengelh@medozas.de>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 21:04:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAnoB-0007IA-4A
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 21:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757285Ab1JCTD6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Oct 2011 15:03:58 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58247 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754145Ab1JCTD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 15:03:56 -0400
Received: by wyg34 with SMTP id 34so3426764wyg.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 12:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=mk7XDkzNkTJX0OJo5pZ4DH/43V1flR5AsGhlBZADvSU=;
        b=oSj4pChJ+UMP8hL8LwtFVVE+BbdVdGAyC7xdcCoFWyjYY49pkyGD8asR/ypwGX2z3a
         g+s5nuc1tu88sk+89sV/LkqYf4l8DxSz6a/F/BQzly/sYZhdVP20KsIcse0qvfzKVtep
         +ZdMNELzNvsDJ7mEVbMbE9n5ZjWnBKVeJgi6s=
Received: by 10.223.10.25 with SMTP id n25mr341707fan.72.1317668313091;
        Mon, 03 Oct 2011 11:58:33 -0700 (PDT)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id f25sm22312819faf.7.2011.10.03.11.58.29
        (version=SSLv3 cipher=OTHER);
        Mon, 03 Oct 2011 11:58:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182695>

It's been a long time coming, but here's an initial submission of PO
files to the po/ directory. This adds some initial and as of yet
unused translations.

I plan on following these with more infrastructure stuff later on, and
hopefully this'll encourage list members to submit new translations.

Documentation on how to do that will follow in a later series, but is
right now left as an exercise for the reader.

Jan Engelhardt (1):
  po/de.po: update German translation

Jan Kr=C3=BCger (1):
  po/de.po: add German translation

Marcin Cie=C5=9Blak (1):
  po/pl.po: add Polish translation

Peter Krefting (1):
  po/sv.po: add Swedish translation

Ramkumar Ramachandra (2):
  po/hi.po: add Hindi Translation
  po/hi.po: Eliminate fuzzy translations

Sam Reed (1):
  po/en_GB.po: add British English translation

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
  po/is.po: add Icelandic translation
  po: run msgmerge to strings update the PO files

 po/de.po    | 3825 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 po/en_GB.po | 3228 +++++++++++++++++++++++++++++++++++++++++++++++++
 po/hi.po    | 3228 +++++++++++++++++++++++++++++++++++++++++++++++++
 po/is.po    | 3254 ++++++++++++++++++++++++++++++++++++++++++++++++++
 po/pl.po    | 3246 ++++++++++++++++++++++++++++++++++++++++++++++++++
 po/sv.po    | 3531 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++
 6 files changed, 20312 insertions(+), 0 deletions(-)
 create mode 100644 po/de.po
 create mode 100644 po/en_GB.po
 create mode 100644 po/hi.po
 create mode 100644 po/is.po
 create mode 100644 po/pl.po
 create mode 100644 po/sv.po

--=20
1.7.6.3
