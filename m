From: Sylvain Joyeux <sylvain.joyeux@dfki.de>
Subject: Re: [PATCH] better git-submodule status output
Date: Mon, 7 Jul 2008 16:57:26 +0200
Message-ID: <20080707145726.GI3696@joyeux>
References: <20080701150119.GE5852@joyeux> <7vhcb3o7q3.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0807061456100.3486@wbgn129.biozentrum.uni-wuerzburg.de> <20080706160758.GA23385@jhaampe.org> <alpine.DEB.1.00.0807061821340.7342@eeepc-johanness> <20080707062142.GA5506@jhaampe.org> <32541b130807070725p6fa4d0dfne9f04bc857920dc7@mail.gmail.com> <alpine.DEB.1.00.0807071533240.18205@racer> <alpine.DEB.1.00.0807071537070.18205@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Lars Hjemli <hjemli@gmail.com>, Ping Yin <pkufranky@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 07 16:58:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFsAi-0003Zp-Si
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 16:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626AbYGGO5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 10:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753427AbYGGO5f
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 10:57:35 -0400
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:46394 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426AbYGGO5e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 10:57:34 -0400
Received: from [134.102.219.50] (helo=joyeux)
	by smtprelay04.ispgateway.de with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <sylvain.joyeux@dfki.de>)
	id 1KFs9f-0001FD-GK; Mon, 07 Jul 2008 16:57:27 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807071537070.18205@racer>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Df-Sender: [pbs]311155
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87619>

> > Thus, I'd say the best fix would be to find a way to have "git pull" or 
> > "git fetch" in the supermodule also do a fetch in the submodule.
> If I am actively working on the submodule, the supermodule has _no 
> business_ trying to wreck my state.

Is it possible to make 'fetch' only .. well .. fetch objects, without
updating any refs ? In that case it would wreck no state as no state
would be updated.
-- 
=======================================================================
Dr. Ing. Sylvain Joyeux                          sylvain.joyeux@dfki.de
Researcher
DFKI Robotik Lab -- Bremen                   http://www.dfki.de/robotik
Tel: 0049 421 218 64136
=======================================================================
