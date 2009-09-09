From: Jeff King <peff@peff.net>
Subject: Re: tracking branch for a rebase
Date: Wed, 9 Sep 2009 06:45:50 -0400
Message-ID: <20090909104550.GA20108@coredump.intra.peff.net>
References: <20090904135414.GA3728@honk.padd.com>
 <4AA124DD.1030208@drmicha.warpmail.net>
 <20090904181846.GC19093@coredump.intra.peff.net>
 <20090904185949.GA21583@atjola.homenet>
 <20090905061250.GA29863@coredump.intra.peff.net>
 <20090905140127.GA29037@atjola.homenet>
 <20090905142841.GB15631@coredump.intra.peff.net>
 <7vfxaz9wfi.fsf@alter.siamese.dyndns.org>
 <20090907084324.GB17997@coredump.intra.peff.net>
 <alpine.DEB.1.00.0909071126040.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 09 12:46:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlKge-00051o-Rq
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 12:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbZIIKpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 06:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752327AbZIIKpz
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 06:45:55 -0400
Received: from peff.net ([208.65.91.99]:39185 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751979AbZIIKpy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 06:45:54 -0400
Received: (qmail 27773 invoked by uid 107); 9 Sep 2009 10:46:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 09 Sep 2009 06:46:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Sep 2009 06:45:51 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0909071126040.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128058>

On Mon, Sep 07, 2009 at 11:29:50AM +0200, Johannes Schindelin wrote:

> > I think using @{} is a reasonable extension format.
> 
> Sorry to enter this thread that late, but I did not realize that it 
> touches my %<branch> work.
> 
> Your proposal leads to something like "master@{upstream}@{2.days.ago}", 
> which looks ugly.  And it is much more to type.
> 
> I still think that it is not too-much asked for to require the 
> "refs/heads/" prefix if somebody starts her branch names with "%".

I don't have a problem with restricting branch names starting with "%".
However, I do think "%.." is a bit ugly to read. And I am somewhat
concerned that we are eating the last reasonable available
meta-character for this feature, which will make things even harder next
time somebody suggests a clever feature. Which is why the discussion
turned to a generic extension syntax.

I wonder if it is worth adding @{upstream} now, which is fairly safe,
letting it cook for a while, and then adding a "%" alias later after the
concept has proved itself (and people say "I like this feature, but it
really is too much to type").

-Peff
