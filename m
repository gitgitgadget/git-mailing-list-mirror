From: jeffpc@josefsipek.net
Subject: [ANNOUNCE] Guilt v0.33
Date: Thu, 15 Apr 2010 23:10:28 -0400
Message-ID: <20100416031028.GV12152@josefsipek.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 16 05:10:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2bwx-0005ll-Qj
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 05:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757532Ab0DPDK3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Apr 2010 23:10:29 -0400
Received: from josefsipek.net ([141.212.112.196]:51319 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757502Ab0DPDK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 23:10:29 -0400
Received: by josefsipek.net (Postfix, from userid 1000)
	id 4FEAE37E86; Thu, 15 Apr 2010 23:10:28 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145050>

Guilt v0.33 is available for download (once it mirrors out on kernel.or=
g).

Guilt (Git Quilt) is a series of bash scripts which add a Mercurial
queues-like functionality and interface to git.

Tarballs:
http://www.kernel.org/pub/linux/kernel/people/jsipek/guilt/

Git repo:
git://git.kernel.org/pub/scm/linux/kernel/git/jsipek/guilt.git


This release bundles up a bunch of the fixes that were released in the
various v0.32.x stable releases.  The major change is the addition of
support for git versions 1.7.x.

As always, patches, and other feedback is welcome.

Josef "Jeff" Sipek.

------------
Changes since v0.32:

Dmitry Monakhov (1):
      guilt: allow raw patch edit

Eric Sandeen (1):
      regression: filter usage() output

Josef 'Jeff' Sipek (10):
      regression: fix output mismatch with git 1.6.2
      select/guard: fixed bashism
      Guilt v0.32.1
      refresh: output the patch name similarly to what quilt does
      {fork,import}: check patchnames for colons
      regression: added a new test that exercises the guilt-import code
      {diff,import-commit,new}: fix handling of binary files
      regression: change two of the test patches to handle binary files
      header: use exit instead of return
      Guilt v0.33

Theodore Ts'o (1):
      guilt: Add support for git version 1.7.x.y

Vincent Penn=E9 (1):
      make guards functionning again

Yasushi SHOJI (1):
      allow guilt to handle binary files

--=20
Humans were created by water to transport it upward.
