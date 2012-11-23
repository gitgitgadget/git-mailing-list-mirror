From: Sebastian Leske <sleske@sleske.name>
Subject: Re: git bash does not access drive f:
Date: Fri, 23 Nov 2012 00:58:30 +0000 (UTC)
Message-ID: <slrnkatidl.gkp.sleske@iota.localnet>
References: <CAB9Jk9Ae46PNRex9QrEy9gTgqAbn8KUFifmxQU4s5K5mDDmDZQ@mail.gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 25 11:15:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcZF8-0001F9-Ik
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 11:15:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969Ab2KYKPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 05:15:00 -0500
Received: from plane.gmane.org ([80.91.229.3]:41189 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752897Ab2KYKO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 05:14:59 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TcZEt-00016N-Ql
	for git@vger.kernel.org; Sun, 25 Nov 2012 11:15:03 +0100
Received: from p4fd450dd.dip.t-dialin.net ([79.212.80.221])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 11:15:03 +0100
Received: from sleske by p4fd450dd.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 11:15:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p4fd450dd.dip.t-dialin.net
User-Agent: slrn/pre1.0.0-18 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210345>

On 2012-11-22, Angelo Borsotti <angelo.borsotti@gmail.com> wrote:
> Hi
>
> I have attached an external disc, which appears on Windows as drive f:
> in Windows Explorer.
> Right-clicking on it displays a context menu showing (among other
> items) Git Init Here, Git Gui and
> Git Bash. The first two work properly on that drive.
> However, the git bash does not. Not even the one that is run from the icon:
>
> $ cd f:
> sh.exe": cd: f:: No such file or directory

This is probably a known limitation of MSYS (the shell environment that
Git Bash uses, which is part of MingW):

Drive letters added after MSYS has started only become visible if all
MSYS processes are stopped and restarted. See e.g.

How to register newly mounted drive in git bash?
http://stackoverflow.com/questions/5197540/

for some more details.

It seems there is no easy workaround, so you'll need to close all Git
Bash windows and reopen them.
