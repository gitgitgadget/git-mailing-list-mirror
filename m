From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 0/2] "git svn" and "git gc --auto"
Date: Sun, 03 Feb 2008 17:55:51 +0100
Message-ID: <20080203165234.10816.6061.stgit@yoghurt>
References: <20080121224818.GA8872@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 17:57:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLi9k-0006i6-1I
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 17:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756519AbYBCQ4s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Feb 2008 11:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756524AbYBCQ4s
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 11:56:48 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3876 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756460AbYBCQ4r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 11:56:47 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JLi8U-0005ej-00; Sun, 03 Feb 2008 16:56:06 +0000
In-Reply-To: <20080121224818.GA8872@untitled>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72368>

On 2008-01-21 14:48:28 -0800, Eric Wong wrote:

> Sorry for the latency[1], ack on both of Karl's patches for
> post-1.5.4.

So here they are again. There was a trivial merge conflict with Eric's
fix, but otherwise they are unchanged.

---

Karl Hasselstr=C3=B6m (2):
      Let "git svn" run "git gc --auto" occasionally
      git-svn: Don't call git-repack anymore


 git-svn.perl |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
