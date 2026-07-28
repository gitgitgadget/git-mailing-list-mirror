Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEFC42378F
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 10:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785235860; cv=none; b=NBRpgXtq2F6cgGAYAt3KmZK58iyDraIvn4P7gUYuRQQBs4PcNUKRZ6dRgNGnDg8ooMH423ufOqDtBeqV2UARQu5N7MDCwH00WOOLyGCSulwv5nORjHZtXSV4LPWD0/GJfDEgl3cRqZlUi4h8nMXavQDAzBy0GnoY7tiCGFQt4i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785235860; c=relaxed/simple;
	bh=jN4ls+F1zBaXJQEijjLL0cwPgg7U1XQJFyPIOJ6K14c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SoDnn8RN2199Wm0pDshwj9g6bCkpSyvtymxCj70ANAzGlyFy9ho6j9rKfeMjYe38v7fxWTz2lQqgTgEdvZ0kaCqLKqgccbjOZ/cJXNnMPg+e+ZiX6lnAn/Ih86ivQlI57UGR+QNjLRi2lW8kJZw7+L91xEsjoTEI/8N0yzJcnvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=KDn03gPC; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="KDn03gPC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785235852; x=1785840652;
	i=johannes.schindelin@gmx.de;
	bh=qK+O4CnOEQC4rJTceDlKJRBcAouhfJVDH1L4/z+a1LU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KDn03gPCtjFSoGsz8h1JSJxT6Oucsnk9K5Twi98kpQzqdxCa3wrZ23K1ZXXPi21R
	 LwLsbSPU4sSb1uVmY2YA/xA6He8fmHN4VbHmNqP6nr12mvTiKWMyCWdSLgNTcBvzg
	 h6lOJrmP4UZxcInnWYzUpkCE1cwEToSi9eiGzph9IT5HBq1zs/Der9/SlUle+/WOw
	 z+xqWurWl92q8iUdDNfg/LKi6G94N8QoGVVljVi098s7RP8+HmJQtV74duC6FmJpC
	 36S/P7Eb3AEykte4FeYiNt+75ex+MnB5hLGUlndBNFudV7WldFAb0ZfCK/jGCvzuz
	 Krmba9pwZa65+mk/SA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIx3I-1wVTqo0r62-00YE4g; Tue, 28
 Jul 2026 12:50:52 +0200
Date: Tue, 28 Jul 2026 12:50:47 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Moksh Goyal <mokshgoyal616@gmail.com>
cc: git@vger.kernel.org
Subject: Re: Vagrant + GitBash Issues
In-Reply-To: <CAPpxU0jjdJu1nssu9vuG9NeyqYFQ_Fu87sVsG0aiRm2qdCXsXw@mail.gmail.com>
Message-ID: <50a74068-d78f-92e1-c259-bd5bf0a89db2@gmail.com>
References: <CAPpxU0jSK52Z+dtK94Ca85j4B6mKWfqypVthaVUVMT4+ur944A@mail.gmail.com> <10584b07-143e-f612-f6d1-6787441a333d@gmx.de> <CAPpxU0jjdJu1nssu9vuG9NeyqYFQ_Fu87sVsG0aiRm2qdCXsXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY=832332810600495621785235758167752
Content-ID: <c5e4ac23-8848-742f-88dc-06186fe7dac8@gitforwindows.org>
X-Provags-ID: V03:K1:aII4BFgpftuaV0Dj6pSeF6IRefQLrI2KZJ4KeCQK6ZJR0/ihy36
 ZkumScui9re+SXp+Dk6PxycjoaOCyXcKwPxdb+mICK1SQWrM7dcmNwJvZGkC3lkwF8V30nl
 IQ1JeOsjmexMHPnH23d++Yyb22fVhJlXFEkgtiaqByh4oWnUrTSg2m1B5S4mq7jhGAh/RMk
 OO1aFg20dqtAM79b76zoA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Bu30s0XVf8o=;zimHdE8YceAo8680AsnmVMvUOWc
 DmpLHiGbhiF0+vdsAOtAnmYhhdbR6H+Iy0qls+ZoxnzR5TlNm3zwg8oKWSYTg2XUNvghRKLAK
 aFSlL02EA0RBBtcgAyoSkvYXGwafxGd5/XjBPVTou/5lGoKn2IrkhrSPr+o6JmDvCBvc4PTWo
 yk+6X88YZv1On6fFLm+lWYHRur/8Woh+W5CPPjRZfzQ438WgLTpWacWafngD6c1hKMhcrZnto
 CxihLYmTu+CFWF2wwoO5N62PZqJB0lKjDZG/az9Ifw8XNzB2x8gyNDp/9ZxzBK9uUAnn4Zcn/
 VRfEw++qY7/w8zQuNERcItDGjYSAubkOflOM3W9oTeF5p+DHT1sPhRJCgEAJ7gu50iiU+bvmT
 C6s0xujFCsT09Ow1OM2prfquukVMv0TmGUG1wS+C/c1ajqguUvijVD5xTuxMGyiyHznb2JUmU
 7XXJFF9aG1KFr/dOeTbljqZEDlFGlJS3Eh6Xf3uHnH3tbALMp0yMuKaaUVJ0UtULHtGL9COqx
 zLUXJ1370UZrFJB/O+IDRFL6nxHSTZslvjMm1/qBiuQqwUISoP4+ySosPdMZfGRfNjx1bAmKq
 jSjgWUgXXtDnOj0poMWe+QyywvetTi8aa/oQedWfzOdA1JuK61oThm14gLQbaYK9Dmzh/qfFU
 UIGScxBESTECmHzWCwS92/D4zCY2k7ajFWedTKI6hyTXJ86w3ZqyDp7dtLW8cI69UqlqmmRFm
 1wMM1cEzBToQactXJz332nInsLcQZN47eYzgaw4Uhp2fJ6iPobOpezcdqyaoLOIYx1ucnOc3N
 IYMeIfPlhjjHzrwEq0HNx7N8ueTtmBZtg/9uVjQocMksEOj5pEGYRv1O3K8hvKq1dNDvx+/19
 dsH/T+WLZCcJt2t97xKh1s5Nmx0flCEzC8FXi9RYBY/C+IUcZEJXI8gPoI9O2j02UlJ4WTrt1
 o4UoV48sjqkh7I7C19V5k/Tlj2UaHpY2lGOmFD17j7CQhqYhR8IqqRD4+fu81Zs6JjjV13DZL
 MNAHXe9JtoFFGBpg+vQIRT1FeRXExOg2hBzhx/RIrVmcq6uHngCVPDYwd8DScABo6K3IK7kgG
 zk+WOTVJZL66S7Sxk7hGskHlR5zb3f+RXdQlwflJLFMNsPN761lRVgFviRMTiJVDUhWY+simv
 bZZVdSnC9rEvyGfHiwnFg2p8qBqgIoTge+dQD6+o43W0UPHctwcxDNY3/dFHKldvtCQV6PQq6
 K5I+WLskSMylCnGiYsX97n2I9dUeJpt3pceDswmC3AVBUlV4flyPn6meLgndg4SNwqe684+DV
 PEXfm3ziBm5k+HY2Dg7MBvRCC0KteArWIi4tUlcbV963gI2nS8IA9XUtyvcjNbbP1LukNwETS
 ACkKHL3kl7/CWjO4Cv9PPrlXwWH1q8O8KQl1uDBX2puQE035FgEjrOvowv0EW/Ql7Q9RDplik
 OA7QThgNHEmrGs1Bt0Ctro9MGAFSJZf7JQGgrhAW04Kva2/GuzlW0h1PovdRpbLp4vkohb/g9
 CrK9FbHv/tV5fgv/UeUuCiG1KQQsaw6dDSuYMK5wnIiEvhIBRxecIl9IBjIglGUYHH9YFpAJT
 nifYX7GqCVz8oYw1iefOHVd4iM/fjkgGQPP7Ejigf02QPbAnzWhWvhQIM3EQEZP3s+q24bhSZ
 Jue6ak2gHm/aQHw3OAyhOb3ZYgWn443HX454ZwZDePIzbeU59kWrFuDiW+iFskOTCCmoRqOSE
 hoowgcntZp78w+WLderawTUtyhRmz/Xtf5joLI+5+izTW/qedGOoJX9/uO7269gsQDO/5L/hI
 KhrToX5aP5HPmNdCeu/ubrRgfywUzyoDUt3Ld9pfi1hf6A8bf+HdKoXVzrd4q2dGcK9DWXZFS
 T/uDZZvTOmkEwB0cdjFZsmDDVndOEi5dR81odFsjetSTmTQFKjb7S7Yjxd5jEDpuzAp4xMpue
 yvzSRBuPXeBvEY9IJ0rc2DdPFlxhPdJpbkHNlluEbXxYuM191kx07RuzO1rqvChL9+1QvNYr1
 VWtABPHLusG142YNVVl520KbL3uovVpRqvJB18+wuKQIT5eV0VzBIoBTiTRczE8/V0q2c2xsl
 VOoNCiSDgddjhZjV/mzEiVreCsaNRkEa6h+xCcncKwOt81nF/cxqJdFGBoh3iFtJuAM6CoV3h
 27kRI+ezMqORYAVBaj9SZkN09mCA27b6559Jb/V6c/II3S13rfZpyedy1FXdNN2iYX+Dnzvpl
 tSgzkAB0ustKS0aUr+gFM3PB1nfBdGDQU0QFSkgPpFUyDsA36Jy6JVEt+h7LtqIf5grU4q1SW
 t1n6MCrSsX1oifSSNTDI7SA1bbQzBNmS5iDQCCC3rfEsIUCOhzMPiioXLKkjtaomu0E1ioUpb
 O9mduK+O/jYR0LT+ZMJec4GVnh0ocEK5Mq+nQbJAN5yrqGOSRPEBcdOlA7x6zJjs1a3LqelIu
 yVhxvh6G8FXvIa/q3c2X29RlKtl+PzXPG5bi7gUGschYXJuDk4Mrxe9ltROa22wsgoQulxaV1
 cLfRn3OdNlDqAvMyBfgrEb3Iz5aqOLt+i+DE0l2JgG78Uy6KZIFb5daqsL8n7Ulq0c6YwjFlz
 xGknWqXcu/3Tm350JjB3+Jh5IePF/gblPz8sGnmHKHuQS9Uwcf5rEze/Bog04NUpCedk1nMa7
 jnFyzX8eBTz/92S2dC5Ce/pkpNRih8Y5KMMFVi23KatJFhOmV90QKeMp4W6D7epkktIp6PJkI
 qgINIvqcotJMR59KnI7St3Nm+SPTwfOMUZ+ZWpLUTvoYF4u3XCo82dniIVAHeq8ZfMNhVyAVx
 krFVDUKJkp34p2t7s7hK/gDcphKL8dIL0H2cEi6zuZkVpfRMhl6arb1+/CyPt1vkSkJGzewR2
 laEHEYUn06vg0zbsHCuE92bozec3ITvGH6icM4BeYj5CFC+ekbwwkx0UD75lXtKblT0j90kbl
 8HBRUG2IQA9MVqDFQgQJYczL/SjHqMlTZyLsEV0DDN3Y1hOJuHxIVFkQufyV5p7DqMhxsJGRp
 0Lx6boz3OTY/evGCRmkC7H7ae11Zz8+BzcvVs+oq3TZg50KCzk9WRmYrkjIVLOhkdDzm7CwHI
 M+jTqkvpxWaaZ02r4MtrZOaErr38Gt1AXw18H1/wNTpooWq5Tb0+YYzlYsBMUkPkjxRTjdyJx
 EKRJDuNl5uDo2zNE6KDEOvMx1y5i1/gVoBt4Yiv9P1K18mVLmavV9sFUF+JVKDb916Ddc6Yru
 GdPpsQGj/ry88V/+AF3zb+q5enNOBpzFq0Y07izPsWnXqhO6y5AIESqLMNSjsJmyouIwfcpFv
 mVcUxINJWHTam1WhI9xat27V1udxBvQ2kQm7ELLv0topi4ZDflyFG828ruGlrXnF8neEm+0EA
 OfciB2XBWah+4AQ5jMXMangqn8adgxBJ1yjq1+AuMGH3VAn1dT1kDP3mYD8PRUo8isZPz/INh
 9uf1HG/rP2RAoTJDTLC2pjYLF7z8yPegmNcncxTW4a0u7MMcCAjLfdYxWSWicUEbnTflx0F9T
 ahpG1faePKEQKJVU5/emhjRW671h2Iz1KHtm04eh5iADXJAPC17rgyRdNHlF50sTAAd3rBtqI
 ygm1peo09p03dUE9qN3YzoDFt4bXa5KXW+Q091l3SmlNpSzbHvS39qFgyPEyl6Zwzpjvte+KZ
 0Q7ygK9WgaGWeciXlBBYlui3XNvBZWra+skX3t+b0TgiBq0zP/OYpHRubo9Alt/OXiUhxolLc
 8g5P+oNeyPXXtwMMvD2dSF3/VsFg337dZ65zXq0Nw1wacj42BC0/AF87chg0PWSJ/0o/sML8b
 Dg5B4hOr2BPPUtJWSIHteVQraF/wQlfCFMv6a9WqGdEXL3/rEiqR/zRtwhL0tdLm6kbJpvKJV
 KbNJplkDIN153lcowP0KljWLos+ju+s0nMrgHCnsDAqN6KWDJHIRbOuf6AbR40Dk8ShtUER+J
 tYP9NNT6fw+qXP5E0iveucbkBBPlq7f4SRjYkW/Tkgi1R/h9HiESXHiMm/r6JKpb25+Sz7hLf
 jdrvPciFA8hEemJ5qtb2ohK1fhXK9pH7Et5pGuo3EiuDvN9na+tGmpD3yw5QU4lW2rday2Dim
 AhBsc/tWRzfSyJ/FCKoFIVXqJYUj5wvBJ79Q+V8ArQ8x8r+Hoo82xKHpSZfMS7ci4eZVhcOv5
 qC7vwH7WmzUKf0F9SRwnX0vB9NYbQiARNnsK4Lh+Va5qeUQ7NN5IhDWb/kYttrzO9EMqC4qQv
 4j6dnUWrjqwIIoHdaUwyvR2qm34VCUAAmBeZBtkOxRj46JoTwn9wvmjAYNnWxMNWHGaQZGdvc
 x6L7FXgiNqdsXEGTZQ2DfY3/MVSl7iY9khDvSwfoE4ufTxCmgUb3zVVx9W+Pfv8iBGpiyI/NG
 Z7BUY5nz24Mqj2WJt7g0eAmQ6kph5xPZZliZ6f+XbBdBBV5DFWUqk/0Qzk8PmwS/dtAjIFOsC
 +yrwMNEJ71ZfGbkZH1rZqCtvadw7kJ+kCxhhmDubXkApSC664MLmV5hqZfFy6ouFfTZTopu4n
 2/vG7nlkFyCFPKd5XzAg/LLjjWWGJ0eyXpxWl/aFeLzB6uZXmtrxE3WvjWrzDsAXbSktIguXt
 RMHQ14OZPkjshZwGAiHuB15fjqQyehhWygxIMO4dgDY5qlcoXBDfaejMjvSFRMnAxnx9BBOFQ
 YFnGcKeYe9bBGllJTWg3sHsFtqHhPzvl830wWBXoI6RA+lSRjEdTk6XHJ6sdGzBhRBOLJ/U+f
 yMyo4cxkTSPI7kr/xxsAR8nHbelYZIT5D5AQAhVpeDhbBztz6vGBgKUgz6CV8w8bgZRpqxywJ
 RsSpRzttZa+YiufFMM9luUwmnz7HfostEo5cPufVzTjYlNvhLoM9sY0fyfHsJLx9QYRTXPwjQ
 Krd1Nt1TfUXrrRXhNyuJUmXAKVHwJ7njlfsmVlkWkn/fhYNO5GP/3kXAQU4uoIKLrn/FhQjVw
 TTsaV0Mjig+k8+VHXrPZZe2FB6aVI6qZATvJOslJbmkW1D6qwAPXREugWTPK/QCTPTlwbiS7w
 ZQUrlqZ4sdJbeUnNK4I+a3FZxhjeel313TDk0WEBcbfgU8fkDm98Cl9TiliDkx388omL+Cti5
 sCfEWdd9Nq8KPCAPHHOZHtsfqFFE3tZiJhoKe9xAFIYrpM3qYGs2DdqETx49+B1iepcRrhgV+
 r4iz52hPO2UBAsOtM8Rf1anjyTr6Oe6e6ksuioHcoq9mg6CO5arRnWru3AW3S0hjEogh1/mkF
 n4UL1rJqh/szjYlW8BThGzoPmrZFWuxAzakzWth0BN44HCO79r2d+ksX4KwikXLGK1Q1mRST+
 HAA/gym9OChAx05xKoW4ZbERBYU7QU7UBSdycuRHqPNCI0t0ZhBgfEzBtkPjZS077M1MQkocQ
 DkbYVmg1Y4SRLitMOi7cYr6o7hoDhHWhd9hh8WNS4h/y4Xp3MVq0KKYTh/1TTRUe80kgF4J1l
 nvBYXGKMDOV9HZYsSoZUO7lE3LeXkNAHFZiQK50wCVNIAv97Gu6IojbUbqaNIZ8adJ4W+h1cx
 arcsXmBd2o380GTYKgKTUku+mpulIBbxUoYKmJwdr59H+L3gbVl5B95qAJ8nvbNyszd1Gzw65
 7Z5SJev8Pylb5qfScEKOJ53e8cWI2kuATyihTt7HxcDBaxJYBUjj/T7cX5c4M5E1YC+C1QrrR
 49BPz+WK6VnOLR9/JfDNuAyMRqNpo8qz2NndhuVz9QWPQz++0J+UAiKX+3wVGN+ShRQTYg8pH
 LfHFSYMMUF4aAq0c3M0+h

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--832332810600495621785235758167752
Content-Type: text/plain; CHARSET=utf-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <a535b84d-d26a-b3f8-6d4d-bfb9b68d477b@gitforwindows.org>

Hi Moksh,

[re-Cc:ing the Git mailing list because I would otherwise feel treated
like unpaid tech support]

On Tue, 28 Jul 2026, Moksh Goyal wrote:

> Thank you for the response. I am currently using the latest version of G=
it
> for Windows (version 2.55.0.windows.3), but the problem still persists.
>=20
> Do you have any other suggestions on how to resolve this?

You could install the native OpenSSH:
https://learn.microsoft.com/en-us/windows-server/administration/openssh/op=
enssh_install_firstuse
and then reinstall Git for Windows, opting out of the bundled SSH.

Ciao,
Johannes

> On Tue, 28 Jul, 2026, 3:52=E2=80=AFpm Johannes Schindelin, <
> Johannes.Schindelin@gmx.de> wrote:
>=20
> > Hi Moksh,
> >
> > On Thu, 16 Jul 2026, Moksh Goyal wrote:
> >
> > > Hi Team,
> > >
> > > I am currently using Vagrant and logging into my virtual machine via
> > SSH. I
> > > have encountered an issue where pressing Ctrl+C terminates my SSH se=
ssion
> > > entirely instead of just force-stopping the active command.
> > >
> > > This setup works correctly when using PowerShell, but the issue
> > > consistently occurs when using Git Bash.
> > >
> > > Do you have any suggestions on how to resolve this?
> >
> > That sounds like https://github.com/git-for-windows/git/issues/3716. A=
re
> > you maybe on a very old version of Git for Windows?
> >
> > Ciao,
> > Johannes
> >
>=20

--832332810600495621785235758167752--
