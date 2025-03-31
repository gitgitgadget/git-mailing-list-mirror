Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81854218585
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 20:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743453083; cv=none; b=p22yW8e+1enfGs5rQKtMmRxwERNW5/6REe1rs0Gn1c4Gsvgn4sgvZD3gkeblxle6DPUUTrRrv4dDkKXQm/rydbEs8KRB1fmwIhew9Go8AKAHarOvJKQKSRNSbEnVrgU1Xfhm293ur177GWRnFkklBA7EFzJ+rHsiKCvGGy1Jfrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743453083; c=relaxed/simple;
	bh=9JhoJwm3Pi42Bi+k7W0iSjwEvZZlGYtPmEji2R1nhQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jI1VTZJ5YZdOZNLIWr75rL/BTthVCumLab0lQbzdESxby4xaeedLvtgP1fXYpFWf1A3Lhu71p7SMaYVy/TCAFJjzYH9D9SD1AMDabJU9uUoLtI8nrpmJQsdDwcSfzlI3faPcFeS0hkVc4LiVf0DnewnDOauU4O6bp+sj0pfqPiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=h80NYXYX; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="h80NYXYX"
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 54AE8428EF7
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 22:31:08 +0200 (CEST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:881e:8ce9:fd06:b1f4])
	(Authenticated sender: jn.avila@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 4908A19F5C6;
	Mon, 31 Mar 2025 22:30:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1743453061;
	bh=9JhoJwm3Pi42Bi+k7W0iSjwEvZZlGYtPmEji2R1nhQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h80NYXYXbAKQzUqi1laFHhFr8t4ICWOgMDITO435+rgXdhfCygSeo8IEjmpUyKbL6
	 HHigPWkbGF4wbqWGeq/xSZL3Ax4FwUFEei9yNwDrPrssCnIerOor5DlN7Tjy0rWtDX
	 Vv+Hu7/hmH9P/ZQjRjaZvgNtD0yRjGJjUfgtatmXBUijHza8p0byT4XrcoHE0sbDzR
	 PP2JUQswtr9SRt7QSYY/9eQA0D9eVJ4BkylNQKL7eknbZmbbSbXH5iUB/YQr0WS1tf
	 H/RH9OHKHhva4mjeqdIq0dmKCjp0vdPqQs5UwzbxnqEYOrI3lGn1+CAtVRGZ/LMqS8
	 YGXnpWGJAI1wQ==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: SZEDER =?UTF-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Johannes Sixt <j6t@kdbg.org>,
 git@vger.kernel.org
Subject: Re: [PATCH] doc: fix asciidoctor synopsis processing of triple-dots
Date: Mon, 31 Mar 2025 22:30:57 +0200
Message-ID: <5873733.DvuYhMxLoT@cayenne>
In-Reply-To: <Z+rUsCW0zEb8kAK8@szeder.dev>
References:
 <Z+piTsfJdx4BG2oI@szeder.dev> <20250331125608.92419-1-jn.avila@free.fr>
 <Z+rUsCW0zEb8kAK8@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Le lundi 31 mars 2025, 19:45:20 heure d=E2=80=99=C3=A9t=C3=A9 d=E2=80=99Eur=
ope centrale SZEDER G=C3=A1bor a=20
=C3=A9crit :
> On Mon, Mar 31, 2025 at 02:55:51PM +0200, Jean-No=C3=ABl Avila wrote:
> > The processing of triple dot notation is tricky because it can be
> > mis-interpreted as an ellipsis. The special processing of the ellipsis
> > is now complete and takes into account the case of
> > `git-mv <source>... <dest>`
> >=20
> > Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> > ---
> >=20
> >  Documentation/asciidoctor-extensions.rb.in | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/asciidoctor-extensions.rb.in
> > b/Documentation/asciidoctor-extensions.rb.in index 2494f17a51..f2be66c4=
ad
> > 100644
> > --- a/Documentation/asciidoctor-extensions.rb.in
> > +++ b/Documentation/asciidoctor-extensions.rb.in
> > @@ -49,7 +49,7 @@ module Git
> >=20
> >        def process parent, reader, attrs
> >       =20
> >          outlines =3D reader.lines.map do |l|
> >=20
> > -          l.gsub(/(\.\.\.?)([^\]$.])/, '`\1`\2')
> > +          l.gsub(/(\.\.\.?)([^\]$\. ])/, '{empty}`\1`{empty}\2')
> >=20
> >             .gsub(%r{([\[\] |()>]|^)([-a-zA-Z0-9:+=3D~@,/_^\$]+)},
> >             '\1{empty}`\2`{empty}')
> >             .gsub(/(<[-a-zA-Z0-9.]+>)/, '__\\1__')
> >             .gsub(']', ']{empty}')
> >=20
> > @@ -72,6 +72,7 @@ module Git
> >=20
> >            %(<inlineequation><alt><![CDATA[#{equation =3D
> >            node.text}]]></alt><mathphrase><![CDATA[#{equation}]]></
mathphra
> >            se></inlineequation>)>         =20
> >          elsif type =3D=3D :monospaced
> >         =20
> >            node.text.gsub(/(\.\.\.?)([^\]$.])/, '<literal>\1</literal>\=
2')
> >=20
> > +                        .gsub(/^\.\.\.?$/, '<literal>\0</literal>\2')
> >=20
> >                .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=3D~@,=
/_^\
$]+
> >                \.{0,2})+)}, '\1<literal>\2</literal>')
> >                .gsub(/(&lt;[-a-zA-Z0-9.]+&gt;)/, '<emphasis>\1</
emphasis>')
> >         =20
> >          else
> >=20
> > @@ -100,6 +101,7 @@ module Git
> >=20
> >        def convert_inline_quoted node
> >       =20
> >          if node.type =3D=3D :monospaced
> >         =20
> >            node.text.gsub(/(\.\.\.?)([^\]$.])/, '<code>\1</code>\2')
> >=20
> > +            .gsub(/^\.\.\.?$/, '<code>\0</code>')
> >=20
> >                .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=3D~@,=
/_^\
$]+
> >                \.{0,2})+)}, '\1<code>\2</code>')
> >                .gsub(/(&lt;[-a-zA-Z0-9.]+&gt;)/, '<em>\1</em>')
>=20
> Thanks.  I can confirm that this patch addresses the issue I reported
> with the manpage of 'git diff' (though I think the commit message
> could go into a bit more detail as to what problem this patch attempts
> to solve and how).

These regex are getting a bit too hairy now. I'm working on using a parser=
=20
generator to clarify how it works (at least for asciidoctor).

>=20
> Alas, the issue caused by 'diff-generate-patch.adoc' in the manpages
> of diff-files, diff-index, log, etc. is still present.

Sorry to ready that, but I cannot reproduce on my setup (using asciidoctor=
=20
2.0.23):

        2. It is followed by one or more extended header lines (this exampl=
e=20
shows a merge with two parents):

               index <hash>,<hash>..<hash>
               mode <mode>,<mode>..<mode>
               new file mode <mode>
               deleted file mode <mode>,<mode>

Has the format failure changed with this patch?

Thanks

JN



