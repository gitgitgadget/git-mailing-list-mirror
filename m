From: David Kastrup <dak@gnu.org>
Subject: Re: What's in git.git (stable)
Date: Sat, 28 Jul 2007 11:35:40 +0200
Organization: Organization?!?
Message-ID: <85bqdw27mb.fsf@lola.goethe.zz>
References: <7v4pmgqrut.fsf@assigned-by-dhcp.cox.net> <7vhcqccnbm.fsf@assigned-by-dhcp.cox.net> <7vveepz8pr.fsf@assigned-by-dhcp.cox.net> <7vmyzv1acz.fsf@assigned-by-dhcp.cox.net> <7vejl0546b.fsf@assigned-by-dhcp.cox.net> <7v4plqoyg5.fsf@assigned-by-dhcp.cox.net> <7v7iqgtt1j.fsf@assigned-by-dhcp.cox.net> <7vk5u7d38h.fsf@assigned-by-dhcp.pobox.com> <7vy7idydqa.fsf@assigned-by-dhcp.pobox.com> <7v7ipsz7vr.fsf@assigned-by-dhcp.pobox.com> <7vk5tj3bj1.fsf@assigned-by-dhcp.cox.net> <7vzm20q1l7.fsf_-_@assigned-by-dhcp.cox.net> <7vvec4synj.fsf_-_@assigned-by-dhcp.cox.net> <85zm1g3nze.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 28 11:36:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEiiq-0003iP-AX
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 11:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573AbXG1JgH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 05:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753616AbXG1JgG
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 05:36:06 -0400
Received: from main.gmane.org ([80.91.229.2]:60599 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753533AbXG1JgE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 05:36:04 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IEiiR-0001zL-Od
	for git@vger.kernel.org; Sat, 28 Jul 2007 11:36:03 +0200
Received: from dslb-084-061-039-045.pools.arcor-ip.net ([84.61.39.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Jul 2007 11:36:03 +0200
Received: from dak by dslb-084-061-039-045.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Jul 2007 11:36:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-039-045.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:I3yhZREeglJY7NP+Npseyn8+2JM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54019>

David Kastrup <dak@gnu.org> writes:

[...]

> If you use the desktop package, this means that you get a bear of a
> startup time while a _new_ instance of Emacs gets loaded against the
> wishes of the setup, and the command line parameters will be
> interpreted relatively to the last file restored into the desktop
> rather than the current directory (arguably a bug in the desktop
> package which I plan to fix eventually, but in the meantime the
> current package is farspread).

I can't reproduce anything similar outside of mergetool, so it appears
more likely that mergetool is passing wrong relative file names.

Have to leave now for the day.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
