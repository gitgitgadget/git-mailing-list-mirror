From: davetron5000 <davetron5000@gmail.com>
Subject: push to backup repo periodically fails with "not fast forward"
Date: Mon, 22 Dec 2008 08:24:39 -0800 (PST)
Message-ID: <19016122-e19d-4885-8b0f-dec7b686c6ea@o4g2000pra.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 22 17:35:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEnjz-0000Pa-HZ
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 17:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbYLVQd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 11:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbYLVQd3
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 11:33:29 -0500
Received: from mail-gx0-f59.google.com ([209.85.217.59]:49823 "EHLO
	mail-gx0-f59.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483AbYLVQd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 11:33:28 -0500
X-Greylist: delayed 527 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Dec 2008 11:33:28 EST
Received: by gxk19 with SMTP id 19so2339559gxk.21
        for <git@vger.kernel.org>; Mon, 22 Dec 2008 08:33:27 -0800 (PST)
Received: by 10.100.38.3 with SMTP id l3mr497757anl.26.1229963079999; Mon, 22 
	Dec 2008 08:24:39 -0800 (PST)
X-IP: 66.92.169.98
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; 
	rv:1.9.0.4) Gecko/2008102920 Firefox/3.0.4,gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103759>

I have a repo on another disk that I ONLY use to backup my in-use
local repo.  I have a post-commit hook that does the push (git push --
all remote-repo-name)

>git commit -a -m 'some change'
Counting objects: 71, done.
Compressing objects: 100% (26/26), done.
Writing objects: 100% (29/29), 2.31 KiB, done.
Total 29 (delta 12), reused 0 (delta 0)
Unpacking objects: 100% (29/29), done.
To file:///Volumes/Git/pose/main
   22d7f10..0037aaf  bimonthly-frequency -> bimonthly-frequency
 ! [rejected]        master -> master (non-fast forward)
error: failed to push some refs to 'file:///Volumes/Git/pose/main'
Created commit 0037aaf: Removed assertion that made no sense.
 1 files changed, 0 insertions(+), 2 deletions(-)

I'm using git as a front-end to Subversion, but I can't figure out why
this is happening.

The repo at /Volumes/Git/pose/main is NEVER pulled from or pushed to
by anything other than my hook.  I can't understand why any push to it
would NOT be a fast-forward.

Any ideas how I can figure out what's going on?
