X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] git-svn: fix dcommit losing changes when out-of-date
 from svn
Date: Thu, 09 Nov 2006 14:37:03 -0800
Message-ID: <4553AD8F.2050603@midwinter.com>
References: <455277A6.2000404@midwinter.com> <20061109091937.GA22853@localdomain> <7vfyctkki5.fsf@assigned-by-dhcp.cox.net> <455381C7.8080207@midwinter.com> <20061109204759.GA8560@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 9 Nov 2006 22:37:27 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=AGCBSCkqMpKpaEEi32U9yvBh9STRQLeCVmWY/vzgraH5ILLty0QLOUW1l42WCtpC  ;
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
In-Reply-To: <20061109204759.GA8560@localdomain>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31203>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GiIWR-0000XN-GQ for gcvg-git@gmane.org; Thu, 09 Nov
 2006 23:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424206AbWKIWhR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 9 Nov 2006
 17:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424207AbWKIWhR
 (ORCPT <rfc822;git-outgoing>); Thu, 9 Nov 2006 17:37:17 -0500
Received: from tater.midwinter.com ([216.32.86.90]:29113 "HELO
 midwinter.com") by vger.kernel.org with SMTP id S1424206AbWKIWhP (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 9 Nov 2006 17:37:15 -0500
Received: (qmail 17689 invoked from network); 9 Nov 2006 22:37:15 -0000
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1) by localhost
 with SMTP; 9 Nov 2006 22:37:15 -0000
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

Eric Wong wrote:
> The commit runs as a transaction on the server-side, where all the real
> locking occurs.  SVN supports user-side locking (svn lock), but it is
> only advisory and can be taken/unlocked by other users
> (svn lock/unlock --force).
>   

Great, that sounds convincing to me. Thanks for such a quick turnaround 
on this fix!

-Steve
