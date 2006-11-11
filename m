X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: StGIT repository not clonable?
Date: Sat, 11 Nov 2006 23:48:04 +0100
Organization: At home
Message-ID: <ej5jt1$9tf$1@sea.gmane.org>
References: <200611110359.kAB3ul02013227@laptop13.inf.utfsm.cl> <20061111123634.GD11224@diana.vm.bytemark.co.uk> <b0943d9e0611111359t994d688w9bc6aae8e9183fd3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sat, 11 Nov 2006 22:47:20 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 14
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31245>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gj1d4-000209-K0 for gcvg-git@gmane.org; Sat, 11 Nov
 2006 23:47:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754889AbWKKWrK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006
 17:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754888AbWKKWrJ
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 17:47:09 -0500
Received: from main.gmane.org ([80.91.229.2]:28370 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1754889AbWKKWrI (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006 17:47:08 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gj1cu-0001yv-Im for git@vger.kernel.org; Sat, 11 Nov 2006 23:47:04 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 11 Nov 2006 23:47:04 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 11 Nov 2006
 23:47:04 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Catalin Marinas wrote:

> IIRC, there was some advise in some GIT document
> or e-mail saying that you shouldn't pack if the export is over a dumb
> protocol. That's good for people pulling regularly but bad for
> cloning.

By the way, does dumb protocols download _whole_ packs only? Or do they
download parts of packs (curl can do that, I think)?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

