From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git push origin error (1.6.3 new default functionality)
Date: Wed, 13 May 2009 11:54:20 +0200
Message-ID: <4A0A98CC.2090701@drmicha.warpmail.net>
References: <81bfc67a0905111826y779555cer6679da11db787ab1@mail.gmail.com> <4A09594F.4040603@drmicha.warpmail.net> <81bfc67a0905122226p113e4aa5y2a3523ac63de77fc@mail.gmail.com> <20090513083203.GA25058@sigill.intra.peff.net> <4A0A8871.6080107@viscovery.net> <20090513090317.GA3421@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 13 11:54:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4BAe-0002Fe-5q
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 11:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757418AbZEMJya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 05:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757216AbZEMJya
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 05:54:30 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39966 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756431AbZEMJya (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2009 05:54:30 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 9E0D63455FD;
	Wed, 13 May 2009 05:54:30 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 13 May 2009 05:54:30 -0400
X-Sasl-enc: ZR8iqwTLKaDFcMopk4SXHjg6umEvzgjF6HZHJ/CQoBGQ 1242208469
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0C57D390FE;
	Wed, 13 May 2009 05:54:28 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090511 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <20090513090317.GA3421@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119018>

Jeff King venit, vidit, dixit 13.05.2009 11:03:
> On Wed, May 13, 2009 at 10:44:33AM +0200, Johannes Sixt wrote:
> 
>> Unfortunately, the case with this warning is not that "simple" because it
>> is not about a planned change of the default behavior, but about a default
>> behavior that may be unexpected for newbies (see the release notes of
>> 1.6.3). I *can* understand that Caleb is upset by the warning, since he's
>> comfortable with the (current and future) default behavior. But I don't
>> know what to do in cases like these.
> 
> I thought this was in preparation for an eventual change, but I might be
> wrong (1.6.3 introduced several such warnings).
> 
> Regardless, my point was: the warning was introduced for a purpose
> (either to point out potentially confusing behavior, or to warn the user
> about an upcoming change in default behavior). Showing up now and saying
> "I don't like this warning" without addressing any of the points in the
> original discussion or making any sort of proposal to try to accomplish
> the same goals is just counterproductive.

I don't want to stir this up to much again - as I said, set config and
be done.

My main issue is the fact that we have a config variable (push.default)
which causes a different behaviour depending on whether it is unset or
set to its default (!) value. That is a completely new UI approach. We
may follow through with this for a "beginners' mode" for git, where
commands with possibly unintended side effects issue warnings, as
opposed to an "advanced mode" (activated by 1 config variable) which
shuts these off. Right now this new behaviour is isolated and feels strange.

Michael
