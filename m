X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: binary patch compatibility
Date: Wed, 01 Nov 2006 22:10:11 +0100
Organization: At home
Message-ID: <eib2ev$ga7$1@sea.gmane.org>
References: <4b73d43f0611011303m3e58b227x1a0bd60a9719f9f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 1 Nov 2006 21:11:01 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 16
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-116.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30658>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfNM0-0002et-Lr for gcvg-git@gmane.org; Wed, 01 Nov
 2006 22:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752416AbWKAVK3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 16:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752418AbWKAVK3
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 16:10:29 -0500
Received: from main.gmane.org ([80.91.229.2]:30691 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1752415AbWKAVK2 (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 16:10:28 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GfNLc-0002Zd-Pt for git@vger.kernel.org; Wed, 01 Nov 2006 22:10:09 +0100
Received: from host-81-190-18-116.torun.mm.pl ([81.190.18.116]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 01 Nov 2006 22:10:08 +0100
Received: from jnareb by host-81-190-18-116.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 01 Nov 2006
 22:10:08 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

John Rigby wrote:

> If I commit a new binary file to a repository and then use
> git-format-patch --binary to produce a patch the resulting patch file
> is not compatible with the patch command.
> 
> Am I doing something wrong or is this not possible.

GNU patch doesn't understand git binary patch. git-apply does (as does
git-am). There is no universal binary diff format.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

