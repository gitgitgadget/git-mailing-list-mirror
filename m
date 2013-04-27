From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 0/6] misc sparse patches (part 1)
Date: Sat, 27 Apr 2013 19:38:01 +0100
Message-ID: <517C1B09.6080601@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 21:46:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWB4f-0007xM-RW
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 21:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755053Ab3D0TqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 15:46:17 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:32998 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754713Ab3D0TqR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 15:46:17 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 52C27384081;
	Sat, 27 Apr 2013 20:46:15 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id A0DF338407C;
	Sat, 27 Apr 2013 20:46:14 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Sat, 27 Apr 2013 20:46:13 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222664>


Hi Junio,

As you know, I like to catch sparse errors/warnings while they
are still in pu. The topics addressed by the first two patches
progressed from pu during the easter break, so I missed them.
Sorry about that.

I have refrained from sending patches to (parts of) the compat
area because I thought they would not be accepted since they
have 'upstream's. However, given the recent patches fixing up
spelling mistakes, I decided it was worth a try ... ;-)

The final patch was a direct result of testing patch 5 on linux.

ATB,
Ramsay Jones

Ramsay Jones (6):
  clone: Make the 'junk_mode' symbol a file static
  path: Make the 'get_st_mode_bits' symbol a file static
  compat/regex/regexec.c: Fix some sparse warnings
  compat/fnmatch/fnmatch.c: Fix a sparse error
  compat/nedmalloc: Fix some sparse warnings
  compat/nedmalloc: Fix compiler warnings on linux

 Makefile                     | 1 +
 builtin/clone.c              | 2 +-
 compat/fnmatch/fnmatch.c     | 3 ++-
 compat/nedmalloc/malloc.c.h  | 6 +++++-
 compat/nedmalloc/nedmalloc.c | 4 ++--
 compat/regex/regexec.c       | 6 +++---
 git-compat-util.h            | 1 -
 path.c                       | 2 +-
 8 files changed, 15 insertions(+), 10 deletions(-)

-- 
1.8.2
