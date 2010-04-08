From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git pull suggestion
Date: Thu, 8 Apr 2010 17:54:24 +0200
Message-ID: <201004081754.24954.trast@student.ethz.ch>
References: <r2x3abd05a91004071617z9ffd6e02v83d825405bb6ef1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 17:54:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzu4E-0008Gz-7q
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 17:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581Ab0DHPyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 11:54:49 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:23942 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932280Ab0DHPys (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 11:54:48 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.247.2; Thu, 8 Apr
 2010 17:54:46 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.247.2; Thu, 8 Apr
 2010 17:54:25 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.2; x86_64; ; )
In-Reply-To: <r2x3abd05a91004071617z9ffd6e02v83d825405bb6ef1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144356>

Aghiles wrote:
> 
> It would be nice to have _all_ the WIP conflicts listed when pulling.
> As of now, one has to fix the currently showed conflict to see the next one.

Are you using 'git pull --rebase' or the equivalent
branch.<name>.rebase setting?

If so, note that git-rebase (which does all the hard work) can't know
the later conflicts once it hits the first one: your resolution of the
first conflict constitutes the base onto which the further patches are
applied.  So depending on what changes you make during the resolution,
there may be more or fewer conflicts in the rest of the rebase.

If not, I can't see how your question makes sense as ordinary 'git
pull' does a merge, and during a 'git merge' there can only ever be
one conflict resolution phase.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
