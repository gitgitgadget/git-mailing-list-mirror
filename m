From: Petr Baudis <pasky@suse.cz>
Subject: Re: TopGit: how to deal with upstream inclusion
Date: Tue, 23 Sep 2008 11:55:28 +0200
Message-ID: <20080923095528.GR10360@machine.or.cz>
References: <20080914203043.GA4872@lapse.rw.madduck.net> <20080914210316.GJ10360@machine.or.cz> <20080919170406.GA22849@lapse.rw.madduck.net> <20080921141924.GI10360@machine.or.cz> <20080923063550.GC19084@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Tue Sep 23 11:56:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki4dO-0007DB-VB
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 11:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbYIWJzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 05:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbYIWJzb
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 05:55:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41669 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952AbYIWJzb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 05:55:31 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id F09543939B44; Tue, 23 Sep 2008 11:55:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080923063550.GC19084@piper.oerlikon.madduck.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96544>

On Tue, Sep 23, 2008 at 08:35:50AM +0200, martin f krafft wrote:
> also sprach Petr Baudis <pasky@suse.cz> [2008.09.21.1619 +0200]:
> > > Yes, it does. One might want to consider to make the use of -s ours
> > > in (iiii) configurable, but otherwise that's it.
> > 
> > That might be pretty dangerous, since then your topic branch will have
> > outstanding branches of the retired branch, but they will _NOT_ be
> > visible to tg patch and others since they will be in both the base and
> > head.
> 
> Well, but what if upstream implemented our solution slightly
> differently, and if it's only because they used tabs instead of
> spaces? We wouldn't want -s ours then, huh?

You still would want to get tabs in other patches that depended on the
merged one, no? Otherwise tg patch output will produce patches that do
not apply and tg export will change the tabs back to spaces.

				Petr "Pasky" Baudis
