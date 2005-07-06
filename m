From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: Stacked GIT 0.3 (now more Quilt-like)
Date: Wed, 06 Jul 2005 21:54:15 +0100
Message-ID: <1120683255.6881.8.camel@localhost.localdomain>
References: <1119994003.9631.6.camel@localhost.localdomain>
	 <m3ekagp9mk.fsf@telia.com> <1120385280.6845.12.camel@localhost.localdomain>
	 <m3oe9k6p40.fsf@telia.com> <1120425269.6845.28.camel@localhost.localdomain>
	 <m3y88m21ln.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 06 23:20:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqHJj-00067I-22
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 23:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262554AbVGFU6T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 16:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbVGFU5l
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 16:57:41 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:11702 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S262524AbVGFUyV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 16:54:21 -0400
Received: from aamta11-winn.ispmail.ntl.com ([81.103.221.35])
          by mta08-winn.ispmail.ntl.com with ESMTP
          id <20050706205416.SBMG889.mta08-winn.ispmail.ntl.com@aamta11-winn.ispmail.ntl.com>;
          Wed, 6 Jul 2005 21:54:16 +0100
Received: from cpc1-cmbg5-3-0-cust179.cmbg.cable.ntl.com ([81.104.192.179])
          by aamta11-winn.ispmail.ntl.com with ESMTP
          id <20050706205416.MFVA11226.aamta11-winn.ispmail.ntl.com@cpc1-cmbg5-3-0-cust179.cmbg.cable.ntl.com>;
          Wed, 6 Jul 2005 21:54:16 +0100
To: Peter Osterlund <petero2@telia.com>
In-Reply-To: <m3y88m21ln.fsf@telia.com>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2005-07-04 at 14:32 +0200, Peter Osterlund wrote:
> I agree with the other comments, it's probably not wise to rely on
> wiggle, and wiggle sometimes makes a mess. However, it often does the
> right thing, and with a configurable merge program and an undo
> function, this should not be a problem. Just undo and try again if you
> don't like the result.

In the today's snapshot you can get the 'stg push --undo' command which
reverts the result of a push operation (either failed or not). The patch
is reverted to its previous state. It works even if you ran 'refresh'.

The current implementation does not remove the .older/.local/.remote
files from the tree when undoing a push. I think I will first implement
a 'resolve' command which takes care of these files.

Anyway, once I fully test the current state of stgit, I will make the
0.4 release (probably this weekend).

--
Catalin
