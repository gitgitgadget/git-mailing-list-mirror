From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/3] "stg edit" fixups
Date: Fri, 01 Feb 2008 08:49:48 +0100
Message-ID: <20080201074708.7905.98305.stgit@yoghurt>
References: <20080129031310.1177.83290.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 08:51:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKqgJ-0004ue-RT
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 08:51:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935453AbYBAHuQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Feb 2008 02:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936100AbYBAHuO
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 02:50:14 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2328 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765812AbYBAHuL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 02:50:11 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JKqek-0008Iq-00; Fri, 01 Feb 2008 07:49:50 +0000
In-Reply-To: <20080129031310.1177.83290.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72153>

I've fixed a few things with the "stg edit" series:

  * Took care of the import problem David pointed out.

  * Made the emacs mode not refuse to edit unaplied patches, now that
    "stg edit" can do it.

  * Made it so that the dates the user gets to edit are nicely
    human-readable, and not that seconds-since-1970 mess.

Also pushed out to kha/experimental.

---

Karl Hasselstr=C3=B6m (3):
      It's possible to edit unapplied patches now
      Convert "stg edit" to the new infrastructure
      Parse the date instead of treating it as an opaque string


 contrib/stgit.el       |    4 -
 stgit/commands/edit.py |  309 ++++++++++++++++++++++------------------=
--------
 stgit/lib/git.py       |   76 +++++++++++-
 3 files changed, 215 insertions(+), 174 deletions(-)

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
