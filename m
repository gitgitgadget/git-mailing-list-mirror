From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: rebase-with-history -- a technique for rebasing without trashing your repo history
Date: Sat, 15 Aug 2009 06:40:01 +0900
Message-ID: <20090815064001.6117@nanako3.lavabit.com>
References: <4A840B0F.9060003@alum.mit.edu>
	<20090813161256.GA8292@atjola.homenet> <4A849634.1020609@alum.mit.edu>
	<20090813233027.GA19833@atjola.homenet>
	<4A85D53D.9050805@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Bjrn Steinbrink <B.Steinbrink@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Aug 14 23:41:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc4WC-000466-C4
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 23:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756726AbZHNVke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 17:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756619AbZHNVke
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 17:40:34 -0400
Received: from karen.lavabit.com ([72.249.41.33]:32859 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756202AbZHNVkd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 17:40:33 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 126D011B8FC;
	Fri, 14 Aug 2009 16:40:35 -0500 (CDT)
Received: from 3486.lavabit.com (195.116.69.252)
	by lavabit.com with ESMTP id 0FXT3DSDA0LT; Fri, 14 Aug 2009 16:40:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=JBCqxo/V80Oz8JAqaQNJ1yzMqFziyVozyz/pES7puqaiFbxxgMX0Fn1R+p7e5tCzI6nNfzKdQpkw79qlEqokaQ4GQAa1bZZYHvGoaXCGUTyPvnzpoEx0amiJv04SRaDePqrQHrA+leGrtReJ7fXRkXdW7BuusNH+N6kWwSxwwHY=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <4A85D53D.9050805@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125959>

Quoting Michael Haggerty <mhagger@alum.mit.edu>

> In [1] I compared rebase-with-history with both of the
> currently-available options (rebase and merge).  Rebase and merge can
> each deal with some of the issues that come up, but each one falls flat
> on others.  I believe that rebase-with-history has the advantages of both.
> ....  Rebase-with-history is obviously
> not an earth-shattering revolution in DVCS technology, but my hope is
> that it could unobtrusively assist with a few minor pain points.

The saddest part is that your [1] works only in a case a user can easily handle manually, and doesn't help cases more complex than the most trivial ones, such as reordering and squashing commits, where the user may benefit if an automated support from VCS were available.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
