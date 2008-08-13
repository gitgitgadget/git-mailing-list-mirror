From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] Adding a challenge-response authentication method to
	git://
Date: Wed, 13 Aug 2008 18:36:46 +0200
Message-ID: <20080813163646.GO32184@machine.or.cz>
References: <20080813162644.GC12200@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Aug 13 18:38:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTJMO-0000dB-9K
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 18:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756345AbYHMQgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 12:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756358AbYHMQgt
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 12:36:49 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40177 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756312AbYHMQgs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 12:36:48 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 2EBED393A2DD; Wed, 13 Aug 2008 18:36:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080813162644.GC12200@cuci.nl>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92240>

On Wed, Aug 13, 2008 at 06:26:44PM +0200, Stephen R. van den Berg wrote:
> What are the opinions on adding a basic challenge-response type
> authentication mechanism to the native git protocol?
> I.e. the authentication would be a simple one, which uses
> SHA1 (surprise ;-) to actually encrypt username/password/salt
> and authenticate the user.
> 
> I'm willing to do the work, if there are no objections.

In the past, such an idea was dismissed with desire not to reimplement
something ssh already implemented, and much better than we would.

				Petr "Pasky" Baudis
