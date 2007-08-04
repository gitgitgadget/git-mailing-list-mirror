From: David Kastrup <dak@gnu.org>
Subject: Terminology question about remote branches.
Date: Sat, 04 Aug 2007 12:55:43 +0200
Message-ID: <854pjfin68.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 04 12:55:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHHIZ-0001VN-4F
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 12:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756195AbXHDKzv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 06:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755745AbXHDKzv
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 06:55:51 -0400
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:37315 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754842AbXHDKzv (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2007 06:55:51 -0400
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id 24F7713019
	for <git@vger.kernel.org>; Sat,  4 Aug 2007 12:55:50 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id EED842DA967
	for <git@vger.kernel.org>; Sat,  4 Aug 2007 12:55:49 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-010-037.pools.arcor-ip.net [84.61.10.37])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id D12B236E869
	for <git@vger.kernel.org>; Sat,  4 Aug 2007 12:55:49 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 299751C4F932; Sat,  4 Aug 2007 12:55:43 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54822>


I am trying to dig through man-pages and user manual and trying to
match them with reality.  I seem to have a hard time.  My current
understanding (which definitely differs from the documented state) is
that there are two types of branches, local and remote branches, and
both types of branches can be remote-tracking (it may not be possible
to have a non-remote-tracking remote branch, though).

A local branch is one with a local branch head.  In contrast, checking
out a remote branch, while possible, leaves one with a detached head.

"remote-tracking" basically means that git-pull will update the branch
according to changes in the remote repository.

Creating a branch using git-branch or git-checkout will always create
a local branch which may or may not be remote-tracking according to
the --no-track or --track options.

So there are basically three types of branches in a repository that I
can see:

local branch, not remote-tracking
local branch, remote-tracking
remote branch, remote-tracking

The way to add a remote branch basically is not via git-branch or
git-checkout -b (those always create local branches), but by editing
.git/config.

Is this understanding correct or did I get things completely wrong?
Because there is little sense in myself working on changing the
documentation if I have not understood the situation.

Also, the documentation currently uses "remote-tracking"
interchangeably for "local branch, remote-tracking" and "remote
branch, remote-tracking", at some times claiming that one can locally
switch to a "remote-tracking" branch, at other times not.

So the terminology seems fuzzy at the moment, and my attempt to clear
it up might not be the preferred way of doing it.

Thanks,

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
