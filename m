From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/6] Various tweaks to 'worktree'-related manpages
Date: Sat, 18 Jul 2015 19:10:52 -0700
Message-ID: <cover.1437271363.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 19 04:11:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGe54-0008Qc-91
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 04:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603AbbGSCLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 22:11:39 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:50139 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752368AbbGSCLi (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jul 2015 22:11:38 -0400
X-AuditID: 1207440c-f79e16d000002a6e-8e-55ab07559484
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 09.11.10862.5570BA55; Sat, 18 Jul 2015 22:11:33 -0400 (EDT)
Received: from localhost.localdomain ([66.251.117.141])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t6J2BUOa011238
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jul 2015 22:11:31 -0400
X-Mailer: git-send-email 2.1.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsUixO6iqBvKvjrUoOOtmEXXlW4mi4beK8wW
	t1fMZ7bonvKW0eLMm0ZGB1aPv+8/MHnsnHWX3ePiJWWPxQ+8PD5vkgtgjeK2SUosKQvOTM/T
	t0vgznh/5CFLwW7Oigkf7jE1MN5i72Lk5JAQMJFo+N3CCmGLSVy4t56ti5GLQ0jgMqPEp2m/
	2SGc9UwS++e1glWxCehKLOppZgKxRQQ2MUq0vs4HsZkFHCQ2f25kBLGFBZwkLixuZe5i5OBg
	EVCVWPS/CiTMK2Au8bCzC2qxnMT54z+ZJzByL2BkWMUol5hTmqubm5iZU5yarFucnJiXl1qk
	a6iXm1mil5pSuokREiA8Oxi/rZM5xCjAwajEw2vxZVWoEGtiWXFl7iFGSQ4mJVHe0ldAIb6k
	/JTKjMTijPii0pzU4kOMEhzMSiK8+YyrQ4V4UxIrq1KL8mFS0hwsSuK8qkvU/YQE0hNLUrNT
	UwtSi2CyMhwcShK8KmxAjYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgQI8vBoY6
	SIoHaO8rVpC9xQWJuUBRiNZTjIpS4rwOIHMFQBIZpXlwY2Fx/4pRHOhLYd5mkCoeYMqA634F
	NJgJaHDn6hUgg0sSEVJSDYyJLYui718osrJyupLftFTPyddN4+7ksNaT+/63KKssD4gSfyeq
	t3IHz+drIQ3VSZ8jpEJ2f2aY2llcZrv2A/PqT1/av13QST9Z5qDOu3y/zf7G6pWyvhfOFn1p
	b2ifoWR+1revb61D24LSYlOjgiM+m8PcbhVXeDVPjTCbdbD2/4IzS8X1m5RYijMS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274190>

I haven't been following the discussion of this feature on the mailing
list, so I apologize if these changes overlap with any in-flight
patches, and these changes should definitely be checked over by
somebody more familiar with the feature. These patches mostly fix what
seem like inconsistencies in the documentation. The last patch
contains some wordsmithing. Feel free to squash them together if you
prefer.

This patch series is also available from my GitHub account [1] as
branch "worktree-docs".

[1] https://github.com/mhagger/git

Michael Haggerty (6):
  worktree: consistently use term "linked working tree" in manpages
  worktree: remove references to "git checkout --to" from the manpage
  worktree: fix incorrect references to file "locked"
  worktree: the "locked" mechanism is already implemented
  config.txt: refer to "git worktree prune", not "prune --worktree"
  worktree: wordsmith worktree-related manpages

 Documentation/config.txt               | 10 +++++-----
 Documentation/git-worktree.txt         | 20 +++++++++-----------
 Documentation/gitrepository-layout.txt | 22 +++++++++++-----------
 3 files changed, 25 insertions(+), 27 deletions(-)

-- 
2.1.4
