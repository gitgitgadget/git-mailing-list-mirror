X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: bug: git-sh-setup should not be in $PATH
Date: Wed, 06 Dec 2006 13:56:06 +0100
Organization: At home
Message-ID: <el6eh6$vg7$2@sea.gmane.org>
References: <el6c6o$oa7$1@sea.gmane.org> <Pine.LNX.4.63.0612061322140.28348@wbgn013.biozentrum.uni-wuerzburg.de> <4576B8BC.8040107@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 6 Dec 2006 12:55:29 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 12
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33450>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrwJ5-00051P-EN for gcvg-git@gmane.org; Wed, 06 Dec
 2006 13:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760569AbWLFMzZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 07:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760575AbWLFMzY
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 07:55:24 -0500
Received: from main.gmane.org ([80.91.229.2]:33302 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1760569AbWLFMzY
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 07:55:24 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1GrwIg-0006sq-4A for git@vger.kernel.org; Wed, 06 Dec 2006 13:55:02 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 13:55:02 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 06 Dec 2006
 13:55:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys wrote:

> Subject: [PATCH] Install git-sh-setup.sh into $(prefix)/share/git-core. Call with explicit path.

I like it... but could you check if you don't need to change
config.mak.in accordingly for ./configure script to generate proper
config.mak.autogen?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

