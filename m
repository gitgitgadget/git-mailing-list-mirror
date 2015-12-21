From: Alan Mackenzie <acm@muc.de>
Subject: Re: "git stash pop" is doing an unwanted "git add" when there are	conflicts.
Date: Mon, 21 Dec 2015 20:34:01 +0000 (UTC)
Message-ID: <n59nnp$t0m$2@ger.gmane.org>
References: <20151221142953.GA12764@acm.fritz.box>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 21 21:55:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aB7UC-0000zR-Al
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 21:55:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbbLUUzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 15:55:10 -0500
Received: from plane.gmane.org ([80.91.229.3]:47313 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751454AbbLUUzI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 15:55:08 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aB7U1-0000jN-Cr
	for git@vger.kernel.org; Mon, 21 Dec 2015 21:55:05 +0100
Received: from p548a50f8.dip0.t-ipconnect.de ([84.138.80.248])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 Dec 2015 21:55:05 +0100
Received: from acm by p548a50f8.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 Dec 2015 21:55:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p548a50f8.dip0.t-ipconnect.de
User-Agent: tin/2.2.1-20140504 ("Tober an Righ") (UNIX) (Linux/4.0.5-gentoo (x86_64))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282818>

Alan Mackenzie <acm@muc.de> wrote: on Mon, 21 Dec 2015 14:29:54
> Hello, git project.

> Last night, whilst clearing out a stale "stash stack", I did "git stash
> pop".  There were conflicts in two files.

> However, all the popped files became staged.  This doesn't normally happen.
> It was intensely irritating, and required me to do "git reset HEAD" on
> each of the files, none of which I wanted to commit.

> I searched the git-stash man page for this scenario, but found nothing
> about it.

> Surely staging all the files is a bug?

Sorry, forgot to mention I'm using git 2.4.10 on GNU/Linux.

-- 
Alan Mackenzie (Nuremberg, Germany).
