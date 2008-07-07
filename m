From: Sylvain Joyeux <sylvain.joyeux@dfki.de>
Subject: Re: [PATCH] better git-submodule status output
Date: Mon, 7 Jul 2008 17:00:23 +0200
Message-ID: <20080707150023.GJ3696@joyeux>
References: <20080701150119.GE5852@joyeux> <7vhcb3o7q3.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0807061456100.3486@wbgn129.biozentrum.uni-wuerzburg.de> <20080706160758.GA23385@jhaampe.org> <alpine.DEB.1.00.0807061821340.7342@eeepc-johanness> <20080707062142.GA5506@jhaampe.org> <32541b130807070725p6fa4d0dfne9f04bc857920dc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Lars Hjemli <hjemli@gmail.com>, Ping Yin <pkufranky@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 17:01:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFsDY-0004gX-4v
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 17:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753825AbYGGPAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 11:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753921AbYGGPAa
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 11:00:30 -0400
Received: from smtprelay11.ispgateway.de ([80.67.29.28]:48914 "EHLO
	smtprelay11.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751AbYGGPA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 11:00:29 -0400
Received: from [134.102.219.50] (helo=joyeux)
	by smtprelay11.ispgateway.de with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <sylvain.joyeux@dfki.de>)
	id 1KFsCX-0004gj-TZ; Mon, 07 Jul 2008 17:00:25 +0200
Content-Disposition: inline
In-Reply-To: <32541b130807070725p6fa4d0dfne9f04bc857920dc7@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Df-Sender: [pbs]965142
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87621>

> I haven't looked at your patch, so I don't know if you're calling
> fetch in such a way that it doesn't update any refs.
Frankly, I don't know either. But since the question is more on a design
level, it does not matter for now.

> Thus, I'd say the
> best fix would be to find a way to have "git pull" or "git fetch" in
> the supermodule also do a fetch in the submodule.  I think it's fair
> to expect "fetchy" operations like fetch and pull to perhaps do some
> extra fetches, but not fair to expect "status" to do extra work like
> that.
I do agree on the principle, it is just that I don't know where to do it
otherwise. Would the involved people be fine with a new "git submodule
fetch" command ?

> Also note that "your supermodule links to a commit that you haven't
> fetched yet" is a perfectly okay state to report to the user.  I might
> use a "?" or something to indicate that.
For now, my patch shows '!' ... But I'm open to other suggestions.

Sylvain
