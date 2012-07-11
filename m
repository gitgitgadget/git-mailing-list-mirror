From: Alexander Strasser <eclipse7@gmx.net>
Subject: [PATCH 0/6] Cleaning up t4012
Date: Thu, 12 Jul 2012 00:11:40 +0200
Message-ID: <20120711221140.GA21303@akuma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 00:12:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sp58Z-0002yN-Bi
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 00:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030379Ab2GKWLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 18:11:49 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:58162 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030280Ab2GKWLs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 18:11:48 -0400
Received: (qmail invoked by alias); 11 Jul 2012 22:11:45 -0000
Received: from p5B06F836.dip.t-dialin.net (EHLO gmx.net) [91.6.248.54]
  by mail.gmx.net (mp071) with SMTP; 12 Jul 2012 00:11:45 +0200
X-Authenticated: #8251126
X-Provags-ID: V01U2FsdGVkX19jh/l9ND1jW1NOpSTXR5d2TE2nLc64QUgzRFS13C
	BA/N6YbyS6dMzA
Received: by gmx.net (sSMTP sendmail emulation); Thu, 12 Jul 2012 00:11:40 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201334>

Hi,

  during my recent bug hunting expedition I had the honor to modify
t/t4012-diff-binary.sh . After submitting my previous patch set it
quickly became clear that this file does not adhere to currently
practiced style of Git tests.

  It took me some time to get back to this but here finally comes a
patch set to modernize t4012. While this patch set did not confront
me with great conceptual problems it still is a bit problematic and
depends to some point on personal preferences. That is part of the
reason why I tried to make as small and focused commits as possible.
(Other part is I find it easier to review/manage my changes for myself
with a finer commit granularity). The patches can still be squashed
together after review if this is preferred.

  Also thanks again to Zbigniew who pointed out most of the addressed
issues.

Alexander Strasser (6):
  t4012: Use different style for quoting
  t4012: Unquote git command fragment in test title
  t4012: Actually quote the sed script
  t4012: Break up pipe into serial redirections
  t4012: Re-indent test snippets
  t4012: Make --shortstat more robust

 t/t4012-diff-binary.sh | 92 +++++++++++++++++++++++++++-----------------------
 1 file changed, 49 insertions(+), 43 deletions(-)

-- 
1.7.10.2.552.gaa3bb87
