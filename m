From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Invert numbers and names in the git-shortlog summary
	mode.
Date: Tue, 11 Dec 2007 15:57:09 +0100
Message-ID: <20071211145709.GB19427@elte.hu>
References: <20071207093439.GA21896@elte.hu> <200712080636.12982.chriscool@tuxfamily.org> <20071211092446.GA4703@elte.hu> <20071211092916.GF30948@artemis.madism.org> <m3ve75sfn3.fsf@roke.D-201> <20071211115914.GJ30948@artemis.madism.org> <20071211122539.GA13945@sigill.intra.peff.net> <20071211140508.GA12204@elte.hu> <20071211144351.GA15448@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Pierre Habouzit <madcoder@debian.org>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Junio C Hamano <g
X-From: git-owner@vger.kernel.org Tue Dec 11 15:58:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J26Ye-0006SR-2E
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 15:58:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753704AbXLKO5i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Dec 2007 09:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753688AbXLKO5h
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 09:57:37 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:36314 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753636AbXLKO5g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 09:57:36 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1J26Xo-0003uH-BS
	from <mingo@elte.hu>; Tue, 11 Dec 2007 15:57:22 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 74BFB3E2193; Tue, 11 Dec 2007 15:57:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071211144351.GA15448@artemis.madism.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67863>


* Pierre Habouzit <madcoder@debian.org> wrote:

>     Agreed, here is the patch that does that, and a sample output is:
>=20
>         $ git shortlog -n -s -e HEAD -- builtin-commit.c
>             11	Junio C Hamano <gitster@pobox.com>
>              6	Johannes Schindelin <Johannes.Schindelin@gmx.de>
>              6	Kristian H=F8gsberg <krh@redhat.com>
>              2	Jeff King <peff@peff.net>
>              1	Alex Riesen <raa.lkml@gmail.com>
>              1	Pierre Habouzit <madcoder@debian.org>
>              1	Shawn Bohrer <shawn.bohrer@gmail.com>
>              1	Wincent Colaiuta <win@wincent.com>

great - this looks really neat!

btw., stupid question: why are the git-shortlog command line arguments=20
different from git-log? I got used to things like:

  git-log kernel/

so for me it would be natural to just do:

  git-shortlog -n -s kernel/

but this currently produces this output:

  $ git-shortlog -n -s kernel/
  (reading log to summarize from standard input)

which is quite a bit confusing to someone who'd like to keep as few=20
details of command line arguments in his head as possible :-)

	Ingo
