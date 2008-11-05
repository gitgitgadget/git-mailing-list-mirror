From: "Suraj N. Kurapati" <sunaku@gmail.com>
Subject: [PATCH/RFC] git-add--interactive.perl: Answer questions with a single keypress
Date: Tue, 4 Nov 2008 22:15:23 -0800
Message-ID: <200811042215.31147.sunaku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: base64
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 05 07:17:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxbiA-0002hb-DU
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 07:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbYKEGPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 01:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbYKEGPg
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 01:15:36 -0500
Received: from rv-out-0506.google.com ([209.85.198.226]:9642 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbYKEGPf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 01:15:35 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3761019rvb.1
        for <git@vger.kernel.org>; Tue, 04 Nov 2008 22:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-disposition:message-id:content-type
         :content-transfer-encoding;
        bh=9UuMMXibFnO2iLAqwuxIVDRrlSybIzg6y4jVWwBxS8Y=;
        b=omxkk5XXMXWSdpCXLAN/n6on6LLApf6Mg63aUFyjTmBEa0YLB2uqqUmgMBN67lkWgt
         JX+uJyzP91tysVxrwHNwpZLQhWDpaw9Mp/VHwvzhAOCrIky+uRnggEOXW2BPcRjgiLCH
         lW7A4xyxCUKfx6ctvZb488ZSSInJZuMbZsUZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-disposition
         :message-id:content-type:content-transfer-encoding;
        b=Ow0pEDDgtJdjDwqenSvKFDpp9uHH2S1ti+suhHR8JiAre66/t8b74vqmjXI15h0zF+
         Yr0UKWCuRc09b6rOQyvyM2gQdFvmUgDpO4gk36sfZoP3w2yGn+QDLAUjpRIZodxWvcGT
         oXUljntaK6I5kbWJFII6FaOCg9E+X/yHKwJx8=
Received: by 10.142.210.4 with SMTP id i4mr242672wfg.240.1225865734728;
        Tue, 04 Nov 2008 22:15:34 -0800 (PST)
Received: from yantram.localnet (adsl-76-221-202-142.dsl.pltn13.sbcglobal.net [76.221.202.142])
        by mx.google.com with ESMTPS id 9sm20169152wfc.19.2008.11.04.22.15.33
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 04 Nov 2008 22:15:34 -0800 (PST)
User-Agent: KMail/1.10.1 (Linux/2.6.27-ARCH; KDE/4.1.2; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100146>

RnJvbSBhZWY2ZGYxNjNiOTBiOTQ4NWRhMWY5N2ExNGZmYWI2ZDhkZTliMDQ3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdXJhaiBOLiBLdXJhcGF0aSA8c3VuYWt1QGdtYWlsLmNvbT4K
RGF0ZTogVHVlLCA0IE5vdiAyMDA4IDIwOjMyOjM0IC0wODAwClN1YmplY3Q6IFtQQVRDSF0gZ2l0
LWFkZC0taW50ZXJhY3RpdmUucGVybDogQW5zd2VyIHF1ZXN0aW9ucyB3aXRoIGEgc2luZ2xlIGtl
eXByZXNzCgpBbGxvd3MgdGhlIHVzZXIgdG8gYW5zd2VyICdTdGFnZSB0aGlzIGh1bmsnIHF1ZXN0
aW9ucyB3aXRoIGEKc2luZ2xlIGtleXByZXNzLCBqdXN0IGxpa2UgaW4gRGFyY3MuICBQcmV2aW91
c2x5LCB0aGUgdXNlcgp3YXMgZm9yY2VkIHRvIHByZXNzIHRoZSBSZXR1cm4ga2V5IGFmdGVyIGV2
ZXJ5IGNob2ljZSwgd2hpY2gKcXVpY2tseSBiZWNvbWVzIHRpcmluZyBhbmQgYnVyZGVuc29tZSB3
b3JrIGZvciB0aGUgZmluZ2Vycy4KClNpZ25lZC1vZmYtYnk6IFN1cmFqIE4uIEt1cmFwYXRpIDxz
dW5ha3VAZ21haWwuY29tPgotLS0KIGdpdC1hZGQtLWludGVyYWN0aXZlLnBlcmwgfCAgICA2ICsr
KysrLQogMSBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZ2l0LWFkZC0taW50ZXJhY3RpdmUucGVybCBiL2dpdC1hZGQtLWludGVyYWN0
aXZlLnBlcmwKaW5kZXggYjAyMjNjMy4uMWEyMjk2OCAxMDA3NTUKLS0tIGEvZ2l0LWFkZC0taW50
ZXJhY3RpdmUucGVybAorKysgYi9naXQtYWRkLS1pbnRlcmFjdGl2ZS5wZXJsCkBAIC04NzcsNiAr
ODc3LDcgQEAgc3ViIHBhdGNoX3VwZGF0ZV9maWxlIHsKIAkkbnVtID0gc2NhbGFyIEBodW5rOwog
CSRpeCA9IDA7CiAKKwlyZXF1aXJlIFRlcm06OlJlYWRLZXk7CiAJd2hpbGUgKDEpIHsKIAkJbXkg
KCRwcmV2LCAkbmV4dCwgJG90aGVyLCAkdW5kZWNpZGVkLCAkaSk7CiAJCSRvdGhlciA9ICcnOwpA
QCAtOTIwLDcgKzkyMSwxMCBAQCBzdWIgcGF0Y2hfdXBkYXRlX2ZpbGUgewogCQkJcHJpbnQ7CiAJ
CX0KIAkJcHJpbnQgY29sb3JlZCAkcHJvbXB0X2NvbG9yLCAiU3RhZ2UgdGhpcyBodW5rIFt5L24v
YS9kJG90aGVyLz9dPyAiOwotCQlteSAkbGluZSA9IDxTVERJTj47CisKKwkJVGVybTo6UmVhZEtl
eTo6UmVhZE1vZGUoJ3JhdycpOworCQlteSAkbGluZSA9IFRlcm06OlJlYWRLZXk6OlJlYWRLZXko
MCk7CisJCVRlcm06OlJlYWRLZXk6OlJlYWRNb2RlKCdyZXN0b3JlJyk7CiAJCWlmICgkbGluZSkg
ewogCQkJaWYgKCRsaW5lID1+IC9eeS9pKSB7CiAJCQkJJGh1bmtbJGl4XXtVU0V9ID0gMTsKLS0g
CjEuNi4wLjMKCgAK
