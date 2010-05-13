From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: how to push from  repository with two tracking branches
Date: Thu, 13 May 2010 14:12:58 +0200
Message-ID: <201005131412.58675.trast@student.ethz.ch>
References: <hsgfjn$onv$1@dough.gmane.org> <20100513115747.GC10963@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, <git@vger.kernel.org>
To: Gelonida <gelonida@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 13 14:13:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCXHs-0002jU-9h
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 14:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758797Ab0EMMNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 08:13:06 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:36852 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755942Ab0EMMNF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 08:13:05 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 13 May
 2010 14:13:02 +0200
Received: from thomas.localnet (129.132.210.10) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 13 May
 2010 14:13:01 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <20100513115747.GC10963@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146996>

Jeff King wrote:
> On Thu, May 13, 2010 at 11:09:11AM +0200, Gelonida wrote:
> 
> > I have a repository with two tracking branches ('master' and 'mybranch')
> > 
> > with only one tracking branch I can do
> > git pull
> > make_local_changes
> > git commit -a
> > git push
> > 
> > with two tracking branches I will be told off if the other branch has
> > been updated meanwhile, so what I currently to do is:
> 
> How about "git push origin mybranch" to just push mybranch? You might
> also want to look at "push.default" in "git help config".

Besides, all successful branch updates go through independently of the
ones that failed.  So you can push without having all local branches
up to date.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
