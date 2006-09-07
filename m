From: Jeff King <peff@peff.net>
Subject: Re: Change set based shallow clone
Date: Thu, 7 Sep 2006 17:33:07 -0400
Message-ID: <20060907213306.GA10781@sigio.intra.peff.net>
References: <9e4733910609071252ree73effwb06358e9a22ba965@mail.gmail.com> <edpuut$dns$1@sea.gmane.org> <9e4733910609071341u7e430214j71ddcbefa26810ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 23:33:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLRUx-0001LU-0t
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 23:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888AbWIGVdK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 17:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbWIGVdK
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 17:33:10 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4799 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751888AbWIGVdJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Sep 2006 17:33:09 -0400
Received: (qmail 8925 invoked from network); 7 Sep 2006 17:32:33 -0400
Received: from unknown (HELO sigio.intra.peff.net) (10.0.0.10)
  by segfault.intra.peff.net with SMTP; 7 Sep 2006 17:32:33 -0400
Received: by sigio.intra.peff.net (sSMTP sendmail emulation); Thu,  7 Sep 2006 17:33:07 -0400
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910609071341u7e430214j71ddcbefa26810ca@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26657>

On Thu, Sep 07, 2006 at 04:41:20PM -0400, Jon Smirl wrote:

> Maybe the answer is to build a shallow clone tool for casual use, and
> then if you try to run anything too complex on it git just tells you
> that you have to download the entire tree.

Can you list which operations you'd like to do on the shallow clone?

Many operations that look at history are going to fail with a very short
history (e.g., finding a merge base). Some operations can work with a
short history, but the results are probably not useful (seeing the last
10 commits from git-log is probably not interesting). If you just want
the latest snapshot, the remote git-archive work going on right now will
probably take care of that.

-Peff
