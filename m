From: Wolfgang Rohdewald <wolfgang@rohdewald.de>
Subject: git status: minor output format error
Date: Sun, 03 Nov 2013 18:17:39 +0100
Message-ID: <31465687.35grSWXxkx@i5>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 03 18:17:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vd1Iv-0002j5-3a
	for gcvg-git-2@plane.gmane.org; Sun, 03 Nov 2013 18:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153Ab3KCRRb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Nov 2013 12:17:31 -0500
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:52385 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684Ab3KCRRa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Nov 2013 12:17:30 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1383499048; l=408;
	s=domk; d=rohdewald.de;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Date:Subject:To:
	From:X-RZG-CLASS-ID:X-RZG-AUTH;
	bh=zVTILBBVMUJXm5Si/hrftbqMrjA=;
	b=bP4w/zIPwnx9J+ullSsNrMNfnjbR/l1I3fFylOZDt4atsYuEDrso/VKOjl3HfodAUec
	8KWEttfu6idyvZhBHRfLPa005ZUaLKh361zu8i1+BJ8uF4VpkbgaFWdxJMF9IN7DojiA0
	v7h6JyrntokFz+uThMmE+jUVns/jr9dz238=
X-RZG-AUTH: :O2MIc0epdfgAjoV+frHI3UhxNCLBO5P+YS73lHhJYRD2uAuzaM+5N8MTp/31LXql
X-RZG-CLASS-ID: mo00
Received: from i5.rohdewald.de (p5B3E3141.dip0.t-ipconnect.de [91.62.49.65])
	by smtp.strato.de (RZmta 32.11 DYNA|AUTH)
	with (SSLv3:DHE-RSA-AES256-SHA encrypted) ESMTPSA id j03be2pA3FPFxz
	for <git@vger.kernel.org>; Sun, 3 Nov 2013 18:17:28 +0100 (CET)
Received: from i5.localnet (localhost.localdomain [127.0.0.1])
	by i5.rohdewald.de (Postfix) with ESMTP id CDF535E0694
	for <git@vger.kernel.org>; Sun,  3 Nov 2013 18:17:39 +0100 (CET)
User-Agent: KMail/4.11.2 (Linux/3.11.0-12-generic; KDE/4.11.2; x86_64; ; )
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
	shortcircuit=no autolearn=unavailable version=3.3.2
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on i5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237270>

git version 1.8.3.2

git status in German says (extract)

#       ge=E4ndert:   kajongg.py
#       gel=F6scht:    playfield.py

as you can see, there is one space too much before playfield.py

LANG=3DC git status is correct:
#       modified:   kajongg.py
#       deleted:    playfield.py

so it seems the spacing between the columns expects "deleted" to have t=
he same number
of letters in all languages.

--=20
Wolfgang
