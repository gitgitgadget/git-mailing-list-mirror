From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: How to merge into my working copy?
Date: Fri, 06 Nov 2009 14:59:32 +0000
Message-ID: <80aayzg0mj.fsf@tiny.isode.net>
References: <e2a1d0aa0911060653t7bbb54ebp948eac0dffeaba64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 16:05:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6QNi-0007MU-PQ
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 16:05:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758583AbZKFPFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 10:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758565AbZKFPFb
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 10:05:31 -0500
Received: from rufus.isode.com ([62.3.217.251]:55972 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758431AbZKFPFb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 10:05:31 -0500
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Nov 2009 10:05:30 EST
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with SMTP 
          id <SvQ51AAJmYAo@rufus.isode.com>; Fri, 6 Nov 2009 14:59:32 +0000
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Fri, 06 Nov 2009 14:59:32 +0000
X-Hashcash: 1:20:091106:wpdster@gmail.com::VRZADsswhaVeDNgx:000000000000000000000000000000000000000000000Gjq
X-Hashcash: 1:20:091106:git@vger.kernel.org::plvddtbBw/eyYyiA:0000000000000000000000000000000000000000005VwK
In-Reply-To: <e2a1d0aa0911060653t7bbb54ebp948eac0dffeaba64@mail.gmail.com>
	(Patrick Doyle's message of "Fri, 6 Nov 2009 09:53:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132302>

Patrick Doyle <wpdster@gmail.com> writes:

[...]

> Basically, I created a branch off my mainline branch a few days ago.
> Made some commits on that branch.  Then went back to my mainline
> branch, made a few commits there, and now I would like to make my
> working copy look like a merge of its current state with the changes
> from the branch, minus any associated commits.
>
> I probably should have just used git-stash to tuck those changes away,
> but I didn't.

Rather than spending time worrying about optimal ways to do this,
wouldn't it work just to do merge (to get the right tree) followed by
rebase -i to get the commits in the way you want (removing the merge,
anyway)?

[...]
