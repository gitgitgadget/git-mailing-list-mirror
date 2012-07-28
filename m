From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 5/5] Change the rest of the code to use the Git::SVN
 and Git::SVN::Ra url accessors.
Date: Sat, 28 Jul 2012 02:59:12 +0000
Message-ID: <20120728025912.GA28871@dcvr.yhbt.net>
References: <1343419252-9447-1-git-send-email-schwern@pobox.com>
 <1343419252-9447-6-git-send-email-schwern@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, jrnieder@gmail.com
To: "Michael G. Schwern" <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 04:59:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuxFR-0000i1-39
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 04:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847Ab2G1C7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 22:59:14 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36161 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752802Ab2G1C7N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 22:59:13 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8C4B1F43A;
	Sat, 28 Jul 2012 02:59:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1343419252-9447-6-git-send-email-schwern@pobox.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202399>

"Michael G. Schwern" <schwern@pobox.com> wrote:

We try to keep Subject: lines short (~50 char soft limit) as documented
in SubmittingPatches.

How about:

Subject: [PATCH 4/5] use Git::SVN->path accessor globally
Subject: [PATCH 5/5] use Git::SVN{,::RA}->url accessor globally

?

I can make the changes to the commit message on my side before I push
for Junio.

> Note: The structure returned from Git::SVN->read_all_remotes() does
> not appear to contain objects, so I'm leaving them alone.

Right, just hashrefs and strings there.

> No functional change.

This series looks good with minor edits.

I made minor edits to reformat the new accessor subs (please do so on
your end before sending in the future).
