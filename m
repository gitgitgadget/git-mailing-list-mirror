From: Marc Weber <marco-oweber@gmx.de>
Subject: Re: [TopGit PATCH] put die() messages to stderr
Date: Fri, 21 Nov 2008 14:28:01 +0100
Message-ID: <20081121132801.GA5912@gmx.de>
References: <1227261900-23420-1-git-send-email-bert.wesarg@googlemail.com> <20081121123654.GB20537@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 21 14:29:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3W4f-0000mk-QL
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 14:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848AbYKUN2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 08:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752796AbYKUN2I
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 08:28:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:51187 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752663AbYKUN2F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 08:28:05 -0500
Received: (qmail invoked by alias); 21 Nov 2008 13:28:02 -0000
Received: from pD9E09E33.dip.t-dialin.net (EHLO nixos) [217.224.158.51]
  by mail.gmx.net (mp065) with SMTP; 21 Nov 2008 14:28:02 +0100
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX1/pSIwSKcjpWPIOKB2ZFvE7jNHIiXz5D/NAkdqLOx
	Ri1sdQ0ZoqXZ5n
Received: by nixos (sSMTP sendmail emulation); Fri, 21 Nov 2008 14:28:01 +0100
Mail-Followup-To: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20081121123654.GB20537@piper.oerlikon.madduck.net>
User-Agent: Mutt/1.5.15 (2007-04-06)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101525>

On Fri, Nov 21, 2008 at 01:36:54PM +0100, martin f krafft wrote:
> also sprach Bert Wesarg <bert.wesarg@googlemail.com> [2008.11.21.1105 +0100]:
> > -	info "fatal: $*"
> > +	info "fatal: $*" >&2
> 
> Shouldn't info also output to stderr?

die is calling info. So this patch is enough.

You should just send this patch to the author. I think he'll apply it
instantly. I've send a small patch to him yesterday as well.

Marc Weber
