From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to re-use setups in multiple tests?
Date: Mon, 1 Oct 2007 12:45:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710011243230.28395@racer.site>
References: <550f9510710010327l3e729ff1tbbb9b6c674c1cb11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Tom Clarke <tom@u2i.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 13:46:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcJjB-0002pg-Pz
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 13:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbXJALqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 07:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbXJALqO
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 07:46:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:57850 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751785AbXJALqN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 07:46:13 -0400
Received: (qmail invoked by alias); 01 Oct 2007 11:46:12 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp029) with SMTP; 01 Oct 2007 13:46:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+gNb0hsxCg5RDFbgq29h/pfaCLTvAvvZOw18aKfn
	Fi4TWeUEsSYsN4
X-X-Sender: gene099@racer.site
In-Reply-To: <550f9510710010327l3e729ff1tbbb9b6c674c1cb11@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59605>

Hi,

On Mon, 1 Oct 2007, Tom Clarke wrote:

> I'm wondering if there's a pattern for re-using setups across several 
> tests, similar to how a setUp function is used in xUnit. The problem is 
> I need the setup to actually be re-run, for each test to start from a 
> clean slate, so using the following doesn't work as the setup is just 
> run before the first test.

We typically do the clean up phase explicitely.  Or avoid it.

Example: you want to do something to a branch, but the next step should 
use the original state of the branch.

Solution: "git checkout -b new-branch HEAD~5"

Sorry, unless you are a little less mysterious about the exact use case 
you have in mind, I cannot help more.

Ciao,
Dscho
