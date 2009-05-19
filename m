From: Michael Radziej <mir@noris.de>
Subject: Re: [TopGit PATCH] tg-graph: print dependency graph like git log
	--graph
Date: Tue, 19 May 2009 12:27:43 +0200
Message-ID: <20090519102742.GA28702@noris.de>
References: <1242711875-25666-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Adam Simpkins <adam@adamsimpkins.net>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue May 19 12:27:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6MY7-0000JG-2X
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 12:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbZESK1q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 May 2009 06:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbZESK1p
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 06:27:45 -0400
Received: from mail02.noris.net ([62.128.1.232]:34131 "EHLO mail02.noris.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbZESK1p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 May 2009 06:27:45 -0400
Received: from mail-intern.backup.noris.net ([10.1.0.25] helo=mail.office.noris.de)
	by mail02.noris.net with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <mir@noris.de>)
	id 1M6MXv-0002gD-AN; Tue, 19 May 2009 12:27:43 +0200
Received: from mir.office.noris.de ([10.2.6.66] ident=postfix)
	by mail.office.noris.de with esmtp (Exim 4.63)
	(envelope-from <mir@noris.de>)
	id 1M6MXv-0004GI-4U; Tue, 19 May 2009 12:27:43 +0200
Received: by mir.office.noris.de (Postfix, from userid 294)
	id 100FF1178BCB; Tue, 19 May 2009 12:27:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1242711875-25666-1-git-send-email-bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Noris-IP: 10.1.0.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119511>

Hi,

I'm really looking forward for a tool like this and tried your patch
instantly, but I keep getting:

gvpr: "/usr/local/share/topgit/graph.gvpr", line 936: gg_nl_ret +=3D
graph_output_commit_line();<<<=20
 -- cannot convert node_t to string
Error: <stdin>:16: syntax error near line 16
context:  >>> \ <<< t"t/conflicts" -> "master";

I have no idea what graph.gvpr is trying. My repo is available at:

git://github.com/mradziej/topgit.git

Your patch is on t/tg-graph. I tried "tg graph" on this repo.

Any idea?

Cheers

Michael

--=20
noris network AG - Deutschherrnstra=DFe 15-19 - D-90429 N=FCrnberg -
Tel +49-911-9352-0 - Fax +49-911-9352-100
http://www.noris.de - The IT-Outsourcing Company
=20
Vorstand: Ingo Kraupa (Vorsitzender), Joachim Astel, Hansjochen Klenk -=
=20
Vorsitzender des Aufsichtsrats: Stefan Schnabel - AG N=FCrnberg HRB 176=
89
