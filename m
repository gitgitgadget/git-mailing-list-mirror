From: Clark Williams <clark.williams@gmail.com>
Subject: [StGit PATCH] add option to import series directly from a tar archive
Date: Sat, 06 Sep 2008 22:47:19 -0500
Message-ID: <48C34EC7.9040102@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000106010500030104090703"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 07 05:50:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcBHE-00074i-VI
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 05:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753695AbYIGDr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 23:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753707AbYIGDr2
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 23:47:28 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:39273 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753683AbYIGDr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 23:47:27 -0400
Received: by py-out-1112.google.com with SMTP id p76so558080pyb.10
        for <git@vger.kernel.org>; Sat, 06 Sep 2008 20:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:x-enigmail-version:content-type;
        bh=36BdZLsarFjwVnr1a6/3U3ZQQpX1wPxp6PBrweZLZN4=;
        b=Iln68pLQh+Qdy8dB4VPbu57+cZzxs1IiAaIJTrRbZoeAkco5QXlE2ZA3AOOLcJ8+RV
         GZj1l6kWfy79h+vp4ohAa8CwNsmkHw70W9+UaTJ6kFMRFM3A2iCLAwSDt6z2gmws3kSy
         bTFPtF2lRJncfC8YHrlJSQWABdC7qul3DyibA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type;
        b=jTVYWQZ5HFHOPb/vcBMQxri29JfFXy5AsCct+esphygEejXpWz/vBqIFsjEHytE8EM
         zBwEA51nnng3dY6YlV2upcJzbq5pWO8rQruTC5KMm+7sXMzuF8EjkuCtlu01CdkFIe/d
         bPj0aPqh3ljZo0VvF9TZehyZshNjZxt8nj3+o=
Received: by 10.65.212.3 with SMTP id o3mr27748798qbq.16.1220759246208;
        Sat, 06 Sep 2008 20:47:26 -0700 (PDT)
Received: from ?172.31.0.50? ( [66.32.27.173])
        by mx.google.com with ESMTPS id s31sm3085694qbs.11.2008.09.06.20.47.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Sep 2008 20:47:24 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95109>

This is a multi-part message in MIME format.
--------------000106010500030104090703
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Catalin/Karl,

Attached is my first cut at adding the ability to import a patch series by specifying
the tarball. For example, the following command:

	$ stg import --tarfile patch-2.6.26.3-rt6.bz2

will apply the latest -rt patch series to your current kernel tree.

No Karl, I haven't developed a test for it (yet).  I wanted to see what you guys
thought first :)

Clark
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkjDTscACgkQqA4JVb61b9dNRgCZAW+tOCgz5Y+A0IdomcOA4X7v
u8MAnRvFWMXRJ0Kxv1rAnBRnheq6Iidi
=W7Dl
-----END PGP SIGNATURE-----

--------------000106010500030104090703
Content-Type: text/plain;
 name="tarfiles.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="tarfiles.patch"

cGF0Y2ggdG8gYWxsb3cgaW1wb3J0aW5nIGEgc2VyaWVzIGZyb20gYSB0YXIgYXJjaGl2ZQoK
RnJvbTogQ2xhcmsgV2lsbGlhbXMgPHdpbGxpYW1zQHJlZGhhdC5jb20+CgpTaWduZWQtb2Zm
LWJ5OiBDbGFyayBXaWxsaWFtcyA8d2lsbGlhbXNAcmVkaGF0LmNvbT4KLS0tCiBzdGdpdC9j
b21tYW5kcy9pbXBydC5weSB8ICAgNDYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLQogMSBmaWxlcyBjaGFuZ2VkLCA0NSBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3N0Z2l0L2NvbW1hbmRzL2ltcHJ0LnB5IGIv
c3RnaXQvY29tbWFuZHMvaW1wcnQucHkKaW5kZXggMjI3NzQzZi4uMGU5YmI3MyAxMDA2NDQK
LS0tIGEvc3RnaXQvY29tbWFuZHMvaW1wcnQucHkKKysrIGIvc3RnaXQvY29tbWFuZHMvaW1w
cnQucHkKQEAgLTg3LDcgKzg3LDEwIEBAIG9wdGlvbnMgPSBbbWFrZV9vcHRpb24oJy1tJywg
Jy0tbWFpbCcsCiAgICAgICAgICAgIG1ha2Vfb3B0aW9uKCctLWNvbW1uYW1lJywKICAgICAg
ICAgICAgICAgICAgICAgICAgaGVscCA9ICd1c2UgQ09NTU5BTUUgYXMgdGhlIGNvbW1pdHRl
ciBuYW1lJyksCiAgICAgICAgICAgIG1ha2Vfb3B0aW9uKCctLWNvbW1lbWFpbCcsCi0gICAg
ICAgICAgICAgICAgICAgICAgIGhlbHAgPSAndXNlIENPTU1FTUFJTCBhcyB0aGUgY29tbWl0
dGVyIGUtbWFpbCcpCisgICAgICAgICAgICAgICAgICAgICAgIGhlbHAgPSAndXNlIENPTU1F
TUFJTCBhcyB0aGUgY29tbWl0dGVyIGUtbWFpbCcpLAorICAgICAgICAgICBtYWtlX29wdGlv
bignLS10YXJmaWxlJywKKyAgICAgICAgICAgICAgICAgICAgICAgaGVscCA9ICdpbXBvcnQg
YSBzZXJpZXMgZnJvbSBhIHRhciBhcmNoaXZlJywKKyAgICAgICAgICAgICAgICAgICAgICAg
YWN0aW9uID0gInN0b3JlX3RydWUiKSwKICAgICAgICAgICAgXSArIG1ha2Vfc2lnbl9vcHRp
b25zKCkKIAogCkBAIC0yODcsNiArMjkwLDQ1IEBAIGRlZiBfX2ltcG9ydF91cmwodXJsLCBv
cHRpb25zKToKICAgICB1cmxsaWIudXJscmV0cmlldmUodXJsLCBmaWxlbmFtZSkKICAgICBf
X2ltcG9ydF9maWxlKGZpbGVuYW1lLCBvcHRpb25zKQogCitkZWYgX19pbXBvcnRfdGFyZmls
ZSh0YXIsIG9wdGlvbnMpOgorICAgICIiIkltcG9ydCBwYXRjaCBzZXJpZXMgZnJvbSBhIHRh
ciBhcmNoaXZlCisgICAgIiIiCisgICAgaW1wb3J0IHRhcmZpbGUKKyAgICBpbXBvcnQgdGVt
cGZpbGUKKworICAgIGlmIG5vdCB0YXJmaWxlLmlzX3RhcmZpbGUodGFyKToKKyAgICAgICAg
cmFpc2UgQ21kRXhjZXB0aW9uLCAiJXMgaXMgbm90IGEgdGFyZmlsZSEiICUgdGFyCisKKwor
ICAgIHQgPSB0YXJmaWxlLm9wZW4odGFyLCAncicpCisgICAgbmFtZXMgPSB0LmdldG5hbWVz
KCkKKworICAgICMgdmVyaWZ5IHBhdGhzIGluIHRoZSB0YXJmaWxlIGFyZSBzYWZlCisgICAg
Zm9yIG4gaW4gbmFtZXM6CisgICAgICAgIGlmIG4uc3RhcnRzd2l0aCgnLycpOgorICAgICAg
ICAgICAgcmFpc2UgQ21kRXhjZXB0aW9uLCAiQWJzb2x1dGUgcGF0aCBmb3VuZCBpbiAlcyIg
JSB0YXIKKyAgICAgICAgaWYgbi5zdGFydHN3aXRoKCIuLi8iKToKKyAgICAgICAgICAgIHJh
aXNlIENtZEV4Y2VwdGlvbiwgIlJlbGF0aXZlIHBhdGggZm91bmQgaW4gJXMiICUgdGFyCisK
KyAgICAjIGZpbmQgdGhlIHNlcmllcyBmaWxlCisgICAgc2VyaWVzZmlsZSA9ICcnOworICAg
IGZvciBtIGluIG5hbWVzOgorICAgICAgICBpZiBtLmVuZHN3aXRoKCcvc2VyaWVzJykgb3Ig
bSA9PSAnc2VyaWVzJzoKKyAgICAgICAgICAgIHNlcmllc2ZpbGUgPSBtCisgICAgICAgICAg
ICBicmVhaworICAgIGlmIHNlcmllc2ZpbGUgPT0gJyc6CisgICAgICAgIHJhaXNlIENtZEV4
Y2VwdGlvbiwgIm5vIHNlcmllcyBmaWxlIGZvdW5kIGluICVzIiAlIHRhcgorCisgICAgIyB1
bnBhY2sgaW50byBhIHRtcCBkaXIKKyAgICB0bXBkaXIgPSB0ZW1wZmlsZS5ta2R0ZW1wKCcu
c3RnJykKKyAgICB0LmV4dHJhY3RhbGwodG1wZGlyKQorCisgICAgIyBhcHBseSB0aGUgc2Vy
aWVzCisgICAgX19pbXBvcnRfc2VyaWVzKG9zLnBhdGguam9pbih0bXBkaXIsIHNlcmllc2Zp
bGUpLCBvcHRpb25zKQorCisgICAgIyBjbGVhbnVwIHRoZSB0bXBkaXIKKyAgICBvcy5zeXN0
ZW0oJ3JtIC1yZiAlcycgJSB0bXBkaXIpCisKIGRlZiBmdW5jKHBhcnNlciwgb3B0aW9ucywg
YXJncyk6CiAgICAgIiIiSW1wb3J0IGEgR05VIGRpZmYgZmlsZSBhcyBhIG5ldyBwYXRjaAog
ICAgICIiIgpAQCAtMzA4LDYgKzM1MCw4IEBAIGRlZiBmdW5jKHBhcnNlciwgb3B0aW9ucywg
YXJncyk6CiAgICAgICAgIF9faW1wb3J0X21ib3goZmlsZW5hbWUsIG9wdGlvbnMpCiAgICAg
ZWxpZiBvcHRpb25zLnVybDoKICAgICAgICAgX19pbXBvcnRfdXJsKGZpbGVuYW1lLCBvcHRp
b25zKQorICAgIGVsaWYgb3B0aW9ucy50YXJmaWxlOgorICAgICAgICBfX2ltcG9ydF90YXJm
aWxlKGZpbGVuYW1lLCBvcHRpb25zKQogICAgIGVsc2U6CiAgICAgICAgIF9faW1wb3J0X2Zp
bGUoZmlsZW5hbWUsIG9wdGlvbnMpCiAK
--------------000106010500030104090703--
