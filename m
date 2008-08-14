From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] Adding a challenge-response authentication method to
	git://
Date: Thu, 14 Aug 2008 10:23:45 +0200
Message-ID: <20080814082345.GQ10151@machine.or.cz>
References: <20080813162644.GC12200@cuci.nl> <20080813163646.GO32184@machine.or.cz> <20080814074805.GA21577@linode.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Stephen R. van den Berg" <srb@cuci.nl>, git <git@vger.kernel.org>
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Thu Aug 14 10:24:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTY8a-0006Z5-SG
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 10:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480AbYHNIXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 04:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752471AbYHNIXt
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 04:23:49 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53476 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752315AbYHNIXs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 04:23:48 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 3DBDA3939BDC; Thu, 14 Aug 2008 10:23:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080814074805.GA21577@linode.davidb.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92334>

On Thu, Aug 14, 2008 at 12:48:05AM -0700, David Brown wrote:
> On Wed, Aug 13, 2008 at 06:36:46PM +0200, Petr Baudis wrote:
>> On Wed, Aug 13, 2008 at 06:26:44PM +0200, Stephen R. van den Berg wrote:
>>> What are the opinions on adding a basic challenge-response type
>>> authentication mechanism to the native git protocol?
>>> I.e. the authentication would be a simple one, which uses
>>> SHA1 (surprise ;-) to actually encrypt username/password/salt
>>> and authenticate the user.
>>
>> In the past, such an idea was dismissed with desire not to reimplement
>> something ssh already implemented, and much better than we would.
>
> The problem is that ssh ties you in very closely with the ability to
> log into the machine.  It's also hard to limit what ssh allows while
> still allowing some users more priveleges.

Can you elaborate, in light of git-shell and Gitosis? What's the
problem?

				Petr "Pasky" Baudis
