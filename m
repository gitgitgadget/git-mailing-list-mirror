X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Show remote branches on gitweb
Date: Tue, 28 Nov 2006 16:14:39 +0100
Organization: At home
Message-ID: <ekhjlo$jv0$1@sea.gmane.org>
References: <loom.20061124T210559-701@post.gmane.org> <ek7jsp$j83$1@sea.gmane.org> <ek7m6m$qqd$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 28 Nov 2006 15:14:57 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 29
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32533>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp4f2-00039g-M5 for gcvg-git@gmane.org; Tue, 28 Nov
 2006 16:14:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758684AbWK1POO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 10:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758685AbWK1PON
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 10:14:13 -0500
Received: from main.gmane.org ([80.91.229.2]:36569 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1758684AbWK1PON (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 10:14:13 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gp4dz-0002op-88 for git@vger.kernel.org; Tue, 28 Nov 2006 16:13:11 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 16:13:11 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 28 Nov 2006
 16:13:11 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:

> Jakub Narebski wrote:
> 
>> Pazu wrote:
>> 
>>> Is there any way to do it? I'm using git-svn to track a remote subversion
>>> repository, and it would be very nice to browse the history for a remote branch
>>> for which I didn't start a local branch yet.
>> 
>> Planned, not implemented yet.
> 
> The problem is that to implement it _well_ we have to get remotes, both
> $GIT_DIR/remotes and config remote.xxx, info. And the latter (config
> remotes info) needs config parsing, something we lack.

We could simplify things, and assume that remote name is _never_
hierarchical, so that remote branches names are:
  remotes/<remote>/<branch>
where <remote> does not contain '/'.

Additional problem is for "summary" view: should we limit number of heads
per remote, should we sort heads inside remote, or should we also sort
remotes, or should we sort remotes by time without grouping into repos?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

