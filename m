From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: 'git branch' when origin branch with same name exists
Date: Tue, 19 Jun 2012 19:21:50 +0200
Message-ID: <87a9zztdxt.fsf@thomas.inf.ethz.ch>
References: <4FE091FB.7020202@desrt.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Ryan Lortie <desrt@desrt.ca>
X-From: git-owner@vger.kernel.org Tue Jun 19 19:22:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh27q-0001Lh-4S
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 19:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367Ab2FSRVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 13:21:54 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:54545 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751958Ab2FSRVx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 13:21:53 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Jun
 2012 19:21:50 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Jun
 2012 19:21:50 +0200
In-Reply-To: <4FE091FB.7020202@desrt.ca> (Ryan Lortie's message of "Tue, 19
	Jun 2012 10:51:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200214>

Ryan Lortie <desrt@desrt.ca> writes:

> In this case, the user wanted to checkout a branch of a module.  They did:
>
>   git clone git://git.gnome.org/gtk+
>   cd gtk+
>   git branch gtk-3-4
>
> Obviously this is a user error, but it's a pretty innocent one, and
> puts the user in a bad state.  When they figure they should have typed
> "git checkout gtk-3-4" it is already too late -- they will be taken
> onto their locally-created copy of the master branch.
>
> So feature request: 'git branch' should not allow creating a local
> branch that has the same name as a branch that already exists on
> origin' (or any remote?) without some sort of --force flag.

How does this fit with the fact that git has forever(?) created a
'master' branch when cloning, and usually points it at origin/master
too?

I honestly haven't decided whether I should like or hate your proposal,
but ISTM that outlawing an operation that git does on every clone is a
bit moot.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
