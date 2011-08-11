From: Luiz Ramos <luizzramos@yahoo.com.br>
Subject: Re: About git-diff
Date: Wed, 10 Aug 2011 17:53:45 -0700 (PDT)
Message-ID: <1313024025.97405.YahooMailClassic@web121818.mail.ne1.yahoo.com>
References: <m2hb5pb3pe.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Aug 11 02:54:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrJXT-0004jR-FN
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 02:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754607Ab1HKAxr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Aug 2011 20:53:47 -0400
Received: from nm9-vm2.bullet.mail.ne1.yahoo.com ([98.138.90.157]:28137 "HELO
	nm9-vm2.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753542Ab1HKAxq convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2011 20:53:46 -0400
Received: from [98.138.90.52] by nm9.bullet.mail.ne1.yahoo.com with NNFMP; 11 Aug 2011 00:53:45 -0000
Received: from [98.138.89.248] by tm5.bullet.mail.ne1.yahoo.com with NNFMP; 11 Aug 2011 00:53:45 -0000
Received: from [127.0.0.1] by omp1040.mail.ne1.yahoo.com with NNFMP; 11 Aug 2011 00:53:45 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 719275.29368.bm@omp1040.mail.ne1.yahoo.com
Received: (qmail 15003 invoked by uid 60001); 11 Aug 2011 00:53:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com.br; s=s1024; t=1313024025; bh=W4exxjsjaYFzp5lkwx+9gyz6jG/Fp0T1TaJ48kZvA0s=; h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=Ej/MbPxPmR36tbMANplLU62reBnywjZQgPzdpr1Qp8VwqfrfjcaYCYrX6f9VVWIKh6VnTlU56QZlIT1tkzR5QJcBQ3eOI7mZ8pQGapvb4R6IA/MN7WtpiWqEU0mFh1r1d2ggRPpSguc3jaRWjRjCkuzELNOwJTULn/TaswCTkvs=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.br;
  h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=SqOeOWSG5M/NvqG/r35ed6cNiIbpx55oRQ4QZ1ChlwuiY/UsoOZ4dJmT7f+F8Engr2eT/SJEI3IdvY6jq6iNg9d9ryQM3M5b0pjfNi3M3Uq/+k1612kqIc8fMpT3p2W2XrtS2vbi+63/gdTydOCIDTYOZY5GO0I/Q2SSHgps2dQ=;
X-YMail-OSG: eZ23S6YVM1nrbHYu7ImXDX9.lmrLSI_LeVQp4qYxRFieNal
 lP3QAyl7z5XPbRYnmJP5Qfsa6SZL0VZ8QqID_VxWiBQuYrYrgSkcuVkdhxGJ
 Nps5pBOuX.JTkpyfaD6UvRdC2.ZAA17azGapeqg2jWZhQO8EUxNDtJKeePV6
 nH4bwEyPwQDTcQIpcQY48ssypf2HVeWKTM5ugnGW6csSG6BUMDsIBHScQJBb
 qcmB8qnJ6fNpho30b8E3Cz9YlUZ1Fa6mosC557S0ywZFhkXxQD1H1.9zV6CJ
 UFUsDDT.4bYL1kcy1MpolZE_xsQrKt.ij7PsQc9b3hCMuaV4jzFWe_dO3itb
 BO7xz.RiqlG42iPvyc5deaf5YTPqtE8w_kVGN3Q57yldvjnpe9e796SZtEPA
 YN7E_PB8z
Received: from [189.121.246.226] by web121818.mail.ne1.yahoo.com via HTTP; Wed, 10 Aug 2011 17:53:45 PDT
X-Mailer: YahooMailClassic/14.0.4 YahooMailWebService/0.8.113.313619
In-Reply-To: <m2hb5pb3pe.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179080>


--- Em qua, 10/8/11, Andreas Schwab <schwab@linux-m68k.org> escreveu:

> De: Andreas Schwab <schwab@linux-m68k.org>
> Assunto: Re: About git-diff
> Para: "Luiz Ramos" <luizzramos@yahoo.com.br>
> Cc: git@vger.kernel.org
> Data: Quarta-feira, 10 de Agosto de 2011, 14:01
> Luiz Ramos <luizzramos@yahoo.com.br>
> writes:
>=20
> > If I run:
> >
> > $ git diff b2 ./
> >
> > that is, the "non-cached" version, it will show the
> same results. This is
> > confusing IMHO, because the git-diff manual suggests
> that invocation
> > should render the difference between the named tree
> contents and the
> > working directory. In the working directory, only to
> recall, file_1 and
> > file_2 are both present and with good versions. In my
> understanding, the
> > command should report that file_1 is in excess in the
> working directory,
> > relative to b2, and report nothing about file_2, as it
> is in the same
> > version as the sample in the tree b2.
>=20
> Since file_2 is not tracked in the current branch, its
> existence in the
> directory is ignored.
>=20
> > This doesn't seem to be the same thing git-diff-index
> manual states,
> > however. The manual gets more deep into the details,
> and it's not so easy
> > to understand it unless one knows a lot of the inner
> commands, which does
> > not apply to me. In my basic reading, it seems that
> behind the scenes,
> > git-diff-index is what is run in this case, and the
> fact that file_2 is
> > not in the tree associated to b1 is a relevant thing
> in this case. So, the
> > index seem to matter, and if I try to do it, a
> previous "git update-index"
> > should be done.
>=20
> It's not the index, but the current tree that matters:
>=20
> =A0 =A0 =A0 =A0 =A0=A0=A0show me the
> differences between HEAD and the currently checked out
> =A0 =A0 =A0 =A0 =A0=A0=A0tree - index
> contents _and_ files that aren't up-to-date
>=20
> Note that it talks about "files that aren't
> up-to-date".=A0 Thus untracked
> files are not considered.
>=20

Ok, understood.

Given this, I'd suggest to change the inline documentation of git-diff =
(git help diff). In the version of my machine (1.7.4.4), it's like that=
:

(snip)
=2E..
       git diff [--options] <commit> [--] [<path>...]
           This form is to view the changes you have in your working tr=
ee
           relative to the named <commit>. You can use HEAD to compare =
it with
           the latest commit, or a branch name to compare with the tip =
of a
           different branch.
=2E..
(snip)

A unadvised reader could understand that the comparison is between <com=
mit> and the working directory, as if <commit> was the current branch, =
plainly stated. In fact, there is no mention to the current branch, or =
to the files being tracked or not, except for the option of mentioning =
HEAD as the <commit> to be taken into account.

If you'd accept a small contribution of yours truly, here's amy suggest=
ion for this text:

=2E..
       git diff [--options] <commit> [--] [<path>...]
           This form is to view the changes you have in your working tr=
ee
           relative to the named <commit>. You can use HEAD to compare =
it with
           the latest commit, or a branch name to compare with the tip =
of a
           different branch. Note, however, that files untracked in the=
=20
           current branch are handled as if they are missing in the wor=
king
           directory. Check out git-diff-index documentation for furthe=
r
           information.
=2E..

It's not in the patch format, but if you'd like the suggestion, there i=
s no problem in re-sending it as a formatted patch.

Thanks,

Luiz


> Andreas.
>=20
> --=20
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756=A0 01D3
> 44D5 214B 8276 4ED5
> "And now for something completely different."
>=20
