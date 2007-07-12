From: Fredrik Tolf <fredrik@dolda2000.com>
Subject: Volume of commits
Date: Thu, 12 Jul 2007 15:16:47 +0200
Message-ID: <m3ps2xu5hc.fsf@pc7.dolda2000.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 15:20:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8yaY-0002Sm-2C
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 15:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763984AbXGLNUH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 09:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763965AbXGLNUG
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 09:20:06 -0400
Received: from main.gmane.org ([80.91.229.2]:52066 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759358AbXGLNUE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 09:20:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1I8yaQ-0006ZF-P0
	for git@vger.kernel.org; Thu, 12 Jul 2007 15:20:02 +0200
Received: from 1-1-3-7a.rny.sth.bostream.se ([82.182.133.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Jul 2007 15:20:02 +0200
Received: from fredrik by 1-1-3-7a.rny.sth.bostream.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Jul 2007 15:20:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 1-1-3-7a.rny.sth.bostream.se
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:neWPMLKQX5uhtt4B0Um79yfjSks=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52286>

Hi List,

I was wondering -- whenever I see Git patches committed to projects
like the Linux kernel or Git itself, the commits always seems to be
committing rather large changes and be rather well-defined in terms of
what they change.

When I develop for myself, I usually commit incrementally quite a
bit, if for no other reason because Git won't let me switch between
branches if I don't commit first. I usually try to keep my commits
well-defined, but I don't manage to get anywhere close to what I see
when I look at the history of Linux or Git.

So what I'm wondering is how you people manage to do this? Do you
actually always commit changes this way (and, in that case, how do you
switch between branches)? Or do you somehow aggregate the smaller
commits into larger patches and recommit them? Or is there some third
possibility that I'm missing?

Fredrik Tolf
