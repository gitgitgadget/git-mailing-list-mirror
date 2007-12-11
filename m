From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: [PATCH] Fix typo: we require Python 2.4, not 2.5
Date: Tue, 11 Dec 2007 15:23:47 +0100
Message-ID: <20071211142347.GA22879@diana.vm.bytemark.co.uk>
References: <b0943d9e0712100340p78326b4avf2b7e64008bba6d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 15:24:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J262A-0001MM-3w
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 15:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178AbXLKOYG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Dec 2007 09:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbXLKOYF
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 09:24:05 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4602 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbXLKOYE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 09:24:04 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1J261T-0005zw-00; Tue, 11 Dec 2007 14:23:47 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0712100340p78326b4avf2b7e64008bba6d6@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67859>

Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>

---

On 2007-12-10 11:40:41 +0000, Catalin Marinas wrote:

> This release requires at least Python 2.4 and GIT 1.5.2.

Yeah. So 0.14.1 (to be released very soon) should probably have this
fix. :-)

diff --git a/stgit/version.py b/stgit/version.py
index edd79e0..2e49e76 100644
--- a/stgit/version.py
+++ b/stgit/version.py
@@ -2,4 +2,4 @@ version =3D '0.13'
=20
 # minimum version requirements
 git_min_ver =3D '1.5.2'
-python_min_ver =3D '2.5'
+python_min_ver =3D '2.4'

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
