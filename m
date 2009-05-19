From: Michael Radziej <mir@noris.de>
Subject: Re: [TopGit PATCH] tg-graph: print dependency graph like git log
	--graph
Date: Tue, 19 May 2009 15:10:44 +0200
Message-ID: <20090519131044.GD28702@noris.de>
References: <1242711875-25666-1-git-send-email-bert.wesarg@googlemail.com> <20090519102742.GA28702@noris.de> <36ca99e90905190337y63aeb98ag59ff37688f75ba96@mail.gmail.com> <20090519110800.GB28702@noris.de> <36ca99e90905190448k64ee18afw8abc49bd90ecb58f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Adam Simpkins <adam@adamsimpkins.net>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue May 19 15:11:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6P5u-0003eL-Pj
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 15:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754809AbZESNKo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 May 2009 09:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754800AbZESNKo
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 09:10:44 -0400
Received: from mail02.noris.net ([62.128.1.232]:60862 "EHLO mail02.noris.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754794AbZESNKo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 May 2009 09:10:44 -0400
Received: from mail-intern.backup.noris.net ([10.1.0.25] helo=mail.office.noris.de)
	by mail02.noris.net with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <mir@noris.de>)
	id 1M6P5g-0001hc-Mb; Tue, 19 May 2009 15:10:44 +0200
Received: from mir.office.noris.de ([10.2.6.66] ident=postfix)
	by mail.office.noris.de with esmtp (Exim 4.63)
	(envelope-from <mir@noris.de>)
	id 1M6P5g-0008H7-K4; Tue, 19 May 2009 15:10:44 +0200
Received: by mir.office.noris.de (Postfix, from userid 294)
	id 81CEC117904E; Tue, 19 May 2009 15:10:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <36ca99e90905190448k64ee18afw8abc49bd90ecb58f@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Noris-IP: 10.1.0.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119523>

On Tue, May 19, Bert Wesarg wrote:
> And you see the error with all 3?

Yes

>=20
> Can you send the output from 'tg summary --graphviz' too?

# GraphViz output; pipe to:
#   | dot -Tpng -o <ouput>
# or
#   | dot -Txlib

digraph G {

        graph [
                rankdir =3D "TB"
                label=3D"TopGit Layout\n\n\n"
                fontsize =3D 14
                labelloc=3Dtop
                pad =3D "0.5,0.5"
        ];

\t"t/conflicts" -> "master";
\t"t/python" -> "master";
\t"t/tg-graph" -> "master";
}

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
