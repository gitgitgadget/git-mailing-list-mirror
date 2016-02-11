From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: git 2.7.0 crashes when top-down memory allocation preference is
 set
Date: Thu, 11 Feb 2016 14:30:05 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602111429200.2964@virtualbox>
References: <9e3cc44087134954a3414fa8998c3ce6@USNAEXCP2.pc.cognex.com> <alpine.DEB.2.20.1602040844330.2964@virtualbox> <43fbdf617f8d412db7b0d5c7d06df3ad@USNAEXCP2.pc.cognex.com> <alpine.DEB.2.20.1602041628180.2964@virtualbox> <9854ccd81e624ee9a8f721a871bda4b2@USNAEXCP2.pc.cognex.com>
 <alpine.DEB.2.20.1602050048570.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Klinger, Xia" <Xia.Klinger@cognex.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 14:30:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTrKK-0007Ce-JG
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 14:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595AbcBKNa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 08:30:29 -0500
Received: from mout.gmx.net ([212.227.15.15]:63034 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752530AbcBKNa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 08:30:28 -0500
Received: from virtualbox ([37.24.143.97]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MLeoF-1aUgfe3ZVD-000qJF; Thu, 11 Feb 2016 14:30:21
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <alpine.DEB.2.20.1602050048570.2964@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:H64HT7LUUnhLyEBMk2soZ8EDBF1/tgK0oB0JIF24hQDnpbVgq1o
 AP0v3FgIWHMg4+vPNgjOC/mUc+3wrzeWch/GEIJlQe11H9ccxfCsM/up9qI1WHgbsmMzFU+
 bfZtDAyk4Fxys/vilKsY987nTxLYlcyD/AeDy0AYcAHXYejsr3c/1k+yCgm6LVxVw9yLy8O
 bSyN3NB5UHmzTPQXinYAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6GH/HMZ9JNs=:YGH+jPsQHyKIk9REbqRR/e
 LwtkKpv33pNCQcQLSgRnYxGSHWsTqPdIirj3SZONDcrFBK/SCLO5GpkfH7TjV56YcIgVmSN/o
 gwcU83RGf1yXtpQA94F5cqLS1nU36Nawbs7i/8cf77ud7XYTxU91mlCVvRPG7NQGAfqDOcdNh
 rebJRauZHfqb9nBRL/3SQn5DEzti2Qotje3aLLGWoW001oq/gfKGUkIL0ZKTOqkRxf9q25TW9
 sEb4txNxESZjAMRw2o0rWBB4xv5Lyju3gv+o4blxfN3p9Kx4P19n4gR2o+JfnY1sBfJf4MGCA
 8TjXiiRV0L3AYHxlNwZFtpsRAWy8ALir8oUR+jwmTATYSMcVJQUW4nFUlK9mcudNlUmD2MFQI
 2F4tQJYx4DKq9jjDwjRdNyAWXF6JFQNlH5XrD4LXZ3MnATQZ5Xk0qfa6xs3yT5s+IaqPREt0S
 12xn/Cg6nf7Y8V9br2FASP6Pb4Im/5EBAqq7fjEk2eqMZiy4iW4//DpRo0iDuvRvW8te7J7rj
 slZ0uAEEpZC36xKMICdBR3v77MbFvyM/hfPtkUSx4hVT/BRcQK3msvAYifJ5w5X1xPRLhXeVl
 NoHp/DKqvluIs1RIuLfk8DVNP7c5M7eeyn/p+wiKhG1xIIMjaex7IvOpxZ02rjstBe6V6NzIP
 LUiwbrxzzFGq9ru/czfpAlQOTh2j8WbjOej/E5EMs9i5SrGseHsphbsUtGSj3mpLg+J1V2KKA
 xX2iY+gZLGVpweVeLKQs7UloyqP3M1TN6p9evBS81RnlF6V9NsGpXDWU2WCeNqAlE7gAx5EX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285980>

Hi,

On Fri, 5 Feb 2016, Johannes Schindelin wrote:

> On Thu, 4 Feb 2016, Klinger, Xia wrote:
> 
> > Thanks for confirming it. I hope a fix is available soon. I am using a
> > very old version of Git at the moment to work around this issue, which
> > doesn't comply to the requirement of our Stash Git Server from
> > Atlassian.
> 
> [...] I worked on a fix for part of the day.

Judging from our past interaction, I would guess that you missed that
2.7.1 fixes this. Just wanted to let you know.

Ciao,
Johannes
