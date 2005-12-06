From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Wine + GIT
Date: Mon, 05 Dec 2005 21:03:31 -0500
Message-ID: <4394F173.6000505@pobox.com>
References: <4394CD68.8020500@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 03:04:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjSBD-0000mG-7M
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 03:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbVLFCDk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 21:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbVLFCDk
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 21:03:40 -0500
Received: from mail.dvmed.net ([216.237.124.58]:27024 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964913AbVLFCDj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Dec 2005 21:03:39 -0500
Received: from cpe-069-134-188-146.nc.res.rr.com ([69.134.188.146] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1EjSB3-0002z1-Ge; Tue, 06 Dec 2005 02:03:39 +0000
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Mike McCormack <mike@codeweavers.com>
In-Reply-To: <4394CD68.8020500@codeweavers.com>
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Mike McCormack wrote: > Hi All, > > The Wine project
	has started maintaining a wine.git in parallel to the > Wine CVS. To
	introduce Wine developers to GIT, we've put together a > short
	introduction on the Wine Wiki on using GIT to maintain patches. > You
	can find it at: [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13247>

Mike McCormack wrote:
> Hi All,
> 
> The Wine project has started maintaining a wine.git in parallel to the 
> Wine CVS.  To introduce Wine developers to GIT, we've put together a 
> short introduction on the Wine Wiki on using GIT to maintain patches. 
> You can find it at:

> http://wiki.winehq.org/GitWine

Very cool!  :)

Comments:

1) I wrote a git howto for kernel hackers, 95% of which applies to other 
projects as well:  http://linux.yyz.us/git-howto.html

2) The "git-foo" commands are apparently uncool.  "git foo ..." is 
preferred.

3) replace
	git-diff-index -p HEAD
with
	git diff HEAD

4) "git commit -a" can often replace git-update-index+git-commit

5) never ever do
	git-checkout -f HEAD

HEAD should always be a symlink.  'git checkout -f master' is probably 
what you want.

6) For merges with hand-merged conflicts, I could have sworn that either 
a "git commit -a" or 'git-update-index' + 'git commit' was required. 
Maybe I'm wrong, or that has changed?
