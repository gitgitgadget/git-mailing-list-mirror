From: =?iso-8859-1?Q?Ren=E9_Haber?= <rene@habr.de>
Subject: =?iso-8859-1?Q?Re=3A_Bug=3A_pull_--rebase_with_=E9_in_name?=
Date: Mon, 5 Mar 2012 13:46:39 +0100
Message-ID: <0E2B8DE3-1ABD-453F-BCAA-0D693ECA5987@habr.de>
References: <FECFDD4D-6EC3-4DE1-8A08-B4477345C4AA@habr.de> <20120305102657.GB29061@sigill.intra.peff.net> <87399nqqog.fsf@thomas.inf.ethz.ch> <F5A485EA-7EAD-4D8B-87C4-7185F713318C@habr.de> <20120305115815.GA4550@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: multipart/mixed; boundary=Apple-Mail-21-457081886
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 05 13:46:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4XJR-0006GM-1J
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 13:46:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142Ab2CEMqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 07:46:44 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58999 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932073Ab2CEMqn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 07:46:43 -0500
Received: by bkcik5 with SMTP id ik5so3091508bkc.19
        for <git@vger.kernel.org>; Mon, 05 Mar 2012 04:46:42 -0800 (PST)
Received-SPF: pass (google.com: domain of rene@habr.de designates 10.204.150.75 as permitted sender) client-ip=10.204.150.75;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of rene@habr.de designates 10.204.150.75 as permitted sender) smtp.mail=rene@habr.de; dkim=pass header.i=rene@habr.de
Received: from mr.google.com ([10.204.150.75])
        by 10.204.150.75 with SMTP id x11mr10303501bkv.62.1330951602187 (num_hops = 1);
        Mon, 05 Mar 2012 04:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=habr.de; s=habr;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :message-id:references:to:x-mailer;
        bh=wHiBrnoIc4nvBEBFHgO0kndm5WfrLNXEga0xRQpW3uI=;
        b=RzDn6EeEWBC+PjhqlObcu9wkRFKXCYKa902jHPno/+kZWMKtLmDXg9XMYoe/KBFM/P
         uuyFQ0rRIzQ2YZllJtsOQkve98fsd9p0EGb2hCH/REJ9rBWnWO5sbG1D4OHCpWMQc2FB
         e3VMA55+lbiAQAm+cqW9Hx72nuV7Aw5yjKROA=
Received: by 10.204.150.75 with SMTP id x11mr8174558bkv.62.1330951601889;
        Mon, 05 Mar 2012 04:46:41 -0800 (PST)
Received: from laptop1.physik.tu-chemnitz.de (laptop1.physik.tu-chemnitz.de. [134.109.16.58])
        by mx.google.com with ESMTPS id f5sm14602768bke.9.2012.03.05.04.46.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Mar 2012 04:46:41 -0800 (PST)
In-Reply-To: <20120305115815.GA4550@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1084)
X-Gm-Message-State: ALoCoQkGXyfH75F0MWPqPkrrxvbQvKlX7Kr1cIJF32dRsBE62ZAxfvAm2umbMnnpNSHBS/4wUOab
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192232>


--Apple-Mail-21-457081886
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=iso-8859-1

sh -c '                                  =20
   . /sw/lib/git-core/git-sh-setup
    get_author_ident_from_commit =
16b94413cbce12531e8f946286851598449d3913
 '
GIT_AUTHOR_NAME=3D'Ren'=E9 Haber
GIT_AUTHOR_EMAIL=3D'rene@habr.de'
GIT_AUTHOR_DATE=3D'@1329212923 +0100'

Commit attached.

The thing is, that this only happens when I do git pull --rebase.
Doing a git rebase -i HEAD~5 or so works.



--Apple-Mail-21-457081886
Content-Disposition: attachment;
	filename=16b9441.commit
Content-Type: application/octet-stream;
	name="16b9441.commit"
Content-Transfer-Encoding: 7bit

0000000: 7472 6565 2032 3338 3339 6430 6161 6635  tree 23839d0aaf5
0000010: 6130 3536 3932 3366 3735 3839 6433 6335  a056923f7589d3c5
0000020: 3063 6661 6337 3830 3632 6661 350a 7061  0cfac78062fa5.pa
0000030: 7265 6e74 2030 6530 6264 3264 6236 3232  rent 0e0bd2db622
0000040: 3565 3433 6463 3565 3239 6139 6161 3034  5e43dc5e29a9aa04
0000050: 3732 3730 3466 3430 6237 3066 380a 6175  72704f40b70f8.au
0000060: 7468 6f72 2052 656e c3a9 2048 6162 6572  thor Ren.. Haber
0000070: 203c 7265 6e65 4068 6162 722e 6465 3e20   <rene@habr.de> 
0000080: 3133 3239 3231 3239 3233 202b 3031 3030  1329212923 +0100
0000090: 0a63 6f6d 6d69 7474 6572 2052 656e c3a9  .committer Ren..
00000a0: 2048 6162 6572 203c 7265 6e65 4068 6162   Haber <rene@hab
00000b0: 722e 6465 3e20 3133 3239 3231 3239 3233  r.de> 1329212923
00000c0: 202b 3031 3030 0a0a 486f 7065 6675 6c6c   +0100..Hopefull
00000d0: 7920 6669 7865 6420 6469 7370 6c61 7920  y fixed display 
00000e0: 6275 6720 696e 2076 6572 616e 7374 616c  bug in veranstal
00000f0: 7475 6e67 656e 2f65 6469 742e            tungen/edit.

--Apple-Mail-21-457081886
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=iso-8859-1


Am 05.03.2012 um 12:58 schrieb Jeff King:

> On Mon, Mar 05, 2012 at 12:42:14PM +0100, Ren=E9 Haber wrote:
>=20
>> I'm running git 1.7.9.2 from Fink Project on MacOS X 10.6.
>> The gitconfig in hex is attached.
>=20
> Hmm, looks like pretty standard utf8:
>=20
>  0000020: 6d65 203d 2052 656e c3a9 2048 6162 6572  me =3D Ren.. Haber
>=20
> and the same thing I used in my tests. I tried repeating the test with
> v1.7.9.2 on OS X (although my test box is 10.7), and couldn't =
replicate
> it.
>=20
> Can you show us the commit that causes the problem, as printed by "git
> cat-file commit $commit | xxd"? I just want to double-check that there
> are no odd bytes there.
>=20
> Also, what happens if you do:
>=20
>  sh -c '
>    . /sw/lib/git-core/git-sh-setup
>     get_author_ident_from_commit $commit
>  '
>=20
> (my theory is that this is the underlying problem in the rebase, and
> should show the bug; by narrowing it down, it should make testing a =
lot
> simpler).
>=20
> -Peff


--Apple-Mail-21-457081886--
