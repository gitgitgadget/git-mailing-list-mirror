From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 0/2] Make test suite work with dash as /bin/sh
Date: Sun, 29 Apr 2007 23:09:45 +0200
Message-ID: <20070429210713.4004.60467.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 29 23:32:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiH06-0001iT-RG
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 23:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161441AbXD2VcG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 29 Apr 2007 17:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161461AbXD2VcG
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 17:32:06 -0400
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:41763 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161441AbXD2VcD (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Apr 2007 17:32:03 -0400
Received: from c83-250-140-11.bredband.comhem.se ([83.250.140.11]:38713 helo=yoghurt)
	by ch-smtp01.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <kha@treskal.com>)
	id 1HiGf5-0004Lw-4P; Sun, 29 Apr 2007 23:10:27 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by yoghurt with esmtp (Exim 4.62)
	(envelope-from <kha@treskal.com>)
	id 1HiGeP-00013z-Bx; Sun, 29 Apr 2007 23:09:45 +0200
User-Agent: StGIT/0.12
X-Scan-Result: No virus found in message 1HiGf5-0004Lw-4P.
X-Scan-Signature: ch-smtp01.sth.basefarm.net 1HiGf5-0004Lw-4P afe7f882f33456d044ff41706ef92b51
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45842>

I got some strange errors when running the StGIT test suite on a
machine I hadn't tried developing on before. It turned out that its
/bin/sh was dash, and that a few bashisms needed fixing.

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
