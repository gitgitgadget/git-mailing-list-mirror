X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [RFC] requiring Perl SVN libraries for git-svn
Date: Wed, 13 Dec 2006 12:21:42 -0800
Message-ID: <20061213202142.GE8179@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 13 Dec 2006 20:22:00 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34230>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guabu-0006et-27 for gcvg-git@gmane.org; Wed, 13 Dec
 2006 21:21:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750704AbWLMUVr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 15:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbWLMUVr
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 15:21:47 -0500
Received: from hand.yhbt.net ([66.150.188.102]:55483 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1750704AbWLMUVq
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 15:21:46 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id CE0DD2DC034; Wed, 13 Dec 2006 12:21:42 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 13 Dec 2006
 12:21:42 -0800
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Are there any git-svn users out there who would be seriously hurt if I
dropped support for using the svn command-line client in git-svn?

The API of the SVN:: libraries seem to be relatively stable these days
and are *much* faster than the command-line client.  I plan on
maintaining compatibility with version 1.1 of the SVN libraries for at
least another year; or more if it's not a big problem.

Lately, I've introduced support for authentication and connecting to
repositories with limited read permissions, as well as reading from the
config files in ~/.subversion; so everything that could be done with
the command-line client backend can be done with the libraries, too.

-- 
