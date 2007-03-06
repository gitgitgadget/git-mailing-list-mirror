From: Michael Poole <mdpoole@troilus.org>
Subject: Re: Git checkout preserve timestamp?
Date: Mon, 05 Mar 2007 19:37:44 -0500
Message-ID: <87wt1vqk9z.fsf@graviton.dyn.troilus.org>
References: <17895.18265.710811.536526@lisa.zopyra.com>
	<Pine.LNX.4.63.0703022018190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070305072323.GA31169@diana.vm.bytemark.co.uk>
	<Pine.LNX.4.63.0703051230390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17900.27067.247950.419438@lisa.zopyra.com>
	<Pine.LNX.4.63.0703052014020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17900.30394.172067.743310@lisa.zopyra.com>
	<Pine.LNX.4.63.0703052143120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17900.36569.805689.922989@lisa.zopyra.com>
	<Pine.LNX.4.64.0703051347490.3998@woody.linux-foundation.org>
	<17900.39124.763603.695942@lisa.zopyra.com>
	<Pine.LNX.4.64.0703051431130.3998@woody.linux-foundation.org>
	<17900.42415.750335.329874@lisa.zopyra.com>
	<Pine.LNX.4.63.0703060026340.13683@wbgn013.biozentrum.uni-wuerzburg.de>
	<17900.43487.947400.649777@lisa.zopyra.com>
	<Pine.LNX.4.63.0703060042040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<87zm6rqlpn.fsf@graviton.dyn.troilus.org>
	<Pine.LNX.4.63.0703060119320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 06 01:37:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HONgg-00036P-0Q
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 01:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933662AbXCFAhp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 19:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933671AbXCFAhp
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 19:37:45 -0500
Received: from 24-75-174-210-st.chvlva.adelphia.net ([24.75.174.210]:37380
	"EHLO sanosuke.troilus.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933662AbXCFAho (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2007 19:37:44 -0500
Received: by sanosuke.troilus.org (Postfix, from userid 1000)
	id 5EFE089C03C; Mon,  5 Mar 2007 19:37:44 -0500 (EST)
In-Reply-To: <Pine.LNX.4.63.0703060119320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 6 Mar 2007 01:20:31 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.19 (linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41515>

Johannes Schindelin writes:

> Hi,
>
> On Mon, 5 Mar 2007, Michael Poole wrote:
>
>> I have not found a git workflow that makes me entirely happy, but I 
>> suspect I just don't know the magic words.
>
> So, what do you want to do?

I want to have several local directories -- including build products
and configuration files that are neither build products nor revision
controlled -- that correspond to certain branches of one project.
(Sometimes I have several trees for a single branch, to handle
compile-time alternatives.)  I do not much care whether there is a
separate source tree for each of these or not.

When I switch from working on one branch to another, I do not want
file timestamps to be any later than the corresponding object was
changed in the repository.

When I change configuration options (including which branch(es) go to
which remote(s)), I want to make that change in one $GIT_DIR rather
than in one $GIT_DIR for each branch.

As a lower priority, I would like a fetch on any of the branches to
have results that are visible to all my local copies without more
network traffic.

The first two goals are neatly solved by having several local clones.
The third and fourth are where I get lost.

Michael Poole
