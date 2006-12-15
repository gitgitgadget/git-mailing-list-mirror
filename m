X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git fetch slow as molasses due to tag downloading
Date: Fri, 15 Dec 2006 10:58:54 +0100
Organization: At home
Message-ID: <eltrg8$b4q$2@sea.gmane.org>
References: <elrr8j$a02$1@sea.gmane.org> <Pine.LNX.4.63.0612141701440.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 15 Dec 2006 10:00:25 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 12
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34486>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv9ra-0000pe-Fw for gcvg-git@gmane.org; Fri, 15 Dec
 2006 11:00:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751401AbWLOKAL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 05:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWLOKAL
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 05:00:11 -0500
Received: from main.gmane.org ([80.91.229.2]:54081 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751401AbWLOKAJ
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006 05:00:09 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1Gv9rG-00005i-5z for git@vger.kernel.org; Fri, 15 Dec 2006 11:00:02 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 11:00:02 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 15 Dec 2006
 11:00:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:

> IMHO this should be solved as a filter: "git-show-ref --stdin 
> --show-invalid". Thus, git does not have to traverse _every_ ref for 
> _every_ incoming tag.

Can you make it so? TIA.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

