X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_05,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Tim O Callaghan" <timo@dspsrv.com>
Subject: Re: git cygwin package?
Date: Fri, 3 Nov 2006 12:43:46 -0000 (GMT)
Message-ID: <2495.145.36.45.123.1162557826.squirrel@www.dspsrv.com>
Reply-To: timo@dspsrv.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 3 Nov 2006 12:44:40 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: SquirrelMail/1.4.8
X-Priority: 3 (Normal)
Importance: Normal
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30842>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfyOk-0000NF-7F for gcvg-git@gmane.org; Fri, 03 Nov
 2006 13:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751426AbWKCMnr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 07:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752635AbWKCMnr
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 07:43:47 -0500
Received: from ns.dspsrv.com ([193.120.211.34]:33502 "EHLO dspsrv.com") by
 vger.kernel.org with ESMTP id S1751426AbWKCMnq (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 07:43:46 -0500
Received: from www-data by dspsrv.com with local (Exim 4.63) (envelope-from
 <timo@dspsrv.com>) id 1GfyOg-0006Cs-4p for git@vger.kernel.org; Fri, 03 Nov
 2006 12:43:46 +0000
Received: from 145.36.45.123 (SquirrelMail authenticated user timo) by
 www.dspsrv.com with HTTP; Fri, 3 Nov 2006 12:43:46 -0000 (GMT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

> Hi,
> Has anyone created a binary package for git on cygwin?

I started working on one a while ago, but it started to take up too much time. In the end i had to
shelve it for a while. I was looking at it recently actually.

There are were few issues with trying to compile with a target path directory of / (root), as
cygwin uses /bin /lib etc for all of its binaries. There were some problems with the import/export
SVN tools as well IIRC.

Its not just git that needs to be added to cygwin, Asciidoc and a few other tools (i have a list
somewhere) would also need to be packaged for cygwin too, because the package system re-builds
their binaries from source for distribution.

Also whoever builds them would also have to make sure they have the time maintain them or they get
dropped.

Tim.

