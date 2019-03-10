Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78DD520248
	for <e@80x24.org>; Sun, 10 Mar 2019 06:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbfCJGeE (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 01:34:04 -0500
Received: from mout.web.de ([212.227.15.14]:38653 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfCJGeD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 01:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1552199640;
        bh=jDvhcqc+sL5PmHIz8cctya4yvj38Bv0XtDXnwTI8x7Q=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=eKdPXKzA+7+eayVYD2ffINCT2+yPt98Bjoh/9AkN+dyFpBM1nPPejRGYkgUyN6Puj
         5p66I8rBwniOxSOsfMWM4B2ZFSn6csCOJZd08V+wXF2fYnxzVWEZzHu5ZCcQRxMsD0
         ZiJM8M83nCH5moC9+hW0Q34MjaFhoaU9LsscHZRg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MI6F4-1h4VOQ07va-003rp5; Sun, 10
 Mar 2019 07:34:00 +0100
Date:   Sun, 10 Mar 2019 06:33:59 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: t0028-working-tree-encoding.sh test #3 data
Message-ID: <20190310063359.ejcv47fihnnbjqp4@tb-raspi4>
References: <CAH8yC8kSakS807d4jc_BtcUJOrcVT4No37AXSz=jePxhw-o9Dg@mail.gmail.com>
 <20190309161003.55t4irdwd76asnuf@tb-raspi4>
 <CAH8yC8=01S8m8XCPoHgfX1woAEzHN7HXEn2Ncc1ceOF0SMnFaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAH8yC8=01S8m8XCPoHgfX1woAEzHN7HXEn2Ncc1ceOF0SMnFaQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:S+Lzw/ojHsD96jlwPyYbJPAYbaErMLoQO/g7V29qNKVcVjxYoZS
 CqqauNuwgq1aOkLW8YMf0bKEDJGhD0DO3DzdSuZvuTA9SHcFcHWGupEKXUJnNq9qeot1+Ob
 ZYvpPnEnQoOB0CN8bCupp0CKHlBMuqsq1Tl6JxnCYe6nzWRTq7Rt6XOwce1Wkm5UDNk7txL
 RnH03TqaAB9AqxIB2GCXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:23zxd/mMlGk=:9K2QwSIH/XXbaKh99Fm6SI
 5znbjXb4spe6gOC1R5UlJe7AzHpESEqk2/kWdee9eQLabcz2ccvrdFXsiv4ef/LpR8bAC3TFr
 lDTCSkNX46kzKHaPBbvGu1TwkiEkX+a6Ur7CHiDqVZpG3o79opuyE3K78XyZb8LpK6E2EEIMh
 zWfCQEITT036FhqYqKO2/tJGSEb3fTV8A7+7v/Drusl/1+p5SNja7fYyVbWaZQDI6QEQCEPSV
 xfVsChLayxBc/vassUz5MVtMpi/Ac/xGPbRAoaxVA5YzUepgt8jAjsWxV67ENiHd4nZnqU9sS
 TvGLD/+wF0ZmGIMIAHc2IAn9u/ZE3UcFxlsMdnZhXMAc4UVCJq7ENFEaDUXXcI7sSjceFO9lV
 mC73cnIFPtRzrmcieoxdhS+xjvngx6/CZccKMv7/x5BWEgf7Ur0aGmbAovvsFWB4joleh9vIJ
 19icF3YfJ2bhMQ4zffrmZUHSF7yoODYGuwCCb53Z3B2wx6egRgZ8OVUxNHyezL7TRYlSmMFd1
 swUJGO1Fp8f8OwA4387oZhs4fPJ49SPemFgoKHZoRfoYYUuru8Tbk8sCZdnB8fznzC9TmRjXM
 b/hN29GGUFh6jOWwiouxipGbykQ+recMgNpj0KYc90ebu4v2eG7ewYtnSCbK2s7VgCqPkebQJ
 dTZ/hUEGaRP0SRt9oiz8/RWZGwLpSRB4xrm4zsUhcbzpAUnT3ZqSFmAosOMzzM43bEV0CreZq
 mtMcPEw9WH4Jb2RFT8xsHXKkW3/UtAgt2FFAuJee0LgwC7KE1cklvSvX2ZBSxPu1eueAteeNV
 DBFqjrXo7REFazNDXzm2TV/Sr+g3oXv9AtPdeONuvM4SnWiV0/J+GOfHgqL8CoFKnxhZsXD15
 yXWELy0nQrbuQd/6MPEkr+o7hBMIHo/KdtgCa45ZIcfkJF4Zg3Dnk5ZeMGFLmY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 09, 2019 at 08:57:07PM -0500, Jeffrey Walton wrote:
> On Sat, Mar 9, 2019 at 11:10 AM Torsten B=F6gershausen <tboegi@web.de> w=
rote:
> >
> > On Sat, Mar 09, 2019 at 09:36:34AM -0500, Jeffrey Walton wrote:
> > >
> > > I'm experiencing a failure in t0028-working-tree-encoding.sh. The
> > > first failure is test #3. The source states "source (test.utf16lebom=
,
> > > considered UTF-16LE-BOM)" but it looks like a UTF16-LE BOM followed =
by
> > > a UTF32-LE stream.
> > >
> > > Am I misunderstanding the data presentation?
> >
> > Thanks for the report.
> >
> > I think you understand it right.
> >
> > May be you can help us: Which OS are you using ?
>
> Fedora 29, x86_64 fully patched.
>
> However, I'm building Git and all of its dependencies with additional
> flags for testing. The prefix directory is /var/tmp and the lib
> directory is /var/tmp/lib64.
>
> RPATHS are set for everything being built, but I don't rule out those
> stupid path problems that plague Linux. In the past I have seen grep
> and awk from /bin use special builds of libraries in /var/tmp/lib64. I
> have not figured out how to tell programs in /bin to stop using test
> libraries in /var/tmp/lib64.
>
> > And what does
> > echo "hallo" | iconv -f UTF-8 -t UTF-16 | xxd
> > give ?
>
> $ PATH=3D/var/tmp/bin/:$PATH echo "hallo" | iconv -f UTF-8 -t UTF-16 | x=
xd
> 00000000: fffe 6800 6100 6c00 6c00 6f00 0a00       ..h.a.l.l.o...
>
> And:
>
> $ PATH=3D/var/tmp/bin/:$PATH echo "hallo" | /usr/bin/iconv -f UTF-8 -t
> UTF-16 | xxd
> 00000000: fffe 6800 6100 6c00 6c00 6f00 0a00       ..h.a.l.l.o...
>
> > We may need some more debugging, may be you can send the whole log fil=
e ?
> > Even if there is are a lot of ESC-sequences...
>
> Yes, absolutely. Which file would you like?
>
> (The only thing I can find is config.log).
>
> Jeff

(Which version of Git are you using ?
I assume that you use the latest master ?)

Sorry being unclear about the log file.
The idea is to run t0028 from the t/ directory like this:
 ./t0028-working-tree-encoding.sh -v 2>&1 | tee t28.txt
 And send the t28.txt to us.

 But before doing that, it may be useful to patch convert.c to remove
 the "ANSI sequences" and make the log file easier to read.
In convert.c, remove the  "\033[2m%2" and "\033[2m%0" stuff in trace_encod=
ing().
(Or use the patch I just send out).

My version looks like this (shortened, you say you see a breakage in test =
#3 ?


Initialized empty Git repository in XXX/t/trash directory.t0028-working-tr=
ee-encoding/.git/
expecting success:
	git config core.eol lf &&

	text=3D"hallo there!\ncan you read me?" &&
	echo "*.utf16 text working-tree-encoding=3Dutf-16" >.gitattributes &&
	echo "*.utf16lebom text working-tree-encoding=3DUTF-16LE-BOM" >>.gitattri=
butes &&
	printf "$text" >test.utf8.raw &&
	printf "$text" | write_utf16 >test.utf16.raw &&
	printf "$text" | write_utf32 >test.utf32.raw &&
	printf "\377\376"                         >test.utf16lebom.raw &&
	printf "$text" | iconv -f UTF-8 -t UTF-32LE >>test.utf16lebom.raw &&

	# Line ending tests
	printf "one\ntwo\nthree\n" >lf.utf8.raw &&
	printf "one\r\ntwo\r\nthree\r\n" >crlf.utf8.raw &&

	# BOM tests
	printf "\0a\0b\0c"                         >nobom.utf16be.raw &&
	printf "a\0b\0c\0"                         >nobom.utf16le.raw &&
	printf "\376\377\0a\0b\0c"                 >bebom.utf16be.raw &&
	printf "\377\376a\0b\0c\0"                 >lebom.utf16le.raw &&
	printf "\0\0\0a\0\0\0b\0\0\0c"             >nobom.utf32be.raw &&
	printf "a\0\0\0b\0\0\0c\0\0\0"             >nobom.utf32le.raw &&
	printf "\0\0\376\377\0\0\0a\0\0\0b\0\0\0c" >bebom.utf32be.raw &&
	printf "\377\376\0\0a\0\0\0b\0\0\0c\0\0\0" >lebom.utf32le.raw &&

	# Add only UTF-16 file, we will add the UTF-32 file later
	cp test.utf16.raw test.utf16 &&
	cp test.utf32.raw test.utf32 &&
	cp test.utf16lebom.raw test.utf16lebom &&
	git add .gitattributes test.utf16 test.utf16lebom &&
	git commit -m initial

checking prerequisite: NO_UTF16_BOM

mkdir -p "$TRASH_DIRECTORY/prereq-test-dir" &&
(
	cd "$TRASH_DIRECTORY/prereq-test-dir" &&
	test $(printf abc | iconv -f UTF-8 -t UTF-16 | wc -c) =3D 6

)
prerequisite NO_UTF16_BOM not satisfied
checking prerequisite: NO_UTF32_BOM

mkdir -p "$TRASH_DIRECTORY/prereq-test-dir" &&
(
	cd "$TRASH_DIRECTORY/prereq-test-dir" &&
	test $(printf abc | iconv -f UTF-8 -t UTF-32 | wc -c) =3D 12

)
prerequisite NO_UTF32_BOM not satisfied
source (test.utf16, considered utf-16):
|  0: ff   |  1: fe   |  2: 68 h |  3:  0   |  4: 61 a |  5:  0   |  6: 6c=
 l |  7:  0
|  8: 6c l |  9:  0   | 10: 6f o | 11:  0   | 12: 20   | 13:  0   | 14: 74=
 t | 15:  0
| 16: 68 h | 17:  0   | 18: 65 e | 19:  0   | 20: 72 r | 21:  0   | 22: 65=
 e | 23:  0
| 24: 21 ! | 25:  0   | 26:  a   | 27:  0   | 28: 63 c | 29:  0   | 30: 61=
 a | 31:  0
| 32: 6e n | 33:  0   | 34: 20   | 35:  0   | 36: 79 y | 37:  0   | 38: 6f=
 o | 39:  0
| 40: 75 u | 41:  0   | 42: 20   | 43:  0   | 44: 72 r | 45:  0   | 46: 65=
 e | 47:  0
| 48: 61 a | 49:  0   | 50: 64 d | 51:  0   | 52: 20   | 53:  0   | 54: 6d=
 m | 55:  0
| 56: 65 e | 57:  0   | 58: 3f ? | 59:  0

destination (test.utf16, considered UTF-8):
|  0: 68 h |  1: 61 a |  2: 6c l |  3: 6c l |  4: 6f o |  5: 20   |  6: 74=
 t |  7: 68 h
|  8: 65 e |  9: 72 r | 10: 65 e | 11: 21 ! | 12:  a   | 13: 63 c | 14: 61=
 a | 15: 6e n
| 16: 20   | 17: 79 y | 18: 6f o | 19: 75 u | 20: 20   | 21: 72 r | 22: 65=
 e | 23: 61 a
| 24: 64 d | 25: 20   | 26: 6d m | 27: 65 e | 28: 3f ?

source (test.utf16lebom, considered UTF-16LE-BOM):
|  0: ff   |  1: fe   |  2: 68 h |  3:  0   |  4:  0   |  5:  0   |  6: 61=
 a |  7:  0
|  8:  0   |  9:  0   | 10: 6c l | 11:  0   | 12:  0   | 13:  0   | 14: 6c=
 l | 15:  0
| 16:  0   | 17:  0   | 18: 6f o | 19:  0   | 20:  0   | 21:  0   | 22: 20=
   | 23:  0
| 24:  0   | 25:  0   | 26: 74 t | 27:  0   | 28:  0   | 29:  0   | 30: 68=
 h | 31:  0
| 32:  0   | 33:  0   | 34: 65 e | 35:  0   | 36:  0   | 37:  0   | 38: 72=
 r | 39:  0
| 40:  0   | 41:  0   | 42: 65 e | 43:  0   | 44:  0   | 45:  0   | 46: 21=
 ! | 47:  0
| 48:  0   | 49:  0   | 50:  a   | 51:  0   | 52:  0   | 53:  0   | 54: 63=
 c | 55:  0
| 56:  0   | 57:  0   | 58: 61 a | 59:  0   | 60:  0   | 61:  0   | 62: 6e=
 n | 63:  0
| 64:  0   | 65:  0   | 66: 20   | 67:  0   | 68:  0   | 69:  0   | 70: 79=
 y | 71:  0
| 72:  0   | 73:  0   | 74: 6f o | 75:  0   | 76:  0   | 77:  0   | 78: 75=
 u | 79:  0
| 80:  0   | 81:  0   | 82: 20   | 83:  0   | 84:  0   | 85:  0   | 86: 72=
 r | 87:  0
| 88:  0   | 89:  0   | 90: 65 e | 91:  0   | 92:  0   | 93:  0   | 94: 61=
 a | 95:  0
| 96:  0   | 97:  0   | 98: 64 d | 99:  0   | 100:  0   | 101:  0   | 102:=
 20   | 103:  0
| 104:  0   | 105:  0   | 106: 6d m | 107:  0   | 108:  0   | 109:  0   | =
110: 65 e | 111:  0
| 112:  0   | 113:  0   | 114: 3f ? | 115:  0   | 116:  0   | 117:  0

destination (test.utf16lebom, considered UTF-8):
|  0: 68 h |  1:  0   |  2: 61 a |  3:  0   |  4: 6c l |  5:  0   |  6: 6c=
 l |  7:  0
|  8: 6f o |  9:  0   | 10: 20   | 11:  0   | 12: 74 t | 13:  0   | 14: 68=
 h | 15:  0
| 16: 65 e | 17:  0   | 18: 72 r | 19:  0   | 20: 65 e | 21:  0   | 22: 21=
 ! | 23:  0
| 24:  a   | 25:  0   | 26: 63 c | 27:  0   | 28: 61 a | 29:  0   | 30: 6e=
 n | 31:  0
| 32: 20   | 33:  0   | 34: 79 y | 35:  0   | 36: 6f o | 37:  0   | 38: 75=
 u | 39:  0
| 40: 20   | 41:  0   | 42: 72 r | 43:  0   | 44: 65 e | 45:  0   | 46: 61=
 a | 47:  0
| 48: 64 d | 49:  0   | 50: 20   | 51:  0   | 52: 6d m | 53:  0   | 54: 65=
 e | 55:  0
| 56: 3f ? | 57:  0

[master (root-commit) 275413c] initial
 Author: A U Thor <author@example.com>
 3 files changed, 4 insertions(+)
 create mode 100644 .gitattributes
 create mode 100644 test.utf16
 create mode 100644 test.utf16lebom
ok 1 - setup test files

expecting success:
	test_when_finished "rm -f test.utf16.git" &&

	git cat-file -p :test.utf16 >test.utf16.git &&
	test_cmp_bin test.utf8.raw test.utf16.git

ok 2 - ensure UTF-8 is stored in Git

expecting success:
	test_when_finished "rm -f test.utf16.raw" &&

	rm test.utf16 &&
	git checkout test.utf16 &&
	test_cmp_bin test.utf16.raw test.utf16

Updated 1 path from the index
ok 3 - re-encode to UTF-16 on checkout
[snip]
