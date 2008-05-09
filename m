From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Who made today's Git?
Date: Thu, 8 May 2008 22:31:22 -0400
Message-ID: <20080509023122.GB29038@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 04:32:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuIPD-0004Xl-Nn
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 04:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754783AbYEICbb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 May 2008 22:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754774AbYEICba
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 22:31:30 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43158 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754721AbYEICb0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 May 2008 22:31:26 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JuIO8-0006z8-GF
	for git@vger.kernel.org; Thu, 08 May 2008 22:31:12 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D6F7E20FBAE; Thu,  8 May 2008 22:31:22 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81587>

Since I had my owner.sh script handy for the jgit code[*1*] I ran it
on most of git.git (next =3D d3ec381f77) just for fun.  What I find
_really_ interesting isn't that Junio owns 31% or Linus owns 12%,
its that there are so many contributors with surviving code.

Keep up the good work everyone!


$ sh owner.sh *.sh *.perl *.c *.h compat/*.c=20
 31%   35276 Junio C Hamano
 12%   14479 Linus Torvalds
  8%    9835 Johannes Schindelin
  4%    5133 Shawn O. Pearce
  4%    5120 Eric Wong
  3%    4397 Daniel Barkalow
  3%    3816 Nicolas Pitre
  2%    3152 Martin Langhoff
  2%    3049 Nick Hengeveld
  2%    3002 Pierre Habouzit
  1%    1318 Jeff King
  1%    1269 Mike McCormack
  1%    1156 Ren=C3=A9 Scharfe
  0%    1001 Christian Couder
  0%     778 Martin Koegler
  0%     766 Carlos Rica
  0%     717 Kristian H=C3=B8gsberg
  0%     669 Lukas Sandstr=C3=B6m
  0%     644 Johannes Sixt
  0%     628 Lars Hjemli
  0%     558 Alex Riesen
  0%     538 Jon Loeliger
  0%     498 Petr Baudis
  0%     477 Ryan Anderson
  0%     406 Franck Bui-Huu
  0%     403 Matthias Urlichs
  0%     388 Wincent Colaiuta
  0%     374 Theodore Ts'o
  0%     327 Timo Hirvonen
  0%     313 Brandon Casey
  0%     302 Paolo Bonzini
  0%     289 Don Zickus
  0%     288 Frank Lichtenheld
  0%     286 Sven Verdoolaege
  0%     284 J=C3=B6rg Sommer
  0%     275 H. Peter Anvin
  0%     274 Andy Whitcroft
  0%     250 Andy Parkins
  0%     249 Mike Hommey
  0%     241 Sergey Vlasov
  0%     221 Yakov Lerner
  0%     220 Matthias Lederhofer
  0%     220 Andreas Ericsson
  0%     218 Dana L. How
  0%     215 Eric W. Biederman
  0%     210 Ping Yin
  0%     206 Steffen Prohaska
  0%     200 Scott R Parish
  0%     195 Jim Meyering
  0%     183 David Rientjes
  0%     175 David D. Kilzer
  0%     171 Benoit Sigoure
  0%     163 Brian Downing
  0%     162 YOSHIFUJI Hideaki
  0%     149 Martyn Smith
  0%     141 Fredrik Kuivinen
  0%     131 Heikki Orsila
  0%     126 Jason Riedy
  0%     126 Nanako Shiraishi
  0%     125 Geert Bosch
  0%     117 James Bowes
  0%     115 Martin Waitz
  0%     115 Gerrit Pape
  0%     115 Bradford C. Smith
  0%     111 Santi B=C3=A9jar
  0%     108 Julian Phillips
  0%     106 Alexandre Julliard
  0%     106 Sean Estabrooks
  0%     105 Shawn Bohrer
  0%     104 Fernando J. Pereda
  0%      99 Uwe Kleine-K=C3=B6nig
  0%      99 Charles Bailey
  0%      99 Marco Costalba
  0%      98 Robin Rosenberg
  0%      94 Michael Witten
  0%      90 Josh Elsasser
  0%      89 Peter Eriksen
  0%      89 Matthias Kestenholz
  0%      85 Pavel Roskin
  0%      84 David Kastrup
  0%      83 Mark Levedahl
  0%      82 Edgar Toernig
  0%      82 Sam Vilain
  0%      81 Ramsay Allan Jones
  0%      81 Jonas Fonseca
  0%      78 Jakub Narebski
  0%      75 Mark Wooding
  0%      71 Jay Soffian
  0%      70 Adam Roben
  0%      69 Josef Weidendorfer
  0%      66 Eygene Ryabinkin
  0%      61 Douglas Stockwell
  0%      60 Michal Ostrowski
  0%      60 Dmitry Potapov
  0%      59 Damien Diederen
  0%      58 J. Bruce Fields
  0%      53 Miklos Vajna
  0%      52 Dmitry V. Levin
  0%      51 Michal Rokos
  0%      49 Brian Gernhardt
  0%      48 SZEDER G=C3=A1bor
  0%      48 Steven Walter
  0%      48 David Brown
  0%      47 Kay Sievers
  0%      45 Lars Knoll
  0%      43 David D Kilzer
  0%      43 Mike Dalessio
  0%      42 Jon Seymour
  0%      41 I=C3=B1aki Arenaza
  0%      40 Florian Forster
  0%      39 Luiz Fernando N. Capitulino
  0%      39 David Steven Tweed
  0%      38 Tilman Sauerbeck
  0%      38 Simon 'corecode' Schubert
  0%      38 Bryan Larsen
  0%      38 Matthieu Moy
  0%      36 Robert Ewald
  0%      36 J=C3=BCrgen R=C3=BChle
  0%      35 Robin H. Johnson
  0%      34 Gr=C3=A9goire Barbier
  0%      34 Serge E. Hallyn
  0%      34 Robert Shearman
  0%      32 Michael S. Tsirkin
  0%      32 David Woodhouse
  0%      31 Quy Tonthat
  0%      31 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
  0%      30 Thomas Harning
  0%      29 Andr=C3=A9 Goddard Rosa
  0%      28 Josh Triplett
  0%      27 Michele Ballabio
  0%      27 Peter Hagervall
  0%      25 Jens Axboe
  0%      25 Clemens Buchacher
  0%      24 Paul Mackerras
  0%      24 Michael Coleman
  0%      24 Luben Tuikov
  0%      24 Joachim Berdal Haga
  0%      23 Stefan-W. Hahn
  0%      22 Sergei Organov
  0%      22 Paul Collins
  0%      21 James Bottomley
  0%      21 Tim Stoakes
  0%      21 Jean-Luc Herren
  0%      20 Dan McGee
  0%      20 Joe Perches
  0%      19 Steven Grimm
  0%      18 Christopher Li
  0%      17 Karl Hasselstr=C3=B6m
  0%      17 Jonathan del Strother
  0%      16 Jason McMullan
  0%      16 Yann Dirson
  0%      16 Matt Kraai
  0%      16 Emil Medve
  0%      15 Sasha Khapyorsky
  0%      15 Tom Prince
  0%      15 Holger Eitzenberger
  0%      15 Willy Tarreau
  0%      15 Zach Welch
  0%      14 Adam Simpkins
  0%      14 Carl Worth
  0%      14 Dennis Stosberg
  0%      13 Brian Ewins
  0%      13 Peter Baumann
  0%      13 Josh England
  0%      12 Simon Sasburg
  0%      12 Kai Ruemmler
  0%      12 Govind Salinas
  0%      11 Johan Herland
  0%      11 BooK
  0%      11 Alex Bennee
  0%      10 Brad King
  0%      10 Bj=C3=B6rn Engelmann
  0%       9 Timo Sirainen
  0%       9 Jeffrey C. Ollie
  0%       9 Roland Dreier
  0%       9 martin f. krafft
  0%       9 Brian Gerst
  0%       8 Finn Arne Gangstad
  0%       8 Markus Amsler
  0%       8 Bryan Donlan
  0%       8 Stephen R. van den Berg
  0%       7 Paul Serice
  0%       7 Denis Cheng
  0%       7 Kevin Leung
  0%       7 Brad Roberts
  0%       6 Ariel Badichi
  0%       6 John Goerzen
  0%       6 Andrew Ruder
  0%       6 Tomash Brechko
  0%       6 Han-Wen Nienhuys
  0%       6 Qingning Huo
  0%       6 Amos Waterland
  0%       6 Ralf Wildenhues
  0%       5 Martin Mares
  0%       5 Giuseppe Bilotta
  0%       5 Paul T Darga
  0%       5 Kevin Ballard
  0%       5 OGAWA Hirofumi
  0%       5 Vineet Kumar
  0%       5 Yasushi SHOJI
  0%       5 Stephan Springl
  0%       5 Rogan Dawes
  0%       5 Miles Bader
  0%       5 Michael Spang
  0%       5 Sam Ravnborg
  0%       5 Michal Vitecek
  0%       5 Ask Bj=C3=B8rn Hansen
  0%       5 Robert Fitzsimons
  0%       5 David S. Miller
  0%       4 H.Merijn Brand
  0%       4 Dan Nicholson
  0%       4 Matthew Wilcox
  0%       4 Bj=C3=B6rn Steinbrink
  0%       4 Ingo Molnar
  0%       4 Michael Weber
  0%       4 Art Haas
  0%       4 Arjen Laarhoven
  0%       4 Patrick Welche
  0%       4 Jan Harkes
  0%       3 Alexey Nezhdanov
  0%       3 Konstantin V. Arkhipov
  0%       3 Steven Drake
  0%       3 Tommi Kyntola
  0%       3 Matthew Ogilvie
  0%       3 Stephan Feder
  0%       3 Michael Milligan
  0%       3 David K=C3=A5gedal
  0%       3 Li Hong
  0%       3 Marc-Andre Lureau
  0%       3 David Symonds
  0%       3 Chris Shoemaker
  0%       3 Tommy M. McGuire
  0%       2 Tony Luck
  0%       2 Michael Hendricks
  0%       2 Thomas Glanzmann
  0%       2 Eyvind Bernhardsen
  0%       2 Marco Roeland
  0%       2 Aurelien Bompard
  0%       2 Adeodato Sim=C3=B3
  0%       2 Gustaf Hendeby
  0%       2 Keith Packard
  0%       2 Andrew Clausen
  0%       2 Tom Clarke
  0%       2 Gordon Hopper
  0%       2 Ralf Baechle
  0%       2 Stephan Beyer
  0%       2 Lars Doelle
  0%       2 Pascal Obry
  0%       2 Robert Schiele
  0%       2 Michael Stefaniuc
  0%       2 CJ van den Berg
  0%       1 Jan Andres
  0%       1 Mika Kukkonen
  0%       1 Bart Trojanowski
  0%       1 Chris Wedgwood
  0%       1 Alp Toker
  0%       1 Avi Kivity
  0%       1 Thomas Guyot-Sionnest
  0%       1 Richard MUSIL
  0%       1 Randal L. Schwartz
  0%       1 veillette@yahoo.ca
  0%       1 Michael W. Olson
  0%       1 Michael Smith
  0%       1 Simon Hausmann
  0%       1 Bill Lear
  0%       1 Stefan Sperling
  0%       1 Jerald Fitzjerald
  0%       1 Haavard Skinnemoen
  0%       1 Martin Sivak
  0%       1 Terje Sten Bjerkseth
  0%       1 Salikh Zakirov
  0%       1 Pedro Melo
  0%       1 Seth Falcon
  0%       1 Joakim Tjernlund
  0%       1 Horst H. von Brand
  0%       1 Blake Ramsdell
  0%       1 Rutger Nijlunsing
  0%       1 Sebastian Noack
  0%       1 Matt Draisey
  0%       1 Darrin Thompson
  0%       1 Kumar Gala
  0%       1 Samuel Tardieu
  0%       1 Alberto Bertogli
  0%       1 Joe English
  0%       1 Alexander Litvinov
  0%       1 Chris Wright
  0%       1 Paul Eggert
  0%       1 David Reiss
------------------------------
100%  112385 total


*1* http://article.gmane.org/gmane.comp.version-control.git/81585

--=20
Shawn.
