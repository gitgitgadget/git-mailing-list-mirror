From: "Neal Kreitzinger" <neal@rsss.com>
Subject: impact on git of changing linux o/s system-date frequently
Date: Thu, 20 Jan 2011 18:01:10 -0600
Message-ID: <ihaie3$63g$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 21 01:02:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pg4SW-0000Xi-G3
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 01:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770Ab1AUACZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 19:02:25 -0500
Received: from lo.gmane.org ([80.91.229.12]:49029 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412Ab1AUACZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 19:02:25 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Pg4SN-0000UL-Sp
	for git@vger.kernel.org; Fri, 21 Jan 2011 01:02:23 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 21 Jan 2011 01:02:23 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 21 Jan 2011 01:02:23 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165347>

What are the implications of linux o/s system-date changes on git?

We plan on having test VM's on which the linux o/s system-date (linux "date" 
command) is changed several times to test time lapse scenarios, e.g. go 
forward 30 days in the future.  We use git to pull updates from the 
development machine to mirror repos and cloned repos on the test VM, and to 
create test areas (local repos) on the test VM.  We do not use git-push or 
git-commit on the test VM at this time.

v/r,
Neal 
