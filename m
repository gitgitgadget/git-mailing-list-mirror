From: Sylvain Joyeux <sylvain.joyeux@dfki.de>
Subject: Re: [PATCH] better git-submodule status output
Date: Mon, 7 Jul 2008 17:52:39 +0200
Message-ID: <20080707155238.GL3696@joyeux>
References: <20080701150119.GE5852@joyeux> <7vhcb3o7q3.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0807061456100.3486@wbgn129.biozentrum.uni-wuerzburg.de> <20080706160758.GA23385@jhaampe.org> <alpine.DEB.1.00.0807061821340.7342@eeepc-johanness> <20080707062142.GA5506@jhaampe.org> <32541b130807070725p6fa4d0dfne9f04bc857920dc7@mail.gmail.com> <alpine.DEB.1.00.0807071533240.18205@racer> <32541b130807070757s4ba03e28tf4701f479e27b687@mail.gmail.com> <alpine.DEB.1.00.0807071621300.18205@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Lars Hjemli <hjemli@gmail.com>, Ping Yin <pkufranky@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 07 17:53:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFt23-0008Dy-SK
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 17:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbYGGPwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 11:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753237AbYGGPwm
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 11:52:42 -0400
Received: from smtprelay05.ispgateway.de ([80.67.18.43]:35446 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbYGGPwm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 11:52:42 -0400
Received: from [134.102.219.50] (helo=joyeux)
	by smtprelay05.ispgateway.de with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <sylvain.joyeux@dfki.de>)
	id 1KFt16-0004qg-3R; Mon, 07 Jul 2008 17:52:40 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807071621300.18205@racer>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Df-Sender: [pbs]133504
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87629>

On Mon, Jul 07, 2008 at 04:23:02PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 7 Jul 2008, Avery Pennarun wrote:
> 
> > On 7/7/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > >  On Mon, 7 Jul 2008, Avery Pennarun wrote:
> > > > Thus, I'd say the best fix would be to find a way to have "git pull" or
> > > > "git fetch" in the supermodule also do a fetch in the submodule.
> > >
> > > Noooooo!
> > >
> > >  If I am actively working on the submodule, the supermodule has _no
> > >  business_ trying to wreck my state.
> > 
> > Hmm... how does doing a fetch wreck your state?
> 
> It updates the tracking branches.  And guess what I use the tracking 
> branches for?  Yes, to track other people's changes.

And ... I'll ask the same question again, then maybe you will be so nice
as to give me the information that you do not want to share with the
earthling that I am.

Is there no way to fetch only objects without updating no refs ?

> Anyway, fetch is wrong, wrong, wrong, if all you want to do is see the 
> _state_ of your submodule.
Agreed. Now, can we move on and discuss Avery's point which was to have
a SEPARATE operation which fetches all submodules in one command ?

> Don't play cute games,
OK. Maybe you're god in the small world of git-submodule or whatever,
but could you at least *try* to explain things to people which are
trying to understand what is SOOOOOOOOOOOOOOO
HOOORRRRRRRIIIIBBBBLLLLLLLLYYYYYYYYY BAD when the only information they
have is:

  THIS IS HORRIBLY BAD, GO AWAY

Sylvain
