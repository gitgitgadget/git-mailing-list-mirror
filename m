X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Teach git-branch howto rename a branch
Date: Tue, 28 Nov 2006 09:07:37 +0100
Organization: At home
Message-ID: <ekgqku$tqt$1@sea.gmane.org>
References: <1164679287192-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 28 Nov 2006 08:06:17 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 21
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32494>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Goxyj-0003yH-Cs for gcvg-git@gmane.org; Tue, 28 Nov
 2006 09:06:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935766AbWK1IGF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 03:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935768AbWK1IGF
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 03:06:05 -0500
Received: from main.gmane.org ([80.91.229.2]:3970 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S935766AbWK1IGC (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 03:06:02 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Goxyb-0003wm-7H for git@vger.kernel.org; Tue, 28 Nov 2006 09:06:01 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 09:06:01 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 28 Nov 2006
 09:06:01 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Lars Hjemli wrote:

> This adds a '--rename' option to git branch. If specified, branch
> creation becomes branch renaming.
> 
> With a single branchname, the current branch is renamed and .git/HEAD is
> updated.
> 
> With two branchnames, the second name is renamed to the first.

Could you please document this new feature?

And wouldn't it be better to use <source> <target>, aka <branch> <newname>
like in git-mv and other rename/move commands? "Second name is renamed to
the first" although fits with "<branchname> [<start-point>]" is not natural
for rename.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

