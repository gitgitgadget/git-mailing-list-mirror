From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: [PATCH 3/3] Explicitly specify utf-8 coding in file
Date: Wed, 24 May 2006 08:07:21 +0200
Message-ID: <20060524060721.GC1490@diana.vm.bytemark.co.uk>
References: <20060524060537.GA1173@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=fixed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 24 08:07:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FimWk-0000Wo-4Z
	for gcvg-git@gmane.org; Wed, 24 May 2006 08:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607AbWEXGHX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 24 May 2006 02:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932608AbWEXGHX
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 02:07:23 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:14856 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S932607AbWEXGHX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 May 2006 02:07:23 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1FimWf-0000Ow-00; Wed, 24 May 2006 07:07:21 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060524060537.GA1173@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20668>

uncommit.py has a non-ascii character in it (in my name in the
copyright line). Without this coding: comment, I get an error like the
following when I run stgit:

  /home/kha/git/stgit/stgit/main.py:61: DeprecationWarning: Non-ASCII
  character '\xc3' in file
  /home/kha/git/stgit/stgit/commands/uncommit.py on line 3, but no
  encoding declared; see http://www.python.org/peps/pep-0263.html for
  details
---

 stgit/commands/uncommit.py |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/stgit/commands/uncommit.py b/stgit/commands/uncommit.py
index e03d207..52ce5a8 100644
--- a/stgit/commands/uncommit.py
+++ b/stgit/commands/uncommit.py
@@ -1,3 +1,5 @@
+# -*- coding: utf-8 -*-
+
 __copyright__ =3D """
 Copyright (C) 2006, Karl Hasselstr=F6m <kha@treskal.com>
=20
