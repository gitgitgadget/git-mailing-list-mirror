From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Have a flag to stop the option parsing at the first
 argument.
Date: Mon, 17 Dec 2007 12:55:52 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712171253290.9446@racer.site>
References: <20071217095014.GF7453@artemis.madism.org>
 <30351C09-8BED-4D81-ABDD-2E079B4D54D2@wincent.com> <20071217114703.GH7453@artemis.madism.org>
 <Pine.LNX.4.64.0712171149540.9446@racer.site> <3CF3CEA5-72F1-47D1-ADB9-37F5C2E292A8@wincent.com>
 <Pine.LNX.4.64.0712171223210.9446@racer.site> <26962818-F702-44D2-BD26-95D74CE21F0D@wincent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 13:56:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4FWL-00049d-0v
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 13:56:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499AbXLQM4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 07:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753457AbXLQM4H
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 07:56:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:48363 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753226AbXLQM4G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 07:56:06 -0500
Received: (qmail invoked by alias); 17 Dec 2007 12:56:04 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp005) with SMTP; 17 Dec 2007 13:56:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19qrq56Ex5q+mhEcYJ2+Vjwh/JDyCQHiD3lb3YW12
	TdhTGypfWr1JBE
X-X-Sender: gene099@racer.site
In-Reply-To: <26962818-F702-44D2-BD26-95D74CE21F0D@wincent.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68561>

Hi,

On Mon, 17 Dec 2007, Wincent Colaiuta wrote:

> El 17/12/2007, a las 13:26, Johannes Schindelin escribi?:
> 
> > I think it is wrong to go out of our way to support "git status -p" as 
> > a synonym to "git -p status".  I simply do not believe that newcomers 
> > are not intelligent enough to understand that "git -p <subcommand>" 
> > means that the output goes into their pager.
> 
> But the point is, of all the special options, -p is the *only* that 
> can't unambiguously go after the subcommand.

It should not be put after the subcommand.  That's my point.  Exactly 
because it is -- even conceptually -- no subcommand option.

CVS has many shortcomings, but one lesson here is that people had no 
problems with "cvs -z3 update -d -P".  See, the "-z3" is an option that 
has nothing to do with the subcommand.

Exactly the same situation here.  I never had any problems explaining why 
"-p" goes before the subcommand here.  Never.

Ciao,
Dscho
