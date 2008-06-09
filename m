From: Clark Williams <clark.williams@gmail.com>
Subject: [PATCH - stgit] Patch to allow import of compressed files
Date: Mon, 09 Jun 2008 13:38:55 -0500
Message-ID: <484D78BF.6030504@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020001030409060500060408"
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 20:40:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5mI4-0007NI-PB
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 20:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550AbYFISjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 14:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753536AbYFISjb
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 14:39:31 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:28706 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478AbYFISja (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 14:39:30 -0400
Received: by an-out-0708.google.com with SMTP id d40so524689and.103
        for <git@vger.kernel.org>; Mon, 09 Jun 2008 11:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:x-enigmail-version
         :content-type;
        bh=j4ONcqbTe+jzWZiXBos/cG0lOqyAha+RR/kWWLq4vyw=;
        b=YTzAGSKtpbb3YEIacktRVVVMmfqg9MmLoCoXbX8i00VikOn9qdX7SCRLBUJHSARP9z
         g+QafoZAIcDeUMzU2LX3ZEH2wfqIf4TFaUdkT5UFcFWKrHQldr2ItkBN+OiH5NjKu34A
         s7xvFXR5pCkMMPivjTH/Hge8orNdOfQ3Err5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :x-enigmail-version:content-type;
        b=paW0SXO0PsgLp0hpYOzQz49yuIWWZQjp0Skp2+5CJTRV+4SKPolhYryMLVPWBjdkJ1
         ELJD1hmbazpumFTO41LCRm/9qYSSv78Dz2Mq4iUO22O+VGa3ck4VV+7Pjxx4PjFSTBms
         WJ9dYFuUFfZ+VgX8Ao9o7Qe0eLqsnERh6LNPQ=
Received: by 10.100.128.20 with SMTP id a20mr4085044and.153.1213036741319;
        Mon, 09 Jun 2008 11:39:01 -0700 (PDT)
Received: from ?172.16.17.168? ( [66.187.231.200])
        by mx.google.com with ESMTPS id g9sm6342666wra.10.2008.06.09.11.38.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Jun 2008 11:38:59 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070911)
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84410>

This is a multi-part message in MIME format.
--------------020001030409060500060408
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch allows StGit to directly import compressed (.gz and .bz2) files with
reasonable patch names.

I do a lot of work on modified kernel trees and usually the first two things imported
are a stable update patch followed immediately by an -rt patch, both of which are
compressed. With this patch I can just copy the files down directly from kernel.org
and import them, rather than having to keep uncompressed copies around.

Hey, I'm lazy... :)

Clark

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkhNeL4ACgkQqA4JVb61b9cu0ACdH/Z71xh4gaD5euF3BgYnIhiO
AkUAnipyN/dsTBQDyhc6uzFhxdxPeYvJ
=2G71
-----END PGP SIGNATURE-----

--------------020001030409060500060408
Content-Type: text/plain;
 name="compressed-input.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="compressed-input.patch"

RnJvbTogQ2xhcmsgV2lsbGlhbXMgPHdpbGxpYW1zQHJlZGhhdC5jb20+CgpQYXRjaCB0byBh
bGxvdyBpbXBvcnQgZnJvbSBjb21wcmVzc2VkICguZ3ogYW5kIC5iejIpIGZpbGVzCgpTaWdu
ZWQtb2ZmLWJ5OiBDbGFyayBXaWxsaWFtcyA8d2lsbGlhbXNAcmVkaGF0LmNvbT4KLS0tCgog
c3RnaXQvY29tbWFuZHMvaW1wcnQucHkgfCAgIDIxICsrKysrKysrKysrKysrKy0tLS0tLQog
MSBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL3N0Z2l0L2NvbW1hbmRzL2ltcHJ0LnB5IGIvc3RnaXQvY29tbWFuZHMvaW1w
cnQucHkKaW5kZXggNGE0Yjc5Mi4uODNkYWUyZiAxMDA2NDQKLS0tIGEvc3RnaXQvY29tbWFu
ZHMvaW1wcnQucHkKKysrIGIvc3RnaXQvY29tbWFuZHMvaW1wcnQucHkKQEAgLTE3OCw4ICsx
NzgsMjIgQEAgZGVmIF9fY3JlYXRlX3BhdGNoKGZpbGVuYW1lLCBtZXNzYWdlLCBhdXRob3Jf
bmFtZSwgYXV0aG9yX2VtYWlsLAogZGVmIF9faW1wb3J0X2ZpbGUoZmlsZW5hbWUsIG9wdGlv
bnMsIHBhdGNoID0gTm9uZSk6CiAgICAgIiIiSW1wb3J0IGEgcGF0Y2ggZnJvbSBhIGZpbGUg
b3Igc3RhbmRhcmQgaW5wdXQKICAgICAiIiIKKyAgICBpZiBwYXRjaDoKKyAgICAgICAgcG5h
bWUgPSBwYXRjaAorICAgIGVsc2U6CisgICAgICAgIHBuYW1lID0gZmlsZW5hbWUKKwogICAg
IGlmIGZpbGVuYW1lOgotICAgICAgICBmID0gZmlsZShmaWxlbmFtZSkKKyAgICAgICAgaWYg
ZmlsZW5hbWUuZW5kc3dpdGgoIi5neiIpOgorICAgICAgICAgICAgaW1wb3J0IGd6aXAKKyAg
ICAgICAgICAgIGYgPSBnemlwLm9wZW4oZmlsZW5hbWUpCisgICAgICAgICAgICBwbmFtZSA9
IGZpbGVuYW1lLnJlcGxhY2UoIi5neiIsICIiKQorICAgICAgICBlbGlmIGZpbGVuYW1lLmVu
ZHN3aXRoKCIuYnoyIik6CisgICAgICAgICAgICBpbXBvcnQgYnoyCisgICAgICAgICAgICBm
ID0gYnoyLkJaMkZpbGUoZmlsZW5hbWUsICdyJykKKyAgICAgICAgICAgIHBuYW1lID0gZmls
ZW5hbWUucmVwbGFjZSgiLmJ6MiIsICIiKQorICAgICAgICBlbHNlOgorICAgICAgICAgICAg
ZiA9IGZpbGUoZmlsZW5hbWUpCiAgICAgZWxzZToKICAgICAgICAgZiA9IHN5cy5zdGRpbgog
CkBAIC0xOTcsMTEgKzIxMSw2IEBAIGRlZiBfX2ltcG9ydF9maWxlKGZpbGVuYW1lLCBvcHRp
b25zLCBwYXRjaCA9IE5vbmUpOgogICAgIGlmIGZpbGVuYW1lOgogICAgICAgICBmLmNsb3Nl
KCkKIAotICAgIGlmIHBhdGNoOgotICAgICAgICBwbmFtZSA9IHBhdGNoCi0gICAgZWxzZToK
LSAgICAgICAgcG5hbWUgPSBmaWxlbmFtZQotCiAgICAgX19jcmVhdGVfcGF0Y2gocG5hbWUs
IG1lc3NhZ2UsIGF1dGhvcl9uYW1lLCBhdXRob3JfZW1haWwsCiAgICAgICAgICAgICAgICAg
ICAgYXV0aG9yX2RhdGUsIGRpZmYsIG9wdGlvbnMpCiAK
--------------020001030409060500060408--
