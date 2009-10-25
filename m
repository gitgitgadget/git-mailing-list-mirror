From: Michael Poole <mdpoole@troilus.org>
Subject: Re: [ANNOUNCE]  BugTracker.NET (FOSS) now supports git integration
Date: Sun, 25 Oct 2009 10:03:48 -0400
Message-ID: <87k4yj8ta3.fsf@sanosuke.troilus.org>
References: <97625.96130.qm@web65401.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Corey Trager <ctrager@yahoo.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 15:03:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N23hN-0002Ta-O8
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 15:03:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753665AbZJYODr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 10:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753661AbZJYODr
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 10:03:47 -0400
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:40774 "HELO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753653AbZJYODr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Oct 2009 10:03:47 -0400
Received: from source ([74.125.92.145]) by na3sys009aob103.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSuRax9fsf4lCqulxRjcjEORdUIApk8Lh@postini.com; Sun, 25 Oct 2009 07:03:52 PDT
Received: by qw-out-1920.google.com with SMTP id 14so1610681qwa.56
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 07:03:51 -0700 (PDT)
Received: by 10.224.7.133 with SMTP id d5mr6674588qad.45.1256479430959;
        Sun, 25 Oct 2009 07:03:50 -0700 (PDT)
Received: from sanosuke.troilus.org.troilus.org (pool-72-83-66-147.washdc.east.verizon.net [72.83.66.147])
        by mx.google.com with ESMTPS id 8sm13424168qwj.31.2009.10.25.07.03.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 07:03:50 -0700 (PDT)
In-Reply-To: <97625.96130.qm@web65401.mail.ac4.yahoo.com> (Corey Trager's message of "Sun\, 25 Oct 2009 06\:15\:50 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131205>

Corey Trager writes:

> BugTracker.NET is a free, open-source, GPL,  ASP.NET bug tracking app.
> More info at http://ifdefined.com/bugtrackernet.html
>
> With the integration, if you do a commit like...
> git commit  -a -m "123 fixed the bug"
> ...then the hook script will link up the commit to bug 123.
>
> Here are screenshots of the Subversion integration, which looks pretty much like the git integration:
> http://ifdefined.com/doc_bug_tracker_subversion.html
>
> Feedback very welcome, good or bad.

Does it recognize bug IDs in the footer section of a commit message
(where Signed-Off-By and similar lines typically go)?

Michael Poole
