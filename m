From: James Cloos <cloos@jhcloos.com>
Subject: [PATCH 0/1] Improve progress display in kB range.
Date: Sun, 19 Apr 2009 00:38:53 -0400
Message-ID: <cover.1240115957.git.cloos@jhcloos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 19 06:59:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvP7i-0006h1-Pt
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 06:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755777AbZDSE5o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Apr 2009 00:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754995AbZDSE5n
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 00:57:43 -0400
Received: from eagle.jhcloos.com ([207.210.242.212]:3798 "EHLO
	eagle.jhcloos.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754243AbZDSE5m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 00:57:42 -0400
X-Greylist: delayed 715 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Apr 2009 00:57:42 EDT
Received: by eagle.jhcloos.com (Postfix, from userid 10)
	id 86B1B400A8; Sun, 19 Apr 2009 04:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jhcloos.com;
	s=eagle; t=1240116346;
	bh=/zqjzTdjcl3rgn4+AsdydYP1Hc8QJKVcEaRKiH8RnMI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=DeqBkBxbdaMTVnmEtMRnuzWoy9jmckuI83bplxbficTA1DQJmW+4Ldqi9+BNb7ADS
	 pGcJYnM+jmhdH3LIZikW34H61BEtWD7j3bK2TurNmpUVZcPDFuvQnuj1ZUkpZA3Jcl
	 W/tCckaGFnYeuk98jFoqDP23wxDXHdhZygBW/Q5c=
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id 80A1F140B1; Sun, 19 Apr 2009 04:44:47 +0000 (UTC)
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0.92 (gnu/linux)
Copyright: Copyright 2009 James Cloos
OpenPGP: ED7DAEA6; url=http://jhcloos.com/public_key/0xED7DAEA6.asc
OpenPGP-Fingerprint: E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6
X-Hashcash: 1:29:090419:git@vger.kernel.org::gB3naGybTu62JY72:00000000000000000000000000000000000000000If5hs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116884>

One of the few irritations when using git =E2=80=94 note that you=E2=80=
=99ll need a
relatively slow link to notice =E2=80=94 is that the progress always sh=
ows
something .99 when under one Meg.

This patch eliminates the constant .99 from the progress display.

James Cloos (1):
  Improve progress display in kB range.

 progress.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

--=20
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
