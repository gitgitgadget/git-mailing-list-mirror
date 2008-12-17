From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-daemon documentation: use {tilde}
Date: Wed, 17 Dec 2008 10:07:15 +0100
Message-ID: <4948C143.8030609@drmicha.warpmail.net>
References: <1229442492-11993-1-git-send-email-vmiklos@frugalware.org>	<4947E7B1.2090608@drmicha.warpmail.net> <vpqbpvcro5z.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Dec 17 10:09:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCsOd-0001Rm-2e
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 10:08:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbYLQJHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 04:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751740AbYLQJHV
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 04:07:21 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43112 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750967AbYLQJHT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Dec 2008 04:07:19 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 601DE1E7295;
	Wed, 17 Dec 2008 04:07:18 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 17 Dec 2008 04:07:18 -0500
X-Sasl-enc: IWuckAODOM+H5JbJl8oJ86iI5NRwjDBrGD85Y7epvgkc 1229504838
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9EDCB1A108;
	Wed, 17 Dec 2008 04:07:17 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
In-Reply-To: <vpqbpvcro5z.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103324>

Matthieu Moy venit, vidit, dixit 16.12.2008 19:05:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Miklos Vajna venit, vidit, dixit 16.12.2008 16:48:
>>> Use '{tilde}' instead of '~', becase the later does not appear in the
>>> manpage version, just in the HTML one.
>> Curiously, "git help daemon" (which execs "man git-daemon") displays the
>> tilde but "man git-daemon" does not (nor does "konqueror
>> man:git-daemon"). Humh?
> 
> You probably have two manpages because of two git installations. "man"
> will take the one in your manpath, and git will try to find the one
> corresponding to the version of git you actually launched.

You're right! I have current pages in ~/share/man/man? and older ones in
~/man/man?. I guess the latter is in the standard search path (I don't
have MANPATH set) but the former is not. I probably dumped a man-tarball
in the standard place back when I didn't know about quick-install-doc.
Now I'm just wondering why ~/share/man is the standard target for git
and ~/man in the standard man path, at least on (K)Ubuntu 7.10 at my
workplace.

Michael
