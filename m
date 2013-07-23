From: John Keeping <john@keeping.me.uk>
Subject: Re: getting git from kernel.org is failing
Date: Tue, 23 Jul 2013 22:06:04 +0100
Message-ID: <20130723210604.GF2337@serenity.lan>
References: <51EEDC78.4000507@googlemail.com>
 <20130723200605.GE5129@paksenarrion.iveqy.com>
 <20130723202127.GA2051@sigill.intra.peff.net>
 <20130723204005.GF14690@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Fredrik Gustafsson <iveqy@iveqy.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 23 23:06:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1jn3-0000vO-UE
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 23:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933386Ab3GWVGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 17:06:17 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:49900 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757159Ab3GWVGP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 17:06:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id C9BED606508;
	Tue, 23 Jul 2013 22:06:14 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hSdOwQC1306S; Tue, 23 Jul 2013 22:06:14 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 2D37D6064E7;
	Tue, 23 Jul 2013 22:06:06 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130723204005.GF14690@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231060>

On Tue, Jul 23, 2013 at 01:40:05PM -0700, Jonathan Nieder wrote:
> Jeff King wrote:
> 
> > then smart HTTP works fine. I wonder if there is a problem in the cgit
> > setup on kernel.org (or if it was even intended that you could fetch
> > from the cgit URL at all; the cgit page shows the clone URLs in
> > /pub/scm/git).
> 
> I didn't think cgit URLs were meant to be clonable, but since
> ls-remote works on them, it seems I thought wrong. :)  Odd.

CGit has a config option "enable-http-clone" which causes it to act as
an endpoint for the dumb HTTP protocol.  That option defaults to "on",
so I suspect that kernel.org has just left it at the default.
