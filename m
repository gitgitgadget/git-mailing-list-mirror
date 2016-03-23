From: Jiang Xin <worldhello.net@gmail.com>
Subject: [GIT PULL] l10n updates for 2.8.0 round 3#2
Date: Wed, 23 Mar 2016 23:17:31 +0800
Message-ID: <CANYiYbH8FZdtq5rAUgo84WgApVfxEAUK7OeyeWw7u3rrxNtHjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Tran Ngoc Quan <vnwildman@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 16:17:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aikXR-0007vt-Ji
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 16:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754544AbcCWPRe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Mar 2016 11:17:34 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34648 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbcCWPRd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 11:17:33 -0400
Received: by mail-wm0-f52.google.com with SMTP id p65so238284233wmp.1
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 08:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc
         :content-transfer-encoding;
        bh=h1IKlyR2mI09YBOPyrKXqpzKM/8jCbMyytwJ9YczZeU=;
        b=CqKIwvYZpW7nb8UJ4wd/h52s5vC+Il5xhN+pjDV+aqUnz3q1Dpa9HF+uoiywrr6n7r
         Cayd9kykSGVThtt31kvfLN2vRee/tnuMMI3V4HCaexJsEOco6ziJfhfNYA0GhCPKtzuj
         Rzv/8NTnsT6DPPLo+yNvrWcJsZn/NsadOdymRGgEd4jnBuLZtTVtOLvWi7Y9bEcjSAZS
         XCx7NHW2e4mtuNCgvhI9GQTwWeC/2hxB+ycY7DVPhBZ5LwBqD7uJLCbbEJ7VdXIv+d82
         mkcajhZDkPi2IMMDijI1+cslSXrMkmJJ6mk6i3B+gh3odvo17pntzEY167nNivXYVK7R
         usIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc
         :content-transfer-encoding;
        bh=h1IKlyR2mI09YBOPyrKXqpzKM/8jCbMyytwJ9YczZeU=;
        b=X4mzpHpWjshfJ01+MEKexjBLVMNEGf1cWPzC82eSX1oGe3tfPT+a3MUPe69MlSPSLa
         QwbA9FjYO1Z6LECv9N9zuomvLfz8Y5ViVibbaWdaDQ0Dkh+YyzfxO8sRCquX4tQfxR4I
         PCQ1OKsMmWgw0LJnv3m/dKILkbBKeK+6keGVweLDr2T4G+umfpPzVnhtS/uG6wqhnwiz
         XvJ1k2BM9t2dzuQIf6GIrC2NmUFXepCSDDRiAxVfNtrIrbb8LaSP+zHaqfQEl8wePvOz
         HzTBaIG/igAMtSwET9Del+HFhmoX/TC0Dsfze+lb6f7bT1dtUn0uCY0+9Qlb8faKSfol
         v9fw==
X-Gm-Message-State: AD7BkJL+dhALCvYi+dMzpc3nRAL48JG6o9EB6G1agSUTCBDPAa5CLsYR6QFxg8wm63uaF4AHjYPNITARcGdSgQ==
X-Received: by 10.194.227.1 with SMTP id rw1mr3987247wjc.62.1458746251878;
 Wed, 23 Mar 2016 08:17:31 -0700 (PDT)
Received: by 10.194.54.8 with HTTP; Wed, 23 Mar 2016 08:17:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289657>

Hi Junio,

The following changes since commit 26e4cbec4558ea21cd572bfc915a462f63c1=
ebb4:

  l10n: zh_CN: review for git v2.8.0 l10n round 2 (2016-03-20 18:46:02 =
+0800)

are available in the git repository at:

  git://github.com/git-l10n/git-po master

for you to fetch changes up to 103ee5c21ea4d63e78b7b984d9611eacd0a06099=
:

  Merge branch 'master' of https://github.com/vnwildman/git
(2016-03-23 23:01:51 +0800)

----------------------------------------------------------------
Alex Henrie (1):
      l10n: ca.po: update translation

Jiang Xin (2):
      Merge branch 'master' of git://github.com/alexhenrie/git-po
      Merge branch 'master' of https://github.com/vnwildman/git

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (1):
      l10n: vi.po (2530t): Update translation

Vasco Almeida (1):
      l10n: pt_PT: Update and add new translations

 po/ca.po    |  2946 ++++++------
 po/pt_PT.po | 14113 ++++++++++++++++++++++++++++++++++++++++++++------=
--------
 po/vi.po    |   155 +-
 3 files changed, 12493 insertions(+), 4721 deletions(-)

--
Jiang Xin
