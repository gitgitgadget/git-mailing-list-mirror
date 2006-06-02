From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Importing Mozilla CVS into git
Date: Thu, 1 Jun 2006 20:55:49 -0400
Message-ID: <9e4733910606011755n29a149f2m1409c5a23888f1c5@mail.gmail.com>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
	 <1149204044.27695.38.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_264_17775510.1149209749803"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 02:56:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlxxC-0001EV-0q
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 02:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWFBAzv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 20:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWFBAzv
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 20:55:51 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:1816 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750826AbWFBAzu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jun 2006 20:55:50 -0400
Received: by nz-out-0102.google.com with SMTP id s18so417025nze
        for <git@vger.kernel.org>; Thu, 01 Jun 2006 17:55:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=N8914EZE4QURGjnYcEzZwPT3YKyCYWchijsXfbmvLLxX4qdtHgYowBQDXrD73jPpJEHHWB6AZogFJxHGEs9uSXi2N3mo9f6FTwjVSDL1A7ie70VYlN0fcyGCu9wMbyZmwIpirwgR/JJ/MU2Qb3g5vUh58KFM1rHj/DNLGIDhF8k=
Received: by 10.36.250.78 with SMTP id x78mr1721442nzh;
        Thu, 01 Jun 2006 17:55:49 -0700 (PDT)
Received: by 10.36.39.3 with HTTP; Thu, 1 Jun 2006 17:55:49 -0700 (PDT)
To: "Keith Packard" <keithp@keithp.com>
In-Reply-To: <1149204044.27695.38.camel@neko.keithp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21131>

------=_Part_264_17775510.1149209749803
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

With the attached patch you can parse the entire Mozilla tree. The
tree has over 100,000 files in it and about 300 branches.

I ran this overnight and it failed with out of memory on a 1GB machine
with 1GB swap. If failed in the branch processing, the parse phase
succeeded.

How much memory does something like this need?

If you want to quickly check out the branch processing problems use
rsync to pull down just a copy of repository files.

I am getting 1000s of warnings like these and I haven't figured out why yet.

Warning: ../mozilla/mozilla/build/mac/build_scripts/Attic/MozillaCheckoutList.txt,v:
unnamed branch from master
Warning: ../mozilla/mozilla/build/unix/run-mozilla.sh,v: unnamed
branch from master
Warning: ../mozilla/mozilla/Makefile.in,v: unnamed branch from master of 99855
Warning: ../mozilla/mozilla/Makefile.in,v: unnamed branch from master
Warning: ../mozilla/mozilla/allmakefiles.sh,v: unnamed branch from master99855
Warning: ../mozilla/mozilla/allmakefiles.sh,v: unnamed branch from master
Warning: ../mozilla/mozilla/cmd/macfe/MailNews/AddressBook/Attic/UAddressBookUtilities.cp,v:
unnamed branch from master
Warning: ../mozilla/mozilla/cmd/macfe/MailNews/AddressBook/Attic/UAddressBookUtilities.h,v:
unnamed branch from master
Warning: ../mozilla/mozilla/cmd/macfe/central/Attic/msv2dsk.cp,v:
unnamed branch from master

-- 
Jon Smirl
jonsmirl@gmail.com

------=_Part_264_17775510.1149209749803
Content-Type: application/octet-stream; name=patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_enxtllfq
Content-Disposition: attachment; filename="patch"

ZGlmZiAtLWdpdCBhL2dyYW0ueSBiL2dyYW0ueQppbmRleCA1MDI5OTFlLi40NTY2NjI4IDEwMDY0
NAotLS0gYS9ncmFtLnkKKysrIGIvZ3JhbS55CkBAIC0xOCw2ICsxOCw3IEBACiAgKi8KIAogI2lu
Y2x1ZGUgImN2cy5oIgorI2RlZmluZSBZWURFQlVHIDEKICAgICAKIHZvaWQgeXllcnJvciAoY2hh
ciAqbXNnKTsKIApAQCAtNzIsNiArNzMsNyBAQCBoZWFkZXIJCTogSEVBRCBOVU1CRVIgU0VNSQog
CQl8IHN5bWJvbGxpc3QKIAkJICB7IHRoaXNfZmlsZS0+c3ltYm9scyA9ICQxOyB9CiAJCXwgTE9D
S1MgU0VNSSBsb2NrX3R5cGUgU0VNSQorCQl8IExPQ0tTIE5BTUUgQ09MT04gTlVNQkVSIFNFTUkg
bG9ja190eXBlIFNFTUkKIAkJfCBDT01NRU5UIERBVEEgU0VNSQogCQl8IEVYUEFORCBEQVRBIFNF
TUkKIAkJOwpAQCAtOTEsNiArOTMsMjEgQEAgc3ltYm9sCQk6IE5BTUUgQ09MT04gTlVNQkVSCiAJ
CQkkJC0+bmFtZSA9ICQxOwogCQkJJCQtPm51bWJlciA9ICQzOwogCQkgIH0KKwkJfCBOVU1CRVIg
Q09MT04gTlVNQkVSCisJCSAgeworCQkgIAljaGFyIGJ1ZmZlclsyMDBdOworCQkgIAlpbnQgaSwg
ajsKKwkJICAJCisJCSAgCWogPSAwOworCQkgIAlmb3IgKGkgPSAwOyBpIDwgJDEuYzsgaSsrKSB7
CisJCSAgCQlpZiAoaSAhPSAwKQorCQkJICAJCWogKz0gc3ByaW50ZigmYnVmZmVyW2pdLCAiLiIp
OworCQkgIAkJaiArPSBzcHJpbnRmKCZidWZmZXJbal0sICIlZCIsICQxLm5baV0pOworCQkgIAl9
CisJCQkkJCA9IGNhbGxvYyAoMSwgc2l6ZW9mIChjdnNfc3ltYm9sKSk7CisJCQkkJC0+bmFtZSA9
IGF0b20oYnVmZmVyKTsKKwkJCSQkLT5udW1iZXIgPSAkMzsKKwkJICB9CiAJCTsKIHJldmlzaW9u
cwk6IHJldmlzaW9uIHJldmlzaW9ucwogCQkgIHsgJDEtPm5leHQgPSAkMjsgJCQgPSAkMTsgfQpk
aWZmIC0tZ2l0IGEvbGV4LmwgYi9sZXgubAppbmRleCBmMjViOGE1Li45NTZlZWQ3IDEwMDY0NAot
LS0gYS9sZXgubAorKysgYi9sZXgubApAQCAtNTIsNyArNTIsNyBAQCAjZGVmaW5lIFlZX0lOUFVU
KGJ1ZixyZXN1bHQsbWF4X3NpemUpIHsgCiAJCQkJCUJFR0lOKElOSVRJQUwpOwogCQkJCQlyZXR1
cm4gVEVYVF9EQVRBOwogCQkJCX0KLTxDT05URU5UPlstYS16QS1aXzAtOStdWy1hLXpBLVpfMC05
Ky9dKiB7Cis8Q09OVEVOVD5bLWEtekEtWl8rXVstYS16QS1aXzAtOSsvLiVdKiB7CiAJCQkJCXl5
bHZhbC5zID0gYXRvbSAoeXl0ZXh0KTsKIAkJCQkJcmV0dXJuIE5BTUU7CiAJCQkJfQpkaWZmIC0t
Z2l0IGEvcGFyc2VjdnMuYyBiL3BhcnNlY3ZzLmMKaW5kZXggZGYwODNjNi4uZTliODA1NiAxMDA2
NDQKLS0tIGEvcGFyc2VjdnMuYworKysgYi9wYXJzZWN2cy5jCkBAIC0yNyw3ICsyNyw5IEBAICNl
bmRpZgogCiBjdnNfZmlsZQkqdGhpc19maWxlOwogCi1yZXZfZXhlY3V0aW9uX21vZGUgcmV2X21v
ZGUgPSBFeGVjdXRlR2l0OworLy9yZXZfZXhlY3V0aW9uX21vZGUgcmV2X21vZGUgPSBFeGVjdXRl
R2l0OworLy9yZXZfZXhlY3V0aW9uX21vZGUgcmV2X21vZGUgPSBFeGVjdXRlR3JhcGg7CityZXZf
ZXhlY3V0aW9uX21vZGUgcmV2X21vZGUgPSBFeGVjdXRlU3BsaXRzOwogCiBpbnQgZWxpZGUgPSAw
OwogaW50IGRpZmZmaWxlcyA9IDE7Cg==
------=_Part_264_17775510.1149209749803--
