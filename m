From: Brian Hetro <whee@smaertness.net>
Subject: gitweb via instaweb not showing log. Bug?
Date: Thu, 2 Aug 2007 21:26:47 -0400
Message-ID: <20070803012647.GA10402@ruiner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 03 03:27:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGlwZ-0007rb-6P
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 03:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756042AbXHCB0v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 21:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755761AbXHCB0v
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 21:26:51 -0400
Received: from ag-out-0708.google.com ([72.14.246.240]:21937 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755102AbXHCB0v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 21:26:51 -0400
Received: by ag-out-0708.google.com with SMTP id 35so722131aga
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 18:26:50 -0700 (PDT)
Received: by 10.100.178.7 with SMTP id a7mr1486883anf.1186104409980;
        Thu, 02 Aug 2007 18:26:49 -0700 (PDT)
Received: from smaertness.net ( [66.67.48.108])
        by mx.google.com with ESMTPS id c40sm2727479anc.2007.08.02.18.26.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2007 18:26:48 -0700 (PDT)
Received: by smaertness.net (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	whee@smaertness.net; Thu,  2 Aug 2007 21:26:48 -0400 (EDT)
Content-Disposition: inline
X-PGP-Key: http://whee.smaertness.net/pubkey.asc
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54658>

Hi,

Using git version 1.5.3.rc3.120.g68d422, I am seeing a problem with
git-instaweb not being able to show the commit logs.  For example, if
I git-clone the git repository, run git-instaweb and browse to:
  http://127.0.0.1:1234/?p=.git;a=log;h=v1.5.1.5
I see:
  Last change .
and no log of changes.

However, this does work using git version 1.5.2.4.  In that case, I do
see the log.

I came up with a test script and let bisect have a go.  It came up
with this commit:
e90fdc39b6903502192b2dd11e5503cea721a1ad is first bad commit
commit e90fdc39b6903502192b2dd11e5503cea721a1ad
Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Date:   Wed Aug 1 01:30:14 2007 +0100

    Clean up work-tree handling

[..snip..]

Known issue?

--
Brian
