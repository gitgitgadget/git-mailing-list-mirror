From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: git push
Date: Thu, 5 Mar 2009 10:44:10 +0100
Message-ID: <20090305094410.GA26120@pvv.org>
References: <43d8ce650902242238s7ab4c851p9c820c96b67aa62b@mail.gmail.com> <7vskm3c84t.fsf@gitster.siamese.dyndns.org> <20090225225826.GA13510@pvv.org> <49AF9117.1020407@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Mar 05 10:45:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfA9C-00082u-Qh
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 10:45:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442AbZCEJoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 04:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752185AbZCEJoR
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 04:44:17 -0500
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:38412 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbZCEJoR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 04:44:17 -0500
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1LfA7e-0005Pk-HM; Thu, 05 Mar 2009 10:44:10 +0100
Content-Disposition: inline
In-Reply-To: <49AF9117.1020407@op5.se>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112279>

On Thu, Mar 05, 2009 at 09:45:11AM +0100, Andreas Ericsson wrote:

> Worst-case scenario, you commits that were never intended for publication
> enter your public wateringhole and needs a revert later on. Big deal.

It could be a very big deal depending on what the contents are. I
think you can split developers in two groups - those who like to learn
a lot about version control systems, and those who just see it as a
necessary evil to get their job done. The latter seems to be the
majority.

The first group will know how to undo the damage from a bad push (and
probably configure their setup so they do not necessarily happen),
while the second group will not necessarily notice that it happened or
know how to undo it. So, bad pushes go through, and are not detected
before 3 other people base their work on it, and we get a lot of
hassle.

>> It is not realistic to believe that in a big project with many
>> developers, no one will ever do the mistake of typing "git push".  It
>> is also not realistic to believe that everyone will know how to (or
>> remember to) configure this away.
>
> But it *is* realistic to not assume that they will also use --force
> while doing so.

Our public repos are set up so that only a few chosen people are
allowed to force pushes, so this is not an issue for us.

>> If "git push" could do nothing at all without configuring anything, that
>> would be a big improvement to us.
>
> I can buy this, I guess. I always type the remote-name I want to push to
> anyways. A sane no-op default would probably be to list the pre-configured
> remotes along with a short usage message. I still don't quite see the point
> of it.

I'll try to whip up a small patch series tonight and see what it ends
up looking like.

- Finn Arne
