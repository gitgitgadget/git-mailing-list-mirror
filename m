X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git on cygwin
Date: Sat, 25 Nov 2006 15:58:51 +0100
Organization: At home
Message-ID: <ek9lkc$ahf$1@sea.gmane.org>
References: <4568555F.8050500@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sat, 25 Nov 2006 14:57:54 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 20
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32292>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnyyK-0001tI-8z for gcvg-git@gmane.org; Sat, 25 Nov
 2006 15:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966606AbWKYO5h (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 09:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966610AbWKYO5h
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 09:57:37 -0500
Received: from main.gmane.org ([80.91.229.2]:29650 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S966606AbWKYO5g (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 09:57:36 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gnyy6-0001pl-AV for git@vger.kernel.org; Sat, 25 Nov 2006 15:57:26 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 25 Nov 2006 15:57:26 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 25 Nov 2006
 15:57:26 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Eric Blake wrote:

> I found the following patch useful for building git 1.4.4.1 on cygwin.  As
> of cygwin-1.5.22, C99 format strings are now supported (since I
> contributed the newlib patch that added them).  As of cygwin-1.5.21, d_ino
> is now reliable for all cygwin filesystem accesses (except for some remote
> NetApp drives, which have been fixed in cygwin CVS).  And while it is true
> that native Windows does not support symlinks, making NO_SYMLINK_HEAD a
> good idea for native builds; this is not the case for cygwin, and I did
> not seem to have any problems with removing it, either.

By the way, does ./configure script (make configure && ./configure)
detect this correctly?

BTW. symlink HEAD is considered obsolete.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

