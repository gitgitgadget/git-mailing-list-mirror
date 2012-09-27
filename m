From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 3/7] Extract, test and enhance the logic to collapse
 ../foo paths.
Date: Thu, 27 Sep 2012 00:15:06 +0000
Message-ID: <20120927001506.GA9515@dcvr.yhbt.net>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
 <1343468312-72024-4-git-send-email-schwern@pobox.com>
 <20120730195108.GA20137@dcvr.yhbt.net>
 <5016F2A5.1090102@pobox.com>
 <20120926194504.GA5013@elie.Belkin>
 <20120926205851.GA2166@dcvr.yhbt.net>
 <20120926213831.GB30131@elie.Belkin>
 <20120926215429.GA4637@dcvr.yhbt.net>
 <20120926224307.GA31456@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael G Schwern <schwern@pobox.com>, git@vger.kernel.org,
	gitster@pobox.com, robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 02:15:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TH1lA-0002sN-3k
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 02:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725Ab2I0API (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 20:15:08 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40389 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134Ab2I0APH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 20:15:07 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48E193287D;
	Thu, 27 Sep 2012 00:15:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20120926224307.GA31456@elie.Belkin>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206455>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Maybe we can use apr_filepath_merge() to avoid reinventing the wheel?

Ideally, yes.  Is there an easy way to access that from Perl? (and
for the older versions of SVN folks people are running).

Perhaps we can expose equivalent functionality in git via
git-rev-parse instead?
