From: Paul Wagland <paul@kungfoocoder.org>
Subject: [PATCH 0/2] Update BASH completions
Date: Sat, 23 Jan 2016 02:23:24 +0100
Message-ID: <20160123012316.GA27965@wagland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 02:37:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMn8f-0007Pa-UQ
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jan 2016 02:37:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755233AbcAWBgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 20:36:39 -0500
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:62804 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754826AbcAWBgh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jan 2016 20:36:37 -0500
Received: from cpsps-ews03.kpnxchange.com ([10.94.84.170]) by cpsmtpb-ews01.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Sat, 23 Jan 2016 02:22:32 +0100
Received: from cpsmtpm-cmt109.kpnxchange.com ([195.121.3.28]) by cpsps-ews03.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Sat, 23 Jan 2016 02:22:32 +0100
Received: from kruimel.wagland.net ([86.85.102.39]) by cpsmtpm-cmt109.kpnxchange.com over TLS secured channel with Microsoft SMTPSVC(7.0.6002.18264);
	 Sat, 23 Jan 2016 02:23:33 +0100
Received: from wagland.net (mijnmodem.kpn.lan [192.168.2.254])
	by kruimel.wagland.net (Postfix) with ESMTPSA id C9E636191D4
	for <git@vger.kernel.org>; Sat, 23 Jan 2016 02:23:32 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.2
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on kruimel
X-OriginalArrivalTime: 23 Jan 2016 01:23:33.0287 (UTC) FILETIME=[ACBDA370:01D1557C]
X-RcptDomain: vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284622>

While playing around git stash I noticed that some options were
missing. I have updated these in the BASH completions file. Note
that this is not a comprehensive review, but adds the options that
I use in git-stash, and a nearby missing option.

Paul Wagland (2):
  Update the flags for git show-branch
  Fix up the arguments for git stash. This adds the branch to the branch
    subcommand, and adds the missing options to save and drop commands

 contrib/completion/git-completion.bash | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

--
2.7.0
