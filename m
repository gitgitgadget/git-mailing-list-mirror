From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: remote tracking branches
Date: Wed, 25 Feb 2009 12:41:01 -0500
Message-ID: <450196A1AAAE4B42A00A8B27A59278E709E0485C@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 25 18:42:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcNmP-0004JX-3I
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 18:42:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225AbZBYRlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 12:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751697AbZBYRlQ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 12:41:16 -0500
Received: from mail5.tradestation.com ([63.99.207.76]:51674 "EHLO
	mail5.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbZBYRlQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 12:41:16 -0500
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 25 Feb 2009 12:41:14 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: remote tracking branches
thread-index: AcmXcDnbZYAuRPqgQMafC0DuAyZ03A==
X-OriginalArrivalTime: 25 Feb 2009 17:41:14.0056 (UTC) FILETIME=[41116480:01C99770]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111470>

The repository on my machine was apparently originally a simple file
copy from another development machine, or set up manually.  That is, was
not done by using the "git clone" command.  I have a [remote "pub"] in
the config file with only a url in it, so I can use "pub" when I push
and pull.

The command "git branch -r" shows nothing.

So, there are no remote tracking branches.  So what?  At first, I think
that this is nothing more than the defaults to use when pulling, to get
everything.  But, the example at the very end of Chapter 1 of the user
manual shows:
	fetch = +refs/heads/*:refs/remotes/linux-nfs/*

I don't have a refs/remotes directory now.  So what does
	git pull pub xx
do?  The _result_ is just fine, as expected.  But if pull calls fetch,
it needs to fetch it to some temporary place first and then merge that,
right?

If I add a suitable line to my config file (changing linux-nfs in the
example to pub to match the remote name), what does that buy me?  But
first, is that all I need to do to enable this feature?

I'm guessing that it means I will be able to examine, e.g. using gitk,
what is in pub, to see if there are changes I need and keep apprised of
other's work.

--John
