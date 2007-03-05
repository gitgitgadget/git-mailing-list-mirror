From: Jon Loeliger <jdl@freescale.com>
Subject: Dry run flag for git-pull or git-fetch?
Date: Mon, 05 Mar 2007 14:41:48 -0600
Message-ID: <1173127307.23776.37.camel@ld0161-tx32>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 05 21:42:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOK0Q-0006Ni-8K
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 21:42:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbXCEUlw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 15:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbXCEUlw
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 15:41:52 -0500
Received: from de01egw01.freescale.net ([192.88.165.102]:55625 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932346AbXCEUlv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 15:41:51 -0500
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id l25Kfmdu018795
	for <git@vger.kernel.org>; Mon, 5 Mar 2007 13:41:49 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l25KfmMO013641
	for <git@vger.kernel.org>; Mon, 5 Mar 2007 14:41:48 -0600 (CST)
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-17) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41483>

Folks,

Is there a "dry-run" flag for git-pull and git-fetch
that I missed somewhere?

Specifically, I'm looking for a  "git pull -n foo"
command that would tell me, as output, the gross-level
effect without actually doing the steps.  That is,
I'd expect something like:

    Fetching from remote "foo"
        URL: git://example.com/pub/foostuff.git
        Remote branch: foo/main into remote/foo/main
        Remote branch: foo/testing into remote/foo/testing
    Merging:
        Remote foo/main into local heads/master

Or something down that line.  Basically parrot the
config file plus command line effect back at the
user as a sanity check first.

Thanks,
jdl
