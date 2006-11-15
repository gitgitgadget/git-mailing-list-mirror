X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git fetch --reference?
Date: Wed, 15 Nov 2006 02:04:00 +0100
Organization: At home
Message-ID: <ejdovj$drm$1@sea.gmane.org>
References: <f2b55d220611141638k5f4a0aeas1a43301e4b40bf59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 15 Nov 2006 01:03:26 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31399>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk9BM-0005dM-SK for gcvg-git@gmane.org; Wed, 15 Nov
 2006 02:03:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966592AbWKOBDO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 20:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966589AbWKOBDO
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 20:03:14 -0500
Received: from main.gmane.org ([80.91.229.2]:2516 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S966591AbWKOBDN (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 20:03:13 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gk9BA-0005ae-Dq for git@vger.kernel.org; Wed, 15 Nov 2006 02:03:04 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 15 Nov 2006 02:03:04 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 15 Nov 2006
 02:03:04 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Michael K. Edwards wrote:

> When setting up a working area for kernel integration for a new
> embedded target, I generally do a "git clone --reference" so that the
> new area has its own repository (and its own branch structure) but
> most of the blobs come from a local reference copy.  But now that I'm
> integrating bits from several non-trivially divergent trees (mtd-2.6,
> netdev-2.6, linux-2.6.16.y, etc.), it would be nice to avoid
> re-downloading blobs for these additional remote branches, which are
> also available in the local reference copy.  Is it feasible to
> implement "git fetch --reference" for this purpose?  Or is there a
> better way to manage this sort of integration effort?

All (I think) that --reference does is to create alternates file.
You can simply add another alternate before fetch.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

