From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: activestate perl: Makemaker generates broken Makefiles.
Date: Wed, 4 Oct 2006 13:25:56 +0200
Message-ID: <81b0412b0610040425j60d0647dk1489d02657379c13@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_15818_11167900.1159961156884"
Cc: "Junio C Hamano" <junkio@cox.net>, "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Oct 04 13:26:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GV4t0-0002Sm-HT
	for gcvg-git@gmane.org; Wed, 04 Oct 2006 13:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161199AbWJDLZ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Oct 2006 07:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030825AbWJDLZ7
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Oct 2006 07:25:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:31382 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030821AbWJDLZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Oct 2006 07:25:58 -0400
Received: by nf-out-0910.google.com with SMTP id x30so445105nfb
        for <git@vger.kernel.org>; Wed, 04 Oct 2006 04:25:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=lmtUDjOFALusnj5r7ZTzEz8Si+hRAlJPuyMQy0VjN5f2uZC3z4neagp8hnWPUoTYhhaO0e7Liix51rABfSfEqNAnWaSpi4AnVRCYKpw0BNHebGH87kGmX+OQLgDqB90Mzq336LyEEhsCdPgbMKgHWkUyMbmCBvENZI0rqhu5F04=
Received: by 10.78.188.19 with SMTP id l19mr341273huf;
        Wed, 04 Oct 2006 04:25:56 -0700 (PDT)
Received: by 10.78.115.11 with HTTP; Wed, 4 Oct 2006 04:25:56 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28325>

------=_Part_15818_11167900.1159961156884
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Just a heads up. Makefile.PL can't be used. The attached patch removes
everything perl (sorry, but it'd help someone to get going).

------=_Part_15818_11167900.1159961156884
Content-Type: text/x-diff; name=disable-git.xs.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_esvjqzje
Content-Disposition: attachment; filename="disable-git.xs.patch"

Y29tbWl0IGJiMGVhNjY3NDZjNzY0ZjY2NWZjMmM1YTBmMGMyODlmYmJjN2ViMDMKQXV0aG9yOiBB
bGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRlOiAgIFdlZCBPY3QgNCAxMTo1MTo1
MSAyMDA2ICswMjAwCgogICAgcmVtb3ZlIEdpdC54cwoKZGlmZiAtLWdpdCBhL01ha2VmaWxlIGIv
TWFrZWZpbGUKaW5kZXggZWUzYmM3Mi4uOTNmOTNlMSAxMDA2NDQKLS0tIGEvTWFrZWZpbGUKKysr
IGIvTWFrZWZpbGUKQEAgLTU5MCw4ICs1OTAsNyBAQCAjIyMgQnVpbGQgcnVsZXMKIAogYWxsOiAk
KEFMTF9QUk9HUkFNUykgJChCVUlMVF9JTlMpIGdpdCRYIGdpdGsgZ2l0d2ViL2dpdHdlYi5jZ2kK
IAotYWxsOiBwZXJsL01ha2VmaWxlCi0JJChNQUtFKSAtQyBwZXJsCithbGw6CiAJJChNQUtFKSAt
QyB0ZW1wbGF0ZXMKIAogc3RyaXA6ICQoUFJPR1JBTVMpIGdpdCRYCkBAIC02MjUsMTUgKzYyNCwx
MSBAQCBjb21tb24tY21kcy5oOiBEb2N1bWVudGF0aW9uL2dpdC0qLnR4dAogCWNobW9kICt4ICRA
KwogCW12ICRAKyAkQAogCi0kKHBhdHN1YnN0ICUucGVybCwlLCQoU0NSSVBUX1BFUkwpKTogcGVy
bC9NYWtlZmlsZQogJChwYXRzdWJzdCAlLnBlcmwsJSwkKFNDUklQVF9QRVJMKSk6ICUgOiAlLnBl
cmwKIAlybSAtZiAkQCAkQCsKLQlJTlNUTElCRElSPWAkKE1BS0UpIC1DIHBlcmwgLXMgLS1uby1w
cmludC1kaXJlY3RvcnkgaW5zdGxpYmRpcmAgJiYgXAogCXNlZCAtZSAnMXsnIFwKIAkgICAgLWUg
JwlzfCMhLipwZXJsfCMhJChQRVJMX1BBVEhfU1EpfCcgXAogCSAgICAtZSAnCWgnIFwKLQkgICAg
LWUgJwlzPS4qPXVzZSBsaWIgKHNwbGl0KC86LywgJCRFTlZ7R0lUUEVSTExJQn0gfHwgIkBASU5T
VExJQkRJUkBAIikpOz0nIFwKLQkgICAgLWUgJwlIJyBcCiAJICAgIC1lICcJeCcgXAogCSAgICAt
ZSAnfScgXAogCSAgICAtZSAnc3xAQElOU1RMSUJESVJAQHwnIiQkSU5TVExJQkRJUiInfGcnIFwK
QEAgLTc2NiwxMCArNzYxLDYgQEAgWERJRkZfT0JKUz14ZGlmZi94ZGlmZmkubyB4ZGlmZi94cHJl
cGFyZQogCXJtIC1mICRAICYmICQoQVIpIHJjcyAkQCAkKFhESUZGX09CSlMpCiAKIAotcGVybC9N
YWtlZmlsZTogcGVybC9HaXQucG0gcGVybC9NYWtlZmlsZS5QTCBHSVQtQ0ZMQUdTCi0JKGNkIHBl
cmwgJiYgJChQRVJMX1BBVEgpIE1ha2VmaWxlLlBMIFwKLQkJUFJFRklYPSckKHByZWZpeF9TUSkn
KQotCiBkb2M6CiAJJChNQUtFKSAtQyBEb2N1bWVudGF0aW9uIGFsbAogCkBAIC04MzIsNyArODIz
LDYgQEAgaW5zdGFsbDogYWxsCiAJJChJTlNUQUxMKSAkKEFMTF9QUk9HUkFNUykgJyQoREVTVERJ
Ul9TUSkkKGdpdGV4ZWNkaXJfU1EpJwogCSQoSU5TVEFMTCkgZ2l0JFggZ2l0ayAnJChERVNURElS
X1NRKSQoYmluZGlyX1NRKScKIAkkKE1BS0UpIC1DIHRlbXBsYXRlcyBERVNURElSPSckKERFU1RE
SVJfU1EpJyBpbnN0YWxsCi0JJChNQUtFKSAtQyBwZXJsIGluc3RhbGwKIAkkKElOU1RBTEwpIC1k
IC1tNzU1ICckKERFU1RESVJfU1EpJChHSVRfUFlUSE9OX0RJUl9TUSknCiAJJChJTlNUQUxMKSAk
KFBZTU9EVUxFUykgJyQoREVTVERJUl9TUSkkKEdJVF9QWVRIT05fRElSX1NRKScKIAlpZiB0ZXN0
ICd6JChiaW5kaXJfU1EpJyAhPSAneiQoZ2l0ZXhlY2Rpcl9TUSknOyBcCg==
------=_Part_15818_11167900.1159961156884--
