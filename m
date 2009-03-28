From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] init: support --import to add all files and commit
 right after init
Date: Sat, 28 Mar 2009 13:39:07 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903281334490.12669@intel-tinevez-2-302>
References: <1237978720-2500-1-git-send-email-pclouds@gmail.com> <200903262223.28546.markus.heidelberg@web.de> <alpine.DEB.1.00.0903270259470.10279@pacific.mpi-cbg.de> <200903281158.51012.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>,
	Jeff King <peff@peff.net>,
	=?ISO-8859-15?Q?Nguydn_Th=E1i_Ngdc?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Sat Mar 28 13:41:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnXqQ-0004LX-Cb
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 13:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215AbZC1MjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 08:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753753AbZC1MjP
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 08:39:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:58291 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752882AbZC1MjP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 08:39:15 -0400
Received: (qmail invoked by alias); 28 Mar 2009 12:39:11 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp013) with SMTP; 28 Mar 2009 13:39:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ZJZYaWlxZmXrFgYv5f9w77SQM6HOhxt4zc487a6
	dMATdb2aRwgnBt
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <200903281158.51012.markus.heidelberg@web.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114951>

Hi,

On Sat, 28 Mar 2009, Markus Heidelberg wrote:

> Johannes Schindelin, 27.03.2009:
> > Others who want to have a quick way to work safely with something they 
> > might need to change, and might then want to use the full power of Git 
> > to see what they changed.  Without any need for a "nice" first commit.
> 
> What's the difference between the first commit and the others? I don't 
> see the reason, not to have a short description for it.

Maybe you can learn a new trick here:

$ tar xf /some/random/project.tar
$ git init
$ git add .
$ git commit -m initial

and now one of two work flows:

# get the thing to work properly, or add a new feature, or clean up...
$ git diff > diff.patch
# send the diff to the maintainer, without ever committing

or

# make a patch series, use rebase -i to clean up after it
# send the patch series to the maintainer of the random project

See?  The initial commit does not matter at all.

I do this so often that it stops being funny having to type three 
commands.

And having to edit a commit message I do not care about anyway everytime, 
just to please you, would not make it any funnier ;-)

I'll just repeat one of my favorite mantras: optimize for the common case, 
not for the uncommon case.

Ciao,
Dscho
