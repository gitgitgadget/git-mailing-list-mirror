X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 22:41:41 +0100
Organization: At home
Message-ID: <eknj33$q2r$1@sea.gmane.org>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0611282322320.9647@xanadu.home>	<7vr6vmsnly.fsf@assigned-by-dhcp.cox.net>	<87ejrlvn7r.wl%cworth@cworth.org>	<7vodqpn3t4.fsf@assigned-by-dhcp.cox.net>	<7vk61dn2yj.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.63.0611300310520.30004@wbgn013.biozentrum.uni-wuerzburg.de>	<Pine.LNX.4.64.0611291859070.3513@woody.osdl.org>	<456EBBE7.8030404@op5.se>	<Pine.LNX.4.64.0611300749560.3513@woody.osdl.org>	<20061130164046.GB17715@thunk.org>	<Pine.LNX.4.64.0611300903080.3513@woody.osdl.org>	<Pine.LNX.4.64.0611301229290.9647@xanadu.home>	<87irgwu6e6.wl%cworth@cworth.org> <87hcwgu5t1.wl%cworth@cworth.org> <456F4E38.50001@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Thu, 30 Nov 2006 21:40:33 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 17
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32805>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gptdh-0002YK-PW for gcvg-git@gmane.org; Thu, 30 Nov
 2006 22:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967929AbWK3VkO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 16:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967930AbWK3VkO
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 16:40:14 -0500
Received: from main.gmane.org ([80.91.229.2]:62158 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S967929AbWK3VkL (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 16:40:11 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GptdO-0002TQ-9G for git@vger.kernel.org; Thu, 30 Nov 2006 22:39:58 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 22:39:58 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 30 Nov 2006
 22:39:58 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Robert Shearman wrote:

> Having the index exposed for even simple operations means that the user 
> has to initially learn three states instead of two. The worst thing 
> about the index is that it is a limbo state. The committed content is in 
> the history and can be viewed by gitk (and other tools that the user 
> will be introduced to later) and the working tree is exactly what the 
> user sees in their editor. Having a hidden state isn't very good from an 
> HCI point of view.

Index is accessible, just like committed contents. The fact that gitk, qgit,
git-gui doesn't display state of index is their limitation.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

