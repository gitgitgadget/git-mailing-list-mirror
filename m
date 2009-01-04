From: Karl Chen <quarl@cs.berkeley.edu>
Subject: Re: git-branch --print-current
Date: Sun, 04 Jan 2009 04:40:51 -0800
Message-ID: <quack.20090104T0440.lthbpun1bxo@roar.cs.berkeley.edu>
References: <quack.20090101T1928.lthzliaqtdf@roar.cs.berkeley.edu>
	<1a69a9d80901040021i1dae2c6j7337cf57eed6476a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git mailing list" <git@vger.kernel.org>
To: "Arnaud Lacombe" <lacombar@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 04 13:42:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJSJ4-0001KJ-SE
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 13:42:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbZADMkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 07:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbZADMkx
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 07:40:53 -0500
Received: from roar.CS.Berkeley.EDU ([128.32.36.242]:40335 "EHLO
	roar.quarl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795AbZADMkx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 07:40:53 -0500
Received: by roar.quarl.org (Postfix, from userid 18378)
	id 65163344D9; Sun,  4 Jan 2009 04:40:51 -0800 (PST)
X-Quack-Archive: 1
In-Reply-To: <1a69a9d80901040021i1dae2c6j7337cf57eed6476a@mail.gmail.com> (Arnaud Lacombe's message of "Sun\, 4 Jan 2009 03\:21\:47 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104513>

>>>>> On 2009-01-04 00:21 PST, Arnaud Lacombe writes:

    Arnaud> FWIW, I had this in a stalled modification in a tree,
    Arnaud> it just add the '-c' (as "current") option to git
    Arnaud> branch. Patch is mostly for the record :/

Thanks, glad someone else wanted this too.  If we modified
git-symbolic-ref it would probably be less code since it doesn't
have to loop over all branches, though from a UI perspective I
still prefer git-branch.  Anyway doesn't look like people like the
idea so how about that git-rev-parse --symbolic-abbrev-name idea
:)

    Arnaud> The main trouble I have with pipe stuff is that it
    Arnaud> forks a process for something that can be done
    Arnaud> natively. Previously, I was using awk(1) to extract
    Arnaud> the current branch:

    Arnaud> $ git branch | awk '/^\*/ {print $2}'

Yet another addition to the list of ways to pipeline it, this one
probably the shortest :)

[BTW, your patch mime type was application/octet-stream :(]
