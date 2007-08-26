From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 0/6] David's conflict series using my subprocess stuff
Date: Sun, 26 Aug 2007 22:42:29 +0200
Message-ID: <20070826203745.16700.5655.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Sun Aug 26 22:43:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPOws-0002JD-AJ
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 22:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbXHZUmz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 26 Aug 2007 16:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbXHZUmy
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 16:42:54 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2209 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbXHZUmw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 16:42:52 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IPOwK-000605-00; Sun, 26 Aug 2007 21:42:32 +0100
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56726>

This is David's conflict series, rebased on top of my subprocess
calling series. There was one place where it used to have to call
popen2.Popen3 directly, since none of our existing ten subprocess
functions could do that particular job. But the new subprocess
machinery can. (This was the original motivation for that refactoring,
by the way.)

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
