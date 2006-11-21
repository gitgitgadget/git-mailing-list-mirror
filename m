X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Stupid Git question
Date: Tue, 21 Nov 2006 22:49:21 +0100
Organization: At home
Message-ID: <ejvs65$vo8$1@sea.gmane.org>
References: <89b129c60611211331r3bb286b6re3c2c8f65ec3896f@mail.gmail.com> <89b129c60611211341j71079633g53b0ec1d2e3193a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 21 Nov 2006 21:48:34 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 18
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32041>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmdTX-00078f-B6 for gcvg-git@gmane.org; Tue, 21 Nov
 2006 22:48:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161383AbWKUVsP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 16:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161393AbWKUVsO
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 16:48:14 -0500
Received: from main.gmane.org ([80.91.229.2]:65458 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1161383AbWKUVsO (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 16:48:14 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GmdTF-00074R-RR for git@vger.kernel.org; Tue, 21 Nov 2006 22:48:02 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 21 Nov 2006 22:48:01 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 21 Nov 2006
 22:48:01 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Sean Kelley wrote:

> git checkout origin

It should be "git checkout master". You shouldn't do work on tracking
branches like origin branch.

> git pull . fm-modulator
> 
> git push origin

Here origin means origin remote (repository). Check out what you have in
remotes/origin, or in [remote "origin"] section in git config.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

