From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git push origin error (1.6.3 new default functionality)
Date: Thu, 14 May 2009 09:37:39 +0200
Message-ID: <4A0BCA43.9080408@drmicha.warpmail.net>
References: <81bfc67a0905111826y779555cer6679da11db787ab1@mail.gmail.com> <4A09594F.4040603@drmicha.warpmail.net> <81bfc67a0905122226p113e4aa5y2a3523ac63de77fc@mail.gmail.com> <20090513083203.GA25058@sigill.intra.peff.net> <4A0A8871.6080107@viscovery.net> <20090513090317.GA3421@sigill.intra.peff.net> <4A0A98CC.2090701@drmicha.warpmail.net> <20090514063157.GA10411@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 14 09:37:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4VVu-0007mq-42
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 09:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892AbZENHht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 03:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753362AbZENHht
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 03:37:49 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52791 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752460AbZENHht (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 03:37:49 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 1FD1C345323;
	Thu, 14 May 2009 03:37:50 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 14 May 2009 03:37:50 -0400
X-Sasl-enc: mGwfGtKCobBqkCUMRdkUHafYRfTOvppXnbqR2MLAWRIE 1242286669
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 55E9627D0F;
	Thu, 14 May 2009 03:37:49 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090511 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <20090514063157.GA10411@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119163>

Jeff King venit, vidit, dixit 14.05.2009 08:31:
> On Wed, May 13, 2009 at 11:54:20AM +0200, Michael J Gruber wrote:

[snip snip snip]

>> My main issue is the fact that we have a config variable (push.default)
>> which causes a different behaviour depending on whether it is unset or
>> set to its default (!) value. That is a completely new UI approach. We
> 
> Well, it depends on how you think of the default. The default could be
> "matched-and-warn", and you are fixing it by setting it to "matched". :)
> 
> -Peff

So, then we have a config variable which you can set to its default
value only by /unsetting/ it :)

In fact, I think that approach could be valuable in general, making git
more fool-proof for beginners while remaining efficient for the
regulars. As a new concept, to be taken up by "deny non-ff pushes",
"deny delation pushes", "pull without refspec" etc., I would like that.
In order to be useful, beginners should be able to rely on it, i.e.:
unless certain config is set, the git-gun should never go off when
pointed at users' own feet. Might be a worthy target for 1.7 (pun
semi-intended).

Michael
