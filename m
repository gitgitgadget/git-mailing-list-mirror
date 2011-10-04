From: Jon Forrest <nobozo@gmail.com>
Subject: A Basic Git Question About File Tracking
Date: Mon, 03 Oct 2011 17:53:10 -0700
Message-ID: <j6dlhf$dp3$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 04 02:55:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAtIP-00082F-9C
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 02:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818Ab1JDAzh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Oct 2011 20:55:37 -0400
Received: from lo.gmane.org ([80.91.229.12]:59074 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752347Ab1JDAzg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 20:55:36 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RAtID-0007y9-1X
	for git@vger.kernel.org; Tue, 04 Oct 2011 02:55:33 +0200
Received: from c-24-6-237-93.hsd1.ca.comcast.net ([24.6.237.93])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 02:55:33 +0200
Received: from nobozo by c-24-6-237-93.hsd1.ca.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 02:55:33 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-6-237-93.hsd1.ca.comcast.net
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182719>

I've been reading the Pro Git book. I'm having trouble really
understanding the concept of file tracking. Here's where
my confusion starts.

The Pro Git book says "Untracked basically means that Git sees a
file you didn=92t have in the previous snapshot (commit)".

Is this right? I can easily think of a counter example.
Let's say you put a new file in the working directory of a
Git repo. Then you "git add" it. At this point, the file hasn't
been in any commit. Yet, 'git status' doesn't show the file
as being untracked. Should that statement be "Untracked basically
means that Git sees a file you didn=92t have in the previous
snapshot (commit) or a file that hasn't been staged."?

One additional confusing thing is that "git add" apparently
both starts tracking a file and puts it in the index the
first time a file is added. Thereafter, "git add" only puts
the file in the index. One of my research projects is to understand
what goes on internally when a file is tracked.

Jon Forrest
