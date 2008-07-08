From: Sylvain Joyeux <sylvain.joyeux@dfki.de>
Subject: Re: [PATCH] better git-submodule status output
Date: Tue, 8 Jul 2008 14:22:44 +0200
Message-ID: <20080708122244.GE14794@joyeux>
References: <20080706160758.GA23385@jhaampe.org> <alpine.DEB.1.00.0807061821340.7342@eeepc-johanness> <20080707062142.GA5506@jhaampe.org> <32541b130807070725p6fa4d0dfne9f04bc857920dc7@mail.gmail.com> <alpine.DEB.1.00.0807071533240.18205@racer> <alpine.DEB.1.00.0807071537070.18205@racer> <20080707145726.GI3696@joyeux> <7v8wwd4kvb.fsf@gitster.siamese.dyndns.org> <20080708080042.GB3628@joyeux> <alpine.DEB.1.00.0807081320220.4319@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Lars Hjemli <hjemli@gmail.com>, Ping Yin <pkufranky@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 08 14:23:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGCEZ-0000pc-Ic
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 14:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462AbYGHMWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 08:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753355AbYGHMWw
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 08:22:52 -0400
Received: from smtprelay05.ispgateway.de ([80.67.18.43]:47044 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656AbYGHMWv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 08:22:51 -0400
Received: from [134.102.219.50] (helo=joyeux)
	by smtprelay05.ispgateway.de with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <sylvain.joyeux@dfki.de>)
	id 1KGCDV-0007Tk-VF; Tue, 08 Jul 2008 14:22:46 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807081320220.4319@eeepc-johanness>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Df-Sender: [pbs]965142
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87756>

> > What I was missing is, given the current discussion, a git-submodule 
> > fetch alike to what Avery was proposing, which fetches all submodules in 
> > one command. Having to do the fetch/update manually for each submodule 
> > is really cumbersome -- I have around 30 modules in the superproject.
> 
> Did I not suggest "git submodule update" earlier?  AFAIR this updates all 
> submodules that have been initialized.

... and checkouts the commit registered in the superproject. Therefore
neither git-submodule status nor git-submodule summary can give an idea
of "what's new in submodules"

Sylvain
