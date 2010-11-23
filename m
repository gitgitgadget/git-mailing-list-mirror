From: "Neal Kreitzinger" <neal@rsss.com>
Subject: when does git start caring about symlinks?
Date: Tue, 23 Nov 2010 17:50:31 -0600
Message-ID: <ichk2q$bbu$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 24 00:52:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PL2f8-0002Fb-UK
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 00:52:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754692Ab0KWXwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 18:52:16 -0500
Received: from lo.gmane.org ([80.91.229.12]:33724 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754379Ab0KWXwG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 18:52:06 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PL2eb-00023q-HC
	for git@vger.kernel.org; Wed, 24 Nov 2010 00:52:05 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 00:52:05 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 00:52:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5931
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162035>

I have a question on how symlinks work and at what point git starts caring 
about them.  If dirA/repoA/.git has no symlinks and I copy it to 
dirB/repoB/.git (ie. cp -rp /dirA/repoA/.git /dirB/repoB/.git), but /dirB is 
a symlink to /x/dirB does that mean that repoB contains symlinks (I suspect 
that repoB may be made up of all symlinks at this point)?  In other words, 
if I parallel test repoA and repoB am I running a true parallel test or are 
the repos different because repoA has no symlinks and repoB has symlinks?

v/r,
Neal 
