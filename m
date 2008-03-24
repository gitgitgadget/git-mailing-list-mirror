From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: Re: [EGIT PATCH 4/4] Show only commits in the current branch.
Date: Mon, 24 Mar 2008 10:18:58 -0300
Message-ID: <47E7AA42.9010202@intelinet.com.br>
References: <1206327487-6543-1-git-send-email-rogersoares@intelinet.com.br> <200803240947.15130.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 14:23:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdmdY-0000qv-Pt
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 14:22:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757362AbYCXNWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 09:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757858AbYCXNWA
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 09:22:00 -0400
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1650 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757013AbYCXNV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 09:21:59 -0400
Received: (qmail 7299 invoked by uid 0); 24 Mar 2008 10:24:24 -0300
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.036503 secs); 24 Mar 2008 13:24:24 -0000
Received: from unknown (HELO ?200.152.180.33?) (200.152.180.33)
  by cvxbsd.convex.com.br with SMTP; 24 Mar 2008 13:24:24 -0000
User-Agent: Thunderbird 1.5.0.12 (X11/20080213)
In-Reply-To: <200803240947.15130.robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78032>


Robin Rosenberg escreveu:
> Good ui, but I don't like the filter (seem you didn't either from your comment) so I suggest inserting this patch
> before the 4/4 patch of yours. Then in your patch drop the filter and fix the call to getHistory. This will
> improve performance since the "current branch only" will be the view I (and probably most other people)
> will use the most.
>   
Yep, I did it some time ago and haven't gone back to understand the 
getHistoryFor code. It will be a lot better now, thanks, will do it. :)

[]s,
Roger.
