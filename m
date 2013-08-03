From: Daniel Convissor <danielc@analysisandsolutions.com>
Subject: Re: change remote to track new branch
Date: Sat, 3 Aug 2013 12:52:15 -0400
Message-ID: <20130803165215.GC945@analysisandsolutions.com>
References: <20130803024032.GA28666@analysisandsolutions.com>
 <m2d2pvp7nw.fsf@linux-m68k.org>
 <20130803162821.GA945@analysisandsolutions.com>
 <87iozmhgl1.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Aug 03 18:52:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5f46-0006VP-8r
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 18:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615Ab3HCQwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 12:52:17 -0400
Received: from analysisandsolutions.com ([50.116.58.177]:60873 "EHLO
	analysisandsolutions.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306Ab3HCQwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 12:52:16 -0400
Received: by analysisandsolutions.com (Postfix, from userid 1001)
	id 71A8818973; Sat,  3 Aug 2013 12:52:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=analysisandsolutions.com; s=default; t=1375548735;
	bh=WLGK9vdn5xgT/0faA6Sox4dhHY23dd/0Pa5aDsUojqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FSjeuHz2G1UDCAeWmXG3bzew01O4VauOYAUnt1WnRoHcsSD3ti5xjwqMMupH2wX2P
	 1zS1BbgzDevZ/lkWXUtzE5wbQn/SuTbg13oFoaG+fhXurJUdciqkcBEJlt8uvxwNo0
	 FVezgUGkADCGAFXf3LIlr2tojn3h6I4AfXIxLND8=
Content-Disposition: inline
In-Reply-To: <87iozmhgl1.fsf@igel.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231604>

Hi Andreas:

On Sat, Aug 03, 2013 at 06:41:46PM +0200, Andreas Schwab wrote:
> Daniel Convissor <danielc@analysisandsolutions.com> writes:
> 
> Use git config.

Yeah.  I had contemplated using the following commands:

    git config remote.wp.fetch \
        "+refs/heads/3.6-branch:refs/remotes/wp/3.6-branch"
    git config branch.wp.merge "refs/heads/3.6-branch"

So is "git remote set-branches" and "git branch --set-upstream-to" just
another syntax for making those same changes to git config?  Or do the
new commands do some additional work on the repository (to better keep
track of things, or whatever)?

Thanks,

--Dan

-- 
 T H E   A N A L Y S I S   A N D   S O L U T I O N S   C O M P A N Y
            data intensive web and database programming
                http://www.AnalysisAndSolutions.com/
        4015 7th Ave #4, Brooklyn NY 11232  v: 718-854-0335
