Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7FA391E7F
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 20:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210649; cv=none; b=WsloMVkx3CGzy2D7MrdPrBmm4jYg1oD1ETXVdr6GWK6XSKOCDMhC5qivperfTjADwczKTDi02MWyrhg4Nt2D7UzijowlE4VFy5Mz42c29xKaNbTYQgDkbBvmGkeKatohZWJxvMv8qOdhhhck7jT10QpYBPcF1QdpyvFEDLyZf/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210649; c=relaxed/simple;
	bh=/5pslbifY91UME4XU0RZ5/91OMXj8BUnGRkEFLJQWQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nyaTP0Lxb0xH+886c3fl/IuTbyg803m/PV2Ijf7EA6nUg9iuzS+J7yqpPZ/DEBSr9MohTn2h7NgxMdn9CKrGjNrKeXU0nAuXlko22PXnkcDIcqUDhx99SvR01/Z+j0YXACMhgSIKduPlRVZp/ErEPShcBtdLFL6C+fINIODau3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=YWBjh/s+; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="YWBjh/s+"
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 9DC9B4CF44
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 22:43:56 +0200 (CEST)
Received: from piment-oiseau.localnet (unknown [IPv6:2a01:e0a:d1:f360:3d51:7a10:3981:3744])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id B4A5AB00563;
	Thu, 11 Jun 2026 22:43:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1781210629;
	bh=/5pslbifY91UME4XU0RZ5/91OMXj8BUnGRkEFLJQWQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YWBjh/s+FIbiqCQE+v7JF3mI+KU1iFMTqETIpDQ+N2XbARJn0W8eHREDTf8HL6C4/
	 sa5hgVb4naTTzdDXzfHFaPOg3z0boTUasvb0VlNB5GuqAVwH5Tb0iK27tks918158c
	 p4JoKJLLBn6n7BPzkRKtKQBBjU5KSHuObwJmYQC/Xn080aAvWXz9co0dDxkkhM1iFP
	 bWXa/BaMUPiResufh2rjam5d1qjgJvGDFzWSQRo+8491jBDPESF5HIZmyC/tfFXDTH
	 J5cihlGmcmqX39AnuUHclVoUq/pALo/Id7UPNLHk9myGcKnBeTPrH7c4hF8+KKwGpf
	 JcY9rvJhlkkOQ==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: Tuomas Ahola <taahol@utu.fi>, Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] doc: git-config: escape erroneous highlight markup
Date: Thu, 11 Jun 2026 22:43:44 +0200
Message-ID: <5106812.31r3eYUQgx@piment-oiseau>
In-Reply-To: <20260611062525.GB2189088@coredump.intra.peff.net>
References:
 <20260610185148.23920-1-taahol@utu.fi>
 <20260611062423.GA2189088@coredump.intra.peff.net>
 <20260611062525.GB2189088@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday, 11 June 2026 08:25:25 CEST Jeff King wrote:
> [and naturally I forgot to cc Jean-No=C3=ABl; resending, sorry for the no=
ise]
>=20
> On Thu, Jun 11, 2026 at 02:24:23AM -0400, Jeff King wrote:
> > On Thu, Jun 11, 2026 at 02:11:57AM -0400, Jeff King wrote:
> > > Though curiously the case of `#` in git-fast-import seems not to get
> > > marked as <code> in the html output (even though the nearby `LF` does=
).
> > > I wonder if there is some special treatment of `#` or something.
> >=20
> > Ah, weird, it has to do with our config file.
> >=20
> > If I do this (not in the git repository):
> >   echo 'This is a literal `#` symbol.' >foo.adoc
> >   asciidoc foo.adoc
> >   grep -i symbol foo.html
> >=20
> > then I get <code> markers, like:
> >   <div class=3D"paragraph"><p>This is a literal <code>#</code> symbol.<=
/p></div>
> >=20
> > But if I build with:
> >   asciidoc -f path/to/git/Documentation/asciidoc.conf foo.adoc
> >=20
> > then the grep shows:
> >   <div class=3D"paragraph"><p>This is a literal # symbol.</p></div>
> >=20
> > Looks like it is due to our [literal-inlinemacro] definition, which
> > comes from 974cdca345 (doc: introduce a synopsis typesetting,
> > 2024-09-24). I think this might have been an unintended side effect.
> > +cc the author of that commit.
> >=20
> > For the purposes of your series, I think we can ignore any issues with
> > [literal-inlinemacro] for the moment, and decide on "\" versus ``
> > depending on which we prefer.
> >=20
> > -Peff

Oh, this is the black magic regexp that is not considering # for keyword
character. Should be solved by something like (and I really hate these .in=
=20
files):


=2D- >8 --

=46rom: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
Date: Thu, 11 Jun 2026 19:44:43 +0200
Subject: [PATCH] asciidoc: fix handling of # in synopsis text
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

There are occurrences of # in the synopsis text of git-config(1) and
git-clone(1) that are not handled as keyword by the current asciidoc
and asciidoctor processors.

Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
=2D--
 Documentation/asciidoc.conf.in             | 12 ++++++------
 Documentation/asciidoctor-extensions.rb.in |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/asciidoc.conf.in b/Documentation/asciidoc.conf.in
index 31b883a72c..b50fad588e 100644
=2D-- a/Documentation/asciidoc.conf.in
+++ b/Documentation/asciidoc.conf.in
@@ -43,7 +43,7 @@ ifdef::doctype-book[]
 endif::doctype-book[]
=20
 [literal-inlinemacro]
=2D{eval:re.sub(r'(&lt;[-a-zA-Z0-9.]+&gt;)', r'<emphasis>\1</emphasis>', re=
=2Esub(r'([\[\s|()>]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=3D~@\\\*\/_^\$%]+\.?)+|,)=
',r'\1<literal>\2</literal>', re.sub(r'(\.\.\.?)([^\]$.])', r'<literal>\1</=
literal>\2', macros.passthroughs[int(attrs['passtext'][1:-1])] if attrs['pa=
sstext'][1:-1].isnumeric() else attrs['passtext'][1:-1])))}
+{eval:re.sub(r'(&lt;[-a-zA-Z0-9.]+&gt;)', r'<emphasis>\1</emphasis>', re.s=
ub(r'([\[\s|()>]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=3D~@#\\\*\/_^\$%]+\.?)+|,)',r=
'\1<literal>\2</literal>', re.sub(r'(\.\.\.?)([^\]$.])', r'<literal>\1</lit=
eral>\2', macros.passthroughs[int(attrs['passtext'][1:-1])] if attrs['passt=
ext'][1:-1].isnumeric() else attrs['passtext'][1:-1])))}
=20
 endif::backend-docbook[]
=20
@@ -75,24 +75,24 @@ git-relative-html-prefix=3D
 <a href=3D"{git-relative-html-prefix}{target}.html">{target}{0?({0})}</a>
=20
 [literal-inlinemacro]
=2D{eval:re.sub(r'(&lt;[-a-zA-Z0-9.]+&gt;)', r'<em>\1</em>', re.sub(r'([\[\=
s|()>]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=3D~@,\\\*\/_^\$]+\.?)+)',r'\1<code>\2</=
code>', re.sub(r'(\.\.\.?)([^\]$.])', r'<code>\1</code>\2', macros.passthro=
ughs[int(attrs['passtext'][1:-1])] if attrs['passtext'][1:-1].isnumeric() e=
lse attrs['passtext'][1:-1])))}
+{eval:re.sub(r'(&lt;[-a-zA-Z0-9.]+&gt;)', r'<em>\1</em>', re.sub(r'([\[\s|=
()>]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=3D~@#,\\\*\/_^\$]+\.?)+)',r'\1<code>\2</c=
ode>', re.sub(r'(\.\.\.?)([^\]$.])', r'<code>\1</code>\2', macros.passthrou=
ghs[int(attrs['passtext'][1:-1])] if attrs['passtext'][1:-1].isnumeric() el=
se attrs['passtext'][1:-1])))}
=20
 endif::backend-xhtml11[]
=20
 ifdef::backend-docbook[]
 ifdef::doctype-manpage[]
 [blockdef-open]
=2Dsynopsis-style=3Dtemplate=3D"verseparagraph",filter=3D"sed 's!&#8230;\\(=
\\]\\|$\\)!<phrase>\\0</phrase>!g;s!\\([\\[ |()]\\|^\\|\\]\\|&gt;\\)\\([-=
=3Da-zA-Z0-9:+@,\\/_^\\$.\\\\\\*]\\+\\|&#8230;\\)!\\1<literal>\\2</literal>=
!g;s!&lt;[-a-zA-Z0-9.]\\+&gt;!<emphasis>\\0</emphasis>!g'"
+synopsis-style=3Dtemplate=3D"verseparagraph",filter=3D"sed 's!&#8230;\\(\\=
]\\|$\\)!<phrase>\\0</phrase>!g;s!\\([\\[ |()]\\|^\\|\\]\\|&gt;\\)\\([-=3Da=
=2DzA-Z0-9:+@#,\\/_^\\$.\\\\\\*]\\+\\|&#8230;\\)!\\1<literal>\\2</literal>!=
g;s!&lt;[-a-zA-Z0-9.]\\+&gt;!<emphasis>\\0</emphasis>!g'"
=20
 [paradef-default]
=2Dsynopsis-style=3Dtemplate=3D"verseparagraph",filter=3D"sed 's!&#8230;\\(=
\\]\\|$\\)!<phrase>\\0</phrase>!g;s!\\([\\[ |()]\\|^\\|\\]\\|&gt;\\)\\([-=
=3Da-zA-Z0-9:+@,\\/_^\\$.\\\\\\*]\\+\\|&#8230;\\)!\\1<literal>\\2</literal>=
!g;s!&lt;[-a-zA-Z0-9.]\\+&gt;!<emphasis>\\0</emphasis>!g'"
+synopsis-style=3Dtemplate=3D"verseparagraph",filter=3D"sed 's!&#8230;\\(\\=
]\\|$\\)!<phrase>\\0</phrase>!g;s!\\([\\[ |()]\\|^\\|\\]\\|&gt;\\)\\([-=3Da=
=2DzA-Z0-9:+@#,\\/_^\\$.\\\\\\*]\\+\\|&#8230;\\)!\\1<literal>\\2</literal>!=
g;s!&lt;[-a-zA-Z0-9.]\\+&gt;!<emphasis>\\0</emphasis>!g'"
 endif::doctype-manpage[]
 endif::backend-docbook[]
=20
 ifdef::backend-xhtml11[]
 [blockdef-open]
=2Dsynopsis-style=3Dtemplate=3D"verseparagraph",filter=3D"sed 's!&#8230;\\(=
\\]\\|$\\)!<span>\\0</span>!g;s!\\([\\[ |()]\\|^\\|\\]\\|&gt;\\)\\([-=3Da-z=
A-Z0-9:+@,\\/_^\\$.\\\\\\*]\\+\\|&#8230;\\)!\\1<code>\\2</code>!g;s!&lt;[-a=
=2DzA-Z0-9.]\\+&gt;!<em>\\0</em>!g'"
+synopsis-style=3Dtemplate=3D"verseparagraph",filter=3D"sed 's!&#8230;\\(\\=
]\\|$\\)!<span>\\0</span>!g;s!\\([\\[ |()]\\|^\\|\\]\\|&gt;\\)\\([-=3Da-zA-=
Z0-9:+@#,\\/_^\\$.\\\\\\*]\\+\\|&#8230;\\)!\\1<code>\\2</code>!g;s!&lt;[-a-=
zA-Z0-9.]\\+&gt;!<em>\\0</em>!g'"
=20
 [paradef-default]
=2Dsynopsis-style=3Dtemplate=3D"verseparagraph",filter=3D"sed 's!&#8230;\\(=
\\]\\|$\\)!<span>\\0</span>!g;s!\\([\\[ |()]\\|^\\|\\]\\|&gt;\\)\\([-=3Da-z=
A-Z0-9:+@,\\/_^\\$.\\\\\\*]\\+\\|&#8230;\\)!\\1<code>\\2</code>!g;s!&lt;[-a=
=2DzA-Z0-9.]\\+&gt;!<em>\\0</em>!g'"
+synopsis-style=3Dtemplate=3D"verseparagraph",filter=3D"sed 's!&#8230;\\(\\=
]\\|$\\)!<span>\\0</span>!g;s!\\([\\[ |()]\\|^\\|\\]\\|&gt;\\)\\([-=3Da-zA-=
Z0-9:+@#,\\/_^\\$.\\\\\\*]\\+\\|&#8230;\\)!\\1<code>\\2</code>!g;s!&lt;[-a-=
zA-Z0-9.]\\+&gt;!<em>\\0</em>!g'"
 endif::backend-xhtml11[]
diff --git a/Documentation/asciidoctor-extensions.rb.in b/Documentation/asc=
iidoctor-extensions.rb.in
index fe64a62d96..b5f06827ca 100644
=2D-- a/Documentation/asciidoctor-extensions.rb.in
+++ b/Documentation/asciidoctor-extensions.rb.in
@@ -50,7 +50,7 @@ module Git
       def process parent, reader, attrs
         outlines =3D reader.lines.map do |l|
           l.gsub(/(\.\.\.?)([^\]$\. ])/, '{empty}`\1`{empty}\2')
=2D           .gsub(%r{([\[\] |()>]|^)([-a-zA-Z0-9:+=3D~@,/_^\$\\\*]+)}, '\=
1{empty}`\2`{empty}')
+           .gsub(%r{([\[\] |()>]|^)([-a-zA-Z0-9:+=3D~@#,/_^\$\\\*]+)}, '\1=
{empty}`\2`{empty}')
            .gsub(/(<[-a-zA-Z0-9.]+>)/, '__\\1__')
            .gsub(']', ']{empty}')
         end
@@ -73,7 +73,7 @@ module Git
         elsif type =3D=3D :monospaced
           node.text.gsub(/(\.\.\.?)([^\]$\.])/, '<literal>\1</literal>\2')
               .gsub(/^\.\.\.?$/, '<literal>\0</literal>')
=2D              .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=3D~@/_^=
\$\\\*%]+\.{0,2})+|,)}, '\1<literal>\2</literal>')
+              .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=3D~@#/_^\=
$\\\*%]+\.{0,2})+|,)}, '\1<literal>\2</literal>')
               .gsub(/(&lt;[-a-zA-Z0-9.]+&gt;)/, '<emphasis>\1</emphasis>')
         else
           open, close, supports_phrase =3D QUOTE_TAGS[type]
@@ -102,7 +102,7 @@ module Git
         if node.type =3D=3D :monospaced
           node.text.gsub(/(\.\.\.?)([^\]$.])/, '<code>\1</code>\2')
               .gsub(/^\.\.\.?$/, '<code>\0</code>')
=2D              .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=3D~@,/_=
^\$\\\*%]+\.{0,2})+)}, '\1<code>\2</code>')
+              .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=3D~@#,/_^=
\$\\\*%]+\.{0,2})+)}, '\1<code>\2</code>')
               .gsub(/(&lt;[-a-zA-Z0-9.]+&gt;)/, '<em>\1</em>')
=20
         else
=2D-=20



