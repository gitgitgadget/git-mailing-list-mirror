From: Jiang Xin <worldhello.net@gmail.com>
Subject: [GIT PULL] l10n updates for maint branch (2.8.2)
Date: Sun, 24 Apr 2016 21:12:57 +0800
Message-ID: <CANYiYbHOkYx6CXHkUHBoWfQOJGiEFXJJi4tDTFvAGigKZfO7gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jean-Noel Avila <jn.avila@free.fr>, Git List <git@vger.kernel.org>,
	Vasco Almeida <vascomalmeida@sapo.pt>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 24 15:13:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auJqV-00065Q-4d
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbcDXNNA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Apr 2016 09:13:00 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33652 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616AbcDXNM7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2016 09:12:59 -0400
Received: by mail-wm0-f68.google.com with SMTP id r12so15633306wme.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc
         :content-transfer-encoding;
        bh=lq03QS2qs1eBlujWASXl7FCBIdbW5sSCgx+T8Yhw8hA=;
        b=gKI+1S0Ay0YIeIP3dYtyfMqJOtWDTJb6EYNQ1gX71fQL7Mk0fnU/0cKnli6sh8vWVu
         pVb78ty6fvtM5zGfKThN5q2Ch4LU5bqKLfxRnd92vGH7ON7ZCmZ9F15I8MCBvgZIpNW+
         OWtTrCLftdrPBrtacgkQ5jcVH1X+BrMA7zEIq1RRBRnM4Gi34wA98Le/fKYPe0VLR2Xp
         5Y2BUuzEzihDbCECziaFrhUxK7PCgfFRIVkvKtkIPYCHuGwvCqjLeXYdw4weROJWLjbW
         YItXDjW14mbd/2x22gpG83uXCxS6qdvAnehWWk4gE4GcMUdPPKAhBgQbgDlgkPsruVMz
         jo5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc
         :content-transfer-encoding;
        bh=lq03QS2qs1eBlujWASXl7FCBIdbW5sSCgx+T8Yhw8hA=;
        b=NUTiqGnmEKj4a9hKvlq7wTnNhcoThiyDK8CPtEg/WbtpERKVKnGfMnkVuafdOwdwtv
         ZnfhWD3CTJl1aotizQf+JavIAfpznr8/VP4jWGvLqt60h0vFerKJGBdamTm399W9V3Sr
         8acIdUZ7fjS/6lvvU7kmWzCxxrAhq3N/P4AsRemds5PbemzK3Zv3n2P8UNb3K26W2sg/
         J5cEWp5tHRFc6MGfPC2ounGqPxFDTlnFljoyuJ7e5XGsYf1MaOVaDWZoRliQZ6aFfvfT
         7veiWevykmKatUNyQs49yoH3+s/nAe9GJbd+fbE/H++ysTEYjVE9OK3IpUeaOlcjkBZj
         MF3Q==
X-Gm-Message-State: AOPr4FXJQX8REH2KqT6CETvcuCA+7+6GTKw+GQrNDuEfqyKZaZdCMmsA+Chqsq2kWm4+ssjZO59AbOUg1zR/lw==
X-Received: by 10.28.174.70 with SMTP id x67mr6590875wme.43.1461503577586;
 Sun, 24 Apr 2016 06:12:57 -0700 (PDT)
Received: by 10.194.6.231 with HTTP; Sun, 24 Apr 2016 06:12:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292322>

Hi Junio,

Please pull this update to the maint branch.  It should have been merge=
d to
Git 2.8.0, but I was busy these weeks and forgot to check my private ma=
ilbox.

The following changes since commit 26e4cbec4558ea21cd572bfc915a462f63c1=
ebb4:

  l10n: zh_CN: review for git v2.8.0 l10n round 2 (2016-03-20 18:46:02 =
+0800)

are available in the git repository at:

  git://github.com/git-l10n/git-po tags/l10n-2.8.0-rnd3-fr

for you to fetch changes up to 2ee0fca122653572f2ecb3c3a2d5441170f8e17c=
:

  Merge branch 'fr_v2.8.0_r3' of git://github.com/jnavila/git into
maint (2016-04-24 20:36:34 +0800)

----------------------------------------------------------------
l10n-2.8.0-rnd3-fr

----------------------------------------------------------------
Jean-No=C3=ABl Avila (1):
      Merge pull request #9 from vascool/fr

Jiang Xin (1):
      Merge branch 'fr_v2.8.0_r3' of git://github.com/jnavila/git into =
maint

Vasco Almeida (4):
      l10n: fr: fix transcation of "dir"
      l10n: fr: fix wrongly translated option name
      l10n: fr: change "id de cl=C3=A9" to match "id-cl=C3=A9"
      l10n: fr: don't translate "merge" as a parameter

 po/fr.po | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--
Jiang Xin
