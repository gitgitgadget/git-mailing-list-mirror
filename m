From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 0/2] Teach "stg delete" to delete several patches at once
Date: Sun, 22 Oct 2006 14:53:37 +0200
Message-ID: <20061022125337.15194.64831.stgit@localhost>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 14:58:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbcu7-0000Rj-M8
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 14:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbWJVM6J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 08:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbWJVM6J
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 08:58:09 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:36072 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1751784AbWJVM6H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 08:58:07 -0400
Received: from ironport2.bredband.com ([195.54.107.84] [195.54.107.84])
          by mxfep02.bredband.com with ESMTP
          id <20061022125806.QJEM2091.mxfep02.bredband.com@ironport2.bredband.com>
          for <git@vger.kernel.org>; Sun, 22 Oct 2006 14:58:06 +0200
Received: from ua-83-227-180-148.cust.bredbandsbolaget.se (HELO yoghurt.hemma.treskal.com) ([83.227.180.148])
  by ironport2.bredband.com with ESMTP; 22 Oct 2006 14:58:06 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by yoghurt.hemma.treskal.com (Postfix) with ESMTP id 010314C010;
	Sun, 22 Oct 2006 14:58:05 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29730>

The first patch introduces a test for "stg delete", since there wasn't
already one, and it's much less stressful to modify stuff if you have
an automatic test that can tell you if you broke stuff.

As it turns out, this test finds an existing bug: it's not possible to
delete a patch in another branch if there's an identically named
branch in the current branch, and both patches are topmost in their
respective applied stacks.

The second patch teaches "delete" how to delete multiple patches in
one go.

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
