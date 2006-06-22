From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: git pull w/o checkout?
Date: Thu, 22 Jun 2006 08:13:54 -0500
Message-ID: <6F96D77C-FE27-4B74-ADBF-9964B5FD72DF@kernel.crashing.org>
References: <E65F8DB5-677B-4C7B-A4EC-5F6FB76D6E9A@kernel.crashing.org> <20060622131129.GB5134@spinlock.ch>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 15:15:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtP0d-00048g-3e
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 15:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161100AbWFVNN7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 09:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161101AbWFVNN6
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 09:13:58 -0400
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:46140 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1161100AbWFVNN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 09:13:58 -0400
Received: from cpe-66-69-212-100.austin.res.rr.com ([66.69.212.100] helo=[192.168.1.100])
	by nommos.sslcatacombnetworking.com with esmtp (Exim 4.52)
	id 1FtP0P-0003wk-3i; Thu, 22 Jun 2006 08:13:57 -0500
In-Reply-To: <20060622131129.GB5134@spinlock.ch>
To: Matthias Kestenholz <lists@spinlock.ch>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22332>


On Jun 22, 2006, at 8:11 AM, Matthias Kestenholz wrote:

> * Kumar Gala (galak@kernel.crashing.org) wrote:
>> I trying to see if there is a way to get the effect of a git-pull w/o
>> getting the checked out files.
>>
>> Any ideas?
>
> Do you want to fetch remote changes without merging them into your
> working tree? If you, "git fetch" is your friend.

that's what I want, however fetch isn't updating any refs/ as far as  
I can tell.

> By the way, pull does the equivalent of a fetch and a subsequent
> merge.

right, its the merge that seems to be doing the checkout.

- k
