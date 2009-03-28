From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 1/2] init: support --import to add all files and commit right after init
Date: Sat, 28 Mar 2009 14:09:23 +0100
Message-ID: <200903281409.24266.markus.heidelberg@web.de>
References: <1237978720-2500-1-git-send-email-pclouds@gmail.com> <200903281158.51012.markus.heidelberg@web.de> <alpine.DEB.1.00.0903281334490.12669@intel-tinevez-2-302>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Santi =?iso-8859-1?q?B=E9jar?= <santi@agolina.net>,
	Jeff King <peff@peff.net>,
	Nguydn =?iso-8859-1?q?Th=E1i_Ngdc?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 28 14:10:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnYJK-0003gN-QB
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 14:10:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562AbZC1NJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 09:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752885AbZC1NJ2
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 09:09:28 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:34342 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbZC1NJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 09:09:27 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id CF753FF195ED;
	Sat, 28 Mar 2009 14:09:24 +0100 (CET)
Received: from [89.59.72.204] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LnYHs-0001pZ-00; Sat, 28 Mar 2009 14:09:24 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0903281334490.12669@intel-tinevez-2-302>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19o0HIvsa9je+RIQtoUp7GYxnQCSi0O3YlYptce
	KKf+wD1BkhrOWz81aByI9uZsfSujQiPocANQ9X8x/0++QMVSmU
	zZ3TphJtM2GadkXJAOGg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114954>

Johannes Schindelin, 28.03.2009:
> Hi,
> 
> On Sat, 28 Mar 2009, Markus Heidelberg wrote:
> 
> > Johannes Schindelin, 27.03.2009:
> > > Others who want to have a quick way to work safely with something they 
> > > might need to change, and might then want to use the full power of Git 
> > > to see what they changed.  Without any need for a "nice" first commit.
> > 
> > What's the difference between the first commit and the others? I don't 
> > see the reason, not to have a short description for it.
> 
> Maybe you can learn a new trick here:
> 
> $ tar xf /some/random/project.tar
> $ git init
> $ git add .
> $ git commit -m initial
> 
> and now one of two work flows:
> 
> # get the thing to work properly, or add a new feature, or clean up...
> $ git diff > diff.patch
> # send the diff to the maintainer, without ever committing
> 
> or
> 
> # make a patch series, use rebase -i to clean up after it
> # send the patch series to the maintainer of the random project
> 
> See?  The initial commit does not matter at all.

Yep, I only thought about own projects and didn't take this workflow
into account. Although I have already used it myself and of course the
initial commit is not interesting then.

> I do this so often that it stops being funny having to type three 
> commands.
> 
> And having to edit a commit message I do not care about anyway everytime, 
> just to please you, would not make it any funnier ;-)

Understood :)
But note, that my second mail was only about writing an initial commit
message or not. I don't have objections against the default commit
message with --import any more.

Markus
