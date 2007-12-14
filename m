From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 00/17] Series short description
Date: Fri, 14 Dec 2007 11:55:25 +0100
Message-ID: <20071214105238.18066.23281.stgit@krank>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: catalin.marinas@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 11:55:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J38Cb-0008Cn-Fd
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 11:55:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757955AbXLNKzK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 05:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756160AbXLNKzK
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 05:55:10 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:51814 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756110AbXLNKzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 05:55:09 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 05A13200A217;
	Fri, 14 Dec 2007 11:55:08 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 30527-01-18; Fri, 14 Dec 2007 11:55:07 +0100 (CET)
Received: from krank (dns.vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id A8363200A1E8;
	Fri, 14 Dec 2007 11:55:07 +0100 (CET)
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by krank (Postfix) with ESMTP id BF1F87B406D;
	Fri, 14 Dec 2007 11:55:25 +0100 (CET)
User-Agent: StGIT/0.13
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68276>

The following series an emacs interface to stgit patch stacks. It
shows a buffer with the the output of "stg series" and allows you to
do some common operations on it, such as push/pop, commit/uncommit,
edit, rename, repair, and coalesce.

The coalesce command obviosly requires the kha/experimental branch.
The edit command requires the edit fixes in kha/safe.

---

David K=C3=A5gedal (10):
      Emacs mode: coalesce command
      Emacs mode: Add mark command
      Emacs mode: Added stgit-new
      Emacs mode: added fontification
      Emacs mode: Add stgit-edit command
      Emacs mode: added stgit-commit and stgit-uncommit
      Emacs mode: add stgit-repair
      Emacs mode: Bind n and p
      Emacs mode: Improve the output buffer state
      Add an StGit mode for emacs

Karl Hasselstr=C3=B6m (7):
      Emacs mode: show patches' short description
      Emacs mode: Bind "G" to "stg goto"
      Emacs mode: Let "P" push or pop patch at point
      Emacs mode: push/pop next patch, not patch at point
      Emacs mode: Makefile for building stgit.el
      Emacs mode: Add an explanatory header
      Emacs mode: Show keybindings when user presses "h" or "?"


 contrib/Makefile |   19 +++
 contrib/stgit.el |  377 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 396 insertions(+), 0 deletions(-)
 create mode 100644 contrib/Makefile
 create mode 100644 contrib/stgit.el

--=20
Signature
