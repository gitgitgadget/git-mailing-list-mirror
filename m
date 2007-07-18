From: Fredrik Tolf <fredrik@dolda2000.com>
Subject: Manpage rendering faults
Date: Wed, 18 Jul 2007 20:47:37 +0200
Message-ID: <m3odi9im5y.fsf@pc7.dolda2000.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 20:48:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBEZa-0007xw-PL
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 20:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbXGRSsB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 14:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759804AbXGRSsB
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 14:48:01 -0400
Received: from main.gmane.org ([80.91.229.2]:54333 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759724AbXGRSsA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 14:48:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IBEYu-0001NS-Jz
	for git@vger.kernel.org; Wed, 18 Jul 2007 20:47:48 +0200
Received: from 1-1-3-7a.rny.sth.bostream.se ([82.182.133.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jul 2007 20:47:48 +0200
Received: from fredrik by 1-1-3-7a.rny.sth.bostream.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jul 2007 20:47:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 1-1-3-7a.rny.sth.bostream.se
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:f3xw0qx25IZ5KzwQuRg/1A4N2hk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52891>

I often read manpages using a `man -t whatever | ggv -' command, since
I like how it is rendered in PostScript. However, it turns out that
some things in the Git manpages don't really render very well using
that method. For example, in the git-rebase manpage, there are two
history graphs that look like this when reading the manpages normally
in a terminal:

      A---B---C topic
     /
D---E---F---G master

and then

              A'--B'--C' topic
             /
D---E---F---G master

However, in the PostScript rendering, they look rather like this:

  A---B---C topic
 /
D---E---F---G master

and then

      A'--B'--C' topic
     /
D---E---F---G master

It took me quite a while to figure out that the rendering was
wrong. Before that, I just couldn't figure out why git-rebase would do
that. :)

Unfortunately, I can't say that I have a fix available -- particularly
as I don't really know anything at all about asciidoc. I thought I'd
at least let you know, though.

Fredrik Tolf
