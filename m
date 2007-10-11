From: Jean-Luc Herren <jlh@gmx.ch>
Subject: Re: Is it possible for git to support binary differencing for binary
 files?
Date: Thu, 11 Oct 2007 19:54:05 +0200
Message-ID: <470E633D.8060107@gmx.ch>
References: <20071011163746.DEB147E6F@mail.kooxoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?GB2312?B?0vjGvQ==?= <yinping@kooxoo.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 19:54:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig2Ex-0001wU-FJ
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 19:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755617AbXJKRyV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Oct 2007 13:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755632AbXJKRyV
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 13:54:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:46048 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755585AbXJKRyV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 13:54:21 -0400
Received: (qmail invoked by alias); 11 Oct 2007 17:54:18 -0000
Received: from 215-36.79-83.cust.bluewin.ch (EHLO [192.168.123.202]) [83.79.36.215]
  by mail.gmx.net (mp048) with SMTP; 11 Oct 2007 19:54:18 +0200
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX188RNUJMbM88EE4tZO6Batqh/rjH4WtRUEtlZZq2W
	I8IcMdVTI8OzVV
User-Agent: Thunderbird 2.0.0.6 (X11/20070805)
In-Reply-To: <20071011163746.DEB147E6F@mail.kooxoo.com>
X-Enigmail-Version: 0.95.3
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60618>

=D2=F8=C6=BD wrote:
> Hi.=20
> Storing binary files as deltas is helpful [...] So is it
> possible for git to do that as svn. This is my only pain when
> using git.

Yes, and git does this already in pack files.  Maybe you're not
seeing it because you haven't packed anything yet.  Try to run
'git gc'.

jlh
