X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-format-patch little gripe
Date: Fri, 03 Nov 2006 18:51:04 +0100
Organization: At home
Message-ID: <eifvhc$u59$1@sea.gmane.org>
References: <46a038f90611030122reecee87ufac5bbaa910ee933@mail.gmail.com> <511753.217.qm@web31807.mail.mud.yahoo.com> <7vwt6cbwzq.fsf@assigned-by-dhcp.cox.net> <87y7qsv3l7.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 3 Nov 2006 17:52:24 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 19
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-116.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30870>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg3Cq-00044v-J1 for gcvg-git@gmane.org; Fri, 03 Nov
 2006 18:51:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753410AbWKCRvs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 12:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753409AbWKCRvs
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 12:51:48 -0500
Received: from main.gmane.org ([80.91.229.2]:56790 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1753411AbWKCRvr (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 12:51:47 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gg3CG-0003wZ-1Y for git@vger.kernel.org; Fri, 03 Nov 2006 18:51:16 +0100
Received: from host-81-190-18-116.torun.mm.pl ([81.190.18.116]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 03 Nov 2006 18:51:16 +0100
Received: from jnareb by host-81-190-18-116.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 03 Nov 2006
 18:51:16 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Carl Worth wrote:

> (We've currently got "git commit --amend" for example, but
> what I often want is "git goto old-commit; #hack; git commit --amend;
> git replay" or whatever, (in Stacked Git speak that is currently "stg
> goto old-commit; #hack; stg refresh; stg push --all").

<we are on branch 'top', and assume that branch 'tmp' does not exist>
$ git checkout -b tmp old-commit
#hack
$ git commit --amend
$ git rebase --onto tmp old-commit top
$ git branch -D tmp

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

