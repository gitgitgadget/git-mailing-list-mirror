From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 0/7] [GSoC2009] Revision cache / git-daemon caching plan
Date: Sun, 07 Jun 2009 16:01:41 +1200
Message-ID: <1244347301.9843.52.camel@maia.lan>
References: <cover.1244125127.git.sam@vilain.net>
	 <m34ouu7h70.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nick Edelen <sirnot@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 06:07:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MD9fa-0004ZC-Ip
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 06:07:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbZFGEBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 00:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbZFGEBS
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 00:01:18 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:52056 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784AbZFGEBS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 00:01:18 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 7BC5C21C400; Sun,  7 Jun 2009 16:00:52 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.182] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 380C521C335;
	Sun,  7 Jun 2009 16:00:36 +1200 (NZST)
In-Reply-To: <m34ouu7h70.fsf@localhost.localdomain>
X-Mailer: Evolution 2.24.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120952>

On Fri, 2009-06-05 at 09:56 -0700, Jakub Narebski wrote:
> > The plan is to aim for one of these API milestones completed per week.
> > When complete, each commit will contain tests for the level of cache
> > that it delivers.  Later milestones include joining the dots -
> > integrating with the 'rev-list' machinery and most importantly,
> > 'pack-objects'.
> 
> I like this sharing not only completed code, but plans, designs (and
> status reports) with Git Development Community (i.e. git mailing
> list).  I like this very much.
> 
> 
> I'd like to ask if there any results of profiling git server
> (git-daemon) code: how much is spend on object enumeration this GSoC
> project tries to make faster by the means of caching?

No, but you're not the first to ask - I'll research this and include
profiling of it (obviously needing to descend into stages taken by
pack-objects/receive-packs, as Nicholas points out) in the next update I
send out.

> Are there prepared benchmarks and tests to check if the code gives
> correct results, and to measure improvements brought by caching?
> Would it be possible to get some real-life statistics of git-daemon
> usage, so that you optimize against real scenarios?

In terms of correct results - that will come down to the test cases
which are written for it, and possibly extending the existing test cases
eg t5500-fetch-pack.sh

> I wish you good work on git-daemon caching...

Thanks!

Sam.
