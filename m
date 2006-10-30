X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: how to ignore merge conflicts?
Date: Mon, 30 Oct 2006 21:06:00 +0100
Organization: At home
Message-ID: <ei5lv0$2jv$1@sea.gmane.org>
References: <200610301448.38222.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Mon, 30 Oct 2006 20:34:04 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 22
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-116.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30518>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GedgW-0000we-0H for gcvg-git@gmane.org; Mon, 30 Oct
 2006 21:24:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751968AbWJ3UYd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 15:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbWJ3UYd
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 15:24:33 -0500
Received: from main.gmane.org ([80.91.229.2]:52971 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1751968AbWJ3UYc (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 15:24:32 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GedYN-0007B6-CY for git@vger.kernel.org; Mon, 30 Oct 2006 21:16:15 +0100
Received: from host-81-190-18-116.torun.mm.pl ([81.190.18.116]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 30 Oct 2006 21:16:15 +0100
Received: from jnareb by host-81-190-18-116.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 30 Oct 2006
 21:16:15 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Len Brown wrote:

> Sometimes when a multiple-file merge give conflicts, I don't want to edit
> one of the resulting <<<<<=====>>>>> files.
> Instead, I just want to choose the version of that particular file that
> existed in one of the two merged branches and commit that along with
> the rest of the merge.
> 
> How to do this?

$ git cat-file -p :<n>:<filename> > <filename>
$ git update-index <filename>

where <n> is one of stages, 1 or 2 to choose one branch version if I
remember correctly. Check out documentation.

Or just use 'ours' as merge strategy...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

