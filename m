X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: how to pass ssh options to git?
Date: Thu, 2 Nov 2006 11:07:17 +0200
Message-ID: <20061102090717.GE7468@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 2 Nov 2006 09:04:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30693>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfYUy-00043L-An for gcvg-git@gmane.org; Thu, 02 Nov
 2006 10:04:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752754AbWKBJE3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 04:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752755AbWKBJE3
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 04:04:29 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:5248 "EHLO
 dev.mellanox.co.il") by vger.kernel.org with ESMTP id S1752754AbWKBJE2 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 04:04:28 -0500
Received: from mellanox.co.il ([194.90.237.34]) by dev.mellanox.co.il
 (8.13.1/8.13.1) with SMTP id kA294Ptk008946 for <git@vger.kernel.org>; Thu, 2
 Nov 2006 11:04:25 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Thu,  2 Nov 2006
 11:07:17 +0200
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org

How is it possible to pass ssh options to git?
for example, I use these options to log into some machine:
ssh -i <private> -o HostKeyAlias=<alias> -p <port> -l <user> <address>

However, git will only let me specify the user name on command line as part of
the URL.  I am guessing something can be done using core.gitProxy?



-- 
