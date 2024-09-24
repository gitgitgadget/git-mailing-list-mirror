Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEE213AA5D
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 19:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727206223; cv=none; b=YPoP48Uyb2902QrxdT2RcKlc14RX45LhqS+eTxBAQ7NXIQsNJ5ULd9Bf4DjJnB/1QlV17TvTFO91Hl2fWMDWohOcSgEI34DcHQkbUI2Qc8PKoZD2vTdg/0VeXu+7gpJap8/JYKkNPIDlGLVCsyG8CGbRtwjMB9PY/LHS7wtCpjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727206223; c=relaxed/simple;
	bh=LOZbOBmqR6p7i0x6fIibgGmowp1yHLKPkRdkDoar4+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oc9AHwBwXUm/gNHlc3NzLrwqbA6l/CPjYEobxvtUdjQ3om5QUysetJkd6Mm6+sDh/t6AHv9XEb5qf2auy8f9bx62OihwCLCBEa+TagoWAcwSwtGUi+OPWudS2MUeliwhTrUJgmcMnpE/u3wcMvQVfT/0YkSApIws0858+k78EQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=NqasCONF; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="NqasCONF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727206205; x=1727811005; i=tboegi@web.de;
	bh=LOEZ0JmHSuHFcWEF/DySYQU4Q/E+YrYIYHAwQdRdY+M=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NqasCONFfGQgpul4Yt0AUM0l3vtP/KUCVnd2IhVVLzS4qrCeaavGyTcvOq5sKphG
	 6SKbq2x+es2zvjimnqGwWcx7+TwCG0Zc+OpjHAmiHyH1BLwYzWdwQNSIYdKnAamXU
	 n7pyUDDPHeLr6kkCHhP+zFWEF5Uw5JiBotQRDwUDX/dbj/M0Kmu6dl6jr3lynvlv6
	 /8DxzMPOPQsGTxmCCxwfT2+s5ajED2/iKbyvRai1vu4PIgICjAcXu9446/Bi02J7X
	 FRArAO8E1XcN8b+ECQJkcFuH3Rrd64Xheg1t8fRCYJSlBnVf8rGihYsZkEzIecK3c
	 VscrZLMlfK4AXSyb0w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQgks-1sXmlH2iuc-00M2vh; Tue, 24
 Sep 2024 21:30:05 +0200
Date: Tue, 24 Sep 2024 21:30:04 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Josh Steadmon <steadmon@google.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= Avila via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Chris Torek <chris.torek@gmail.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v5 0/3] doc: introducing synopsis para
Message-ID: <20240924193004.GA20138@tb-raspi4>
References: <pull.1766.v4.git.1725573126.gitgitgadget@gmail.com>
 <pull.1766.v5.git.1727161730.gitgitgadget@gmail.com>
 <xmqq5xqlug4l.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <xmqq5xqlug4l.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:vwhuQAsum0IAkBDL7MPdP5RVRFc967zl28p622r/DEz1+UitaPT
 OhAIjAes9fHdZALNEjr9PDMT/eCSl8cFsW9fITaB9PJoZLe+E1C4RJnG7sp57y12BQb7JZN
 oIDrSfWumrcUa3yhuRf24TX4iK9hUn69+REdqkhNH9mvohMJre1cLHY1BdswclSRpv/yLKs
 OL9JIjiJtOmwhj0VJiwaw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pKSVoFdgfXc=;0dXSpl3uozxXoDA1deuS7rCOAAC
 fDMiWUdm2L1eG2/KNevexaUiw7jV2t3GRh+FA0B9eUDZtAKUAw2YDrObX+WIB6+KWxin/jFXl
 HhWK3F4wInwrzc8Kuu4TJd9I3j44e7GDvRORw5A7E3wOmlS8u5HTcfmmZiFeS81nW0ziYn/6q
 jflm+lZ+YaumxUUZJuzL8h+Qhxc1Tjl7HpZqU4ZVUsxx/EjUM0UtcQhgTfRadsdqylnNDD/hv
 f3A9PuO9qNt0P/enjWMtmyewd1Il/kqhUHjWPbVjOnHV4wlH7kE1EaoXq+rIEcihhOi4B2vcA
 JNAvgeAKNabzJ9JuG9eSiMHiAmpynQ9nfl3pqCyU2SJzvjOTOK0RU98SM0yfhp8jPXii75Hz9
 +oaDy+I4KGsxhmXHuSAr5RlIpELpF2XNFu84PqGUEkbDDagRZXuJOj0/XLiv0Wz/2gRtvZ8o2
 GAe6s9q7kisl4GV7qr8QXKIVOJi6CRaemqKlMMK2PL8MGy1tyuFwh/HgU7jYWBJCecs4pe0Wr
 ntcrujsJs3FrKbnffcQkKpTu6KoL0vXXwP7NXlEoQ9HEetU+00mZ+02tFdWcHjBVuChwEflYJ
 p8hLz21wJTmU6fseF6RslrhJAt1W/SCOgzo87S4Tq61p9q+pgpMf3tzylBAPJUs1iKTh2qEsW
 b2TWutz8syZxG16VM9jXQWi95pcqh0vENX50wMmfFkDXbrlZwPzTz4Tp6RSk6cVzSIGMecOAB
 S0Fr4sUMfwcMYE27tf8TVhg958O1XNVVyQY0ruPpGnbAx6hUe7sNJ+0ePqieVaMYwRB7sXfaQ
 w/7fVlDIGoDrh2/KzuhHxOGg==

On Tue, Sep 24, 2024 at 10:16:10AM -0700, Junio C Hamano wrote:
> "Jean-No=EBl Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Changes since V4:
> >
> >  * used BRE in sed filter
> >  * rework the processing of three dots
>
> The topic has been deep in 'next' already, and I wasn't expecting a
> wholesale replacement.  But thanks for updating.
>
> As the patches are more in the technology demonstration phase by
> converting only a few pages and making sure other uses of `` outside
> the synopsis section in unconverted pages are not broken, we can
> declare that the three-patch series will not be in 2.47 and will
> keep it in 'next'.  So let me revert the merge of the previous one
> out of 'next' and queue this one afresh to 'seen' to see how well it
> works.
>
> Josh (or whoever is taking over this week from him at Google), can
> you see if the breakage you saw that stopped us merging the topic
> before it causes us trouble on 'master' reproduces with this version
> (either by running "make doc" on the topic branch by itself, or on
> 'seen' that merges the topic) in your environment that had trouble
> with the previous round?
>
> It would also be highly appreciated if other macOS users try "make
> doc" and see the resulting git-init and git-clone documentation
> pages are reasonable, both for the previous round that has been
> cooking in 'next' and for this latest round.  Inputs from folks on
> more mainstream platforms with modern asciidoc/asciidoctor toolchain
> would also help.  The more people we have who look at how the new
> way the synopsis section is written and how the resulting documents
> get rendered, the more fairly we can assess the value of this topic.
>
> Thanks.
>

Here a report from a MacOs user,
asciidoc --version
asciidoc 10.2.0

installed via macports.

No problems seen in the seen branch.

I diffed git-init.html from seen of today against both master and next,
some (minor) improvements (like GIT_OBJECT_DIRECTORY vs $GIT_OBJECT_DIRECT=
ORY)
All in all it looks all sensible.
(and yes, `sed` understands -E)

