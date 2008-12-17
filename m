From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 1/2] Revert "Fix commit id in egit test
	T0001_ConnectProviderOperationTest"
Date: Wed, 17 Dec 2008 14:32:31 -0800
Message-ID: <20081217223231.GJ32487@spearce.org>
References: <1229472439-24104-1-git-send-email-robin.rosenberg@dewire.com> <1229472439-24104-2-git-send-email-robin.rosenberg@dewire.com> <20081217160933.GD32487@spearce.org> <200812172328.07371.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 23:34:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD4xr-0004ti-Uf
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 23:34:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbYLQWcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 17:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbYLQWcd
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 17:32:33 -0500
Received: from george.spearce.org ([209.20.77.23]:45723 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925AbYLQWcd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 17:32:33 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 411E138200; Wed, 17 Dec 2008 22:32:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200812172328.07371.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103402>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> onsdag 17 december 2008 17:09:33 skrev Shawn O. Pearce:
> > The only thing I can think of is the timestamp we are creating by
> > the deprecated Date constructor call back on line 82.  Perhaps
> > on different JVMs it is using different values for the hh:mm:ss
> > parts of the timestamp value?
> 
> Indeed it is. Date is dependent on local time zone.

Thanks, much better.
 
-- 
Shawn.
