X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Steven Grimm <koreth@midwinter.com>
Subject: Re: git and bzr
Date: Thu, 30 Nov 2006 01:39:59 -0800
Message-ID: <456EA6EF.4000104@midwinter.com>
References: <45357CC3.4040507@utoronto.ca> <456E8147.9070304@gmx.net> <fcaeb9bf0611300101s51a53b75lc7e771b067ba6e33@mail.gmail.com> <200611300930.33537.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 09:40:09 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Macintosh/20061025)
In-Reply-To: <200611300930.33537.alan@chandlerfamily.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32715>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpiOZ-0001EN-Q3 for gcvg-git@gmane.org; Thu, 30 Nov
 2006 10:39:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933390AbWK3Jjx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 04:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933351AbWK3Jjw
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 04:39:52 -0500
Received: from tater.midwinter.com ([216.32.86.90]:39332 "HELO
 midwinter.com") by vger.kernel.org with SMTP id S933390AbWK3Jjw (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 04:39:52 -0500
Received: (qmail 11944 invoked from network); 30 Nov 2006 09:39:51 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.128?)
 (koreth@76.21.17.123) by tater.midwinter.com with SMTP; 30 Nov 2006 09:39:51
 -0000
To: Alan Chandler <alan@chandlerfamily.org.uk>
Sender: git-owner@vger.kernel.org

Alan Chandler wrote:
> No you won't.   
>
> If you don't use update-index, then index will match HEAD and you will commit 
> changes in the working tree.  That is the way for newbies
>
> As soon as you do the first update-index the index will no longer match HEAD, 
> so commit will do the same as it does now.
>
> And if you are not sure which you have done then presumably you do what you do 
> now, or git commit -a or git commit -i as you need.

Plus, one assumes, the git-generated comments in the commit message will 
tell you what kind of commit it has decided to do.

I like this suggestion a lot. Thinking back over my git usage recently, 
which has included both styles of commits (though mostly -a ones), I 
think this would have done the right thing by default in every case.

