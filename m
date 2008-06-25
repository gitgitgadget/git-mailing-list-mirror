From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH] Ship sample hooks with .sample suffix
Date: Wed, 25 Jun 2008 05:18:54 +0000
Message-ID: <20080625051854.GA11813@m62s10.vlinux.de>
References: <53A5AFCF-94C7-465E-A181-1DA69F251F5B@gmail.com> <alpine.LFD.1.10.0806241418360.32759@sys-0.hiltweb.site> <39C2861E-F800-40AE-8C15-4FC3BB51EF16@gmail.com> <7v3an2bh3b.fsf@gitster.siamese.dyndns.org> <930163B6-4A7E-49C7-B9D5-F7B37699C2A9@gmail.com> <7v4p7i9ygd.fsf@gitster.siamese.dyndns.org> <7vtzfi8dvk.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Holtje <docwhat@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 07:20:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBNQH-0002b3-Lj
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 07:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600AbYFYFS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 01:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752610AbYFYFS5
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 01:18:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:35892 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752376AbYFYFS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 01:18:56 -0400
Received: (qmail invoked by alias); 25 Jun 2008 05:18:54 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp043) with SMTP; 25 Jun 2008 07:18:54 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX18P/E1JtXQPzJV/v4EXwCJiTWEgFjO8NyJIu4KP9P
	s8zjJkyd5xmBSY
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id BD50758139; Wed, 25 Jun 2008 05:18:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vtzfi8dvk.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86228>

On Tue, Jun 24, 2008 at 07:09:03PM -0700, Junio C Hamano wrote:
> We used to mark hooks we ship as samples by making them unexecutable, but
> some filesystems cannot tell what is executable and what is not.
> 
> This makes it much more explicit.  The hooks are suffixed with .sample
> (but now are made executable), so enabling it is still one step operation
> (instead of "chmod +x $hook", you would do "mv $hook.sample $hook") but
> now they won't get accidentally enabled on systems without executable bit.
> 

Wouldn't it be better to name the hooks $hook.deactivated so its obvious
to anybody that they are not executed? Just my 2 cents.

-Peter
