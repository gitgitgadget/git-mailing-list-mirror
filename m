X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Bash completion Issue?
Date: Sun, 05 Nov 2006 12:45:14 +0100
Organization: At home
Message-ID: <eikirg$772$1@sea.gmane.org>
References: <200611041236.59989.alan@chandlerfamily.org.uk> <20061105042849.GA3840@spearce.org> <200611050930.23455.alan@chandlerfamily.org.uk> <200611051122.46971.alan@chandlerfamily.org.uk> <20061105113115.GC4843@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sun, 5 Nov 2006 11:45:33 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 26
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30974>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GggRF-0003b3-MD for gcvg-git@gmane.org; Sun, 05 Nov
 2006 12:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932669AbWKELpS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 06:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932671AbWKELpS
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 06:45:18 -0500
Received: from main.gmane.org ([80.91.229.2]:62695 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S932669AbWKELpQ (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 06:45:16 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GggQs-0003W8-Ja for git@vger.kernel.org; Sun, 05 Nov 2006 12:44:58 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 05 Nov 2006 12:44:58 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 05 Nov 2006
 12:44:58 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Shawn Pearce wrote:

> Alan Chandler <alan@chandlerfamily.org.uk> wrote:
>>  removing the git-completion package and copying the bash completion script 
>> from /usr/share/doc/git-core/contrib/completion to /etc/bash_completion.d 
>> solves the problem.  I am getting completion working fine now.
> 
> Good.  :-)
> 
> Let us know if there's anything you'd like to see in the bash
> completion...  I just sent out two rounds of patches for it, but
> certainly still have more work to do on it.

I'd like to see completion for git-format-patch, git-cherry-pick
and git-rebase. I tried to start doing completion for git-format-patch,
but realized that I don't know bash, and bash completion enough for that.

While at it, do git-completion.bash takes into consideration that
some commands doesn't accept branch which is current branch.

Otherwise, I find git-completion for bash very useful.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

