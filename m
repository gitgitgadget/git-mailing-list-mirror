From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH 0/5] fetch & co: misc output cleanup
Date: Fri, 29 Sep 2006 20:05:01 +0200
Message-ID: <87r6xu1rci.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Sep 29 20:05:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTMjW-0003PK-Iy
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 20:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWI2SFG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 14:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWI2SFG
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 14:05:06 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:43687 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S1751263AbWI2SFE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Sep 2006 14:05:04 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k8TI51Q03510
	for <git@vger.kernel.org>; Fri, 29 Sep 2006 20:05:02 +0200
To: git <git@vger.kernel.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28117>

Hi *,

this patchset includes:

      fetch: Reset remote refs list each time fetch_main is called
      fetch & co: Use "hash1..hash2" instead of "from hash1 to hash2"
      fetch & co: Use short sha1 in the output
      fetch: Add output for the not fast forward case
      fetch: Clean output

The first one is actually a bugfix (at least for me), but needed for the
last one.

 git-fetch.sh   |   19 ++++++++++++++-----
 git-merge.sh   |    2 +-
 git-resolve.sh |    2 +-
 3 files changed, 16 insertions(+), 7 deletions(-)
