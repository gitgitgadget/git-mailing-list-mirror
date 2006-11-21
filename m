X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Is there a way to trim old SHAs from a git tree (so it's not so large)?
Date: Wed, 22 Nov 2006 00:22:41 +0100
Organization: At home
Message-ID: <ek01l3$ihf$1@sea.gmane.org>
References: <455B90AD.3060707@freescale.com> <20061117103611.183640@gmx.net> <45632957.5070205@freescale.com> <20061121163206.GA22006@spearce.org> <45632EC6.5030902@freescale.com> <20061121165656.GC22006@spearce.org> <456330CD.9080503@freescale.com> <20061121183941.GB22283@spearce.org> <45637457.1010505@freescale.com> <Pine.LNX.4.63.0611212306060.26827@wbgn013.biozentrum.uni-wuerzburg.de> <45638212.8030501@freescale.com> <Pine.LNX.4.63.0611212349440.26827@wbgn013.biozentrum.uni-wuerzburg.de> <456387D5.9080407@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 21 Nov 2006 23:21:49 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 15
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32057>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gmevr-0004RL-SB for gcvg-git@gmane.org; Wed, 22 Nov
 2006 00:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754887AbWKUXVd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 18:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755483AbWKUXVd
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 18:21:33 -0500
Received: from main.gmane.org ([80.91.229.2]:23198 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1754887AbWKUXVc (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 18:21:32 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gmevi-0004Oz-97 for git@vger.kernel.org; Wed, 22 Nov 2006 00:21:30 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 22 Nov 2006 00:21:30 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 22 Nov 2006
 00:21:30 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Timur Tabi wrote:

> make configure
> ./configure --prefix=$PWD
> make

make configure
./configure --prefix=$PWD --bindir=$PWD
make

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

