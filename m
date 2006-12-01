X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Wink Saville <wink@saville.com>
Subject: Re: Resolving conflicts
Date: Thu, 30 Nov 2006 23:41:41 -0800
Message-ID: <456FDCB5.9040907@saville.com>
References: <456FD461.4080002@saville.com> <200612010730.25700.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 07:41:48 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
In-Reply-To: <200612010730.25700.alan@chandlerfamily.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32860>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq31g-0007gO-Oa for gcvg-git@gmane.org; Fri, 01 Dec
 2006 08:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935044AbWLAHlh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 02:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935053AbWLAHlh
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 02:41:37 -0500
Received: from 70-91-206-233-BusName-SFBA.hfc.comcastbusiness.net
 ([70.91.206.233]:10957 "EHLO saville.com") by vger.kernel.org with ESMTP id
 S935044AbWLAHlh (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006
 02:41:37 -0500
Received: from [192.168.0.52] (unknown [192.168.0.52]) by saville.com
 (Postfix) with ESMTP id 700F457A6F; Thu, 30 Nov 2006 23:37:40 -0800 (PST)
To: Alan Chandler <alan@chandlerfamily.org.uk>
Sender: git-owner@vger.kernel.org

Alan Chandler wrote:
> On Friday 01 December 2006 07:06, Wink Saville wrote:
> 
> Take a look in these two files - you should see conflict markers of the form
> <<<<<<<<<<<<<<<< 
> some content
> ================
> some other content
> 

That's what I thought but there isn't any "<<<<<" and git-diff also seems
to indicate no differences:

wink@winkc2d1:~/linux/linux-2.6$ git-diff kernel/fork.c
diff --cc kernel/fork.c
index d74b4a5,8cdd3e7..0000000
--- a/kernel/fork.c
+++ b/kernel/fork.c
wink@winkc2d1:~/linux/linux-2.6$


wink@winkc2d1:~/linux/linux-2.6$ git-diff kernel/spinlock.c
diff --cc kernel/spinlock.c
index f4d1718,2c6c2bf..0000000
--- a/kernel/spinlock.c
+++ b/kernel/spinlock.c
wink@winkc2d1:~/linux/linux-2.6$

Thanks,

