From: Sam Vilain <sam@vilain.net>
Subject: Re: [spf:guess] Re: git-svn: SVK merge commits can have >2 parents
Date: Mon, 30 Nov 2009 00:26:07 +1300
Message-ID: <1259493967.31767.4.camel@denix>
References: <1259479636-sup-573@utwig> <1259480367-sup-6891@utwig>
	 <20091129080815.GC24222@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Alex Vandiver <alex@chmrr.net>, git <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Nov 29 12:26:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEhv9-0002bK-Am
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 12:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920AbZK2L0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 06:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753915AbZK2L0F
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 06:26:05 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:58458 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750958AbZK2L0F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 06:26:05 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id A9E5521C442; Mon, 30 Nov 2009 00:26:08 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.234] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 9577F21C368;
	Mon, 30 Nov 2009 00:25:51 +1300 (NZDT)
In-Reply-To: <20091129080815.GC24222@dcvr.yhbt.net>
X-Mailer: Evolution 2.28.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134011>

On Sun, 2009-11-29 at 08:08 +0000, Eric Wong wrote:
> Alex Vandiver <alex@chmrr.net> wrote:
> > At Sun Nov 29 02:28:39 -0500 2009, Alex Vandiver wrote:
> > > While converting a mildly complicated svn repository that was managed
> > > with SVK, I ran across the following oddness.  `svk smerge` can only
> > > merge between _two_ branches at once -- however, the way that svk
> > > merge detection works, you can end up with erroneous extra parents
> > > from long-dead branches.
> > 
> > Upon a little more inspection, I now understand that the rev-parse
> > lines in find_extra_svk_parents are attempting to deal with this exact
> > circumstance -- but they fail to properly sort the merge tickets
> > first, which leads to this incorrect behavior.  Armed with this
> > understanding, I'm more confident in the attached updated patch.  I
> 
> Hi Alex, Sam,
> 
> I'll defer to Sam for the Ack, my svk knowledge is limited. Thanks.

Yes, the change does make sense to me - nicely done, Alex.

Acked-By: Sam Vilain <sam@vilain.net>

Sam
