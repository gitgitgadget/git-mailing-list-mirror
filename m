From: Moritz Neeb <lists@moritzneeb.de>
Subject: Re: Improving git branch
Date: Sun, 21 Dec 2014 16:36:00 +0000 (UTC)
Message-ID: <loom.20141221T170822-647@post.gmane.org>
References: <CAHQ6N+qBUcBcG8RC6Co+k_GmJDXCynmyfZmvTjz4bQyH1wG3DA@mail.gmail.com> <549168DD.1080906@drmicha.warpmail.net> <xmqqvbla80bm.fsf@gitster.dls.corp.google.com> <20141217210148.GA26551@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 21 17:40:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2jYF-0003nI-R6
	for gcvg-git-2@plane.gmane.org; Sun, 21 Dec 2014 17:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424AbaLUQkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2014 11:40:08 -0500
Received: from plane.gmane.org ([80.91.229.3]:51067 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141AbaLUQkH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2014 11:40:07 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Y2jY4-0003fj-Cg
	for git@vger.kernel.org; Sun, 21 Dec 2014 17:40:04 +0100
Received: from dslb-178-000-098-148.178.000.pools.vodafone-ip.de ([178.0.98.148])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Dec 2014 17:40:04 +0100
Received: from lists by dslb-178-000-098-148.178.000.pools.vodafone-ip.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Dec 2014 17:40:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 178.0.98.148 (Mozilla/5.0 (X11; Linux x86_64; rv:34.0) Gecko/20100101 Firefox/34.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261614>

Jeff King <peff <at> peff.net> writes:

> 
> On Wed, Dec 17, 2014 at 12:53:49PM -0800, Junio C Hamano wrote:
> 
> > Michael J Gruber <git <at> drmicha.warpmail.net> writes:
> > 
> > > Rather than extending "git branch" any further[*], I suggest a bolder
> > > strategy:
> > >
> > > - unify/merge for-each-ref and pretty formats (and code) as far as
possible
> > > - leverage that for the list modes of branch and tag
> > >
> > > That would allow everyone to get their favourite listing, just like for
> > > logs. Otherwise it would be very difficult to agree on *the* proper
> > > format for an extended branch or tag list.
> > >
> > > Michael
> > >
> > >
> > > [*] I know I'm a sinner, too.
> > 
> > Actually this is not a "bolder" strategy, but the unification has
> > been discussed and agreed to be the longer-term direction for quite
> > a while, I think.  Didn't Peff have this in his "things to do when
> > absolutely bored" box?
> 
> Yes. It is not even in my "absolutely bored" box, but rather the "I
> would like to work on this but somehow other crap keeps coming up" box.

Is this box public somewhere?

> The last blocker I ran into was that we need to unify the "--contains"
> implementation for "git tag" and "git branch". If anybody wants to push
> this forward, I think that is the best place to start. I can dig up
> references if anybody is interested.
> 

Yes, I would be interested in references. I already found something in
Junio's leftover bits [1] that seems related:
  "git tag --contains" should not consider a tag as the anchor point to
  describe the commit, when it can reach another tag that can also be used
  to describe the commit. Cf. [2]

Regards,
Moritz

[1] http://git-blame.blogspot.fr/p/leftover-bits.html
[2] http://thread.gmane.org/gmane.comp.version-control.git/246381/focus=246423
