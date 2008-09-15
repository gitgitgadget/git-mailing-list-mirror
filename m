From: Michael Radziej <mir@noris.de>
Subject: Re: [ANNOUNCE] TopGit v0.3
Date: Mon, 15 Sep 2008 10:01:31 +0200
Message-ID: <20080915080131.GA30396@noris.de>
References: <20080909231009.GD10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Sep 15 10:08:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kf97s-0002u4-3H
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 10:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755807AbYIOIGo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Sep 2008 04:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753499AbYIOIGn
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 04:06:43 -0400
Received: from mail04.noris.net ([62.128.1.224]:38471 "EHLO mail04.noris.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755495AbYIOIGj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Sep 2008 04:06:39 -0400
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Sep 2008 04:06:39 EDT
Received: from mail02.noris.net ([62.128.1.232])
	by mail04.noris.net with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <mir@noris.de>)
	id 1Kf91o-0004Pa-9f
	for git@vger.kernel.org; Mon, 15 Sep 2008 10:01:48 +0200
Received: from mail-intern.backup.noris.net ([10.1.0.25] helo=mail.office.noris.de)
	by mail02.noris.net with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <mir@noris.de>)
	id 1Kf91X-0005ZS-Tb; Mon, 15 Sep 2008 10:01:31 +0200
Received: from mir.office.noris.de ([10.2.6.66])
	by mail.office.noris.de with esmtp (Exim 4.63)
	(envelope-from <mir@noris.de>)
	id 1Kf91X-0000la-Qv; Mon, 15 Sep 2008 10:01:31 +0200
Received: by mir.office.noris.de (Postfix, from userid 294)
	id BED9E7976D3; Mon, 15 Sep 2008 10:01:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080909231009.GD10544@machine.or.cz>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Noris-IP: 10.1.0.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95891>

Hi!

I'm just starting to toy around with TopGit. Please excuse if I am simp=
ly
too naive :-)                                                =20
                               =20
I wonder about the .topmsg and .topdeps files. Why is this information
within the topic branch? It tends to get into the way even though a spe=
cial
merge driver is provided. For example, you cannot do octopus merges (wh=
ich I
found very confusing as first-time user). And it might also confuse peo=
ple
cloning a TopGit repository and want to use a topgit branch. They might=
 not
be aware of these special TopGit things.
                                                                       =
                                                               =20
I'd rather have a dedicated branched named e.g. 'TopGit' which includes=
 the                                                          =20
information that is currently in .topmsg and .topdeps, but for all bran=
ches
in a repository.


Cheers,

Michael Radziej

--=20
noris network AG - Deutschherrnstra=DFe 15-19 - D-90429 N=FCrnberg -
Tel +49-911-9352-0 - Fax +49-911-9352-100
http://www.noris.de - The IT-Outsourcing Company
=20
Vorstand: Ingo Kraupa (Vorsitzender), Joachim Astel, Hansjochen Klenk -=
=20
Vorsitzender des Aufsichtsrats: Stefan Schnabel - AG N=FCrnberg HRB 176=
89
