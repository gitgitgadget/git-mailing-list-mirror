From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: Strange diff behavior?
Date: Thu, 21 Jun 2007 08:50:44 +0200
Message-ID: <20070621065043.GA30521@moooo.ath.cx>
References: <31e9dd080706201802h9dcbffawd82575d09e082155@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jason Sewall <jasonsewall@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 08:50:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1GVI-0002rV-4q
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 08:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769AbXFUGuv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 02:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752411AbXFUGuv
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 02:50:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:38546 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751494AbXFUGuu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 02:50:50 -0400
Received: (qmail invoked by alias); 21 Jun 2007 06:50:49 -0000
Received: from pD9EBB443.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.180.67]
  by mail.gmx.net (mp033) with SMTP; 21 Jun 2007 08:50:49 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1/ZE0li/DzZL96HhiIw/mt6Srdvf0q9TvnP2Q+soM
	EnO1nd4kchVAYr
Content-Disposition: inline
In-Reply-To: <31e9dd080706201802h9dcbffawd82575d09e082155@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50601>

Jason Sewall <jasonsewall@gmail.com> wrote:
> It seems like every change listed after the first one is meaningless.
> I really think I just don't understand something about the diff
> algorithm. Can someone tell my why those empty lines are recorded as
> changes?

This are whitespace changes.

    $ git diff --color

marks whitespaces at the end of the line with a red background color
so you can see what changed.  I also use vim with :set list to see
whitespace changes, e.g.

    $ git diff | vim -c 'set list' -

If you like to have colors (not just in diff) permnanently you can add
this to your .git/config or ~/.gitconfig:

    [color]
        branch = auto
        diff = auto
        status = auto
        pager = true

See also git-config(1) for more information on these and other
configuration options.
