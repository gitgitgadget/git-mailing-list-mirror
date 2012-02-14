From: "Neal Kreitzinger" <neal@rsss.com>
Subject: git-cherry filter
Date: Mon, 13 Feb 2012 22:20:59 -0600
Message-ID: <jhcnfc$aec$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 05:21:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx9tE-0002X1-SQ
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 05:21:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758890Ab2BNEVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 23:21:12 -0500
Received: from plane.gmane.org ([80.91.229.3]:37217 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755767Ab2BNEVK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 23:21:10 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Rx9t6-0002Lu-T2
	for git@vger.kernel.org; Tue, 14 Feb 2012 05:21:08 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 05:21:08 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 05:21:08 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-RFC2646: Format=Flowed; Original
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190700>

Is there a way to add a pre-git-patch-id filter to git-cherry?

e.g.,

(a) perform "keyword contraction" to the patch before generating the 
git-patch-id.

e.g.  I want to run a git-cherry to see if two patches are identical other 
than keyword expansion values like $User: foo$ vs. $User: bar$.  (I would 
have to tell git-cherry which keyword formats to "contract".)

(b) ignore comments in the source code.

e.g.  I want to run a git-cherry to see if the patches are identical in 
regards to executable source.  (I would have to tell git-cherry what the 
comment rules are for the various source files.)

(c) exclude certain files from the diff (ie., binaries, comment files, 
etc.).

e.g.  I want to run a git-cherry to see which source code fixes from the old 
system have already been applied to the new system regardless of whether 
certain files differ (ie., binaries (ie, compile date), comment files (ie., 
fixed a typo), etc.).  (I would have to tell git-cherry which 
paths/filenames to disregard.)

I suppose these may be git-patch-id options that are passed via git-cherry 
like the git-fetch options passable via git-pull.


v/r,
neal 
