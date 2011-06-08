From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: Q: how can i find the upstream merge point of a commit?
Date: Wed, 08 Jun 2011 12:40:36 +0200
Message-ID: <1307529636.2322.320.camel@twins>
References: <20110608093648.GA19038@elte.hu>
	 <20110608203433.61e02ad8.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
X-From: git-owner@vger.kernel.org Wed Jun 08 12:41:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUGCC-0003o9-RS
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 12:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198Ab1FHKlD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 06:41:03 -0400
Received: from casper.infradead.org ([85.118.1.10]:59170 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171Ab1FHKlB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2011 06:41:01 -0400
Received: from j77219.upc-j.chello.nl ([24.132.77.219] helo=twins)
	by casper.infradead.org with esmtpsa (Exim 4.76 #1 (Red Hat Linux))
	id 1QUGBl-0005fg-LU; Wed, 08 Jun 2011 10:40:41 +0000
Received: by twins (Postfix, from userid 1000)
	id 87CE18277E7C; Wed,  8 Jun 2011 12:40:36 +0200 (CEST)
In-Reply-To: <20110608203433.61e02ad8.sfr@canb.auug.org.au>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175351>

On Wed, 2011-06-08 at 20:34 +1000, Stephen Rothwell wrote:

> You can restict which tags get used:
> 
> $ git describe --contains --match 'v*' 189d3c4a94
> v2.6.26-rc1~155

*groan*, I tried that, but got:

# git describe --contains  189d3c4a94ef19fca2a71a6a336e9fda900e25e7 --match '^v.*'
fatal: cannot describe '189d3c4a94ef19fca2a71a6a336e9fda900e25e7'

and

# git describe --contains  189d3c4a94ef19fca2a71a6a336e9fda900e25e7 --match 'v.*'
fatal: cannot describe '189d3c4a94ef19fca2a71a6a336e9fda900e25e7'

at which point I gave up.. 
