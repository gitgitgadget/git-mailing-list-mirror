From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Fixed indeterminism in t2102-pull-policy-rebase
Date: Thu, 23 Aug 2007 10:20:35 +0200
Message-ID: <20070823082035.GA11996@diana.vm.bytemark.co.uk>
References: <11878521324048-git-send-email-davidk@lysator.liu.se> <20070823075224.GA11772@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 10:20:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO7vp-0007IT-TU
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 10:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbXHWIUm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 23 Aug 2007 04:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbXHWIUl
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 04:20:41 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4035 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbXHWIUk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 04:20:40 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IO7vf-0003AM-00; Thu, 23 Aug 2007 09:20:35 +0100
Content-Disposition: inline
In-Reply-To: <20070823075224.GA11772@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56472>

On 2007-08-23 09:52:24 +0200, Karl Hasselstr=F6m wrote:

> On 2007-08-23 08:55:32 +0200, David K=E5gedal wrote:
>
> > This test case was sometimes succeeding and sometimes failing.
> > This seems to be how it was expected to work.
>
> Oooh, evil.

The following changes since commit 7e97cc0590f29482af022340df84a43b98c6=
57ce:
  Yann Dirson (1):
        Include contrib scripts in the release tarball.

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git fixes

David K=E5gedal (1):
      Fixed indeterminism in t2102-pull-policy-rebase

Karl Hasselstr=F6m (1):
      Don't touch ref files manually

 stgit/commands/branch.py      |    5 +--
 stgit/commands/common.py      |    4 +--
 stgit/git.py                  |   79 ++++++++++++++++++++++++---------=
--------
 stgit/stack.py                |   70 +++++++++++++++++++--------------=
---
 t/t0001-subdir-branches.sh    |    7 ++--
 t/t1000-branch-create.sh      |   30 +---------------
 t/t1001-branch-rename.sh      |    2 +-
 t/t2102-pull-policy-rebase.sh |    2 +-
 8 files changed, 92 insertions(+), 107 deletions(-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
