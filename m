From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git rebase -i (and gitk) problem in Windows/Cygwin
Date: Mon, 20 Apr 2009 14:47:53 +0200
Message-ID: <81b0412b0904200547g3151ce70l9327bb287da4fdd0@mail.gmail.com>
References: <831vs4im37.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd56b485867730467fbf0e4
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Hannu Koivisto <azure@iki.fi>
X-From: git-owner@vger.kernel.org Mon Apr 20 14:49:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvswE-0002LL-F1
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 14:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754564AbZDTMr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 08:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753522AbZDTMr4
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 08:47:56 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:59818 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357AbZDTMrz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 08:47:55 -0400
Received: by yx-out-2324.google.com with SMTP id 3so756045yxj.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 05:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=uwG5TKsLTRFexgQbAvspDtcoGKC3+aq8QRW6tkCaE9c=;
        b=e7pKIqV5Lx8NDglWmCN2MGWIATvww2V5bgz9RujpvsE8xfn0PhvE3FSswpPnw5go1W
         yGb2Hw5zHzByWGyqYN39HKWelO5lUsVcR5OKQZ+6i4srqF6Rc2fK5WNRDyqz6d62CpsV
         hvIpFlk5b4ribaaSOejN/cZ4/V/bqMeGD4Ncg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=s5JYIJZy0FnBQOnsSZybwvkzBmwGC6o9WPt3R/j2+rPd4UH2jkHNPgd9s2Qm37ea0L
         ewChjk2LP8VMyIrJw7DijtJVSIB4+VLuI71F4dPQniGQZZEa+wRbEnivUBgYaOViSYIN
         fpoW9mwf/dHwMye6UalqGToEXYDWEa7/bTtXQ=
Received: by 10.150.137.14 with SMTP id k14mr5798773ybd.53.1240231673618; Mon, 
	20 Apr 2009 05:47:53 -0700 (PDT)
In-Reply-To: <831vs4im37.fsf@kalahari.s2.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116978>

--000e0cd56b485867730467fbf0e4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2009/4/7 Hannu Koivisto <azure@iki.fi>:
> ---8<----------------------------------------------------
> error: Entry 'kala.c' not uptodate. Cannot merge.
> fatal: merging of trees 787519579d90e45dfee00189985fa8c92f56be8f and 83f124d88764604c7d348e73103168bd98665e56 failed
>
> Could not apply 14eb9c7... Kala addition 2.
> ---8<----------------------------------------------------
>
> rebase -i used to work fine earlier, but unfortunately I don't
> remember which version I used back then (1.6.something).

FWIW, I cannot reproduce it. I have quite a bit of changes in my tree
though, and maybe that cygwin fstat patches can help...
(I believe I posted them, but attached anyway.
I didn't try to revert them and retest, sorry)

--000e0cd56b485867730467fbf0e4
Content-Type: application/octet-stream; 
	name="0001-Add-a-fast-version-of-fstat-to-cygwin-port.patch"
Content-Disposition: attachment; 
	filename="0001-Add-a-fast-version-of-fstat-to-cygwin-port.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ftr5w3860

RnJvbSA3MzgwZTgwMjJmZmZkMWY5YmFhMGY0NTE3NGM2NDA2YTcwMGQ2MWY5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUaHUsIDE5IE1hciAyMDA5IDE1OjE4OjAwICswMTAwClN1YmplY3Q6IFtQQVRDSF0gQWRkIGEg
ZmFzdCB2ZXJzaW9uIG9mIGZzdGF0IHRvIGN5Z3dpbiBwb3J0CgpCZXNpZGVzLCB0aGUgb3V0cHV0
IG9mIHRoZSBmYXN0IHN0YXQgYW5kIGxzdGF0IGlzIG5vdCBjb21wYXRpYmxlCndpdGggY3lnd2lu
J3MgZnN0YXQgd2l0aCByZWdhcmQgdG8gdWlkLCBnaWQgYW5kIGN0aW1lIGZpZWxkcy4KClNpZ25l
ZC1vZmYtYnk6IEFsZXggUmllc2VuIDxyYWEubGttbEBnbWFpbC5jb20+Ci0tLQogY29tcGF0L2N5
Z3dpbi5jIHwgICA2MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKystLS0KIGNvbXBhdC9jeWd3aW4uaCB8ICAgIDIgKwogMiBmaWxlcyBjaGFuZ2VkLCA1
OCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2NvbXBhdC9jeWd3
aW4uYyBiL2NvbXBhdC9jeWd3aW4uYwppbmRleCBlYmFjMTQ4Li5lOTFhZjRmIDEwMDY0NAotLS0g
YS9jb21wYXQvY3lnd2luLmMKKysrIGIvY29tcGF0L2N5Z3dpbi5jCkBAIC0xNSw2ICsxNSwxOCBA
QCBzdGF0aWMgaW5saW5lIHZvaWQgZmlsZXRpbWVfdG9fdGltZXNwZWMoY29uc3QgRklMRVRJTUUg
KmZ0LCBzdHJ1Y3QgdGltZXNwZWMgKnRzKQogCiAjZGVmaW5lIHNpemVfdG9fYmxvY2tzKHMpICgo
KHMpKzUxMSkvNTEyKQogCisvKgorICogSW5pdGlhbGl6ZSB0aGUgZmllbGRzIG9mIHN0cnVjdCBz
dGF0IHdoaWNoIHRoaXMgaW1wbGVtZW50YXRpb24KKyAqIGNvbnNpZGVycyBjb25zdGFudCBvbiB0
aGlzIHBsYXRmb3JtLiBTZWUgYWxzbyBtaW5ndy5jCisgKi8KK3N0YXRpYyB2b2lkIGRvc2lmeV9z
dGF0YnVmKHN0cnVjdCBzdGF0ICpidWYpCit7CisJYnVmLT5zdF9kZXYgPSBidWYtPnN0X3JkZXYg
PSAwOyAvKiBub3QgdXNlZCBieSBHaXQgKi8KKwlidWYtPnN0X2lubyA9IDA7CisJYnVmLT5zdF9u
bGluayA9IDE7CisJYnVmLT5zdF91aWQgPSBidWYtPnN0X2dpZCA9IDA7Cit9CisKIC8qIGRvX3N0
YXQgaXMgYSBjb21tb24gaW1wbGVtZW50YXRpb24gZm9yIGN5Z3dpbl9sc3RhdCBhbmQgY3lnd2lu
X3N0YXQuCiAgKgogICogVG8gc2ltcGxpZnkgaXRzIGxvZ2ljLCBpbiB0aGUgY2FzZSBvZiBjeWd3
aW4gc3ltbGlua3MsIHRoaXMgaW1wbGVtZW50YXRpb24KQEAgLTQxLDExICs1Myw4IEBAIHN0YXRp
YyBpbnQgZG9fc3RhdChjb25zdCBjaGFyICpmaWxlX25hbWUsIHN0cnVjdCBzdGF0ICpidWYsIHN0
YXRfZm5fdCBjeWdzdGF0KQogCQkJcmV0dXJuIGN5Z3N0YXQoZmlsZV9uYW1lLCBidWYpOwogCiAJ
CS8qIGZpbGwgb3V0IHRoZSBzdGF0IHN0cnVjdHVyZSAqLwotCQlidWYtPnN0X2RldiA9IGJ1Zi0+
c3RfcmRldiA9IDA7IC8qIG5vdCB1c2VkIGJ5IEdpdCAqLwotCQlidWYtPnN0X2lubyA9IDA7CisJ
CWRvc2lmeV9zdGF0YnVmKGJ1Zik7CiAJCWJ1Zi0+c3RfbW9kZSA9IGZpbGVfYXR0cl90b19zdF9t
b2RlKGZkYXRhLmR3RmlsZUF0dHJpYnV0ZXMpOwotCQlidWYtPnN0X25saW5rID0gMTsKLQkJYnVm
LT5zdF91aWQgPSBidWYtPnN0X2dpZCA9IDA7CiAjaWZkZWYgX19DWUdXSU5fVVNFX0JJR19UWVBF
U19fCiAJCWJ1Zi0+c3Rfc2l6ZSA9ICgoX29mZjY0X3QpZmRhdGEubkZpbGVTaXplSGlnaCA8PCAz
MikgKwogCQkJZmRhdGEubkZpbGVTaXplTG93OwpAQCAtODUsNiArOTQsNDEgQEAgc3RhdGljIGlu
dCBjeWd3aW5fc3RhdChjb25zdCBjaGFyICpwYXRoLCBzdHJ1Y3Qgc3RhdCAqYnVmKQogCXJldHVy
biBkb19zdGF0KHBhdGgsIGJ1Ziwgc3RhdCk7CiB9CiAKKyN1bmRlZiBmc3RhdAorc3RhdGljIGlu
dCBjeWd3aW5fZnN0YXQoaW50IGZkLCBzdHJ1Y3Qgc3RhdCAqYnVmKQoreworCUhBTkRMRSBmaCA9
IChIQU5ETEUpX2dldF9vc2ZoYW5kbGUoZmQpOworCUJZX0hBTkRMRV9GSUxFX0lORk9STUFUSU9O
IGZkYXRhOworCisJaWYgKGZoID09IElOVkFMSURfSEFORExFX1ZBTFVFKSB7CisJCWVycm5vID0g
RUJBREY7CisJCXJldHVybiAtMTsKKwl9CisJLyogZGlyZWN0IG5vbi1maWxlIGhhbmRsZXMgdG8g
Y3lnd2luJ3MgZnN0YXQoKSAqLworCWlmIChHZXRGaWxlVHlwZShmaCkgIT0gRklMRV9UWVBFX0RJ
U0spCisJCXJldHVybiBmc3RhdChmZCwgYnVmKTsKKworCWlmICghYnVmKSB7CisJCWVycm5vID0g
RUlOVkFMOworCQlyZXR1cm4gLTE7CisJfQorCWlmIChHZXRGaWxlSW5mb3JtYXRpb25CeUhhbmRs
ZShmaCwgJmZkYXRhKSkgeworCQlkb3NpZnlfc3RhdGJ1ZihidWYpOworCQlidWYtPnN0X21vZGUg
PSBmaWxlX2F0dHJfdG9fc3RfbW9kZShmZGF0YS5kd0ZpbGVBdHRyaWJ1dGVzKTsKKyNpZmRlZiBf
X0NZR1dJTl9VU0VfQklHX1RZUEVTX18KKwkJYnVmLT5zdF9zaXplID0gKChfb2ZmNjRfdClmZGF0
YS5uRmlsZVNpemVIaWdoIDw8IDMyKSArCisJCQlmZGF0YS5uRmlsZVNpemVMb3c7CisjZWxzZQor
CQlidWYtPnN0X3NpemUgPSAob2ZmX3QpZmRhdGEubkZpbGVTaXplTG93OworI2VuZGlmCisJCWZp
bGV0aW1lX3RvX3RpbWVzcGVjKCZmZGF0YS5mdExhc3RBY2Nlc3NUaW1lLCAmYnVmLT5zdF9hdGlt
KTsKKwkJZmlsZXRpbWVfdG9fdGltZXNwZWMoJmZkYXRhLmZ0TGFzdFdyaXRlVGltZSwgJmJ1Zi0+
c3RfbXRpbSk7CisJCWZpbGV0aW1lX3RvX3RpbWVzcGVjKCZmZGF0YS5mdENyZWF0aW9uVGltZSwg
JmJ1Zi0+c3RfY3RpbSk7CisJCXJldHVybiAwOworCX0KKwllcnJubyA9IEVCQURGOworCXJldHVy
biAtMTsKK30KIAogLyoKICAqIEF0IHN0YXJ0IHVwLCB3ZSBhcmUgdHJ5aW5nIHRvIGRldGVybWlu
ZSB3aGV0aGVyIFdpbjMyIEFQSSBvciBjeWd3aW4gc3RhdApAQCAtMTE5LDkgKzE2MywxMSBAQCBz
dGF0aWMgaW50IGluaXRfc3RhdCh2b2lkKQogCQlpZiAoIWNvcmVfZmlsZW1vZGUgJiYgbmF0aXZl
X3N0YXQpIHsKIAkJCWN5Z3dpbl9zdGF0X2ZuID0gY3lnd2luX3N0YXQ7CiAJCQljeWd3aW5fbHN0
YXRfZm4gPSBjeWd3aW5fbHN0YXQ7CisJCQljeWd3aW5fZnN0YXRfZm4gPSBjeWd3aW5fZnN0YXQ7
CiAJCX0gZWxzZSB7CiAJCQljeWd3aW5fc3RhdF9mbiA9IHN0YXQ7CiAJCQljeWd3aW5fbHN0YXRf
Zm4gPSBsc3RhdDsKKwkJCWN5Z3dpbl9mc3RhdF9mbiA9IGZzdGF0OwogCQl9CiAJCXJldHVybiAw
OwogCX0KQEAgLTEzOCw2ICsxODQsMTIgQEAgc3RhdGljIGludCBjeWd3aW5fbHN0YXRfc3R1Yihj
b25zdCBjaGFyICpmaWxlX25hbWUsIHN0cnVjdCBzdGF0ICpidWYpCiAJcmV0dXJuIChpbml0X3N0
YXQoKSA/IGxzdGF0IDogKmN5Z3dpbl9sc3RhdF9mbikoZmlsZV9uYW1lLCBidWYpOwogfQogCitz
dGF0aWMgaW50IGN5Z3dpbl9mc3RhdF9zdHViKGludCBmZCwgc3RydWN0IHN0YXQgKmJ1ZikKK3sK
KwlyZXR1cm4gKGluaXRfc3RhdCgpID8gZnN0YXQgOiAqY3lnd2luX2ZzdGF0X2ZuKShmZCwgYnVm
KTsKK30KKwogc3RhdF9mbl90IGN5Z3dpbl9zdGF0X2ZuID0gY3lnd2luX3N0YXRfc3R1YjsKIHN0
YXRfZm5fdCBjeWd3aW5fbHN0YXRfZm4gPSBjeWd3aW5fbHN0YXRfc3R1YjsKK2ludCAoKmN5Z3dp
bl9mc3RhdF9mbikoaW50IGZkLCBzdHJ1Y3Qgc3RhdCAqKSA9IGN5Z3dpbl9mc3RhdF9zdHViOwog
CmRpZmYgLS1naXQgYS9jb21wYXQvY3lnd2luLmggYi9jb21wYXQvY3lnd2luLmgKaW5kZXggYTMy
MjlmNS4uZmQ1NGM4MiAxMDA2NDQKLS0tIGEvY29tcGF0L2N5Z3dpbi5oCisrKyBiL2NvbXBhdC9j
eWd3aW4uaApAQCAtNCw2ICs0LDggQEAKIHR5cGVkZWYgaW50ICgqc3RhdF9mbl90KShjb25zdCBj
aGFyKiwgc3RydWN0IHN0YXQqKTsKIGV4dGVybiBzdGF0X2ZuX3QgY3lnd2luX3N0YXRfZm47CiBl
eHRlcm4gc3RhdF9mbl90IGN5Z3dpbl9sc3RhdF9mbjsKK2V4dGVybiBpbnQgKCpjeWd3aW5fZnN0
YXRfZm4pKGludCBmZCwgc3RydWN0IHN0YXQgKik7CiAKICNkZWZpbmUgc3RhdChwYXRoLCBidWYp
ICgqY3lnd2luX3N0YXRfZm4pKHBhdGgsIGJ1ZikKICNkZWZpbmUgbHN0YXQocGF0aCwgYnVmKSAo
KmN5Z3dpbl9sc3RhdF9mbikocGF0aCwgYnVmKQorI2RlZmluZSBmc3RhdChmZCwgYnVmKSAoKmN5
Z3dpbl9mc3RhdF9mbikoZmQsIGJ1ZikKLS0gCjEuNi4zLnJjMC40NS5nNjM2MzQKCg==
--000e0cd56b485867730467fbf0e4--
