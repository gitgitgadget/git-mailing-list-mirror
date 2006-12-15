X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC] requiring Perl SVN libraries for git-svn
Date: Fri, 15 Dec 2006 10:44:24 -0800
Message-ID: <20061215184424.GA1442@localdomain>
References: <20061213202142.GE8179@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 18:44:36 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061213202142.GE8179@localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34539>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvI2n-0005aZ-Ll for gcvg-git@gmane.org; Fri, 15 Dec
 2006 19:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753155AbWLOSo0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 13:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753161AbWLOSo0
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 13:44:26 -0500
Received: from hand.yhbt.net ([66.150.188.102]:58057 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1753155AbWLOSo0
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006 13:44:26 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 7333E2DC03A; Fri, 15 Dec 2006 10:44:24 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 15 Dec 2006
 10:44:24 -0800
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Eric Wong <normalperson@yhbt.net> wrote:
> Are there any git-svn users out there who would be seriously hurt if I
> dropped support for using the svn command-line client in git-svn?

One additional comment is that the dcommit command (much favored over
'git svn commit') does not currently work with the command-line client.

-- 
