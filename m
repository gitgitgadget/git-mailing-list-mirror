From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] pull --rebase: Add support for rebased default
 upstream
Date: Sat, 6 Jun 2009 01:22:19 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906060120140.26154@pacific.mpi-cbg.de>
References: <1244231617-17754-2-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1382109001-1244244140=:26154"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Sat Jun 06 01:22:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCijg-0007e5-C2
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 01:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458AbZFEXV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 19:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752454AbZFEXV2
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 19:21:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:59718 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752234AbZFEXV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 19:21:28 -0400
Received: (qmail invoked by alias); 05 Jun 2009 23:21:28 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp037) with SMTP; 06 Jun 2009 01:21:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/I6Bget2TI8FfPnmR35M6Xuf4qdUZI2sTtnnATXM
	dGzWj5DLcIIh2O
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1244231617-17754-2-git-send-email-santi@agolina.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120839>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1382109001-1244244140=:26154
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 5 Jun 2009, Santi Béjar wrote:

> Also add a test to check for this case and another one (failing) to
> test rebasing two branches on top of a rebased upstream using just
> 'git pull --rebase'.
> 
> Signed-off-by: Santi Béjar <santi@agolina.net>

Either I am a stupid moron (which is a completely valid suggestion) or 
this commit message lacks in detail severely.

For example, when I "git pull --rebase junio next" and "next" was rebased, 
it works _perfectly_, so I do not see any need for a fix.

Further, this:

> ---
>  git-parse-remote.sh |    8 +++++++-
>  t/t5520-pull.sh     |   29 +++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+), 1 deletions(-)

... suggests to me that pull --rebase is not even affected by your patch.  
So maybe you want to clarify so much that even stupid morons understand 
what you want to achieve, and how.

Ciao,
Dscho
--8323328-1382109001-1244244140=:26154--
