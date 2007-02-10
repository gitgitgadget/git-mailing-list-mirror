From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: 'git status' is not read-only fs friendly
Date: Sat, 10 Feb 2007 21:36:33 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702102135080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
 <Pine.LNX.4.63.0702101517360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <e5bfff550702100631w1b6243e7i44039ceaa8d3fe93@mail.gmail.com>
 <Pine.LNX.4.63.0702101536090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <e5bfff550702100648p6db5fc67vb5e4a04d40771922@mail.gmail.com>
 <e5bfff550702100651j244e5a2flf02fb91dc71799b3@mail.gmail.com>
 <7v1wkykmj1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@gmail.com>,
	GIT list <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 10 21:36:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFyxf-00011l-5b
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 21:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbXBJUgf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 15:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbXBJUgf
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 15:36:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:56341 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751886AbXBJUgf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 15:36:35 -0500
Received: (qmail invoked by alias); 10 Feb 2007 20:36:33 -0000
X-Provags-ID: V01U2FsdGVkX1/AkGpRpFPAzFXWcGvrBVqTWO9RCef1U4t3SyaVSo
	thhg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v1wkykmj1.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39258>

Hi,

On Sat, 10 Feb 2007, Junio C Hamano wrote:

> About "Cygwin and Linux NTFS seem to disagree with lstat(2)"
> problem.  Is it really what is happening here?

Probably. AFAIR Windows lacks some important information, which is filled 
with zeroes by Cygwin.

Note that this problem already arises between Cygwin and MinGW, and it 
cannot be fixed: Cygwin _has_ symlinks, while MinGW has _not_.

Ciao,
Dscho
