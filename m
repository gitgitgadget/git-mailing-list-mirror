From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: [OT] Your branch is ahead of the tracked remote branch
         'origin/master' by 50 commits.
Date: Tue, 01 Jul 2008 10:26:39 +0100
Message-ID: <80iqvq2bw0.fsf@tiny.isode.net>
References: <20080701091347.GA11817@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Tue Jul 01 11:33:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDcF5-000780-AL
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 11:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754175AbYGAJcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 05:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754043AbYGAJcp
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 05:32:45 -0400
Received: from rufus.isode.com ([62.3.217.251]:48036 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753972AbYGAJco (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 05:32:44 -0400
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Jul 2008 05:32:44 EDT
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with SMTP 
          id <SGn4TwAXxSza@rufus.isode.com>; Tue, 1 Jul 2008 10:26:39 +0100
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Tue, 01 Jul 2008 10:26:39 +0100
X-Hashcash: 1:20:080701:mingo@elte.hu::nL4sbyDfgZpc4IzB:000090Nj
X-Hashcash: 1:20:080701:git@vger.kernel.org::E197tHYoQhOSZIvt:0000000000000000000000000000000000000000002S8E
In-Reply-To: <20080701091347.GA11817@elte.hu> (Ingo Molnar's message of "Tue\, 1 Jul 2008 11\:13\:47 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87016>

Ingo Molnar <mingo@elte.hu> writes:

> i recently switched to 1.5.6.1.89.gd5446 and i'm getting this:
>
>   Switched to branch "master"
>   Your branch is ahead of the tracked remote branch 'origin/master' by 50 commits.
>
> it's a very useful detail! It's especially useful when two branches 
> diverge in a non-trivial way.

I agree, it's a really nice little feature.  Indeed, I occasionally do
"git checkout master" just to get the message (to see where I am).

It feels logical for "git status" to offer the same information (when
the information is appropriate).

[...]
