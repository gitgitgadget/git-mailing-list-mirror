From: David Aguilar <davvid@gmail.com>
Subject: Re: Overriding ~/.gitconfig using GIT_CONFIG
Date: Sun, 28 Aug 2011 06:05:56 -0700
Message-ID: <20110828130555.GA56765@gmail.com>
References: <1313163498.14274.505.camel@rex>
 <7vr54qmodf.fsf@alter.siamese.dyndns.org>
 <7vmxfemnc4.fsf@alter.siamese.dyndns.org>
 <1313181853.14274.535.camel@rex>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	=?utf-8?B?Tmd1eeG7IG4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Richard Purdie <rpurdie@rpsys.net>
X-From: git-owner@vger.kernel.org Sun Aug 28 15:08:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qxf6V-0000rv-5I
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 15:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915Ab1H1NGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Aug 2011 09:06:11 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:59527 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941Ab1H1NGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2011 09:06:09 -0400
Received: by pzk37 with SMTP id 37so6903015pzk.1
        for <git@vger.kernel.org>; Sun, 28 Aug 2011 06:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZitO70g4/YT0DdCUp7RJHWWj8eBW/GWaxw1pnn71yMg=;
        b=Lta/gnsMVlvjkzMZC0mCi20u+zKEp+4SOciTlR9iRKd0SRkjaiTN0OVrGdgQpi4Qej
         rLnj+T0Z5SWmeo/Oe1H/U1nfn41If3ENkurUPAE2/QOJvs36EUIdChgwOl2ZnoK1izW+
         p9/GHbqBBLuA7nF3BIu7ypZt5NYi7PDb5DzUs=
Received: by 10.142.43.2 with SMTP id q2mr1882569wfq.89.1314536768759;
        Sun, 28 Aug 2011 06:06:08 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net. [208.106.56.2])
        by mx.google.com with ESMTPS id t7sm1294833pbn.11.2011.08.28.06.06.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 28 Aug 2011 06:06:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313181853.14274.535.camel@rex>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180267>

On Fri, Aug 12, 2011 at 09:44:13PM +0100, Richard Purdie wrote:
> My problem isn't that I want to specify a specific .gitconfig file, I
> just need it to ignore the one in $HOME. I'm happy for the .git/config
> file to be used, in fact I need it to be.

If you're writing a tool then it should restrict itself to
git's plumbing commands.  You should be able to do just about
anything without needing to worry about differences in
configuraiton.  Git commands almost always provide a way to
override configuration through the use of flags.

The plumbing commands are listed in the main git manpage.
See "Low-level commands (plumbing)" here:
http://www.kernel.org/pub/software/scm/git/docs/

What is the specific problem solved by overriding the
configuration?  It may be possible to solve it without needing
to get too complicated.

Have fun,
-- 
					David
