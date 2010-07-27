From: Bradley Wagner <bradley.wagner@hannonhill.com>
Subject: Pushing a new branch to a remote and tracking it
Date: Tue, 27 Jul 2010 18:12:09 -0400
Message-ID: <AANLkTikxmhndNqGDpwfBm41OuaPvnB=2xqp6gkYOTQiF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 28 00:12:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdsO1-0004lV-2T
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 00:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335Ab0G0WML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 18:12:11 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44339 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269Ab0G0WMK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 18:12:10 -0400
Received: by pwi5 with SMTP id 5so648489pwi.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 15:12:09 -0700 (PDT)
Received: by 10.142.156.14 with SMTP id d14mr10969559wfe.248.1280268729485; 
	Tue, 27 Jul 2010 15:12:09 -0700 (PDT)
Received: by 10.142.98.16 with HTTP; Tue, 27 Jul 2010 15:12:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152008>

Is there a more elegant way to: 1) create a branch, 2) push it to a
remote and 3) continue to track it.

I noticed that:

git branch <branchname> HEAD
git checkout <branchname>
git push origin <branchname>

does not link the local branch to the remote.

I've seen other people do:

git push origin origin:refs/heads/<branchname>
git fetch origin
git branch -r (verify that the branch is there)
git checkout <branchname> -b origin/<branchname>

but it seems kind of the reverse of what I would expect to do. I know
I could also do the first thing and then delete/re-checkout the branch
with tracking.
