From: Tommy Thorn <tommy-git@thorn.ws>
Subject: Re: Question about your git habits
Date: Fri, 22 Feb 2008 17:26:55 -0800
Message-ID: <47BF765F.9010706@thorn.ws>
References: <200802221837.37680.chase.venters@clientec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chase Venters <chase.venters@clientec.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 02:28:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSjBF-0005Qn-1o
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 02:27:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbYBWB1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 20:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752801AbYBWB1U
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 20:27:20 -0500
Received: from server204.webhostingpad.com ([69.65.0.218]:47932 "EHLO
	server204.webhostingpad.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752754AbYBWB1T (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Feb 2008 20:27:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=thorn.ws;
	h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:X-Source-Dir;
	b=qT0OWQ+il2G6gZp7zJLKV0vBDKcCbKF40JHeM9vXKOITseOFtCqV9OAydg+AhYsCFXdSq44QnIlRXxbr8lrsmvsVaSqN19sfzM/ZAgh6G7bgcbPWW5KGnpmIknt831ML;
Received: from [216.228.112.21] (helo=dhcp-172-16-177-224.nvidia.com)
	by server204.webhostingpad.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <tommy-git@thorn.ws>)
	id 1JSjAA-0001dP-OY; Fri, 22 Feb 2008 19:26:56 -0600
User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
In-Reply-To: <200802221837.37680.chase.venters@clientec.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server204.webhostingpad.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - thorn.ws
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74777>

Chase Venters wrote:
> My question is: If you're working on multiple things at once, do you tend to 
> clone the entire repository repeatedly into a series of separate working 
> directories and do your work there, then pull that work (possibly comprising 
> a series of "temporary" commits) back into a separate local master 
> respository with --squash, either into "master" or into a branch containing 
> the new feature?
>   

IMO, that approach scales poorly and involves a lot of overhead.

> Or perhaps you create a temporary topical branch for each thing you are 
> working on, and commit arbitrary changes then checkout another branch when 
> you need to change gears, finally --squashing the intermediate commits when a 
> particular piece of work is done?
>   

Spot on.


Distribution prune for relevance.

Tommy
