From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [BUG] assertion failure in builtin-mv.c with "git mv -k"
Date: Wed, 14 Jan 2009 17:04:44 +0100
Message-ID: <496E0D1C.20807@drmicha.warpmail.net>
References: <vpqwscy81o8.fsf@bauges.imag.fr> <496DFC75.2000904@drmicha.warpmail.net> <alpine.DEB.1.00.0901141653540.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 14 17:07:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN8Ft-0003kX-UD
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 17:06:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755210AbZANQEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 11:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755143AbZANQEq
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 11:04:46 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57688 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755139AbZANQEp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jan 2009 11:04:45 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 4AAB72118C4;
	Wed, 14 Jan 2009 11:04:44 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 14 Jan 2009 11:04:44 -0500
X-Sasl-enc: xqZYnSlK7SlsiB62t0b+XvKXEAh31WZnzjRbNFb9SbrW 1231949083
Received: from [139.174.44.34] (pascal.math.tu-clausthal.de [139.174.44.34])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 98FAF30E60;
	Wed, 14 Jan 2009 11:04:43 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <alpine.DEB.1.00.0901141653540.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105650>

Johannes Schindelin venit, vidit, dixit 14.01.2009 16:54:
> Hi,
> 
> On Wed, 14 Jan 2009, Michael J Gruber wrote:
> 
>> I'll send a patch but I'm not sure if this needs a test case.
> 
> Umm, Michael, you have been here long enough to know that the answer is a 
> "YES!".  If you fix something, you want to provide a test case just to 
> make sure you do not need to fix it again later.
> 
> Ciao,
> Dscho
> 

It was a lame attempt at getting around it, it's just one line... I
didn't know I've been being noticed long enough ;)
So, should I prepare a series like:

1: test case and mark known fail
2: the 1 line fix
3: mark test pass

Or should 2+3 be squashed into one?

Cheers,
Michael
