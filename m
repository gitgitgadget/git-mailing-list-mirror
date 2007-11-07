From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in git, help users out.
Date: Wed, 7 Nov 2007 20:32:47 +0100
Message-ID: <200711072032.48193.robin.rosenberg.lists@dewire.com>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org> <20071107081608.GA19066@glandium.org> <Pine.LNX.4.64.0711071103450.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Mike Hommey <mh@glandium.org>, Junio C Hamano <gitster@pobox.com>,
	Steven Grimm <koreth@midwinter.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 07 20:51:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpqwG-0002vs-S1
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 20:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043AbXKGTve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 14:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754041AbXKGTvd
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 14:51:33 -0500
Received: from [83.140.172.130] ([83.140.172.130]:16875 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753463AbXKGTvd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 14:51:33 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B40C1802679;
	Wed,  7 Nov 2007 20:42:32 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 16789-08; Wed,  7 Nov 2007 20:42:32 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 31CD5802659;
	Wed,  7 Nov 2007 20:42:32 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <Pine.LNX.4.64.0711071103450.4362@racer.site>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63848>

onsdag 07 november 2007 skrev Johannes Schindelin:
> Hi,
> 
> On Wed, 7 Nov 2007, Mike Hommey wrote:
> 
> > On Tue, Nov 06, 2007 at 10:25:48PM +0000, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > > On Tue, 6 Nov 2007, Robin Rosenberg wrote:
> > > 
> > > > tisdag 06 november 2007 skrev Mike Hommey:
> > > > > Maybe the documentation could emphasise on how to undo things when 
> > > > > the user makes mistakes. Sometimes, saving your repo can be as 
> > > > > simple as git reset --hard HEAD@{1}. This is not, unfortunately, a 
> > > > > works-for-all-cases command.
> > > > 
> > > > Yea, git-undo(7). 
> > > 
> > > In related news, I know a few users who need an un-rm-rf.  Anyone?
> > 
> > The fact is you can do harm to your repo with things you wouldn't expect 
> > to break things, except maybe you gave bad arguments or so. It's quite 
> > easy to fuck up with git-rebase, or to merge the wrong commits, etc.
> 
> I don't see how these commands are dangerous.  Usually you just look into 
> the reflog, pick the one commit you started with, and reset --hard.

Indeed, but you must *know* that and you must know that you *can* do it.

As for undo rm -rf, it's not part of git and outside the scope of git.

-- robin
