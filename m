From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT PATCH] Improve the sideband progress scaper to be more accurate
Date: Sat, 3 Jan 2009 23:12:52 +0100
Message-ID: <200901032312.53148.robin.rosenberg@dewire.com>
References: <1230055423-9944-1-git-send-email-spearce@spearce.org> <20081231073505.GA22551@spearce.org> <20081231190401.GI29071@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jan 03 23:14:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJElB-0003GL-QH
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 23:14:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759650AbZACWM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 17:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752989AbZACWM6
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 17:12:58 -0500
Received: from mail.dewire.com ([83.140.172.130]:13133 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751684AbZACWM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 17:12:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 774701484F53;
	Sat,  3 Jan 2009 23:12:55 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tl6bIIbj1h-4; Sat,  3 Jan 2009 23:12:54 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id D2D228006AF;
	Sat,  3 Jan 2009 23:12:54 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27-11-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <20081231190401.GI29071@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104483>

onsdag 31 december 2008 20:04:01 skrev Shawn O. Pearce:
> By matching only whole lines we should be able to improve the
> progress scaper so we avoid ugly output like we had been seeing:
> 
>   EGIT.contrib/jgit clone git://repo.or.cz/libgit2.git LIBGIT2
>   Initialized empty Git repository in /home/me/SW/LIBGIT2/.git
>   Counting objects:       547
>   Compressing objects:    100% (192/192)
>   ts:                     100% (192/192)
>   Compressing objects:    100% (192/192)
>   ng objects:             100% (192/192)
> 
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>  Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
>  > Would it be hard to get the progress look better?
> 
>  Maybe this does the trick.  Its hard to reproduce so its hard to
>  come up with the condition that was giving us the problem before.
>  I suspect its because we were getting line fragments on the sideband
>  channel, but I'm not sure that was really the case.

Nasty. I couldn't reproduce it myself. I'll hold onto this one for a while and
see if I'll get the opportunity to test it live with this problem.

-- robin
