From: Marko Macek <Marko.Macek@gmx.net>
Subject: Re: Question about "git commit -a"
Date: Fri, 05 Oct 2007 20:16:08 +0200
Message-ID: <47067F68.2080709@gmx.net>
References: <4d8e3fd30710040838t48bb590erbd90a8c4a1c6e932@mail.gmail.com> <545CB3B2-96B3-4853-9397-B42F4F268A15@wincent.com> <fcaeb9bf0710041333l636b2c1fn4d8f3298000127c7@mail.gmail.com> <Pine.LNX.4.64.0710042209410.4174@racer.site> <4d8e3fd30710050139j45a5a924t5c048994e3457c5f@mail.gmail.com> <4705FB52.3030208@op5.se> <1191599763.7117.18.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 20:18:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdrkX-0000GN-LM
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 20:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755434AbXJESSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 14:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755261AbXJESSA
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 14:18:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:34730 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754760AbXJESR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 14:17:59 -0400
Received: (qmail invoked by alias); 05 Oct 2007 18:17:58 -0000
Received: from BSN-77-244-89.dial-up.dsl.siol.net (EHLO [192.168.2.7]) [193.77.244.89]
  by mail.gmx.net (mp055) with SMTP; 05 Oct 2007 20:17:58 +0200
X-Authenticated: #420190
X-Provags-ID: V01U2FsdGVkX1/7Z79jLbL7D2cF0H9b6LSindhhlHYl6SdIbBc6tf
	QSPw0S98wgr6L4
User-Agent: Thunderbird 2.0.0.5 (X11/20070716)
In-Reply-To: <1191599763.7117.18.camel@hinata.boston.redhat.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60121>


> I understand why people like staging and commit without -a, seeing how
> it's faster and all, but I have a serious problem with this practice
> that I haven't seen brought up on the list.  How do you know what you
> commit actually works or even compiles?  The reason that I almost
> exclusively use -a with commit is that I want to know that what I just
> compiled and tested is what I will be committing.  I don't want to just
> commit half the files in my working copy, I want to make sure that the
> exact state of my project that I just compiled and tested is what gets
> into version controlled history.
> 
> git commit -a isn't sloppy to me - eye balling some subset of your
> working copy and committing that under the assumption that you don't
> make mistakes and don't need to compile what you commit... that is
> sloppy.

Agreed. For this reason git-commit without -a, staging, index, ... is
not really interesting to me.

In CVS and subversion (which has nicer working-copy command line interface IMHO),
I simply make a copy of the working copy, revert the non-commitable parts, build,
commit the minor changes, and then update the first copy. For larger projects,
where this can be slow, I use diff/revert/patch.

Small checkins are nice for git-bisect, but if they don't build...

Mark
