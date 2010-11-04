From: Yann Dirson <ydirson@free.fr>
Subject: Re: [PATCH] git-rebase--interactive.sh: Add new command "shell"
Date: Thu, 4 Nov 2010 21:53:08 +0100
Message-ID: <20101104205307.GA8911@home.lan>
References: <9C0BAFB4-299E-459B-A64A-54D480C5445D@sb.org>
 <20101104112530.5c0e444a@chalon.bertin.fr>
 <4CD2E7B4.3000908@nextest.com>
 <vpq62wddmc0.fsf@bauges.imag.fr>
 <20101104181020.GB16431@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Raible <raible@nextest.com>,
	Yann Dirson <dirson@bertin.fr>, kevin@sb.org,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 21:53:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE6oF-0007Rr-Nd
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 21:53:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078Ab0KDUxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 16:53:19 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:49424 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739Ab0KDUxS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 16:53:18 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 38038D480AE;
	Thu,  4 Nov 2010 21:53:09 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PE6o0-0002K5-1j; Thu, 04 Nov 2010 21:53:08 +0100
Content-Disposition: inline
In-Reply-To: <20101104181020.GB16431@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160765>

On Thu, Nov 04, 2010 at 01:10:20PM -0500, Jonathan Nieder wrote:
> How about:
> 
> # Commands:
> #  p, pick = use commit
> #  r, reword = use commit, but edit the commit message
> #  e, edit = use commit, but stop for amending
> #  s, squash = use commit, but meld into previous commit
> #  f, fixup = like "squash", but discard this commit's log message
> #  x, exec = run command using shell, and stop if it fails
> #
> # The argument to edit is optional; if left out, it means to
> # stop to examine or amend the previous commit.
> #
> # If you remove a line here, THAT COMMIT WILL BE LOST.
> # However, if you remove everything, the rebase will be aborted.
> # Use the noop command if you really want to remove all commits.

That may be too far from the "edit" line, although I do like the idea
of mentionning other uses than "amend".

Eric Raible suggested:
> How about:
>
> #  e [<commit>], edit [<commit>] = use commit (if present) but pause to amend

Other commands do not mention commit (or other things) as a synopsis would.
What about:

#  e, edit = use commit (if specified) but pause to amend/examine/test
