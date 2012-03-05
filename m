From: =?iso-8859-1?Q?Ren=E9_Haber?= <rene@habr.de>
Subject: =?iso-8859-1?Q?Re=3A_Bug=3A_pull_--rebase_with_=E9_in_name?=
Date: Mon, 5 Mar 2012 12:42:14 +0100
Message-ID: <F5A485EA-7EAD-4D8B-87C4-7185F713318C@habr.de>
References: <FECFDD4D-6EC3-4DE1-8A08-B4477345C4AA@habr.de> <20120305102657.GB29061@sigill.intra.peff.net> <87399nqqog.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: multipart/mixed; boundary=Apple-Mail-14-453216409
Cc: Jeff King <peff@peff.net>, <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 05 12:42:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4WJ5-0007We-PS
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 12:42:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756918Ab2CELmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 06:42:19 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45585 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756615Ab2CELmS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 06:42:18 -0500
Received: by mail-bk0-f46.google.com with SMTP id ik5so3029386bkc.19
        for <git@vger.kernel.org>; Mon, 05 Mar 2012 03:42:17 -0800 (PST)
Received-SPF: pass (google.com: domain of rene@habr.de designates 10.204.141.25 as permitted sender) client-ip=10.204.141.25;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of rene@habr.de designates 10.204.141.25 as permitted sender) smtp.mail=rene@habr.de; dkim=pass header.i=rene@habr.de
Received: from mr.google.com ([10.204.141.25])
        by 10.204.141.25 with SMTP id k25mr5945086bku.72.1330947737677 (num_hops = 1);
        Mon, 05 Mar 2012 03:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=habr.de; s=habr;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :message-id:references:to:x-mailer;
        bh=cNkBl8xTnWWWDTuLlqyBHEHb/V0QirhHw+9sFxqFLeA=;
        b=e1DFBH1VzkNlz01wuL5LNSImmnI58bARZW48zFbJqiJ7YoOjdOp0TWYAc/De/S+R8I
         nu4CFgo6ZzbFC0gmWkjoEgIZ0oWL/Ipy7t0MpWzyrl/Nqlh7cN0AaNK45xlQK2cIyeXI
         Q1IJlHgOmQw/Wh/q2v1xCY8LoGHQ+CCFdrxK8=
Received: by 10.204.141.25 with SMTP id k25mr4614074bku.72.1330947737418;
        Mon, 05 Mar 2012 03:42:17 -0800 (PST)
Received: from laptop1.physik.tu-chemnitz.de (laptop1.physik.tu-chemnitz.de. [134.109.16.58])
        by mx.google.com with ESMTPS id u14sm12722618bkp.2.2012.03.05.03.42.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Mar 2012 03:42:16 -0800 (PST)
In-Reply-To: <87399nqqog.fsf@thomas.inf.ethz.ch>
X-Mailer: Apple Mail (2.1084)
X-Gm-Message-State: ALoCoQm6K3wvWEDXc2IMWvuApssWoPJq7IGtxoU3EBdslKawjDAi0OeclfmW4+LXOCUTCaH6vzzd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192228>


--Apple-Mail-14-453216409
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=iso-8859-1

I'm running git 1.7.9.2 from Fink Project on MacOS X 10.6.
The gitconfig in hex is attached.
I'm not using i18n.commitencoding or a charset different from utf8.

Thanks.
Ren=E9

--Apple-Mail-14-453216409
Content-Disposition: attachment;
	filename=gitconfig.xxd
Content-Type: application/octet-stream;
	name="gitconfig.xxd"
Content-Transfer-Encoding: 7bit

0000000: 5b75 7365 725d 0a09 656d 6169 6c20 3d20  [user]..email = 
0000010: 7265 6e65 4068 6162 722e 6465 0a09 6e61  rene@habr.de..na
0000020: 6d65 203d 2052 656e c3a9 2048 6162 6572  me = Ren.. Haber
0000030: 0a5b 636f 6c6f 725d 0a09 6469 6666 203d  .[color]..diff =
0000040: 2061 7574 6f0a 0973 7461 7475 7320 3d20   auto..status = 
0000050: 6175 746f 0a09 6272 616e 6368 203d 2061  auto..branch = a
0000060: 7574 6f0a 0969 6e74 6572 6163 7469 7665  uto..interactive
0000070: 203d 2061 7574 6f0a 0975 6920 3d20 7472   = auto..ui = tr
0000080: 7565 0a09 7061 6765 7220 3d20 7472 7565  ue..pager = true
0000090: 0a5b 636f 6c6f 7220 2262 7261 6e63 6822  .[color "branch"
00000a0: 5d0a 0963 7572 7265 6e74 203d 2079 656c  ]..current = yel
00000b0: 6c6f 7720 7265 7665 7273 650a 096c 6f63  low reverse..loc
00000c0: 616c 203d 2079 656c 6c6f 770a 0972 656d  al = yellow..rem
00000d0: 6f74 6520 3d20 6772 6565 6e0a 5b63 6f6c  ote = green.[col
00000e0: 6f72 2022 6469 6666 225d 0a09 6d65 7461  or "diff"]..meta
00000f0: 203d 2079 656c 6c6f 7720 626f 6c64 0a09   = yellow bold..
0000100: 6672 6167 203d 206d 6167 656e 7461 2062  frag = magenta b
0000110: 6f6c 640a 096f 6c64 203d 2072 6564 2062  old..old = red b
0000120: 6f6c 640a 096e 6577 203d 2067 7265 656e  old..new = green
0000130: 2062 6f6c 640a 0977 6869 7465 7370 6163   bold..whitespac
0000140: 6520 3d20 7265 6420 7265 7665 7273 650a  e = red reverse.
0000150: 5b63 6f6c 6f72 2022 7374 6174 7573 225d  [color "status"]
0000160: 0a09 6164 6465 6420 3d20 7965 6c6c 6f77  ..added = yellow
0000170: 0a09 6368 616e 6765 6420 3d20 6772 6565  ..changed = gree
0000180: 6e0a 0975 6e74 7261 636b 6564 203d 2063  n..untracked = c
0000190: 7961 6e0a 5b70 6163 6b5d 0a09 7468 7265  yan.[pack]..thre
00001a0: 6164 7320 3d20 300a 5b61 6c69 6173 5d0a  ads = 0.[alias].
00001b0: 0973 7420 3d20 7374 6174 7573 0a09 6369  .st = status..ci
00001c0: 203d 2063 6f6d 6d69 740a 0962 7220 3d20   = commit..br = 
00001d0: 6272 616e 6368 0a09 636f 203d 2063 6865  branch..co = che
00001e0: 636b 6f75 740a 0964 6620 3d20 6469 6666  ckout..df = diff
00001f0: 0a09 6c70 203d 206c 6f67 202d 700a 096c  ..lp = log -p..l
0000200: 6720 3d20 6c6f 6720 2d2d 6772 6170 6820  g = log --graph 
0000210: 2d2d 7072 6574 7479 3d66 6f72 6d61 743a  --pretty=format:
0000220: 2725 4372 6564 2568 2543 7265 7365 7420  '%Cred%h%Creset 
0000230: 2d25 4328 7965 6c6c 6f77 2925 6425 4372  -%C(yellow)%d%Cr
0000240: 6573 6574 2025 7320 2543 6772 6565 6e28  eset %s %Cgreen(
0000250: 2563 7229 2025 4328 626f 6c64 2062 6c75  %cr) %C(bold blu
0000260: 6529 3c25 616e 3e25 4372 6573 6574 2720  e)<%an>%Creset' 
0000270: 2d2d 6162 6272 6576 2d63 6f6d 6d69 7420  --abbrev-commit 
0000280: 2d2d 6461 7465 3d72 656c 6174 6976 650a  --date=relative.
0000290: 0964 6320 3d20 6469 6666 202d 2d63 6163  .dc = diff --cac
00002a0: 6865 6420 2d2d 6e6f 2d65 7874 2d64 6966  hed --no-ext-dif
00002b0: 660a 0977 7466 203d 2021 6769 742d 7774  f..wtf = !git-wt
00002c0: 660a 5b70 7573 685d 0a09 6465 6661 756c  f.[push]..defaul
00002d0: 7420 3d20 6d61 7463 6869 6e67 0a5b 636f  t = matching.[co
00002e0: 7265 5d0a 0977 6869 7465 7370 6163 653d  re]..whitespace=
00002f0: 6669 782c 7472 6169 6c69 6e67 2d73 7061  fix,trailing-spa
0000300: 6365 2c63 722d 6174 2d65 6f6c 0a5b 7265  ce,cr-at-eol.[re
0000310: 7265 7265 5d0a 0965 6e61 626c 6564 203d  rere]..enabled =
0000320: 2074 7275 650a 5b6d 6572 6765 5d0a 0973   true.[merge]..s
0000330: 7461 7420 3d20 7472 7565 0a5b 6469 6666  tat = true.[diff
0000340: 5d0a 096d 6e65 6d6f 6e69 6370 7265 6669  ]..mnemonicprefi
0000350: 7820 3d20 7472 7565 0a09 7265 6e61 6d65  x = true..rename
0000360: 7320 3d20 636f 7069 6573 0a              s = copies.

--Apple-Mail-14-453216409
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



Am 05.03.2012 um 11:37 schrieb Thomas Rast:

> Jeff King <peff@peff.net> writes:
>=20
>> On Mon, Mar 05, 2012 at 10:59:16AM +0100, Ren=C3=A9 Haber wrote:
>>=20
>>> I'm having trouble with the following scenario:
>>> My name contains an =C3=A9 with accent. Having set
>>> git config --global user.name "Ren=C3=A9 Haber"
>>> and several commits with that name in a project.
>>=20
>> That should work in general, but...
>>=20
>>> git pull --rebase
>>> [...]
>>> /sw/lib/git-core/git-am: line 675: Haber: command not found
>>>=20
>>> The problem lies in .git/rebase-apply/author-script :
>>>=20
>>> GIT_AUTHOR_NAME=3D'Rene'=CC=81 Haber
>>> GIT_AUTHOR_EMAIL=3D'rene@habr.de'
>>> GIT_AUTHOR_DATE=3D'@1330931169 +0100'
>>=20
>> That's definitely not right.
>>=20
>> I can't seem to reproduce it here with a simple test (neither with
>> "Ren=C3=A9" in the author name, nor with an author name containing
>> single-quote). What version of git are you using (it looks like a =
recent
>> one, as it has the magic @-date syntax). Have you set
>> i18n.commitencoding, or are otherwise using an encoding besides utf8? =
Is
>> it possible to share the commits that trigger this bug?
>=20
> Also, can you post a hex dump of the config that defines user.name =
(try
> 'xxd ~/.gitconfig'), so we can see the encoding of Ren=C3=A9?
>=20
> I find it pretty odd that Git manages to split the =C2=B4 from the e, =
so I'm
> wondering if perhaps you are using UTF-8 in NFD or similar.
>=20
> --=20
> Thomas Rast
> trast@{inf,student}.ethz.ch


--Apple-Mail-14-453216409--
