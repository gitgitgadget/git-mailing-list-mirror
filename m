X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: Re: latest git and git.kernel.org
Date: Fri, 27 Oct 2006 14:33:25 +0530
Message-ID: <4541CB5D.1000007@gmail.com>
References: <ehqvgs$sla$1@sea.gmane.org> <4541C123.8000203@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 27 Oct 2006 09:03:46 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=EDHBx19C8ROGSMje224O6dvIusd3khNnyLARdq1ePYDnQsbAJac7AB4Q0BXz2F8e00OUMMX7wmgYp9XSWv/oUcJGAQenSYaWCA+Pw5agY+VymLL0mNR+BDF/sIDxK8TBHSgVqLJTXdF9tgn02pm6iN9T6IvRCHKHpNanGTukhwo=
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
In-Reply-To: <4541C123.8000203@op5.se>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30313>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdNco-0002BS-H9 for gcvg-git@gmane.org; Fri, 27 Oct
 2006 11:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946247AbWJ0JDg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 05:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946251AbWJ0JDg
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 05:03:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:8644 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1946247AbWJ0JDf
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 05:03:35 -0400
Received: by ug-out-1314.google.com with SMTP id 32so626768ugm for
 <git@vger.kernel.org>; Fri, 27 Oct 2006 02:03:34 -0700 (PDT)
Received: by 10.78.151.15 with SMTP id y15mr4545329hud; Fri, 27 Oct 2006
 02:03:33 -0700 (PDT)
Received: from ?217.108.227.183? ( [156.153.255.234]) by mx.google.com with
 ESMTP id 39sm403284hug.2006.10.27.02.03.30; Fri, 27 Oct 2006 02:03:32 -0700
 (PDT)
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

Andreas Ericsson wrote:
> Aneesh Kumar K.V wrote:
>> I am getting lot of errors with git.kernel.org in the last few days. 
>> Is it something to do with the latest git client that i am using or 
>> due to issues with git.kernel.org ?
>>
> 
> I'm seeing the same, but only against git.kernel.org. repo.or.cz works 
> fine for my, so I've switched to pulling the git repo from there 
> instead. I guess this is an enforced resource policy on kernel.org. I 
> believe the inetd rules there have limits on how many concurrent 
> connections it allows the git-daemon to handle. For example, I often get 
> to pull the actual objects, but it then fails to fetch the tags because 
> of "Unexpected EOF. Connection closed" thingie.
> 


That means i need to find mirrors for kernel and git. Any list available some where regarding these repositories.
For the time being i switched to repo.or.cz 

