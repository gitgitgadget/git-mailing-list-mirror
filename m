From: "Neal Kreitzinger" <neal@rsss.com>
Subject: filtering out mode-change-only changes
Date: Tue, 28 Feb 2012 20:31:13 -0600
Message-ID: <jik2le$2lb$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 29 03:31:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2ZKI-0001rq-Bc
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 03:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966189Ab2B2Cb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 21:31:29 -0500
Received: from plane.gmane.org ([80.91.229.3]:49450 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965501Ab2B2Cb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 21:31:28 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1S2ZK8-0001jh-UW
	for git@vger.kernel.org; Wed, 29 Feb 2012 03:31:24 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 03:31:24 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 03:31:24 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191802>

What is the best way to filter out the "mode change only" entries from a 
"name-status diff result" listing of changed files?

Reason-for-this:
get a list of files whose content changed and feed that list into a 
gui-diff-tool for visual review of "merge" (rebase) results.

Partial-Solutions:
--name-status does not have mode-change info.
--raw has mode change info but I would have to parse it out and compare it 
myself.
--summary has that info, but not the content modification info.

Before I write a script to discern "mode-change-only changes" and remove 
them from the list of changed files (thus leaving only content-changed files 
in the list), I'd like to see if there is some way that git 
already-does-this-for-you, or if someone already has a script that does 
this.

Thanks in advance for any tips.

v/r,
neal 
