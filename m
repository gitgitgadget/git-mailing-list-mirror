X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Mitchell Blank Jr <mitch@sfgoth.com>
Subject: Re: [ANNOUNCE] gitfs pre-release 0.04
Date: Mon, 4 Dec 2006 12:03:49 -0800
Message-ID: <20061204200349.GX47959@gaz.sfgoth.com>
References: <20061204194011.GW47959@gaz.sfgoth.com> <el1tg0$n07$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 19:48:10 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <el1tg0$n07$1@sea.gmane.org>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Mon, 04 Dec 2006 12:03:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33230>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrJnB-0001Qe-E4 for gcvg-git@gmane.org; Mon, 04 Dec
 2006 20:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937341AbWLDTp5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 14:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937335AbWLDTp5
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 14:45:57 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:52130 "EHLO gaz.sfgoth.com"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S937348AbWLDTpo
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 14:45:44 -0500
Received: from gaz.sfgoth.com (localhost.sfgoth.com [127.0.0.1]) by
 gaz.sfgoth.com (8.12.10/8.12.10) with ESMTP id kB4K3otV099964; Mon, 4 Dec
 2006 12:03:50 -0800 (PST) (envelope-from mitch@gaz.sfgoth.com)
Received: (from mitch@localhost) by gaz.sfgoth.com (8.12.10/8.12.6/Submit) id
 kB4K3oee099963; Mon, 4 Dec 2006 12:03:50 -0800 (PST) (envelope-from mitch)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:
> Not true. Symlink HEAD still works, and we have even core.preferSymlinkRefs
> configuration variable.

Yes, but it has to be a symlink pointing into "refs/", not just a regular
file holding a hash value.  Which is fine for most purposes but sort of a
pain for me.

I'll probably have it be a symlink to "refs/gitfs-dynamic" or something and
then have "refs" be populated with that synthetic file and symlinks to
any of the normal contents of the refs directory.  Not too bad, but will
take a little bit of code.

