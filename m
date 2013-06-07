From: Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: branch.<name>.pushremote not working with push.default simple or
 upstream
Date: Fri, 7 Jun 2013 19:07:52 +0200
Message-ID: <20130607170752.GI28668@sociomantic.com>
References: <20130607124146.GF28668@sociomantic.com>
 <CALkWK0miONv_O67SHcfJoXq1x7xPvKu6uefg+TiPGbF-1WJ-bg@mail.gmail.com>
 <7v8v2lvs5s.fsf@alter.siamese.dyndns.org>
 <20130607161402.GH28668@sociomantic.com>
 <CALkWK0=v2vF7oGG3yUAXfaGdodCrkbvmQA+z9hMcoeMUFGFgsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 19:08:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul08w-0007Mn-V1
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 19:08:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754902Ab3FGRH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 13:07:58 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:50887 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753453Ab3FGRH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 13:07:58 -0400
Received: from labs09.localdomain (pD957613F.dip0.t-ipconnect.de [217.87.97.63])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0LpeUg-1U84pL0fOY-00fOfr; Fri, 07 Jun 2013 19:07:53 +0200
Received: from luca by labs09.localdomain with local (Exim 4.76)
	(envelope-from <leandro.lucarella@sociomantic.com>)
	id 1Ul08m-0001ZE-8N; Fri, 07 Jun 2013 19:07:52 +0200
Content-Disposition: inline
In-Reply-To: <CALkWK0=v2vF7oGG3yUAXfaGdodCrkbvmQA+z9hMcoeMUFGFgsg@mail.gmail.com>
X-Paranoid: Just because you're paranoid, don't mean they're not after you.
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:oO3NbhfGUo2jWUcVXqKJT6m2Bum7MCrAbq2fLWxoCKf
 7iAWJbtALlW7g8K4C8p5RKzOUmjJu1+PgEtethcQcwCCqfoVd4
 U9IiYC/OIOzMIGVdbELmBw1djSK0+7UYDNJqECTSikB6FIREDm
 vQlr0MtfO8EqHtCXRyt0B9jAS76grfO9CmjQK5URc2zzH6AsJk
 dYPFSEI2LO3+Xug1XeQOMipGvUAS83c6W5gsTGKx5zAeYuWhsK
 6A/Thry38mTN9RS1ULClOLlktu2AKmbfiOWgN0nX8Pvoc0KnUg
 iYxq5BR0NmxFT9RNyS0ESF3k7o1udXab0PPDvZtxh/rsPiv4sy
 LYIeAVnIrSRbxopBOfLR3VSdFER9Mxs7EgPiNkRWe882QNtbG0
 XnyI4+kkbl/VQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226651>

On Fri, Jun 07, 2013 at 10:27:58PM +0530, Ramkumar Ramachandra wrote:
> Leandro Lucarella wrote:
> > Thanks for the detailed explanations, I think this would cover my use
> > case. Just for clarification, here are some more details on this use
> > case, which I think is becoming very popular among github users.
> > We have a "blessed" repository (upstream in my case) and only a few
> > people is able to push to it (let's call them maintainers). Every
> > developer, including the ones with push access, have to go through peer
> > reviewing and are not allowed to push their own commits to upstream. For
> > peer reviewing, each have it's own public fork, that other people can
> > review and merge/push if is good.
> 
> Yes, and I wrote it precisely to address this itch.  git/git is
> origin, and artagnon/git is ram.  I just set remote.pushdefault to ram
> and continue working as usual.
> 
> I apologize for not having thought hard enough about other
> push.default modes: I personally use current, and like it very much.
> As an added bonus, even new branches created with git checkout -b
> hot-branch will get push to go to the right place; no need to set
> upstream before pushing.

I might try to just switch to current, I feel more comfortable with
simple because I feel is safer to explicitly set the upstream branch,
but is true that most of the time is not necessary.

-- 
Leandro Lucarella
Senior R&D Developer
sociomantic labs GmbH <http://www.sociomantic.com>
