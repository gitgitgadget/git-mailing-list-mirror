From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: gitweb: kernel versions in the history (feature request,
	probably)
Date: Tue, 20 Nov 2007 22:20:09 -0500
Message-ID: <20071121032009.GB4175@fieldses.org>
References: <20071120142042.GA4157@ff.dom.local> <20071120215904.GF1001@machine.or.cz> <47436E0F.6080003@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, linux-kernel@vger.kernel.org,
	git@vger.kernel.org
To: Jarek Poplawski <jarkao2@o2.pl>
X-From: git-owner@vger.kernel.org Wed Nov 21 04:20:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iug8o-00025x-AL
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 04:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbXKUDUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 22:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752224AbXKUDUT
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 22:20:19 -0500
Received: from mail.fieldses.org ([66.93.2.214]:46366 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752161AbXKUDUR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 22:20:17 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1Iug8H-0001Wj-Mg; Tue, 20 Nov 2007 22:20:09 -0500
Content-Disposition: inline
In-Reply-To: <47436E0F.6080003@o2.pl>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65587>

On Wed, Nov 21, 2007 at 12:30:23AM +0100, Jarek Poplawski wrote:
> I don't know git, but it seems, at least if done for web only, this
> shouldn't be so 'heavy'. It could be a 'simple' translation of commit
> date by querying a small database with kernel versions & dates.

If I create a commit in my linux working repo today, but Linus doesn't
merge it into his repository until after he releases 2.6.24, then my
commit will be created with an earlier date than 2.6.24, even though it
isn't included until 2.6.25.

So you have to actually examine the history graph to figure this out
this sort of thing.

--b.
