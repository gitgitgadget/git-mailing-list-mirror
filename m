From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: git pull w/o checkout?
Date: Thu, 22 Jun 2006 08:20:51 -0500
Message-ID: <6C519A4B-9253-49BB-BF68-DCD557DACCB7@kernel.crashing.org>
References: <E65F8DB5-677B-4C7B-A4EC-5F6FB76D6E9A@kernel.crashing.org> <20060622131129.GB5134@spinlock.ch> <6F96D77C-FE27-4B74-ADBF-9964B5FD72DF@kernel.crashing.org> <20060622131730.GB7168@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 15:21:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtP7U-0005x9-8I
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 15:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161111AbWFVNU4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 09:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161110AbWFVNU4
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 09:20:56 -0400
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:17725 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1161111AbWFVNUz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 09:20:55 -0400
Received: from cpe-66-69-212-100.austin.res.rr.com ([66.69.212.100] helo=[192.168.1.100])
	by nommos.sslcatacombnetworking.com with esmtp (Exim 4.52)
	id 1FtP77-0005wS-O7; Thu, 22 Jun 2006 08:20:53 -0500
In-Reply-To: <20060622131730.GB7168@coredump.intra.peff.net>
To: Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.750)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22336>


On Jun 22, 2006, at 8:17 AM, Jeff King wrote:

> On Thu, Jun 22, 2006 at 08:13:54AM -0500, Kumar Gala wrote:
>
>> that's what I want, however fetch isn't updating any refs/ as far as
>> I can tell.
>
> It won't update the ref for the branch you're on; it will update the
> head for the remotes (try running git-show-branch before and after  
> your
> fetch, and you should see an update on 'origin' or whatever remote
> you're fetching).

Ahh, I see.  I can than just copy the 'origin' ref over 'master'.

thanks

- kumar
