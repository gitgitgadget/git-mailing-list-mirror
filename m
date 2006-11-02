X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git and "dumb protocols"
Date: Thu, 02 Nov 2006 13:12:53 +0100
Organization: At home
Message-ID: <eicnbe$v6l$1@sea.gmane.org>
References: <vpqu01i16g8.fsf@ecrins.imag.fr> <20061102104848.GH20017@pasky.or.cz> <vpq4ptixdfj.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Thu, 2 Nov 2006 12:13:28 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30740>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfbRZ-0006bF-47 for gcvg-git@gmane.org; Thu, 02 Nov
 2006 13:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752149AbWKBMNJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 07:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752376AbWKBMNJ
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 07:13:09 -0500
Received: from main.gmane.org ([80.91.229.2]:61411 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1752324AbWKBMNG (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 07:13:06 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GfbRB-0006X0-C5 for git@vger.kernel.org; Thu, 02 Nov 2006 13:12:50 +0100
Received: from host-81-190-18-116.torun.mm.pl ([81.190.18.116]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 02 Nov 2006 13:12:49 +0100
Received: from jnareb by host-81-190-18-116.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 02 Nov 2006
 13:12:49 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Matthieu Moy wrote:

> I'll probably do, but my concern is broader than that. I like the
> ability to use almost any webhosting service for my revision control.
> GNU Arch was quite good at that, bzr is also (doesn't support webdav
> very well yet, but read-only-HTTP, sftp and ftp are there), so I'd
> like git to do the same.

Well, git can fetch (read) via http, https, ftp, sftp, rsync, git, ssh+git;
it can push via http(s) with WebDAV, and ssh+git (ssh+git meaning via ssh,
with git installed on the server side).

BTW. rsync is considered obsolete, and suitable only for initial cloning,
perhaps.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

