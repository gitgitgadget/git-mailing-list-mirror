From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: Re: BuGit: File-less distributed issue tracking system with Git
Date: Tue, 02 Feb 2016 11:13:34 -0500
Message-ID: <jwvbn7zksha.fsf-monnier+gmane.comp.version-control.git@gnu.org>
References: <jwva8psr6vr.fsf-monnier+gmane.comp.version-control.git@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 17:13:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQdaT-0006QK-FM
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 17:13:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933407AbcBBQNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 11:13:49 -0500
Received: from plane.gmane.org ([80.91.229.3]:48570 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933392AbcBBQNs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 11:13:48 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aQdaJ-0006E2-7Z
	for git@vger.kernel.org; Tue, 02 Feb 2016 17:13:43 +0100
Received: from modemcable022.171-203-24.mc.videotron.ca ([24.203.171.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Feb 2016 17:13:43 +0100
Received: from monnier by modemcable022.171-203-24.mc.videotron.ca with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Feb 2016 17:13:43 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: modemcable022.171-203-24.mc.videotron.ca
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.50 (gnu/linux)
Cancel-Lock: sha1:81j3x57J9l7YMlE8iZGoYoWkYO0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285271>

> So, see attached BuGit, an issue tracking system which stores its
> database in Git to try and get "distributed operation for free".

It's now hosted at https://gitlab.com/monnier/bugit

In the mean time it grew to 80KB, offers a read-only web UI, email
notifications, and a fairly complete command line UI.

It also changed its internal representation slightly, so it can now be
used within the same Git repository as the project on which you're
working (e.g. I cloned the BuGit source code and BuGit's bug database
into the same repository, so I can use bugit directly from the source
code directory to manipulate its bugs).

You can even host the bug database and the source code of your project
in the same repository (the post-receive hook script can be told to pass
the non-bugit-related changes to some other script).


        Stefan
