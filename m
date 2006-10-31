X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/2] Allow '-' in config variable names
Date: Mon, 30 Oct 2006 19:23:20 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0610301922020.25218@g5.osdl.org>
References: <Pine.LNX.4.64.0610300823250.25218@g5.osdl.org>
 <7vodrtv2wy.fsf@assigned-by-dhcp.cox.net> <7vfyd5rxvg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 31 Oct 2006 03:23:31 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vfyd5rxvg.fsf@assigned-by-dhcp.cox.net>
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30565>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GekDp-0007mE-4Y for gcvg-git@gmane.org; Tue, 31 Oct
 2006 04:23:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161573AbWJaDX0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 22:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161574AbWJaDX0
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 22:23:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15287 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1161573AbWJaDXZ (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 22:23:25 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9V3NLPo012551
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 30
 Oct 2006 19:23:21 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9V3NKhF014949; Mon, 30 Oct
 2006 19:23:20 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org



On Mon, 30 Oct 2006, Junio C Hamano wrote:
> 
> One thing I forgot to add.  Just like we downcase what user has
> written in config file, it might make sense to also remove '-'
> (and if we add '_' to keychar set, that one as well) to when
> canonicalizing the key value.  That way, somewhat awkward long
> configuration variables we currently have can be written more
> readably, e.g. repack.use-delta-base-offset

Well, then we need to teach "git <alias>" that "git <al-i-as>" is the same 
thing as "alias".

> > By the way, everybody seems to do "alias.xxx = -p cat-file -p"
> > (I have it as "git less").  Maybe we would want to make a
> > built-in alias for that?
> 
> Seconds?

I like it mainly as a great example of how to use aliases, not because I 
actually much -use- the thing, so I don't personally care.

