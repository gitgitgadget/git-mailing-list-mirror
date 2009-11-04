From: Gisle Aas <gisle@aas.no>
Subject: Re: [PATCH] More precise description of 'git describe --abbrev'
Date: Wed, 4 Nov 2009 23:04:56 +0100
Message-ID: <b48ea8a00911041404p2f176763kcc022249deab23a9@mail.gmail.com>
References: <b48ea8a00910291438r8b66a0fq9e821393ecfff0bf@mail.gmail.com>
	 <m2my38fxeo.fsf@igel.home> <7vmy38im51.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001485f79366168c92047792cdd9
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 23:05:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5nyS-0006yw-DD
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 23:05:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758266AbZKDWEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 17:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758261AbZKDWEx
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 17:04:53 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:39633 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758252AbZKDWEw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 17:04:52 -0500
Received: by ewy3 with SMTP id 3so3644661ewy.37
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 14:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type;
        bh=N3TJwok+y5VJ7KZaSPRbEih1SYQYoyLgbBR0q00bBK8=;
        b=wdBnJNQUT/FCkhHTyUNuUCJO5kqy+Pnv+yRHtuCp4rwWPOPsuwaRXDy+Oaq/xppbuE
         Jjc9gjr8w2Fqwi20mHahhEg2Tqd/oOo9Kf/YfeybyxQc7kEzQCcpbxZ/eyDMBiGIYBFP
         6KIWIT8XDcvGoa3Kg9GWgcsMwM3lXwbUoCVVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=JIcUhlLx9DSCrP1SnqQn5Hij2odRP0W6adIS9beBjEmWnBrO5DpQAuXfdnqWzgmW9c
         EY3mCv0c3iR7HyX+qjHNhWa9HA/nbJK5PSmw5djXlQd5fE1ez/QiU4hAXBBMC7/Ov1Gr
         sGA8sBvUcNJP4g1Fgliose8CI6KMYsltsNW/s=
Received: by 10.239.184.157 with SMTP id y29mr241092hbg.54.1257372296579; Wed, 
	04 Nov 2009 14:04:56 -0800 (PST)
In-Reply-To: <7vmy38im51.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 25da21dd0bb4b3c8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132159>

--001485f79366168c92047792cdd9
Content-Type: text/plain; charset=UTF-8

Unfortunately there was still a grammar typo in that patch:

--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -120,7 +120,7 @@ closest tagname without any suffix:
        tags/v1.0.0

 Note that the suffix you get if you type these commands today may be
-longer than what Linus saw above when he ran this command, as your
+longer than what Linus saw above when he ran these commands, as your
 git repository may have new commits whose object names begin with
 975b that did not exist back then, and "-g975b" suffix alone may not
 be sufficient to disambiguate these commits.

--001485f79366168c92047792cdd9
Content-Type: application/octet-stream; 
	name="0001-Fix-documentation-grammar-typo.patch"
Content-Disposition: attachment; 
	filename="0001-Fix-documentation-grammar-typo.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g1mmvm090

RnJvbSA4OTEwZWVkNDhmMGM0YzUzYWYxYjc0ZDAwMTZlZjc3MmJkY2U1Njg5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHaXNsZSBBYXMgPGdpc2xlQGFhcy5ubz4KRGF0ZTogV2VkLCA0
IE5vdiAyMDA5IDIyOjU3OjQ2ICswMTAwClN1YmplY3Q6IFtQQVRDSF0gRml4IGRvY3VtZW50YXRp
b24gZ3JhbW1hciB0eXBvCgpJbnRyb2R1Y2VkIGluIGNvbW1pdCA0OTJjZjNmNzJmOWQ4Li4uCgpT
aWduZWQtb2ZmLWJ5OiBHaXNsZSBBYXMgPGdpc2xlQGFhcy5ubz4KLS0tCiBEb2N1bWVudGF0aW9u
L2dpdC1kZXNjcmliZS50eHQgfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2dpdC1kZXNj
cmliZS50eHQgYi9Eb2N1bWVudGF0aW9uL2dpdC1kZXNjcmliZS50eHQKaW5kZXggZTlkYmNhNy4u
MmY5NzkxNiAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlvbi9naXQtZGVzY3JpYmUudHh0CisrKyBi
L0RvY3VtZW50YXRpb24vZ2l0LWRlc2NyaWJlLnR4dApAQCAtMTIwLDcgKzEyMCw3IEBAIGNsb3Nl
c3QgdGFnbmFtZSB3aXRob3V0IGFueSBzdWZmaXg6CiAJdGFncy92MS4wLjAKIAogTm90ZSB0aGF0
IHRoZSBzdWZmaXggeW91IGdldCBpZiB5b3UgdHlwZSB0aGVzZSBjb21tYW5kcyB0b2RheSBtYXkg
YmUKLWxvbmdlciB0aGFuIHdoYXQgTGludXMgc2F3IGFib3ZlIHdoZW4gaGUgcmFuIHRoaXMgY29t
bWFuZCwgYXMgeW91cgorbG9uZ2VyIHRoYW4gd2hhdCBMaW51cyBzYXcgYWJvdmUgd2hlbiBoZSBy
YW4gdGhlc2UgY29tbWFuZHMsIGFzIHlvdXIKIGdpdCByZXBvc2l0b3J5IG1heSBoYXZlIG5ldyBj
b21taXRzIHdob3NlIG9iamVjdCBuYW1lcyBiZWdpbiB3aXRoCiA5NzViIHRoYXQgZGlkIG5vdCBl
eGlzdCBiYWNrIHRoZW4sIGFuZCAiLWc5NzViIiBzdWZmaXggYWxvbmUgbWF5IG5vdAogYmUgc3Vm
ZmljaWVudCB0byBkaXNhbWJpZ3VhdGUgdGhlc2UgY29tbWl0cy4KLS0gCjEuNi4yLjk1Lmc5MzRm
NwoK
--001485f79366168c92047792cdd9--
