From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Question about "git commit -a"
Date: Sun, 7 Oct 2007 14:26:39 +0200
Message-ID: <E0245DA3-1B32-47C3-88F9-BF2B4AAB084F@wincent.com>
References: <4d8e3fd30710040838t48bb590erbd90a8c4a1c6e932@mail.gmail.com> <545CB3B2-96B3-4853-9397-B42F4F268A15@wincent.com> <fcaeb9bf0710041333l636b2c1fn4d8f3298000127c7@mail.gmail.com> <Pine.LNX.4.64.0710042209410.4174@racer.site> <4d8e3fd30710050139j45a5a924t5c048994e3457c5f@mail.gmail.com> <4705FB52.3030208@op5.se> <1191599763.7117.18.camel@hinata.boston.redhat.com> <47067F68.2080709@gmx.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	Andreas Ericsson <ae@op5.se>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Marko Macek <Marko.Macek@gmx.net>
X-From: git-owner@vger.kernel.org Sun Oct 07 14:27:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeVEF-0001hA-4T
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 14:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568AbXJGM1Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Oct 2007 08:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752552AbXJGM1Q
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 08:27:16 -0400
Received: from wincent.com ([72.3.236.74]:59131 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142AbXJGM1P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Oct 2007 08:27:15 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l97CQpfG006663;
	Sun, 7 Oct 2007 07:26:53 -0500
In-Reply-To: <47067F68.2080709@gmx.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60175>

El 5/10/2007, a las 20:16, Marko Macek escribi=F3:

> In CVS and subversion (which has nicer working-copy command line =20
> interface IMHO),
> I simply make a copy of the working copy, revert the non-commitable =20
> parts, build,
> commit the minor changes, and then update the first copy. For =20
> larger projects,
> where this can be slow, I use diff/revert/patch.

This sounds painful compared to Dmitry's method (pasted below) if you =20
care about all published changes being buildable and passing all the =20
tests...

El 5/10/2007, a las 23:10, Dmitry Potapov escribi=F3:

> IMHO, the best practice is to recompile everything step-wise in
> a clean directory before you are going to publish your changes.
> It can be done automatically by script, while you do something
> useful, like reading this mailing-list :)

Cheers,
Wincent
