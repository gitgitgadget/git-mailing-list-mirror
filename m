From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: git-gui Ctrl-U (unstage) broken
Date: Mon, 30 Jan 2012 20:22:24 +0100
Message-ID: <20120130192223.GA21444@ecki>
References: <CAA5Ydx-mi7i7mWDYO=Cbw4g1b7LR0hw4Tcqe9gMtBoCkDRuvYA@mail.gmail.com>
 <877h0at7ua.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Victor Engmark <victor.engmark@gmail.com>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Jan 30 20:31:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrwwL-00035n-2P
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 20:30:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400Ab2A3Taw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 14:30:52 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:59901 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753374Ab2A3Taw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 14:30:52 -0500
Received: from localhost (p5B22FE88.dip.t-dialin.net [91.34.254.136])
	by bsmtp.bon.at (Postfix) with ESMTP id 5587BA7EC1;
	Mon, 30 Jan 2012 20:31:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <877h0at7ua.fsf@fox.patthoyts.tk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189407>

Hi Victor,

Victor Engmark <victor.engmark@gmail.com> writes:
>
> Version info:
> 
> git-gui version 0.12.0.64.g89d6
> git version 1.7.1
> 
> Tcl/Tk version 8.5.8
> Aspell 0.60.6, en_US

I could reproduce this issue on my Fedora 14 box at dayjob with the
git-gui package that corresponds to git version 1.7.4.4 (git-gui version
0.13.0.8.g8f855 according to git.git).

But I cannot reproduce with the current git version or even with git
1.7.1 and git-gui 0.12.0.64.g89d6 on my Arch Linux box, where I have
Tcl/Tk version 8.5.11.

I have to check which Tcl/Tk version the F14 box uses. But the bug does
not seem to depend on the git gui version. Have you tried upgrading
Tcl/Tk?

Clemens
