X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 15:04:42 +1300
Message-ID: <456E3C3A.6050807@vilain.net>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home>	<7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net>	<87bqmswm1e.wl%cworth@cworth.org>	<7vodqse90q.fsf@assigned-by-dhcp.cox.net>	<87ac2cwha4.wl%cworth@cworth.org>	<7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net>	<878xhwwdyj.wl%cworth@cworth.org>	<7vk61gcnzl.fsf@assigned-by-dhcp.cox.net>	<7vd5786opj.fsf@assigned-by-dhcp.cox.net>	<871wnnwi3k.wl%cworth@cworth.org>	<7virgzuf38.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0611282322320.9647@xanadu.home>	<7vr6vmsnly.fsf@assigned-by-dhcp.cox.net>	<87ejrlvn7r.wl%cworth@cworth.org>	<7vodqpn3t4.fsf@assigned-by-dhcp.cox.net> <7vk61dn2yj.fsf@assigned-by-dhcp.cox.net> <456E3AB7.1030306@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 02:05:12 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.2 (X11/20060521)
In-Reply-To: <456E3AB7.1030306@midwinter.com>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32695>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpbIF-00023H-A1 for gcvg-git@gmane.org; Thu, 30 Nov
 2006 03:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933283AbWK3CEw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 21:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934632AbWK3CEw
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 21:04:52 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:29339 "EHLO
 magnus.utsl.gen.nz") by vger.kernel.org with ESMTP id S933283AbWK3CEv (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 21:04:51 -0500
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534) id 6F06F139AED;
 Thu, 30 Nov 2006 15:04:49 +1300 (NZDT)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7]) (using
 TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by magnus.utsl.gen.nz (Postfix) with ESMTP id 68EF0139AEB; Thu, 30
 Nov 2006 15:04:45 +1300 (NZDT)
To: Steven Grimm <koreth@midwinter.com>
Sender: git-owner@vger.kernel.org

Steven Grimm wrote:
> Am I missing some magic index command that would support multi-level 
> backing out? Obviously StGIT is an option as well, but that seems like 
> overkill when all I want is to checkpoint my work. The above is why, 
> even though (I think) I know enough about the index to use it as you 
> describe, I often don't bother and just run "commit -a" during 
> development instead. When I merge, I usually fold all my checkpoint 
> commits together and merge the change as a logical unit.
>   

Try `git commit --amend'.

