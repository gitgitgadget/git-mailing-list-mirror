From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [BUG ?] completion of stash name with git stash
Date: Thu, 19 Jan 2012 17:18:04 +0100
Message-ID: <87lip3mzsz.fsf@thomas.inf.ethz.ch>
References: <loom.20120119T141601-606@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Mathieu CLAVEL <math.clavel@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 19 17:18:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rnugo-0002Ev-2z
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 17:18:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515Ab2ASQSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 11:18:09 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:17420 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932499Ab2ASQSH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 11:18:07 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 19 Jan
 2012 17:18:04 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 19 Jan
 2012 17:18:04 +0100
In-Reply-To: <loom.20120119T141601-606@post.gmane.org> (Mathieu CLAVEL's
	message of "Thu, 19 Jan 2012 13:21:53 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188818>

Mathieu CLAVEL <math.clavel@gmail.com> writes:

> I'm using mysgit 1.7.8 on XP.
>
> I think the stash name completion has a problem.
> I don't know if it's a problem from my system, mysgit or git.
>
> Here are the steps to reproduce (you need to have at least 2 stashed commits).
> '+ tab =>' means using the tab to autocomplete the current command. Left part is
> before completion, right tab is after completion.
>
> $ git stash list
> stash@{0}: WIP on feature/preservation_offres: 7f2c9a8 import.cmd : import par
> lot de 10.000 contrats
> stash@{1}: WIP on feature/echeancier: ddb7bb0 Mockito : 1.8.5 -> 1.9.0
>
> $ git stash drop '+ tab =>' $ git stash drop stash@{
>
> $ git stash drop stash@{0 '+ tab =>' $ git stash drop stashstash@{0}
>
> I don't know if it's relevant, but I also have 'git flow' and 'git flow
> completion' installed, and as said in a previous thread, 'git flow completion'
> isn't working with alias [2].

This works for me using git completion as shipped with v1.7.9-rc2 and
bash 4.2.10.  Double-tabbing at 'git stash drop ' prints a list of
stashes as expected.  Which bash version are you using?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
