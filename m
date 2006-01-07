From: walt <wa1ter@myrealbox.com>
Subject: Does git belong in root's $PATH?
Date: Sat, 7 Jan 2006 09:21:08 -0800
Organization: DFly
Message-ID: <Pine.LNX.4.64.0601070838470.6317@x2.ybpnyarg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Jan 07 18:21:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvHkx-00061J-D7
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 18:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030505AbWAGRVZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 12:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030506AbWAGRVZ
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 12:21:25 -0500
Received: from main.gmane.org ([80.91.229.2]:26085 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030505AbWAGRVY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 12:21:24 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EvHkn-000600-V9
	for git@vger.kernel.org; Sat, 07 Jan 2006 18:21:22 +0100
Received: from adsl-69-234-210-171.dsl.irvnca.pacbell.net ([69.234.210.171])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Jan 2006 18:21:21 +0100
Received: from wa1ter by adsl-69-234-210-171.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Jan 2006 18:21:21 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-210-171.dsl.irvnca.pacbell.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14263>

When updated my kernel this morning, the same way I've been doing
it for many months, I noticed that the -gxxxxxxx localversion
string was missing from the new kernel's name.

I finally figured out that this happened because /usr/local/bin
is not in my root's $PATH, and the setlocalversion script depends
on git.  (The only thing I do as root is 'make install').

I suppose I'm asking a philosophical question here:  do you
guys install git where root can find it (as a system tool)?
Does it really matter?  (The linux distribution I use is very
picky about what it includes in root's path...)

Thanks!
