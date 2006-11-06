X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] merge-recursive implicitely depends on trust_executable_bit
Date: Mon, 6 Nov 2006 11:38:52 +0100
Message-ID: <81b0412b0611060238k29c20ff6le555aa0579ecc0ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_42988_9471310.1162809532292"
NNTP-Posting-Date: Mon, 6 Nov 2006 10:39:06 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=Q5W9udpv8GpBkXqp+w5uC6PxZLgF4jTEn+Rpc1ADAHRmiY41OlTnNKI7Mes0Y8LsXuHeoXbXn9fgbYvU3StriX7C1pn/bxmBkawJ0riRzTloXmSDgSDAxT7HKED21aBCjbZqnNwYiY7CzCUlj5r9nsM6wkXxVAzD6m3i2ayzNSM=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31005>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gh1sX-0007c6-V8 for gcvg-git@gmane.org; Mon, 06 Nov
 2006 11:38:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750701AbWKFKiy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 05:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWKFKiy
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 05:38:54 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:49957 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1750701AbWKFKiy
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 05:38:54 -0500
Received: by ug-out-1314.google.com with SMTP id m3so839391ugc for
 <git@vger.kernel.org>; Mon, 06 Nov 2006 02:38:52 -0800 (PST)
Received: by 10.78.201.10 with SMTP id y10mr6548766huf.1162809532313; Mon, 06
 Nov 2006 02:38:52 -0800 (PST)
Received: by 10.78.128.2 with HTTP; Mon, 6 Nov 2006 02:38:52 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

------=_Part_42988_9471310.1162809532292
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Read the configuration in to get core.filemode value for this
particular repository.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

------=_Part_42988_9471310.1162809532292
Content-Type: text/plain; name="0001-merge-recursive-implicitely-depends-on-trust_executable_bit-core.filemode.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-merge-recursive-implicitely-depends-on-trust_executable_bit-core.filemode.txt"
X-Attachment-Id: file0

RnJvbSAxOTNhYzY1MjU5YjVkZTE5ZmFlMWExYmQ1ZDRhZGI1NTk4ODA4NmY2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBNb24sIDYgTm92IDIwMDYgMDk6MjQ6MTcgKzAxMDAKU3ViamVjdDogW1BBVENIXSBtZXJnZS1y
ZWN1cnNpdmUgaW1wbGljaXRlbHkgZGVwZW5kcyBvbiB0cnVzdF9leGVjdXRhYmxlX2JpdCAoY29y
ZS5maWxlbW9kZSkuClJlYWQgdGhlIGNvbmZpZ3VyYXRpb24gaW4gdG8gZ2V0IGl0cyB2YWx1ZSBm
b3IgdGhpcyBwYXJ0aWN1bGFyIHJlcG9zaXRvcnkKLS0tCiBtZXJnZS1yZWN1cnNpdmUuYyB8ICAg
IDEgKwogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvbWVyZ2UtcmVjdXJzaXZlLmMgYi9tZXJnZS1yZWN1cnNpdmUuYwppbmRleCAy
YmE0M2FlLi5jODEwNDhkIDEwMDY0NAotLS0gYS9tZXJnZS1yZWN1cnNpdmUuYworKysgYi9tZXJn
ZS1yZWN1cnNpdmUuYwpAQCAtMTMwOCw2ICsxMzA4LDcgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNo
YXIgKmFyZ3ZbXSkKIAljb25zdCBjaGFyICpicmFuY2gxLCAqYnJhbmNoMjsKIAlzdHJ1Y3QgY29t
bWl0ICpyZXN1bHQsICpoMSwgKmgyOwogCisJZ2l0X2NvbmZpZyhnaXRfZGVmYXVsdF9jb25maWcp
OyAvKiBjb3JlLmZpbGVtb2RlICovCiAJb3JpZ2luYWxfaW5kZXhfZmlsZSA9IGdldGVudigiR0lU
X0lOREVYX0ZJTEUiKTsKIAogCWlmICghb3JpZ2luYWxfaW5kZXhfZmlsZSkKLS0gCjEuNC4zLjMu
Z2IyODI4Cgo=
