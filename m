From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: SVK merge commits can have >2 parents
Date: Sun, 29 Nov 2009 08:08:16 +0000
Message-ID: <20091129080815.GC24222@dcvr.yhbt.net>
References: <1259479636-sup-573@utwig> <1259480367-sup-6891@utwig>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Vandiver <alex@chmrr.net>, git <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sun Nov 29 09:08:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEepb-0000yy-1e
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 09:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbZK2IIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 03:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751964AbZK2IIK
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 03:08:10 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:34394 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017AbZK2IIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 03:08:09 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 4BA5B1F675;
	Sun, 29 Nov 2009 08:08:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1259480367-sup-6891@utwig>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134002>

Alex Vandiver <alex@chmrr.net> wrote:
> At Sun Nov 29 02:28:39 -0500 2009, Alex Vandiver wrote:
> > While converting a mildly complicated svn repository that was managed
> > with SVK, I ran across the following oddness.  `svk smerge` can only
> > merge between _two_ branches at once -- however, the way that svk
> > merge detection works, you can end up with erroneous extra parents
> > from long-dead branches.
> 
> Upon a little more inspection, I now understand that the rev-parse
> lines in find_extra_svk_parents are attempting to deal with this exact
> circumstance -- but they fail to properly sort the merge tickets
> first, which leads to this incorrect behavior.  Armed with this
> understanding, I'm more confident in the attached updated patch.  I

Hi Alex, Sam,

I'll defer to Sam for the Ack, my svk knowledge is limited. Thanks.

-- 
Eric Wong
