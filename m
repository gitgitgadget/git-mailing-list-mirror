From: David Brown <git@davidb.org>
Subject: Re: [RFC] Adding a challenge-response authentication method to
	git://
Date: Thu, 14 Aug 2008 00:48:05 -0700
Message-ID: <20080814074805.GA21577@linode.davidb.org>
References: <20080813162644.GC12200@cuci.nl> <20080813163646.GO32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: "Stephen R. van den Berg" <srb@cuci.nl>, git <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Aug 14 10:18:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTY2p-0004ym-LI
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 10:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872AbYHNIRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 04:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752845AbYHNIRu
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 04:17:50 -0400
Received: from linode.davidb.org ([72.14.176.16]:58836 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752740AbYHNIRt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 04:17:49 -0400
X-Greylist: delayed 1781 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Aug 2008 04:17:49 EDT
Received: from davidb by mail.davidb.org with local (Exim 4.69 #1 (Debian))
	id 1KTXYz-0005wY-S0; Thu, 14 Aug 2008 00:48:05 -0700
Content-Disposition: inline
In-Reply-To: <20080813163646.GO32184@machine.or.cz>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92333>

On Wed, Aug 13, 2008 at 06:36:46PM +0200, Petr Baudis wrote:
>On Wed, Aug 13, 2008 at 06:26:44PM +0200, Stephen R. van den Berg wrote:
>> What are the opinions on adding a basic challenge-response type
>> authentication mechanism to the native git protocol?
>> I.e. the authentication would be a simple one, which uses
>> SHA1 (surprise ;-) to actually encrypt username/password/salt
>> and authenticate the user.
>
>In the past, such an idea was dismissed with desire not to reimplement
>something ssh already implemented, and much better than we would.

The problem is that ssh ties you in very closely with the ability to
log into the machine.  It's also hard to limit what ssh allows while
still allowing some users more priveleges.

But, this problem comes up with other protocols that use ssh for
authentication as well, so perhaps the solution is to fix the problems
with ssh to allow it to more securely allow non-login services.

David
