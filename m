X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: David Lang <dlang@digitalinsight.com>
Subject: Re: What's in git.git
Date: Tue, 7 Nov 2006 20:13:10 -0800 (PST)
Message-ID: <Pine.LNX.4.63.0611072009220.2601@qynat.qvtvafvgr.pbz>
References: <7v8ximwrm3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
NNTP-Posting-Date: Wed, 8 Nov 2006 04:18:41 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <7v8ximwrm3.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31113>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhetY-0008Cl-KN for gcvg-git@gmane.org; Wed, 08 Nov
 2006 05:18:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754196AbWKHESV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 23:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754178AbWKHESV
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 23:18:21 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:29438 "HELO
 warden.diginsite.com") by vger.kernel.org with SMTP id S1754196AbWKHESU
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 23:18:20 -0500
Received: from wlvims02.diginsite.com by warden.diginsite.com via smtpd (for
 vger.kernel.org [209.132.176.167]) with SMTP; Tue, 7 Nov 2006 20:18:20 -0800
Received: from dlang.diginsite.com ([10.201.10.67]) by
 wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Tue, 07
 Nov 2006 20:18:14 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Tue, 7 Nov 2006, Junio C Hamano wrote:

> [pu]
>
>  Johannes's shallow clone work now should rebase cleanly on top
>  of 'master' although I haven't done so yet.  As he said
>  himself the series is waiting for people who have needs for
>  such a feature to raise hands.

I haven't been watching this recently, but if this is what I understand it to be 
(the ability to get a partial repository from upstream and work normally from 
there with the result of data-mineing tools sometimes reporting 'that's part of 
the truncated history' if they hit the cutoff) consider my hand raised.

there are a number of cases where I would be interested in following a project 
as it moves forwards, but do not have the need to have the full history (even 
with the good compression that a git pack provides, it's still a significant 
amount of disk space and download time for large projects)

