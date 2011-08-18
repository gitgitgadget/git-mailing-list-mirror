From: Sedat Dilek <sedat.dilek@googlemail.com>
Subject: Re: linux-next: Tree for Aug 18 (GNU patch and "git diffs: Support symlinks")
Date: Thu, 18 Aug 2011 11:35:56 +0200
Message-ID: <CA+icZUXs0cdCna8ogKubpg_SgZo0K3GmHDkBk2gDuJkg7CX0Zw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=bcaec51a8c62fdce7c04aac4568f
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Christoph Berg <myon@debian.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
X-From: linux-next-owner@vger.kernel.org Thu Aug 18 11:36:02 2011
Return-path: <linux-next-owner@vger.kernel.org>
Envelope-to: glkn-linux-next@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-next-owner@vger.kernel.org>)
	id 1Qtz18-00013d-7u
	for glkn-linux-next@lo.gmane.org; Thu, 18 Aug 2011 11:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755379Ab1HRJf7 (ORCPT <rfc822;glkn-linux-next@m.gmane.org>);
	Thu, 18 Aug 2011 05:35:59 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61013 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755215Ab1HRJf5 (ORCPT
	<rfc822;linux-next@vger.kernel.org>); Thu, 18 Aug 2011 05:35:57 -0400
Received: by qwk3 with SMTP id 3so1199989qwk.19
        for <multiple recipients>; Thu, 18 Aug 2011 02:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:date:message-id:subject:from:to:cc
         :content-type;
        bh=jnR7VuV+OgCW/OsCN3IyPuuChTtn5DBmk4G8btXdVIs=;
        b=roQXfZkegu6DNjp+j+5x32KlkHEQcoGmdMY37Yo4hEKK1Aaq1GflmBHN6K76TbDNC4
         otwi3lBk4uj1ctPmT2r0uxPUnRA500PU3dNJrjtmuvJmcjur9/0+moJbzxym7Wfqfl8Q
         0QYkhgrDhvvl98asPLVH1McC47Mh2l9eqMcQk=
Received: by 10.224.10.12 with SMTP id n12mr429564qan.305.1313660156628; Thu,
 18 Aug 2011 02:35:56 -0700 (PDT)
Received: by 10.229.232.139 with HTTP; Thu, 18 Aug 2011 02:35:56 -0700 (PDT)
Sender: linux-next-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-next.vger.kernel.org>
X-Mailing-List: linux-next@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179587>

--bcaec51a8c62fdce7c04aac4568f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 18, 2011 at 8:00 AM, Stephen Rothwell <sfr@canb.auug.org.au> wr=
ote:
> Hi all,
>
> The powerpc allyesconfig build still fails today.
>
> Changes since 20110817:
>
> The sound-asoc tree lost its build failure.
>
> The tip tree gained a conflict against Linus' tree.
>
> The moduleh tree lost 2 of its merge fixups, but I added another.
>
> -------------------------------------------------------------------------=
---
>
> I have created today's linux-next tree at
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> (patches at http://www.kernel.org/pub/linux/kernel/v2.6/next/ ). =C2=A0If=
 you
> are tracking the linux-next tree using git, you should not use "git pull"
> to do so as that will try to merge the new linux-next release with the
> old one. =C2=A0You should use "git fetch" as mentioned in the FAQ on the =
wiki
> (see below).
>

Just FYI:

Yesterday and today, I had the same problem when applying the
linux-next single patch (see attached ErrMsg text file).

I am using a slightly modified kernel-buildsystem from Debian Kernel
Team (so not building out of a GIT repository).

The GNU/patch I have installed from Debian/sid does not include
symlink-support for git-diff [1].
Jonathan gave me the pointer to install patch package from Debian/experimen=
tal.
After reading its Changelog [2] and Debian-bug #243309 [3] I installed
the recommended version.
Indeed, it fixes the issue.

Cristoph, can we have a backport of [1] to patch/sid?

Thanks Jonathan!

- Sedat -

[1] http://git.savannah.gnu.org/cgit/patch.git/commit/?id=3Df9db7450fa27883=
77c4567b5d0565b0ddfc1015c
[2] http://packages.debian.org/changelogs/pool/main/p/patch/patch_2.6.1.85-=
423d-3/changelog
[3] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D243309

--bcaec51a8c62fdce7c04aac4568f
Content-Type: text/plain; charset=US-ASCII; 
	name="ErrMsg_linux-next-patch-did-not-apply.txt"
Content-Disposition: attachment; 
	filename="ErrMsg_linux-next-patch-did-not-apply.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_grhivbv61

WyBwYXRjaC12My4xLXJjMi1uZXh0LTIwMTEwODE4IF0KLi4uCmRpZmYgLS1naXQgYS90b29scy9w
b3dlci9jcHVwb3dlci9kZWJ1Zy94ODZfNjQvTWFrZWZpbGUgYi90b29scy9wb3dlci9jcHVwb3dl
ci9kZWJ1Zy94ODZfNjQvTWFrZWZpbGUKaW5kZXggZGJmMTM5OS4uMzMyNjIxNyAxMDA2NDQKLS0t
IGEvdG9vbHMvcG93ZXIvY3B1cG93ZXIvZGVidWcveDg2XzY0L01ha2VmaWxlCisrKyBiL3Rvb2xz
L3Bvd2VyL2NwdXBvd2VyL2RlYnVnL3g4Nl82NC9NYWtlZmlsZQpAQCAtMSwxMCArMSwxMCBAQAog
ZGVmYXVsdDogYWxsCgotY2VudHJpbm8tZGVjb2RlOiBjZW50cmluby1kZWNvZGUuYwotICAgICAg
ICQoQ0MpICQoQ0ZMQUdTKSAtbyBjZW50cmluby1kZWNvZGUgY2VudHJpbm8tZGVjb2RlLmMKK2Nl
bnRyaW5vLWRlY29kZTogLi4vaTM4Ni9jZW50cmluby1kZWNvZGUuYworICAgICAgICQoQ0MpICQo
Q0ZMQUdTKSAtbyAkQCAkPAoKLXBvd2Vybm93LWs4LWRlY29kZTogcG93ZXJub3ctazgtZGVjb2Rl
LmMKLSAgICAgICAkKENDKSAkKENGTEFHUykgLW8gcG93ZXJub3ctazgtZGVjb2RlIHBvd2Vybm93
LWs4LWRlY29kZS5jCitwb3dlcm5vdy1rOC1kZWNvZGU6IC4uL2kzODYvcG93ZXJub3ctazgtZGVj
b2RlLmMKKyAgICAgICAkKENDKSAkKENGTEFHUykgLW8gJEAgJDwKCiBhbGw6IGNlbnRyaW5vLWRl
Y29kZSBwb3dlcm5vdy1rOC1kZWNvZGUKCmRpZmYgLS1naXQgYS90b29scy9wb3dlci9jcHVwb3dl
ci9kZWJ1Zy94ODZfNjQvY2VudHJpbm8tZGVjb2RlLmMgYi90b29scy9wb3dlci9jcHVwb3dlci9k
ZWJ1Zy94ODZfNjQvY2VudHJpbm8tZGVjb2RlLmMKZGVsZXRlZCBmaWxlIG1vZGUgMTIwMDAwCmlu
ZGV4IDI2ZmIzZjEuLjAwMDAwMDAKLS0tIGEvdG9vbHMvcG93ZXIvY3B1cG93ZXIvZGVidWcveDg2
XzY0L2NlbnRyaW5vLWRlY29kZS5jCisrKyAvZGV2L251bGwKQEAgLTEgKzAsMCBAQAotLi4vaTM4
Ni9jZW50cmluby1kZWNvZGUuYwpcIE5vIG5ld2xpbmUgYXQgZW5kIG9mIGZpbGUKZGlmZiAtLWdp
dCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2RlYnVnL3g4Nl82NC9wb3dlcm5vdy1rOC1kZWNvZGUu
YyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2RlYnVnL3g4Nl82NC9wb3dlcm5vdy1rOC1kZWNvZGUu
YwpkZWxldGVkIGZpbGUgbW9kZSAxMjAwMDAKaW5kZXggZWIzMGM3OS4uMDAwMDAwMAotLS0gYS90
b29scy9wb3dlci9jcHVwb3dlci9kZWJ1Zy94ODZfNjQvcG93ZXJub3ctazgtZGVjb2RlLmMKKysr
IC9kZXYvbnVsbApAQCAtMSArMCwwIEBACi0uLi9pMzg2L3Bvd2Vybm93LWs4LWRlY29kZS5jClwg
Tm8gbmV3bGluZSBhdCBlbmQgb2YgZmlsZQouLi4KCgokIExDX0FMTD1DIGZha2Vyb290IG1ha2Ug
LWYgZGViaWFuL3J1bGVzLmdlbiBzZXR1cF9pMzg2X25vbmVfNjg2LXNtYWxsIDI+JjEgfCB0ZWUg
Li4vc2V0dXAubG9nICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAKbWFrZSAtZiBkZWJpYW4vcnVsZXMucmVhbCBzZXR1cC1mbGF2b3VyIEFC
SU5BTUU9Jy1uZXh0MjAxMTA4MTguMycgQVJDSD0naTM4NicgQ09NUElMRVI9J2djYy00LjYnIEZF
QVRVUkVTRVQ9J25vbmUnIEZMQVZPVVI9JzY4Ni1zbWFsbCcgS0NPTkZJRz0nZGViaWFuL2NvbmZp
Zy9jb25maWcgZGViaWFuL2NvbmZpZy9rZXJuZWxhcmNoLXg4Ni9jb25maWcgZGViaWFuL2NvbmZp
Zy9rZXJuZWxhcmNoLXg4Ni9jb25maWctYXJjaC0zMiBkZWJpYW4vY29uZmlnL2kzODYvbm9uZS9j
b25maWcuNjg2LWluaXphIGRlYmlhbi9jb25maWcvY3VzdG9tLXg4Ni9jb25maWctZGVidWcgZGVi
aWFuL2NvbmZpZy9jdXN0b20teDg2L2NvbmZpZy1mcyBkZWJpYW4vY29uZmlnL2N1c3RvbS14ODYv
Y29uZmlnLWluZmluaWJhbmQgZGViaWFuL2NvbmZpZy9jdXN0b20teDg2L2NvbmZpZy1pc2EgZGVi
aWFuL2NvbmZpZy9jdXN0b20teDg2L2NvbmZpZy1pc2RuIGRlYmlhbi9jb25maWcvY3VzdG9tLXg4
Ni9jb25maWctbXVsdGltZWRpYSBkZWJpYW4vY29uZmlnL2N1c3RvbS14ODYvY29uZmlnLXBzZXVk
b2ZzIGRlYmlhbi9jb25maWcvY3VzdG9tLXg4Ni9jb25maWctc3RhZ2luZyBkZWJpYW4vY29uZmln
L2kzODYvbm9uZS9jb25maWcuNjg2LXNtYWxsJyBLRVJORUxfQVJDSD0neDg2JyBMT0NBTFZFUlNJ
T049Jy02ODYtc21hbGwnIExPQ0FMVkVSU0lPTl9IRUFERVJTPScnIExPQ0FMVkVSU0lPTl9JTUFH
RT0nLTY4Ni1zbWFsbCcgTU9EVUxFUz0nVHJ1ZScgU09VUkNFVkVSU0lPTj0nMy4xLjB+cmMyLTF+
bmV4dDIwMTEwODE4LmRpbGVrczMnIFRZUEU9J3BsYWluJyBVUFNUUkVBTVZFUlNJT049JzMuMS4w
LXJjMicgVkVSU0lPTj0nMy4xLjAnICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAptYWtlWzFdOiBFbnRlcmluZyBkaXJlY3Rv
cnkgYC9tbnQvc2RiMy9saW51eC1rZXJuZWwvbGludXgtMy4xLXJjMicgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IApybSAtcmYgJ2RlYmlhbi9idWlsZC9zb3VyY2UnICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIApta2RpciAtcCAnZGViaWFuL2J1aWxkL3NvdXJj
ZScgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIApj
cCAtYWwgQ09QWUlORyBDUkVESVRTIERvY3VtZW50YXRpb24gS2J1aWxkIEtjb25maWcgTUFJTlRB
SU5FUlMgTWFrZWZpbGUgUkVBRE1FIFJFUE9SVElORy1CVUdTIGFyY2ggYmxvY2sgY3J5cHRvIGRy
aXZlcnMgZmlybXdhcmUgZnMgaW5jbHVkZSBpbml0IGlwYyBrZXJuZWwgbGliIG1tIG5ldCBzYW1w
bGVzIHNjcmlwdHMgc2VjdXJpdHkgc291bmQgdG9vbHMgdXNyIHZpcnQgLmdpdGlnbm9yZSAubWFp
bG1hcCAnZGViaWFuL2J1aWxkL3NvdXJjZScgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCmNkICdk
ZWJpYW4vYnVpbGQvc291cmNlJzsgcHl0aG9uICcvbW50L3NkYjMvbGludXgta2VybmVsL2xpbnV4
LTMuMS1yYzIvZGViaWFuL2Jpbi9wYXRjaC5hcHBseScgLS1vdmVyd3JpdGUtaG9tZT0nL21udC9z
ZGIzL2xpbnV4LWtlcm5lbC9saW51eC0zLjEtcmMyL2RlYmlhbi9wYXRjaGVzJyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgCldhcm5pbmc6IE5vIHZlcnNpb24uRGViaWFuIGZpbGUsIGFz
c3VtaW5nIERlYmlhbiBMaW51eCAzLjEuMH5yYzIgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCjEgb3V0IG9m
IDEgaHVuayBGQUlMRUQgLS0gc2F2aW5nIHJlamVjdHMgdG8gZmlsZSB0b29scy9wb3dlci9jcHVw
b3dlci9kZWJ1Zy94ODZfNjQvY2VudHJpbm8tZGVjb2RlLmMucmVqICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgCjEgb3V0IG9mIDEgaHVuayBGQUlMRUQgLS0gc2F2aW5nIHJlamVj
dHMgdG8gZmlsZSB0b29scy9wb3dlci9jcHVwb3dlci9kZWJ1Zy94ODZfNjQvcG93ZXJub3ctazgt
ZGVjb2RlLmMucmVqCkVycm9yOiBQYXRjaCBmYWlsZWQKLS0+IFRyeSB0byBhcHBseSBiYXNlLgog
ICgrKSBGQUlMIGxpbnV4LW5leHQvcGF0Y2gtdjMuMS1yYzItbmV4dC0yMDExMDgxOAptYWtlWzFd
OiAqKiogW2RlYmlhbi9zdGFtcHMvc291cmNlXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGly
ZWN0b3J5IGAvbW50L3NkYjMvbGludXgta2VybmVsL2xpbnV4LTMuMS1yYzInCm1ha2U6ICoqKiBb
c2V0dXBfaTM4Nl9ub25lXzY4Ni1zbWFsbF9yZWFsXSBFcnJvciAyCgoKLWRpbGVrcyAvLyAxOC1B
dWctMjAxMQoK
--bcaec51a8c62fdce7c04aac4568f--
