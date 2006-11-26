X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Christian Thaeter <ct@pipapo.org>
Subject: Re: handling symlinks proposal
Date: Sun, 26 Nov 2006 20:50:01 +0100
Message-ID: <4569EFE9.6010101@pipapo.org>
References: <4569C7F8.4030303@pipapo.org> <Pine.LNX.4.64.0611261034100.3483@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 26 Nov 2006 19:50:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Icedove 1.5.0.7 (X11/20061013)
In-Reply-To: <Pine.LNX.4.64.0611261034100.3483@woody.osdl.org>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32364>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoQ14-0001Ua-7K for gcvg-git@gmane.org; Sun, 26 Nov
 2006 20:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756935AbWKZTuG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 14:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756965AbWKZTuG
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 14:50:06 -0500
Received: from pipapo.org ([217.140.77.75]:47120 "EHLO mail.pipapo.org") by
 vger.kernel.org with ESMTP id S1756961AbWKZTuE (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 14:50:04 -0500
Received: from [10.20.40.100] (unknown [10.20.40.100]) by mail.pipapo.org
 (Postfix) with ESMTP id B48AD127AAD; Sun, 26 Nov 2006 20:50:02 +0100 (CET)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 26 Nov 2006, Christian Thaeter wrote:
>> Git currently keep symlinks always as symlink, I would like to see some
>> optional functionality when handling symlinks.
> 
> I can pretty much guarantee that you really don't want to do this, and 
> that you'd be _much_ happier using some explicit wrappers around git to 
> handle your special needs, than try to teach the SCM to handle symlinks 
> specially.

ok agreed, i'll write some script which one can use on a tree to
sanitize symlinks on given rules and/or be used as a pre-commit check.
That has the pretty same effect for my needs and is more sane like you
outlined.

