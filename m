X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: branch builtin
Date: Wed, 01 Nov 2006 20:17:57 +0000
Message-ID: <454900F5.5050603@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 1 Nov 2006 20:19:47 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30653>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfMXn-0000Jo-Gv for gcvg-git@gmane.org; Wed, 01 Nov
 2006 21:18:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752312AbWKAUSf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 15:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752316AbWKAUSf
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 15:18:35 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:9224 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S1752312AbWKAUSe
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 15:18:34 -0500
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1GfMX5-0002Gp-Lu for git@vger.kernel.org; Wed, 01 Nov 2006
 20:17:55 +0000
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

Since the branch command moved built-in it no longer works in
sub-directories.  I've futzed with it and it seems adding RUN_SETUP to
the command table for branch makes 'git branch' work.  Is this safe to do?

