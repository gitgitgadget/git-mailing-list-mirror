X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Rocco Rutte <pdmef@gmx.net>
Subject: Re: If merging that is really fast forwarding creates new commit
Date: Mon, 6 Nov 2006 13:39:23 +0000
Organization: Berlin University of Technology
Message-ID: <20061106133923.GB1151@robert.daprodeges.fqdn.th-h.de>
References: <454EAEDB.8020909@gmail.com> <7vk629f6is.fsf@assigned-by-dhcp.cox.net> <454F31D7.1030202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
NNTP-Posting-Date: Mon, 6 Nov 2006 13:42:00 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1642131
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <454F31D7.1030202@gmail.com>
X-GnuPG-Key: http://user.cs.tu-berlin.de/~pdmef/rrutte.gpg
X-Blog: http://user.cs.tu-berlin.de/~pdmef/horst.cgi?o
X-System: robert (FreeBSD 6.2-PRERELEASE i386)
User-Agent: Mutt/1.5.13-pdmef (2006-10-30)
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31012>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gh4hd-0003fR-M9 for gcvg-git@gmane.org; Mon, 06 Nov
 2006 14:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753121AbWKFNjk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 08:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753129AbWKFNjk
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 08:39:40 -0500
Received: from mail.gmx.de ([213.165.64.20]:40836 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1753121AbWKFNjj (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 08:39:39 -0500
Received: (qmail invoked by alias); 06 Nov 2006 13:39:37 -0000
Received: from cable-62-117-26-126.cust.blue-cable.de (EHLO
 peter.daprodeges.fqdn.th-h.de) [62.117.26.126] by mail.gmx.net (mp010) with
 SMTP; 06 Nov 2006 14:39:37 +0100
Received: from robert.daprodeges.fqdn.th-h.de (robert.daprodeges.fqdn.th-h.de
 [192.168.0.113]) (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested) by peter.daprodeges.fqdn.th-h.de (Postfix)
 with ESMTP id 93FDD20F02 for <git@vger.kernel.org>; Mon,  6 Nov 2006 13:39:36
 +0000 (UTC)
Received: from robert.daprodeges.fqdn.th-h.de (robert.daprodeges.fqdn.th-h.de
 [192.168.0.113]) (using TLSv1 with cipher AES128-SHA (128/128 bits)) (No
 client certificate requested) by robert.daprodeges.fqdn.th-h.de (Postfix)
 with ESMTP id E59A233FF6 for <git@vger.kernel.org>; Mon,  6 Nov 2006 13:39:24
 +0000 (UTC)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

* Liu Yubao [06-11-06 21:00:07 +0800] wrote:

>Then, what bad *logical* problem will happen if a merging that is really a fast forwarding creates a new commit?

I don't know what you expect by "logical" nor if I get you right, but if 
fast-forward merge a branch to another one, both branches now have 
exactly the same hash. If you create a commit object for a fast-forward 
merge, both tip hashes not identical anymore... which is bad.

The identical hash important so that you really know they're identical 
and for future reference like ancestry.

   bye, Rocco
-- 
