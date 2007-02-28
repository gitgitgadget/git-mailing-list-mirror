From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How do get a specific version of a particular file?
Date: Wed, 28 Feb 2007 01:01:13 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702280059050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <E1HM1XL-00071C-N5@candygram.thunk.org>
 <Pine.LNX.4.63.0702271356040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070227154241.GA8228@thunk.org> <Pine.LNX.4.63.0702272053080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070227223929.GA9027@thunk.org> <86vehnnpy2.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 01:01:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMCFy-0005yR-4g
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 01:01:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661AbXB1ABP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 19:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752662AbXB1ABP
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 19:01:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:55959 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752661AbXB1ABO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 19:01:14 -0500
Received: (qmail invoked by alias); 28 Feb 2007 00:01:13 -0000
X-Provags-ID: V01U2FsdGVkX18GrYhEfPUGZWzp3JoKsGK7CdSX0qxybHeYY0Ft8x
	owow==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <86vehnnpy2.fsf@blue.stonehenge.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40857>

Hi,

On Tue, 27 Feb 2007, Randal L. Schwartz wrote:

> >>>>> "Theodore" == Theodore Tso <tytso@mit.edu> writes:
> 
> Theodore> And I'm still not sure why
> 
> Theodore> 	git show v1.5.0..v1.5.0.1 
> 
> Theodore> doesn't throw an error, and why it prints what it does...
> 
> Wait, that doesn't throw an error?
> 
> (tries it)
> 
> OK, how is that different from git-diff ?

	$ git diff v1.5.0..v1.5.0.1

shows the differences between those two 
versions;

	$ git show v1.5.0..v1.5.0.1

is _identical_ to

	$ git show v1.5.0 v1.5.0.1

and shows the same as

	$ git show v1.5.0; git show v1.5.0.1

i.e. the commit diffs of both commits.

Ciao,
Dscho
