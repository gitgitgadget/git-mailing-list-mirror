From: Fredrik Tolf <fredrik@dolda2000.com>
Subject: Re: Manpage rendering faults
Date: Wed, 18 Jul 2007 22:06:36 +0200
Message-ID: <m3k5sxiiib.fsf@pc7.dolda2000.com>
References: <m3odi9im5y.fsf@pc7.dolda2000.com> <Pine.LNX.4.64.0707182024440.734@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 22:06:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBFnW-00024V-Jk
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 22:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759343AbXGRUGz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 16:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757096AbXGRUGz
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 16:06:55 -0400
Received: from main.gmane.org ([80.91.229.2]:50553 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754613AbXGRUGy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 16:06:54 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IBFnG-0000mD-F1
	for git@vger.kernel.org; Wed, 18 Jul 2007 22:06:42 +0200
Received: from 1-1-3-7a.rny.sth.bostream.se ([82.182.133.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jul 2007 22:06:42 +0200
Received: from fredrik by 1-1-3-7a.rny.sth.bostream.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jul 2007 22:06:42 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 1-1-3-7a.rny.sth.bostream.se
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:e2l5oifrue7fLTRccZzW/9t8va4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52895>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> On Wed, 18 Jul 2007, Fredrik Tolf wrote:
>
>> I often read manpages using a `man -t whatever | ggv -' command, since
>> I like how it is rendered in PostScript. However, it turns out that
>> some things in the Git manpages don't really render very well using
>> that method. For example, in the git-rebase manpage, there are two
>> history graphs that look like this when reading the manpages normally
>> in a terminal:
>
> It's a proportional font issue ...
>
> Running "groff -Tps -f C -man $(man -w git-rebase) | ggv -" should
> display it correctly.  (The "-f C" being the part the man doesn't do)
>
> No idea how to make it use that font by default though ... not even
> sure if you can put that kind of information into a man page?

Well, if it were a "pure" manpage, I'd try to use pic(1) to do it for
the PS version, but I don't suspect asciidoc has a similar feature. I
don't actually know, though -- again, I know virtually nothing about
asciidoc.

Fredrik Tolf
