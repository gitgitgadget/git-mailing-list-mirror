From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Bug in gitk - can post the window off screen
Date: Thu, 7 Feb 2008 10:56:19 +0100
Message-ID: <200802071056.19370.robin.rosenberg.lists@dewire.com>
References: <47AAA254.2020008@thorn.ws> <20080207063020.GP24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Tommy Thorn <tommy-git@thorn.ws>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 07 10:57:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN3VF-0007qn-51
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 10:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757564AbYBGJ4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 04:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756961AbYBGJ4K
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 04:56:10 -0500
Received: from [83.140.172.130] ([83.140.172.130]:27823 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756659AbYBGJ4H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 04:56:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 3303780069D;
	Thu,  7 Feb 2008 10:56:06 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5jppWcs2Mn4B; Thu,  7 Feb 2008 10:56:05 +0100 (CET)
Received: from [10.9.0.5] (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 8E15280069C;
	Thu,  7 Feb 2008 10:56:00 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <20080207063020.GP24004@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72919>

torsdagen den 7 februari 2008 skrev Shawn O. Pearce:
> Tommy Thorn <tommy-git@thorn.ws> wrote:
> > Just a quick heads-up: I was running a dual screen setup with gitk on my 
> > 2nd monitor. When I later started gitk up without the 2nd monitor, the 
> > gitk window didn't appear. Given the time between the two sessions, it 
> > didn't occur to me what the problem was.
> > 
> > Gitk should probably validate the "set geometry(main)" variable against 
> > the current resolution.
> 
> Sad to say but this is a known issue with both gitk and git-gui.
> Both applications save the prior geometry and restore it during
> the next run, but neither validates the new geometry makes sense
> with the current available desktop space.  :-\

Seems KDE forces it back into visible space, but it is annoying that the 
gitk/git-gui windows do not come up on the same monitor as my cursor is on. 
Could we change it and save just size, just like "all other" apps?

-- robin
