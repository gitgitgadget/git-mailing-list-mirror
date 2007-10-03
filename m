From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git push (mis ?)behavior
Date: Wed, 3 Oct 2007 15:14:02 +0200
Message-ID: <20071003131402.GA4615@diana.vm.bytemark.co.uk>
References: <20070927130447.GH10289@artemis.corp> <7v3awzvrpr.fsf@gitster.siamese.dyndns.org> <buoprzwn5qm.fsf@dhapc248.dev.necel.com> <20071003073554.GA8110@artemis.corp> <buobqbgmv6z.fsf@dhapc248.dev.necel.com> <83C5420A-528A-43F0-AF8C-699B85B7AD95@wincent.com> <20071003104943.GA3017@diana.vm.bytemark.co.uk> <7v8x6kfobq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>, Miles Bader <miles@gnu.org>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 15:20:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id49D-00052p-QJ
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 15:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270AbXJCNUL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Oct 2007 09:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753028AbXJCNUK
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 09:20:10 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2850 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbXJCNUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 09:20:09 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Id438-0001HK-00; Wed, 03 Oct 2007 14:14:02 +0100
Content-Disposition: inline
In-Reply-To: <7v8x6kfobq.fsf@gitster.siamese.dyndns.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59837>

On 2007-10-03 04:08:09 -0700, Junio C Hamano wrote:

> Karl Hasselstr=F6m <kha@treskal.com> writes:
>
> > So it all comes down to case (2) mistakes being much harder to fix
> > than case (1) mistakes. Therefore, we should change the default,
> > since doing so makes it safer.
>
> I am not convinced.
>
> I've seen many new people alias "rm" to "rm -i" for this (I'd say
> "false") reasoning to "default to safer", and end up training their
> fingers to say "y" without thinking.

I don't think that's a good analogy here, since no one is proposing
any kind of interactive prompt.

> Also mistakes can cut both ways. Pushing out what you did not intend
> to is what you seem to be worried about more. But not pushing out
> enough and not noticing is an equally bad mistake.

It may be an equally bad mistake, but it's _not_ equally hard to fix.
(And in my book, that means they aren't in fact equally bad.)

You're right that some users will train their fingers to always type
"git push --all" to the point where they will push everything by
mistake even in cases where that's not what they wanted. But the same
thing will happen with the current default for people who almost
always push just a single branch, and train their fingers for that.
And you just said the two mistakes were equally bad. :-)

> People also argue for "default per user". I am not really convinced
> on that point either.
>
> You, an expert, will get asked for help by somebody, walk up to his
> shell prompt, and try to help and teach him by showing you type, and
> then you suddenly notice the command does not work as you expect
> because he set the default differently (because he read that
> configuration option on some web parge). And we will be in such a
> cumbersome to diagnose situation _very_ often if we have per-user
> default on many things.

I'm generally opposed to per-user settings for that reason. Users who
insist can alias "pusha" to "push --all".

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
