X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Does pushing to git demon works ?
Date: Mon, 11 Dec 2006 10:38:27 +0100
Organization: At home
Message-ID: <elj8q6$32n$2@sea.gmane.org>
References: <200612111513.05752.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Mon, 11 Dec 2006 09:36:42 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 21
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33986>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GthaS-0007mq-35 for gcvg-git@gmane.org; Mon, 11 Dec
 2006 10:36:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762697AbWLKJgi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 04:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762702AbWLKJgi
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 04:36:38 -0500
Received: from main.gmane.org ([80.91.229.2]:55770 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1762697AbWLKJgg
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006 04:36:36 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gtha3-0001W7-JE for git@vger.kernel.org; Mon, 11 Dec 2006 10:36:19 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 10:36:15 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 11 Dec 2006
 10:36:15 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Alexander Litvinov wrote:

> I tried pushing [to git daemon] without success:

>$ git push
> fatal: unexpected EOF
> 
> What should I do to make it work ?

You cannot make it work. Git by design allow pushing only through
authenticated protocols. You can push via ssh+git:// and local,
you can push via http(s):// but you have to configure WebDAV, perhaps in the
future you would be able to push via ftp(s)://. The git:// and rsync://
protocols are read-only: you can fetch (pull) but you can't push.

P.S. Please send reply also to git mailing list
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

