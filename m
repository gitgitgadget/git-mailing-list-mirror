From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/5] Various odds and ends
Date: Fri, 14 Dec 2007 07:24:53 +0100
Message-ID: <20071214062251.29148.86191.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 07:25:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J33zE-0001sx-UO
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 07:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbXLNGZE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 01:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbXLNGZE
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 01:25:04 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2998 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbXLNGZD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 01:25:03 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1J33yi-0002gu-00; Fri, 14 Dec 2007 06:24:56 +0000
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68235>

Also available from

  git://repo.or.cz/stgit/kha.git safe

---

David K=C3=A5gedal (2):
      Treat filename '-' as stdin/stdout in edit
      Added --save-template flag to edit command

Karl Hasselstr=C3=B6m (3):
      Name the exit codes to improve legibility
      Make generic --message/--file/--save-template flags
      Let parse_patch take a string instead of a file parameter


 stgit/commands/common.py |    6 ++--
 stgit/commands/edit.py   |   73 +++++++++++++++++++++++---------------=
--------
 stgit/commands/imprt.py  |    2 +
 stgit/main.py            |   25 ++++++++--------
 stgit/utils.py           |   50 ++++++++++++++++++++++++++++++++
 5 files changed, 103 insertions(+), 53 deletions(-)

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
