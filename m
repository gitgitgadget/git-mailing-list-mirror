From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: showing conflicting merges
Date: Thu, 24 Apr 2008 15:08:44 +0200
Message-ID: <8aa486160804240608m702ba3b5he8277a0982730d61@mail.gmail.com>
References: <20080422091233.GA12091@digi.com>
	 <8aa486160804220249y55677f63o892643775960880f@mail.gmail.com>
	 <20080423061715.GB25446@digi.com>
	 <8aa486160804240551y1d1e412cvb6801e652026f832@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?=" <Uwe.Kleine-Koenig@digi.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 15:09:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jp1Ch-0004fh-Lb
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 15:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756597AbYDXNIs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Apr 2008 09:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757689AbYDXNIs
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Apr 2008 09:08:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:63696 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756423AbYDXNIr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Apr 2008 09:08:47 -0400
Received: by fg-out-1718.google.com with SMTP id l27so3068070fgb.17
        for <git@vger.kernel.org>; Thu, 24 Apr 2008 06:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=A66eAHaXuDtaor8A7HdGNE9ypwZjOOLN1Ie17Tdaa2w=;
        b=iASl3d1+BiL3PAE57SU+r212qUwpSdrcLrILpWrH8i1Upf7R82yE20RW5JiHaCDXh2WXbrIEmyQOoodfurGZZJ0/fseCIshc2l+xw17anYL2/6J5FERu0GA4hhIqPgWclkRwj8WFaWadCFszRk9EMmUze9HlQQwTVud9WzdEFzo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Un4RKKi07zQYrh/l4dVWeywdeUXEhy8GcR9D3PMeWtZhjkRf+kzuMm20YPal47Ajt3BUHx2iCXzCMGBEXKotaKWrn1o1nR4d5FpN9dW41A9nr+cqQYvrnvKeOcl+WjFNDWhxMN0fbM14K/BQV/OKWE1J/BmKIGKmsdPFqF1IoMs=
Received: by 10.86.3.4 with SMTP id 4mr1179682fgc.3.1209042524076;
        Thu, 24 Apr 2008 06:08:44 -0700 (PDT)
Received: by 10.86.27.11 with HTTP; Thu, 24 Apr 2008 06:08:44 -0700 (PDT)
In-Reply-To: <8aa486160804240551y1d1e412cvb6801e652026f832@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80302>

On Thu, Apr 24, 2008 at 2:51 PM, Santi B=E9jar <sbejar@gmail.com> wrote=
:
> On Wed, Apr 23, 2008 at 8:17 AM, Uwe Kleine-K=F6nig
>
> <Uwe.Kleine-Koenig@digi.com> wrote:
>  > Hello Santi,
>  >
>  >
>  >  Santi B=E9jar wrote:
>  >  > On Tue, Apr 22, 2008 at 11:12 AM, Uwe Kleine-K=F6nig
>  >  > <Uwe.Kleine-Koenig@digi.com> wrote:
>  >  > > Hello,
>  >  > >
>  >  > >  There is a thread on the linux-arm-kernel ML that discusses =
handling of
>  >  > >  merge conflicts with git.[1]
>  >  > >
>  >  > >  I played around a bit with that and wondered about a few thi=
ngs:
>  >  > >
>  >  > >         ukleinek@zentaur:~/gsrc/linux-2.6$ git checkout -b te=
st adf6d34e460387ee3e8f1e1875d
>  >  > >         Switched to a new branch "test"
>  >  > >
>  >  > >         ukleinek@zentaur:~/gsrc/linux-2.6$ git merge v2.6.25
>  >  > >         Auto-merged MAINTAINERS
>  >  > >         CONFLICT (delete/modify): drivers/leds/leds-tosa.c de=
leted in HEAD and modified in v2.6.25. Version v2.6.25 of drivers/leds/=
leds-tosa.c left in tree.
>  >  > >         Auto-merged drivers/serial/imx.c
>  >  > >         Automatic merge failed; fix conflicts and then commit=
 the result.
>  >  > >
>  >  > >  Now "git diff --merge" shows:
>  >  > >
>  >  > >         diff --cc drivers/leds/leds-tosa.c
>  >  > >         index 7ebecc4,0000000..9e0a188
>  >  > >         ...
>  >  > >
>  >  > >  Shouldn't that better be reversed, i.e. 9e0a188..7ebecc4,000=
0000?
>  >  >
>  >  > It compares the versions in conflict with the version in the wo=
rking copy.
>  >
>  >  I have not checked in the source code, but the output of
>  >
>  >         strace -f -e open git diff --merge 2>&1 >/dev/null | grep =
leds-tosa
>  >
>  >  seems to contradict that (i.e. there is no output).
>
>  The version in the working copy should be 7ebecc4, so there is no ne=
ed
>  to open it as it is in the index (but maybe I'm wrong).
>
>
>  >
>  >         7ebecc4 =3D v2.6.25:drivers/leds/leds-tosa.c
>  >         9e0a188 =3D $(git merge-base test v2.6.25):drivers/leds/le=
ds-tosa.c
>  >
>  >  (Ah, I just see, that's another hint that diff --merge doesn't lo=
ok in
>  >  the working copy.  The wc has 7ebecc4 which is in the LHS togethe=
r with
>  >  000000 (i.e. the deleted file from HEAD).
>  >
>  >  Maybe the combined diff format cannot have more than one rev on t=
he RHS?
>  >
>  >
>
>  FWIU --merge is an option for git-rev-list (and alike, git log,
>  gitk...). I don't know its meaning in this case. It shoud be juts:
>
>  $git diff
>
>  that currently says in this case:
>
>  $ git diff
>  * Unmerged path file1
>
>  In this case:
>
>         echo a >file1 &&
>         git add file1 &&
>         git commit -m initial &&
>         git checkout -b a1 master &&
>         git rm file1 &&
>         git commit -m a &&
>         git checkout -b b1 master &&
>         echo  b> file1 &&
>         git add file1 &&
>         git commit -m b1 &&
>         git checkout a1 &&
>         git merge b1
>
>  The merge output is:
>  Merging HEAD with b1
>  Merging:
>  3231a8a a
>  ace6b2d b1
>  found 1 common ancestor(s):
>  f43806f initial
>  CONFLICT (delete/modify): file1 deleted in HEAD and modified in b1.
>  Version b1 of file1 left in tree.
>
> Automatic merge failed; fix conflicts and then commit the result.
>
>  $ git ls-files -s
>  100644 78981922613b2afb6025042ff6bd878ac1994e85 1       file1
>  100644 61780798228d17af2d34fce4cfbdf35556832472 3       file1
>
>  $ git diff [-1 | -2 | -3]
>  * Unmerged path file1

Actually only:
git diff
git diff -2
git diff -3

for:
$ git diff -1
* Unmerged path file1
diff --git a/file1 b/file1
index 7898192..c9c6af7 100644
--- a/file1
+++ b/file1
@@ -1 +1 @@
-a
+b1

but "-2" and "-3" do the same for different reasons

-2) theres is no "2" in the index
-3) is equal to the wc file1

so both output the same:
* Unmerged path file1

and I still think "git diff" has to output something else than
"*Unmerged path file1".

>
>  $ git diff --merge
>  diff --cc file1
>  index 6178079,0000000..7898192
>  mode 100644,000000..100644
>  --- a/file1
>  +++ b/file1
>  @@@ -1,1 -1,0 +1,1 @@@
>  - b
>  ++a
>
>  that does not make sense.
>
>  Maybe something as?
>
>  $ git diff
>  diff --cc file1
>  index 0000000,6178079..0000000
>  mode 000000,100644..0000000
>  --- /dev/null
>  +++ b/file1
>
>  But I don't really know what to expect in this case.
>
>  Santi
>
