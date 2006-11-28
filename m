X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 28 Nov 2006 11:38:41 -0600
Message-ID: <1164735520.4724.28.camel@cashmere.sps.mot.com>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net>
	 <200611281335.38728.andyparkins@gmail.com>
	 <20061128154434.GD28337@spearce.org>
	 <200611281629.08636.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 17:39:54 +0000 (UTC)
Cc: Git List <git@vger.kernel.org>, Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611281629.08636.andyparkins@gmail.com>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32554>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp6vZ-0001nW-3g for gcvg-git@gmane.org; Tue, 28 Nov
 2006 18:39:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935957AbWK1RjZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 12:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935962AbWK1RjZ
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 12:39:25 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:5337 "EHLO
 az33egw01.freescale.net") by vger.kernel.org with ESMTP id S935957AbWK1RjY
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 12:39:24 -0500
Received: from az33smr02.freescale.net (az33smr02.freescale.net
 [10.64.34.200]) by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
 kASHdMIN017992; Tue, 28 Nov 2006 10:39:22 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2]) by
 az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id kASHdLfb009216; Tue, 28
 Nov 2006 11:39:21 -0600 (CST)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

On Tue, 2006-11-28 at 10:29, Andy Parkins wrote:

> IMO, it should always be possible to take a submodule and work on it in 
> isolation - in an extreme case, by moving it out of the supermodule tree 
> entirely.

This seems to me to be tantamount to saying something like:

    We need a "recursively defined git repository" that
    is representable as a git repository.

That is, can the tree object be changed from containing
just "blob" and "tree" references to also having a new
"git" reference as well?

jdl

