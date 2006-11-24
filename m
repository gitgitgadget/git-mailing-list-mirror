X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
From: Pazu <pazu@pazu.com.br>
Subject: git-svn: why fetching files is so slow
Date: Fri, 24 Nov 2006 13:36:35 +0000 (UTC)
Message-ID: <loom.20061124T143148-286@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 24 Nov 2006 13:37:07 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 9
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 201.37.99.93 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1) Gecko/20061010 Firefox/2.0)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32216>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnbEm-0004co-HM for gcvg-git@gmane.org; Fri, 24 Nov
 2006 14:37:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757778AbWKXNg5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 08:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757777AbWKXNg5
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 08:36:57 -0500
Received: from main.gmane.org ([80.91.229.2]:65219 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1757778AbWKXNg4 (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 08:36:56 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GnbEV-0004YZ-5k for git@vger.kernel.org; Fri, 24 Nov 2006 14:36:50 +0100
Received: from C925635D.poa.virtua.com.br ([C925635D.poa.virtua.com.br]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 24 Nov 2006 14:36:47 +0100
Received: from pazu by C925635D.poa.virtua.com.br with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 24 Nov 2006
 14:36:47 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

... compared to the standalone svn client. I'm working with repositories over
the internet, using not-so-fast links, but still, a svn checkout takes somewhere
around 5 to 10 minutes, while git-svn fetch takes at least 10 times that just to
fetch the initial revision. Later fetches also take *a lot* more time than a svn
update would.

Cheers,

-- Pazu
