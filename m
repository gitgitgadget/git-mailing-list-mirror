From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH v3 5/5] Implement 'git stash save --patch'
Date: Sun, 26 Jul 2009 10:45:54 +0200
Message-ID: <200907261045.55551.trast@student.ethz.ch>
References: <7vzlat64u1.fsf@alter.siamese.dyndns.org> <e5ef2e602347914a7a14d769ca2297223cde8042.1248557241.git.trast@student.ethz.ch> <fabb9a1e0907252303y2606d585l41819a74084b58f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 10:46:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUzNB-00021C-3Y
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 10:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbZGZIqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 04:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbZGZIqH
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 04:46:07 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:10044 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751111AbZGZIqG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2009 04:46:06 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 26 Jul 2009 10:46:05 +0200
Received: from thomas.localnet ([77.56.221.170]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 26 Jul 2009 10:46:04 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.2.98; x86_64; ; )
In-Reply-To: <fabb9a1e0907252303y2606d585l41819a74084b58f1@mail.gmail.com>
X-OriginalArrivalTime: 26 Jul 2009 08:46:04.0616 (UTC) FILETIME=[82B9EC80:01CA0DCD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124110>

Sverre Rabbelier wrote:
> 
> On Sat, Jul 25, 2009 at 14:29, Thomas Rast<trast@student.ethz.ch> wrote:
> > This adds a hunk-based mode to git-stash.  You can select hunks from
> > the index and the worktree, and git-stash will attempt to build a
> > stash that reflects these changes.
> 
> Awesome! Does it also remove the stashed hunks from the worktree? From
> what I gather from the patch it looks like it, but the commit message
> doesn't say.

Yes, and unless you used --keep-index, also the stashed index-hunks
from the index.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
