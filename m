X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: [ANNOUNCE] Git Queues 0.10
Date: Tue, 14 Nov 2006 05:10:37 -0500
Message-ID: <20061114101037.GA8075@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 14 Nov 2006 10:11:22 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31339>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjvFb-0000LJ-GG for gcvg-git@gmane.org; Tue, 14 Nov
 2006 11:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933369AbWKNKKj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 05:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933375AbWKNKKj
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 05:10:39 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:7878 "EHLO
 filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP id S933369AbWKNKKi
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 05:10:38 -0500
Received: from filer.fsl.cs.sunysb.edu
 (IDENT:NkeokRtBo+0IbwelTNfq4d2FuymDNvS9@localhost.localdomain [127.0.0.1]) by
 filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id
 kAEAAceY008655 for <git@vger.kernel.org>; Tue, 14 Nov 2006 05:10:38 -0500
Received: (from jsipek@localhost) by filer.fsl.cs.sunysb.edu
 (8.12.11.20060308/8.13.1/Submit) id kAEAAbZ5008653 for git@vger.kernel.org;
 Tue, 14 Nov 2006 05:10:37 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Git Queues (aka. gq) is a series of bash scripts which add a Mercurial
queues-like [1] functionality and interface to git. The one distinguishing
feature from other quilt-like porcelains, is the format of the patches
directory. _All_ the information is stored as plain text - a series file and
the patches (one per file). This easily lends itself to versioning the
patches using any number of of SCMs.

The scripts are rather incomplete at the moment, but I'm hoping they'll get
to being very usable very soon.

Tarball:
http://www.kernel.org/pub/linux/kernel/people/jsipek/gq/gq-0.10.tar.bz2
http://www.kernel.org/pub/linux/kernel/people/jsipek/gq/gq-0.10.tar.gz

Git repository:
git://git.kernel.org/pub/scm/linux/kernel/git/jsipek/gq.git


The code is licensed under GPLv2.

Of course, contributions and feedback are welcomed :)

Josef "Jeff" Sipek.

