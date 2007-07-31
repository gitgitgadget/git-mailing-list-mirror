From: "Denis Bueno" <denbuen@sandia.gov>
Subject: Git clone error
Date: Tue, 31 Jul 2007 17:45:47 -0600
Message-ID: <C2D525CB.2A81%denbuen@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 01 01:56:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG1ZJ-0005Fx-24
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 01:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763840AbXGaXz7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 19:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763852AbXGaXz6
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 19:55:58 -0400
Received: from mm04snlnto.sandia.gov ([132.175.109.21]:4352 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763598AbXGaXzz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 19:55:55 -0400
X-Greylist: delayed 594 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Jul 2007 19:55:54 EDT
Received: from [134.253.164.148] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Tue, 31 Jul 2007 17:45:48 -0600
X-Server-Uuid: 6CEB1540-FE13-491B-9872-FD67060ED864
Received: from ES21SNLNT.srn.sandia.gov ([134.253.164.104]) by
 ES24SNLNT.srn.sandia.gov with Microsoft SMTPSVC(6.0.3790.3959); Tue, 31
 Jul 2007 17:45:48 -0600
Received: from 134.253.202.158 ([134.253.202.158]) by
 ES21SNLNT.srn.sandia.gov ([134.253.164.116]) with Microsoft Exchange
 Server HTTP-DAV ; Tue, 31 Jul 2007 23:45:47 +0000
User-Agent: Microsoft-Entourage/11.3.3.061214
Thread-Topic: Git clone error
Thread-Index: AcfTzOrVKUHBcD/AEdyJZQAX8tQlcQ==
X-OriginalArrivalTime: 31 Jul 2007 23:45:48.0358 (UTC)
 FILETIME=[EBA4BE60:01C7D3CC]
X-TMWD-Spam-Summary: TS=20070731234548; SEV=2.2.2; DFV=B2007073120;
 IFV=2.0.4,4.0-9; AIF=B2007073120; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230332E34364146433941432E303042342C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007073120_5.02.0125_4.0-9
X-WSS-ID: 6AB116261V82439776-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54380>

Hi all,

I'm a new git user (actually a darcs convert) and am running into a weird
problem on a small and simple repository.  The error I see is:

    git[14] > git clone /Volumes/work/scripts/
    Initialized empty Git repository in /tmp/git/scripts/.git/
    remote: Generating pack...
    Done counting 80 objects.
    remote: error: unable to unpack b28b949a1a3c8eb37ca6eefd024508fa8b253429
header
    fatal: unable to get type of object b28b949a1a3c8eb37ca6error:
git-upload-pack: git-pack-objects died with error.
    fatal: git-upload-pack: aborting due to possible repository corruption
on the remote side.
    remote: aborting due to possible repository corruption on the remote
side.
    fatal: early EOF
    fatal: index-pack died with error code 128
    fetch-pack from '/Volumes/work/scripts/.git' failed.

I have many git repos on my system (one for configuration files, one for
scripts, various school projects, etc.) and this is the only one that has
been problematic thus far.  As you can see I am trying to clone a local repo
-- there should be no network problems here.  As I said, the repo is small:

    scripts[19] > find . -type f | wc -l
    118

(which of course includes all of git's files.)

$ git --version
git version 1.5.2.4

$ uname -a
Darwin 8.10.1 Darwin Kernel Version 8.10.1: Wed May 23 16:33:00 PDT 2007;
root:xnu-792.22.5~1/RELEASE_I386 i386 i386

I have little experience with git, but if you need any more info, let me
know.  Any suggestion on what might be the problem, and how to fix it?

-Denis
