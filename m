X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] Implement poor-man's submodule support in pre-commit hook
Date: Wed, 20 Dec 2006 12:59:58 +0100
Organization: At home
Message-ID: <emb8ev$egb$1@sea.gmane.org>
References: <200612200901.30584.andyparkins@gmail.com> <200612201008.49045.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 20 Dec 2006 11:57:56 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 18
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34920>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx04v-0008BL-Dz for gcvg-git@gmane.org; Wed, 20 Dec
 2006 12:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964956AbWLTL5m (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 06:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754627AbWLTL5m
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 06:57:42 -0500
Received: from main.gmane.org ([80.91.229.2]:45546 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1754453AbWLTL5l
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006 06:57:41 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gx04h-0007OG-VM for git@vger.kernel.org; Wed, 20 Dec 2006 12:57:31 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 20 Dec 2006 12:57:31 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 20 Dec 2006
 12:57:31 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:

> Help...
> 
>> +if [ -f .gitmodules ]; then
> 
> This doesn't work because git-commit is not necessarily in the root of the 
> working tree.  How do I safely get that root?  While ${GIT_DIR}/.. would work 
> it is not guaranteed.

Do you want "git rev-parse --show-prefix" or "git rev-parse --show-cdup",
or "git rev-parse --git-dir" perhaps? (Although here rev in rev-parse is
misnomer).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

