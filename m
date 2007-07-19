From: Olivier Galibert <galibert@pobox.com>
Subject: Re: [REVISED PATCH 2/6] Introduce commit notes
Date: Thu, 19 Jul 2007 12:34:36 +0200
Message-ID: <20070719103436.GA9143@dspnet.fr.eu.org>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site> <Pine.LNX.4.64.0707160022560.14781@racer.site> <7vejj96igx.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707190258550.14781@racer.site> <alpine.LFD.0.999.0707181949490.27353@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 19 12:34:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBTLM-0005gK-IM
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 12:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937567AbXGSKem (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 06:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937216AbXGSKel
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 06:34:41 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:4559 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936718AbXGSKej (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 06:34:39 -0400
Received: by dspnet.fr.eu.org (Postfix, from userid 1007)
	id 8227EA35E2; Thu, 19 Jul 2007 12:34:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707181949490.27353@woody.linux-foundation.org>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52961>

On Wed, Jul 18, 2007 at 08:28:27PM -0700, Linus Torvalds wrote:
> And yes, the "search for zero bytes" is not *guaranteed* to find any 
> beginning at all, if you have lots of short names, *and* lots of zero 
> bytes in the SHA1's. But while short names may be common, zero bytes in 
> SHA1's are not so much (since you should expect to see a very even 
> distribution of bytes, and as such most SHA1's by far should have no zero 
> bytes at all!)

The probability of a sha1 to have a zero is approximatively 0.075.
That's 1 in 13, more or less.

  OG.
