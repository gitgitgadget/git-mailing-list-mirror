From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git-archive and submodules
Date: Mon, 20 Jul 2009 22:56:25 +0200
Message-ID: <200907202256.26669.trast@student.ethz.ch>
References: <41ceb5540907200922r5decb047h75e723a1809b587e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>
To: Woody Gilk <woody.gilk@kohanaphp.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 22:56:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSzub-0003qw-5F
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 22:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbZGTU4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 16:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbZGTU4e
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 16:56:34 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:13423 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102AbZGTU4e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 16:56:34 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 20 Jul 2009 22:56:32 +0200
Received: from thomas.localnet ([84.74.103.245]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 20 Jul 2009 22:56:32 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.23-0.1-default; KDE/4.2.96; x86_64; ; )
In-Reply-To: <41ceb5540907200922r5decb047h75e723a1809b587e@mail.gmail.com>
X-OriginalArrivalTime: 20 Jul 2009 20:56:32.0294 (UTC) FILETIME=[8F945C60:01CA097C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123634>

Woody Gilk wrote:
> I would find it hugely valuable if git-archive would support
> submodules, rather than leaving empty files in the place of
> submodules.

Such support was already in the pipeline before 1.6.2, see this
thread:

  http://thread.gmane.org/gmane.comp.version-control.git/107030

Lars' series is still available from the repo mentioned in one of the
messages

  git://hjemli.net/pub/git/git lh/traverse-gitlinks

but does not merge into master cleanly any more, because an earlier
version of the first commit (of now three) made it into 1.6.2.  For
your testing convenience, I rebased the other two commits on 'master'
and pushed them to

  git://repo.or.cz/git/trast.git lh/traverse-gitlinks-on-master

All conflicts were trivial, but I made a minor change: there's already
a t5001 from 8aece7f (archive test: attributes, 2009-04-18), so I
renamed it to t5002 in the tip commit.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
