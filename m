X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git reset --soft a merged commit
Date: Mon, 06 Nov 2006 10:01:44 +0100
Organization: At home
Message-ID: <eimtkj$bkv$1@sea.gmane.org>
References: <fcaeb9bf0611052048r11816e76p88d568e3478c354b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Mon, 6 Nov 2006 09:02:07 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 19
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31002>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gh0MZ-0001jq-UQ for gcvg-git@gmane.org; Mon, 06 Nov
 2006 10:01:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161208AbWKFJBs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 04:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161721AbWKFJBs
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 04:01:48 -0500
Received: from main.gmane.org ([80.91.229.2]:2258 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1161208AbWKFJBr (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 04:01:47 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gh0MC-0001ei-C3 for git@vger.kernel.org; Mon, 06 Nov 2006 10:01:28 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 06 Nov 2006 10:01:28 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 06 Nov 2006
 10:01:28 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Nguyen Thai Ngoc Duy wrote:

> I did "git reset --soft HEAD~1" where HEAD is a merged commit and
> committed again (nothing changed).  The new commit was not recorded as
> a merged commit. Is it intentional?

Yes, you have chosen to go back to 1st parent. The information about other
parents got lost.

If you want to correct commit, even if it is merge commit, use
  git commit --amend
instead.

Or you can muck with MERGE_HEAD instead.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

