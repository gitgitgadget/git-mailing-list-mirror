From: Kevin D <me@ikke.info>
Subject: Re: Git very slow ?
Date: Sun, 8 Mar 2015 16:51:36 +0100
Message-ID: <20150308155136.GA6273@vps892.directvps.nl>
References: <20150307013007.GA13250@milliways>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ken Moffat <zarniwhoop@ntlworld.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 16:52:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUdUu-0000oh-Jx
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 16:52:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730AbbCHPvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 11:51:38 -0400
Received: from ikke.info ([178.21.113.177]:36897 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752301AbbCHPvh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 11:51:37 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id 994431DCF6D; Sun,  8 Mar 2015 16:51:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20150307013007.GA13250@milliways>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265096>

On Sat, Mar 07, 2015 at 01:30:07AM +0000, Ken Moffat wrote:
> Hi, please CC me if that is not your usual fashion, because I am not
> subscribed.
> 
> I use git for my build scripts - those are accessed over nfs.  Since
> I started using 2.1 and later (I don't think I used 2.0) commands
> such as 'commit' take a long time before anything happens.  I
> assumed that the newer version meant this would take longer.
> 
> But today^Wyesterday I was bisecting the kernel on a local
> filesystem - even when the number of revisions left to test was in
> the single digits, git bisect took a long time to decide which
> revision should be the next one to test.  The filesystems are ext4.
> Is this sort of delay normal now?
> 
> What really prompted me to ask is that I ran git blame on a script,
> to see when I made a particular change so that I could add that
> information to a ticket, and almost gave up waiting because it felt
> as if it was taking for ever.
> 

What kind of repository are we talking about? How many files, how big?
Git should not have become significantly slower recently.

Also, might there be anti-virus software that slows down file access?
