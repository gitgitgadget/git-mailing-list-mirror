From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Build bug report: 'make check' needs sparse, but configure
	doesn't check it
Date: Sun, 5 Oct 2008 23:58:47 -0700
Message-ID: <20081006065847.GA27516@spearce.org>
References: <loom.20081004T131652-828@post.gmane.org> <20081005003446.GN21650@dpotapov.dyndns.org> <loom.20081005T094301-345@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ed Avis <eda@waniasset.com>
X-From: git-owner@vger.kernel.org Mon Oct 06 09:00:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kmk4X-0005bP-Kp
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 09:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbYJFG6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 02:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbYJFG6t
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 02:58:49 -0400
Received: from george.spearce.org ([209.20.77.23]:44369 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbYJFG6s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 02:58:48 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1897F3835F; Mon,  6 Oct 2008 06:58:47 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <loom.20081005T094301-345@post.gmane.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97566>

Ed Avis <eda@waniasset.com> wrote:
> Dmitry Potapov <dpotapov <at> gmail.com> writes:
> 
> >The whole point of 'make check' is to run 'sparce' on all files.
> 
> >If you want to build
> >and to test the resulting binaries then you run 'make test'.
> 
> To reduce confusion I suggest renaming the target to 'make sparse'.  Then it's
> obvious what it does and it can't get confused with the more common usage of
> 'make check'.

Nah.  We're not going to rename the target to "make sparse".
First off that sounds like we are compiling the sparse binary for
the user, and we will never do that.  And existing developers who
use "make check" to run sparse are used to that calling convention.

-- 
Shawn.
