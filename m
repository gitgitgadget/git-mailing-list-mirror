From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git push (mis ?)behavior
Date: Wed, 3 Oct 2007 18:07:31 +0200
Message-ID: <20071003160731.GA7113@diana.vm.bytemark.co.uk>
References: <20070927130447.GH10289@artemis.corp> <7v3awzvrpr.fsf@gitster.siamese.dyndns.org> <buoprzwn5qm.fsf@dhapc248.dev.necel.com> <20071003073554.GA8110@artemis.corp> <buobqbgmv6z.fsf@dhapc248.dev.necel.com> <83C5420A-528A-43F0-AF8C-699B85B7AD95@wincent.com> <20071003104943.GA3017@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0710031550490.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>, Miles Bader <miles@gnu.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 03 18:08:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id6m2-0002I0-TB
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 18:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754784AbXJCQI1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Oct 2007 12:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753085AbXJCQI1
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 12:08:27 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2096 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243AbXJCQI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 12:08:26 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Id6l1-0001rf-00; Wed, 03 Oct 2007 17:07:31 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710031550490.28395@racer.site>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59851>

On 2007-10-03 16:27:49 +0100, Johannes Schindelin wrote:

> On Wed, 3 Oct 2007, Karl Hasselstr?m wrote:
>
> >   2. "push all branches" is the default, but the user intended to
> >      push only the current branch. She ends up pushing a superset
> >      of what she wanted, which is not easily fixed if she can't be
> >      sure that no one else has pulled from the public repo before
> >      she notices what's happened.
>
> But that is not the default. Not at all.
>
> The default is to push the refs which the remote and the local side
> have _in common_.

I know, and that's what I meant by "all branches". Sorry for the
sloppy language.

> Maybe we should initialise the "remote.origin.push" variable to
> "completely-bogus-branchname" when you "git init --im-a-newbie"?

I'd rather have a suboptimal default than different defaults depending
on user settings. (See also Junio's comment on that elsewhere in this
thread.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
