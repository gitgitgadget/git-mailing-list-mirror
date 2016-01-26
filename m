From: Paul Wagland <paul@kungfoocoder.org>
Subject: [PATCH v2 0/2] Update BASH completions
Date: Tue, 26 Jan 2016 10:34:29 +0100
Message-ID: <20160126093429.GA77046@wagland.net>
References: <20160123012316.GA27965@wagland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 10:34:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO01P-0000aS-8Z
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 10:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933846AbcAZJen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 04:34:43 -0500
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:60189 "EHLO
	cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933384AbcAZJel (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jan 2016 04:34:41 -0500
Received: from cpsps-ews07.kpnxchange.com ([10.94.84.174]) by cpsmtpb-ews09.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Tue, 26 Jan 2016 10:33:36 +0100
Received: from CPSMTPM-CMT108.kpnxchange.com ([195.121.3.24]) by cpsps-ews07.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Tue, 26 Jan 2016 10:33:36 +0100
Received: from kruimel.wagland.net ([86.85.102.39]) by CPSMTPM-CMT108.kpnxchange.com over TLS secured channel with Microsoft SMTPSVC(7.0.6002.18264);
	 Tue, 26 Jan 2016 10:34:38 +0100
Received: from wagland.net (net06.redwood.com [91.233.6.246])
	by kruimel.wagland.net (Postfix) with ESMTPSA id E069861C95A;
	Tue, 26 Jan 2016 10:34:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20160123012316.GA27965@wagland.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.2
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on kruimel
X-OriginalArrivalTime: 26 Jan 2016 09:34:38.0934 (UTC) FILETIME=[C6DFCF60:01D1581C]
X-RcptDomain: vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284791>

While playing around git stash I noticed that some options were
missing. I have updated these in the BASH completions file. Note
that this is not a comprehensive review, but adds the options that
I use in git-stash, and a nearby missing option.

This re-roll doesn't change the code, but updates the commit comments
to make it clearer what each change is doing.

Paul Wagland (2):
  Update the flags for git show-branch
  Fix up the arguments for git stash. This adds the branch to the branch
    subcommand, and adds the missing options to save and drop commands

 contrib/completion/git-completion.bash | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

--
2.7.0
