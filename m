From: John Goerzen <jgoerzen@complete.org>
Subject: Re: git-rebase dirty index and email address bug?
Date: Sat, 1 Mar 2008 15:29:37 -0600
Message-ID: <slrnfsjim1.5e0.jgoerzen@katherina.lan.complete.org>
References: <slrnfsjfpo.3fl.jgoerzen@katherina.lan.complete.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 23:09:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVZtC-0006Mu-3h
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 23:09:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517AbYCAWI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 17:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753592AbYCAWI3
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 17:08:29 -0500
Received: from main.gmane.org ([80.91.229.2]:43708 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752377AbYCAWI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 17:08:29 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JVZsV-00076W-4e
	for git@vger.kernel.org; Sat, 01 Mar 2008 22:08:23 +0000
Received: from 63-245-179-205.kitusa.com ([63.245.179.205])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Mar 2008 22:08:23 +0000
Received: from jgoerzen by 63-245-179-205.kitusa.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Mar 2008 22:08:23 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 63-245-179-205.kitusa.com
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75707>

On 2008-03-01, John Goerzen <jgoerzen@complete.org> wrote:
> Hi folks,
>
> I have checked out a remote git repo.  I have hacked on my local copy
> for the last two days.  I have performed no merges or anything elese
> odd.  Today I git fetched the remote, and then I tried to git rebase
> upstream/master.  I had committed all outstanding changes first.  My
> index was clean.  It displayed:

Two things to add:

1) This was a clean branch prior to rebase (git status was empty)

2) Adding -i to the rebase command, then making no changes to the
list, caused the rebase to work perfectly.


