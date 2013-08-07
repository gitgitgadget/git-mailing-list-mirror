From: Daniel Convissor <danielc@analysisandsolutions.com>
Subject: Re: change remote to track new branch
Date: Tue, 6 Aug 2013 20:30:53 -0400
Message-ID: <20130807003053.GA7145@analysisandsolutions.com>
References: <20130803024032.GA28666@analysisandsolutions.com>
 <m2d2pvp7nw.fsf@linux-m68k.org>
 <20130803162821.GA945@analysisandsolutions.com>
 <87iozmhgl1.fsf@igel.home>
 <20130803165215.GC945@analysisandsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 07 02:31:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6reU-0002dE-Op
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 02:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756567Ab3HGAay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 20:30:54 -0400
Received: from analysisandsolutions.com ([50.116.58.177]:35206 "EHLO
	analysisandsolutions.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756355Ab3HGAax (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 20:30:53 -0400
Received: by analysisandsolutions.com (Postfix, from userid 1001)
	id 4D2CC18973; Tue,  6 Aug 2013 20:30:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=analysisandsolutions.com; s=default; t=1375835453;
	bh=qgs7zFglEXLe8r64RLmZ/rXhsFRhowN/Ojuir6aBUx0=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=a8Iy19ZLPT7bC9SuTHQAkpI9VoiGBkt/Muvgh2C6dquv0KH5L7dJw1P2Hjt6eBm/s
	 gYPfllUS2H+6f9k23VhkuQMAorLjTvG4Bv3HvxeuYwoPYPmaz9av/Id8ueT/xbir3o
	 1Rpk5Hi2RcY5X0Wl1NIrg+jOrlmYOL09psFpEWnk=
Content-Disposition: inline
In-Reply-To: <20130803165215.GC945@analysisandsolutions.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231802>

Hi Folks:

On Sat, Aug 03, 2013 at 12:52:15PM -0400, Daniel Convissor wrote:
> 
> Yeah.  I had contemplated using the following commands:
> 
>     git config remote.wp.fetch \
>         "+refs/heads/3.6-branch:refs/remotes/wp/3.6-branch"
>     git config branch.wp.merge "refs/heads/3.6-branch"
> 
> So is "git remote set-branches" and "git branch --set-upstream-to" just
> another syntax for making those same changes to git config?  Or do the
> new commands do some additional work on the repository (to better keep
> track of things, or whatever)?

Sorry to be a pest, but I'm curious what the answer is, please.

Thank you,

--Dan

-- 
 T H E   A N A L Y S I S   A N D   S O L U T I O N S   C O M P A N Y
            data intensive web and database programming
                http://www.AnalysisAndSolutions.com/
        4015 7th Ave #4, Brooklyn NY 11232  v: 718-854-0335
