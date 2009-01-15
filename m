From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: rebase -p confusion in 1.6.1
Date: Thu, 15 Jan 2009 14:55:18 +0100
Message-ID: <20090115135518.GB10045@leksak.fem-net>
References: <slrngmu4j5.e1u.sitaramc@sitaramc.homelinux.net> <496F3C99.1040800@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org,
	Stephen Haberman <stephen@exigencecorp.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 14:56:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNSiH-0000mO-J6
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 14:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755412AbZAONzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 08:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755133AbZAONzX
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 08:55:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:33702 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754960AbZAONzW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 08:55:22 -0500
Received: (qmail invoked by alias); 15 Jan 2009 13:55:21 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp030) with SMTP; 15 Jan 2009 14:55:21 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+Hba02fDeHKTOdK1sBfyHU6oTvviRNw1HPNk6mbM
	giVz3cPbPmn+gU
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1LNSgo-000510-TO; Thu, 15 Jan 2009 14:55:18 +0100
Content-Disposition: inline
In-Reply-To: <496F3C99.1040800@drmicha.warpmail.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105808>

Hi,

> First of all: git 1.6.0.6 gives you the unchanged graph after using
> rebase -i -p.

This is true and it is a far better behavior than now, but I think it's
not the expected behavior. (I have written about the behavior I'd expect
in another reply to the original mail.)

Also

	git rebase -i -p master

should do the same as

	git rebase -i -p --onto master master

or am I wrong?

But the latter does

	$ git rebase --onto master -i -p master
	fatal: Needed a single revision
	Invalid base

instead of resulting in an unchanged graph.
(Tested with 1.5.6.5, the only other version I have installed besides
my master branch)

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
