X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Wink Saville <wink@saville.com>
Subject: Re: how-to "backup" a repository
Date: Sun, 05 Nov 2006 22:13:19 -0800
Message-ID: <454ED27F.8060106@saville.com>
References: <454ECC23.6010503@saville.com> <20061106055224.GA23126@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 6 Nov 2006 06:13:26 +0000 (UTC)
Cc: git <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
In-Reply-To: <20061106055224.GA23126@spearce.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30996>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgxjW-0002Po-Rb for gcvg-git@gmane.org; Mon, 06 Nov
 2006 07:13:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423564AbWKFGNU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 01:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423568AbWKFGNU
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 01:13:20 -0500
Received: from 70-91-206-233-BusName-SFBA.hfc.comcastbusiness.net
 ([70.91.206.233]:16293 "EHLO saville.com") by vger.kernel.org with ESMTP id
 S1423564AbWKFGNT (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006
 01:13:19 -0500
Received: from [192.168.0.52] (unknown [192.168.0.52]) by saville.com
 (Postfix) with ESMTP id AE9E757A6F; Sun,  5 Nov 2006 22:10:05 -0800 (PST)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce wrote:
> Wink Saville <wink@saville.com> wrote:
>> I've been working with git for a little while, but still very
>> much a neophyte. One thing I'd like to do is be able to backup
>> my work on a server located on my network.
>>
>> Currently I have cloned the Linux 2.6 tree on my personal computer
>> and have been backing it up by tar'ing the subdirectory with the
>> cloned repository and then using scp to copy it to my server.
>>
>> I suspect there is a better way, probably using git itself:)
>>
>> How is the typically handled?
> 
> Create a remote (in .git/remotes) which refers to your backup
> location.  Then use 'git push' to push your branch(es) of
> interest to the backup.
> 

Shawn,

This sounds easy enough, but how-to "create a remote"?
I looked in .git/remotes and see origin which contains:

URL: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
Pull: refs/heads/master:refs/heads/origin

But where is the syntax defined?

Also, how do I setup git on my server so that it becomes a server?

Sorry for are naive questions, but looking at my git tree and
the Internet didn't turn up any obvious answers. Hopefully you can
point to the appropriate documents.

Thanks,

Wink

