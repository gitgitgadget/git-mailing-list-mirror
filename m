From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Question about "git commit -a"
Date: Sat, 6 Oct 2007 01:10:11 +0400
Message-ID: <20071005211011.GB25125@potapov>
References: <4d8e3fd30710040838t48bb590erbd90a8c4a1c6e932@mail.gmail.com> <545CB3B2-96B3-4853-9397-B42F4F268A15@wincent.com> <fcaeb9bf0710041333l636b2c1fn4d8f3298000127c7@mail.gmail.com> <Pine.LNX.4.64.0710042209410.4174@racer.site> <4d8e3fd30710050139j45a5a924t5c048994e3457c5f@mail.gmail.com> <4705FB52.3030208@op5.se> <1191599763.7117.18.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>
To: Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 23:10:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IduRG-0001ul-RO
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 23:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762914AbXJEVKS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Oct 2007 17:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761765AbXJEVKR
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 17:10:17 -0400
Received: from smtp05.mtu.ru ([62.5.255.52]:64573 "EHLO smtp05.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756521AbXJEVKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 17:10:16 -0400
Received: from potapov.private (ppp85-140-169-127.pppoe.mtu-net.ru [85.140.169.127])
	by smtp05.mtu.ru (Postfix) with ESMTP id 8571A9798AB;
	Sat,  6 Oct 2007 01:10:13 +0400 (MSD)
Received: from potapov.private (localhost [127.0.0.1])
	by potapov.private (8.13.8/8.13.8/Debian-3) with ESMTP id l95LADlB028252;
	Sat, 6 Oct 2007 01:10:13 +0400
Received: (from dpotapov@localhost)
	by potapov.private (8.13.8/8.13.8/Submit) id l95LABi0028251;
	Sat, 6 Oct 2007 01:10:11 +0400
X-Authentication-Warning: potapov.private: dpotapov set sender to dpotapov@gmail.com using -f
Content-Disposition: inline
In-Reply-To: <1191599763.7117.18.camel@hinata.boston.redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60134>

On Fri, Oct 05, 2007 at 11:56:03AM -0400, Kristian H=F8gsberg wrote:
> I understand why people like staging and commit without -a, seeing ho=
w
> it's faster and all, but I have a serious problem with this practice
> that I haven't seen brought up on the list.  How do you know what you
> commit actually works or even compiles?

You don't. Even with 'commit -a' there is no guarantee that the
result will compile, because you can forget to add a new file.
IMHO, the best practice is to recompile everything step-wise in=20
a clean directory before you are going to publish your changes.
It can be done automatically by script, while you do something
useful, like reading this mailing-list :)

Dmitry
