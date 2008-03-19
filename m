From: Jonas Fonseca <fonseca@diku.dk>
Subject: [ANNOUNCE] tig-0.10.1
Date: Thu, 20 Mar 2008 00:33:16 +0100
Message-ID: <20080319233316.GA5925@diku.dk>
References: <20080317020304.GA19249@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 00:35:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc7oI-0005TR-2u
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 00:35:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S942920AbYCSXdY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Mar 2008 19:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938332AbYCSXdW
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 19:33:22 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:60360 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S942919AbYCSXdU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 19:33:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 1191052C31E
	for <git@vger.kernel.org>; Thu, 20 Mar 2008 00:33:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bQZqIc4JYQvp for <git@vger.kernel.org>;
	Thu, 20 Mar 2008 00:33:16 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id A548552C315
	for <git@vger.kernel.org>; Thu, 20 Mar 2008 00:33:16 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP id 224436DFAB0
	for <git@vger.kernel.org>; Thu, 20 Mar 2008 00:32:21 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 797A21DC52D; Thu, 20 Mar 2008 00:33:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080317020304.GA19249@diku.dk>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77590>

Hello,

Here is a small update to tig with accumulated fixes and suggestions.
Apart from fixes for compiler warnings and configure checks, this
version should work much better with rendering CJK properly thanks to
Dominik. It still requires that tig is linked with ncursesw, which
should happen automatically if possible when using the configure script=
=2E
=46inally, the status view will show renames instead of a copy + a rena=
me.

Thanks for suggestions and patches! Below is the diffstat and shortlog
for changes made in this release.

 INSTALL      |   28 ++++---
 Makefile     |   20 +++--
 VERSION      |    2 +-
 configure.ac |   15 ++++-
 tig.c        |  246 +++++++++++++++++++++++++++++++++++++++-----------=
--------
 5 files changed, 210 insertions(+), 101 deletions(-)

Dominik Vogt (3):
      Fix compiler warnings: pointer of type =E2=80=98void *=E2=80=99 u=
sed in arithmetic
      Fixed handling of UTF8 tag names and commit messages.
      More verbose diff headers (including dates and committer)

Jonas Fonseca (8):
      tig-0.10.1.git
      Replace SYSCONFDIR value in distributed documentation distributed
      Make it more clear that use of configure (and autoreconf) is opti=
onal
      Add rename support to the status view
      Refresh the index when opening the status view to avoid "empty di=
ffs"
      Make configure search for the ncursesw library first
      Fix drawing "outside" the screen in the status and pager views
      tig-0.10.1

Peter Karlsson (1):
      Fixed spurious "/bin/sh: --list: command not found" error

Russell Steicke (1):
      Fix signed char comparison where char is unsigned by default

--=20
Jonas Fonseca
