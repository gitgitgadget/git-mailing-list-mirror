From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 1/2] po/de.po: add German translation
Date: Wed, 15 Sep 2010 11:47:44 +0200
Message-ID: <201009151147.45314.trast@student.ethz.ch>
References: <20100915093313.44396t6yr62ixccg@webmail.tu-harburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <jk@jk.gs>, <avarab@gmail.com>, git <git@vger.kernel.org>
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Wed Sep 15 11:48:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ovoav-000829-Lf
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 11:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657Ab0IOJrt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Sep 2010 05:47:49 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:29112 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750719Ab0IOJrs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Sep 2010 05:47:48 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Wed, 15 Sep
 2010 11:47:46 +0200
Received: from thomas.site (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 15 Sep
 2010 11:47:46 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34.4-0.1-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <20100915093313.44396t6yr62ixccg@webmail.tu-harburg.de>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156227>

Hi Christian

Christian Stimming wrote:
>=20
> As you might guess, as the (initial) translator of git-gui I've been =
=20
> through this discussion before [1] and as you have noticed, I have =20
> decided to take a translation approach different from what you have =20
> recently discussed here. I deliberately tried to translate as much of=
 =20
> the terms into German as possible. I do not agree about the importanc=
e =20
> of statements on this mailing list like "This translation translates =
=20
> too much terms - I cannot find the commands I'm used to".=20
[...]
> Instead, a translation is for people who do neither know nor =20
> understand the English wording for the git concepts. For this target =
=20
> audience, the goal is to find a set of terms for the different git =20
> concepts which makes the concepts most easily accessible for their =20
> language. This may or may not include terms which are left at English=
 =20
> words.

Maybe there should be two sets of translations then.

I'm only half serious, but the problem here is what I said earlier in
the thread (referring to Jan's draft):

} In any case it roughly matches (or still stays slightly on the
} more-German side of) the colloquial usage in my group, if that is
} any indication.

"My group" is a bunch of CS researchers, so I can't say they fall
outside the description above.  However, in our work we observe a very
funny split between translating and keeping the terms in English:

  graph                               Graph
  vertex                              Knoten
  edge                                Kante
  directed                            gerichtet
  DAG (directed acyclic graph)        DAG
  independent set                     independent set
  cut (vertex, edge)                  cut (vertex, edge)
  degree                              Grad
  matching                            Matching
  tree                                Baum
  MST (minimum spanning tree)         MST (minimaler Spannbaum)

There are German terms for all the untranslated ones, but I rarely
hear them in practical usage.  Books probably go for a full
translation since they want to be normative (how should I know, it's
been a while since I used a German book), but lectures stick to the
half-translated version.

And much like the average computer scientist around here uses a number
of English terms even in German informal speech, I suspect the average
German user of git would not translate *every* term.  Unless you are
aiming for a normative usage, in which case we would also have to
translate the theory (manpages, books) using the same terms...

I'll leave it at that for my $0.02, since as you note, I'm not
actually the intended audience.

By the way:

> >  index                 Index
>=20
> I'd strongly vote for not using "Index". The "Index" is where the =20
> "Bundespr=FCfstelle f=FCr jugendgef=E4hrdende Schriften" puts the =20
> Ballerspiele on. Don't let the identical word fool you into thinking =
=20
> this is a worthwhile translation. Also, the English term is a bad =20
> naming anyway IMHO. I'd use git-gui's replacement (staging area) and =
=20
> use "Bereitstellung" here as well. Feel free to propose something =20
> different, but please not "Index". Git isn't FSK18.

I guess I will have to go for a de_CH translation then.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
