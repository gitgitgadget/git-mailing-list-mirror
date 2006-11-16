X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Anand Kumria" <wildfire@progsoc.org>
Subject: Re: [PATCH] git-checkout: allow pathspec to recover lost working
 tree directory
Date: Thu, 16 Nov 2006 01:17:15 +0000 (UTC)
Message-ID: <ejge6q$bm7$1@sea.gmane.org>
References: <7vbqn8msuw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
NNTP-Posting-Date: Thu, 16 Nov 2006 01:17:35 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 18
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 88-110-175-230.dynamic.dsl.as9105.com
User-Agent: pan 0.117 (We'll fly and we'll fall and we'll burn)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31536>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkVsf-0001O8-PC for gcvg-git@gmane.org; Thu, 16 Nov
 2006 02:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162143AbWKPBR0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 20:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162148AbWKPBR0
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 20:17:26 -0500
Received: from main.gmane.org ([80.91.229.2]:47080 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1162143AbWKPBRZ (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 20:17:25 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GkVsa-0001N7-LF for git@vger.kernel.org; Thu, 16 Nov 2006 02:17:24 +0100
Received: from 88-110-175-230.dynamic.dsl.as9105.com ([88.110.175.230]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 16 Nov 2006 02:17:24 +0100
Received: from wildfire by 88-110-175-230.dynamic.dsl.as9105.com with local
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 16
 Nov 2006 02:17:24 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wed, 15 Nov 2006 11:07:19 -0800, Junio C Hamano wrote:

> It is often wanted on the #git channel that this were to work to
> recover removed directory:
> 
> 	rm -fr Documentation
> 	git checkout -- Documentation
> 	git checkout HEAD -- Documentation ;# alternatively
> 
> Now it does.

One thing I often seem to do is make some changes, test them out and
remove the file if it wa a dead end and get my original back with
'cg-restore <file>'. Does this mean that the git equivalent will be 'git
checkout -- <file>' as well?

Thanks,
Anand
