From: Luiz Ramos <luizzramos@yahoo.com.br>
Subject: Re: About git-diff
Date: Thu, 11 Aug 2011 04:17:16 -0700 (PDT)
Message-ID: <1313061436.22648.YahooMailClassic@web121810.mail.ne1.yahoo.com>
References: <7vr54sr1qi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 11 13:17:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrTGM-0003Yo-W6
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 13:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753284Ab1HKLRS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Aug 2011 07:17:18 -0400
Received: from nm18.bullet.mail.ne1.yahoo.com ([98.138.90.81]:32233 "HELO
	nm18.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751253Ab1HKLRR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 07:17:17 -0400
Received: from [98.138.90.57] by nm18.bullet.mail.ne1.yahoo.com with NNFMP; 11 Aug 2011 11:17:16 -0000
Received: from [98.138.89.161] by tm10.bullet.mail.ne1.yahoo.com with NNFMP; 11 Aug 2011 11:17:16 -0000
Received: from [127.0.0.1] by omp1017.mail.ne1.yahoo.com with NNFMP; 11 Aug 2011 11:17:16 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 736387.62804.bm@omp1017.mail.ne1.yahoo.com
Received: (qmail 79528 invoked by uid 60001); 11 Aug 2011 11:17:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com.br; s=s1024; t=1313061436; bh=aqXlV4m4GrhEipdbgrLHWLzNpVrVSSPhownN6yZ4ito=; h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=dMguzZeEbCjNOee/rTZpyRCxLTMFHr8WlnFrEjWSIIW1kNDYOvKVAhW7GW+gnMeJ5zNxtg/ySiujExU6OjKpHHo61oLl6AV7+nNK1eWICZgDXXsydVtf+na1L6Qiy856mH9qQtFoCmv/cXV2DQ7fFTR4hvnWAMT3JscXJFoYqmQ=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.br;
  h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=NFgFKPMPNgH7jGQRwt59Wmsh8cfx7y7dMxBZIxZVoHA9lCxhh85QhFHcrV872u7PtNmGELJykXl5IbvYIV6BQUBG51Fxnlzz+ihWkWaSEk4TM78Nc+GHzAGe1Kk8qd0TTtEyW01om0oqfqVm+E3g6Rymn1lEux6Dmxf3O2pdVNg=;
X-YMail-OSG: QiOxm0wVM1m11LFCcMxZn5kelEtjORWl1yoR1Zi8ZtbAa7S
 qODOEJZGbdZdO5dqR23YTzl1zw4R2y8r6m8bobQx6nKDlGFXZaba5JPp3_oF
 mSxXOQm_pmq2PQnrnEfbUzdADArq7sjTW.LZ8J6VpAZ0es9G7Qm0Zfl9XljZ
 vvddTW6Jv0NgfWw88juuEzglc009.5gO4vyV_f_.RoaGBCjXmLppPxvOfMkj
 h3I92JW5Tv7cN3qnAr.HzcKfd_uodEaDzQAMpDHySRT1P2WupW5V.4Heg7E2
 PbGoYMnQ_ZNATT9eAKv00PIUc8AwJzFA5QYVUMadrCVZ0dzqAffAGulpfu_q
 TuPt.3mr.iyil.SLsyHvlmWgt0x30.jUCchpcR.7zxVMWFRINvv85eEgv.TU
 oevJLVOk-
Received: from [189.121.246.226] by web121810.mail.ne1.yahoo.com via HTTP; Thu, 11 Aug 2011 04:17:16 PDT
X-Mailer: YahooMailClassic/14.0.4 YahooMailWebService/0.8.113.313619
In-Reply-To: <7vr54sr1qi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179109>



--- Em qui, 11/8/11, Junio C Hamano <gitster@pobox.com> escreveu:

> Luiz Ramos <luizzramos@yahoo.com.br>
> writes:
>=20
> > Given this, I'd suggest to change the inline
> documentation of git-diff (git help diff). In the version of
> my machine (1.7.4.4), it's like that:
> >
> > (snip)
> > ...
> >=A0 =A0 =A0 =A0 git diff [--options]
> <commit> [--] [<path>...]
> >=A0 =A0 =A0 =A0 =A0 =A0 This form is
> to view the changes you have in your working tree
> >=A0 =A0 =A0 =A0 =A0 =A0 relative to
> the named <commit>. You can use HEAD to compare it
> with
> >=A0 =A0 =A0 =A0 =A0 =A0 the latest
> commit, or a branch name to compare with the tip of a
> >=A0 =A0 =A0 =A0 =A0 =A0 different
> branch.
> > ...
>=20
> Strictly speaking, "the changes you have in your working
> tree" may be what
> is confusing. Your working tree does _not_ have "changes";
> it only has
> "contents". Changes are perceived only if you compare it
> with something
> else, as their _difference_.
>=20
> This operation compares "the contents of tracked files in
> your working
> tree" with "the contents recorded in the named
> <commit>"---the result of
> this comparison comparison matches what humans perceive as
> "changes".
>=20
> So perhaps updating the first sentence with:
>=20
> =A0=A0=A0 Compare the contents of tracked files in
> your working tree with
> =A0=A0=A0 what is recorded in the named
> <commit>.
>=20

Yes, agreed. This sentence seems to embed the right information in a mo=
re concise manner.

> would be all that is necessary. I didn't bother to look but
> I suspect we
> have a simlar description for "git diff [--options] [--]
> [<path>...]"
> form, and it should be updated in a similar way (the only
> difference is
> that it compares "with what is recorded in the index").
>=20

In my version (1.7.4.4):

(snip)
=2E..
       git diff [--options] [--] [<path>...]
           This form is to view the changes you made relative to the in=
dex (staging area for the next commit). In other words, the differences=
 are what you could tell git to further add to
           the index but you still haven't. You can stage these changes=
 by using git-add(1).
=2E..
(snip)

And yes, if an untracked new file is in the working directory, it is no=
t reported. Again, the words "changes" and "differences" seem to be con=
fusing in this case as new files may be seen as "changes" or "differenc=
es" for an operator not used to git.

Luiz
