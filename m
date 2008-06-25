From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Don't select the wrong file if the last listed file is staged.
Date: Wed, 25 Jun 2008 16:57:02 -0400
Message-ID: <20080625205702.GN11793@spearce.org>
References: <1213308730-12707-1-git-send-email-ams@toroid.org> <20080625103650.GA20492@toroid.org> <486222A6.70205@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Abhijit Menon-Sen <ams@toroid.org>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jun 25 22:58:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBc4D-0003VW-BQ
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 22:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbYFYU5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 16:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753836AbYFYU5I
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 16:57:08 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45778 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565AbYFYU5H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 16:57:07 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KBc2x-0002dl-AE; Wed, 25 Jun 2008 16:56:55 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 857DA20FBAE; Wed, 25 Jun 2008 16:57:02 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <486222A6.70205@viscovery.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86349>

Johannes Sixt <j.sixt@viscovery.net> wrote:
> Abhijit Menon-Sen schrieb:
> > Johannes Sixt noticed that if the last file in the list was staged, my
> > earlier patch would display the diff for the penultimate file, but show
> > the file _before_ that as being selected.
> > 
> > This was due to my misunderstanding the lno argument to show_diff.
> > 
> > This patch fixes the problem: lno is not decremented in the special case
> > to handle the last item in the list (though we still need to use $lno-1
> > to find the right path for the next diff).
> 
> Thanks. It works here, too:

Thanks, both.  Its in my tree.
 
-- 
Shawn.
