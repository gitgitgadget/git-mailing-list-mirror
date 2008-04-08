From: "Kai Hendry" <hendry@aplixcorp.com>
Subject: Re: Integration branching
Date: Tue, 8 Apr 2008 14:56:53 +0100
Message-ID: <b24851260804080656u4c42c31cv3984fa2943d83b8a@mail.gmail.com>
References: <b24851260804070602o11b93923m7ce7d79d5f59547b@mail.gmail.com>
	 <7vod8lpnpb.fsf@gitster.siamese.dyndns.org>
	 <b24851260804071118h4eaadef8i8313c5a4cb26495d@mail.gmail.com>
	 <32541b130804071132q24acff6an853730af4fc7273e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1879_15818035.1207663013635"
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 15:58:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjEKV-0006tW-Gw
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 15:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbYDHN46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 09:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752324AbYDHN46
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 09:56:58 -0400
Received: from rn-out-0910.google.com ([64.233.170.187]:62863 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219AbYDHN45 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 09:56:57 -0400
Received: by rn-out-0910.google.com with SMTP id e11so2263438rng.17
        for <git@vger.kernel.org>; Tue, 08 Apr 2008 06:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:references:x-google-sender-auth;
        bh=cfefmM5RhzqyEv5KH79nemPN1oe6U+Jneli2w7S1Bhc=;
        b=C7N9H9248bLl4UP9ryeNbEwNPcSbVFf28saqSrNBq23DQnVX48/dqM/OBLpBvEaL0rI6e88KSRS4h/+TFWV1Sy5APbNmB8RLHkgYiUf6BUfDWB6CwZ+GzjL4/6Hvv7m/dy/j46buC6lnHdUsC45Zta8c0sX4+BDOx4NPv5zV+W4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:references:x-google-sender-auth;
        b=lTDdj5klyBzpmM9rhZf1FGhC0MUS/vfjNPW/z8KjY0MbVNwrJ6dlDpu5rnaBjdyyuuFTnScr9YknYAn28sCC2Tkfy+AV9a4cdNZkJVGLvWHnr8ptBi8QlQa8GJFKNNh0XNI9qcFDVbVp7MsOgWCxA9AKwzpRzlyGa61cZXhinVM=
Received: by 10.115.76.5 with SMTP id d5mr1369282wal.194.1207663013635;
        Tue, 08 Apr 2008 06:56:53 -0700 (PDT)
Received: by 10.114.136.13 with HTTP; Tue, 8 Apr 2008 06:56:53 -0700 (PDT)
In-Reply-To: <32541b130804071132q24acff6an853730af4fc7273e@mail.gmail.com>
X-Google-Sender-Auth: 514f32bdce2ce1ec
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78999>

------=_Part_1879_15818035.1207663013635
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Ok it makes sense that I need at least one checkout of all the
objects. But still it seems that when I branch and publish via http it
wants to upload zillions of objects.

For example see the attached webkit-http.txt log. I think there is
some bug in the http push transport as if the transport is ssh it's
much *much* faster:

x61:~/aplix/webkit-test/webkit% git-config remote.origin.url
ssh://git.webvm.net/srv/git/webkit
x61:~/aplix/webkit-test/webkit% git push origin deleteme
Counting objects: 5, done.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 289 bytes, done.
Total 3 (delta 2), reused 0 (delta 0)
To ssh://git.webvm.net/srv/git/webkit
 * [new branch]      deleteme -> deleteme
x61:~/aplix/webkit-test/webkit%

I need http:// to work as some of the engineers I work with are behind
a "corporate firewall" that doesn't allow ssh://. Crazy, I know.

------=_Part_1879_15818035.1207663013635
Content-Type: text/plain; name=webkit-http.txt
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fesj83ug0
Content-Disposition: attachment; filename=webkit-http.txt

eDYxOn4vYXBsaXgvd2Via2l0LXRlc3QlIGdpdCBjbG9uZSBnaXQ6Ly9naXQud2Vidm0ubmV0L3dl
YmtpdApJbml0aWFsaXplZCBlbXB0eSBHaXQgcmVwb3NpdG9yeSBpbiAvaG9tZS9oZW5kcnkvYXBs
aXgvd2Via2l0LXRlc3Qvd2Via2l0Ly5naXQvCnJlbW90ZTogQ291bnRpbmcgb2JqZWN0czogNDA2
MDQxLCBkb25lLgpyZW1vdGU6IENvbXByZXNzaW5nIG9iamVjdHM6IDEwMCUgKDk4MTM4Lzk4MTM4
KSwgZG9uZS4KcmVtb3RlOiBUb3RhbCA0MDYwNDEgKGRlbHRhIDI5NTY0MiksIHJldXNlZCAzOTg3
NjYgKGRlbHRhIDI4ODQwNykKUmVjZWl2aW5nIG9iamVjdHM6IDEwMCUgKDQwNjA0MS80MDYwNDEp
LCA0NDAuOTMgTWlCIHwgMjQ4NCBLaUIvcywgZG9uZS4KUmVzb2x2aW5nIGRlbHRhczogMTAwJSAo
Mjk1NjQyLzI5NTY0MiksIGRvbmUuCkNoZWNraW5nIG91dCBmaWxlczogMTAwJSAoNDQ3NTAvNDQ3
NTApLCBkb25lLgp4NjE6fi9hcGxpeC93ZWJraXQtdGVzdCUgbGwKdG90YWwgMTJLCmRyd3hyLXhy
LXggIDMgaGVuZHJ5IGhlbmRyeSA0LjBLIDIwMDgtMDQtMDggMTM6MzkgLi8KZHJ3eHIteHIteCAy
MCBoZW5kcnkgaGVuZHJ5IDQuMEsgMjAwOC0wNC0wOCAxMzoyMiAuLi8KZHJ3eHIteHIteCAxNSBo
ZW5kcnkgaGVuZHJ5IDQuMEsgMjAwOC0wNC0wOCAxMzo1NCB3ZWJraXQvCng2MTp+L2FwbGl4L3dl
YmtpdC10ZXN0JSBjZCB3ZWJraXQKeDYxOn4vYXBsaXgvd2Via2l0LXRlc3Qvd2Via2l0JSB2aW0g
LmdpdC9jb25maWcKeDYxOn4vYXBsaXgvd2Via2l0LXRlc3Qvd2Via2l0JSBnaXQtY29uZmlnIHJl
bW90ZS5vcmlnaW4udXJsIGh0dHA6Ly9tb3RvQG1vdG8ud2Vidm0ubmV0L3dlYmtpdC5naXQKeDYx
On4vYXBsaXgvd2Via2l0LXRlc3Qvd2Via2l0JSB2aW0gLmdpdC9jb25maWcKeDYxOn4vYXBsaXgv
d2Via2l0LXRlc3Qvd2Via2l0JSBsbAp0b3RhbCAyMjBLCmRyd3hyLXhyLXggMTUgaGVuZHJ5IGhl
bmRyeSA0LjBLIDIwMDgtMDQtMDggMTM6NTQgLi8KZHJ3eHIteHIteCAgMyBoZW5kcnkgaGVuZHJ5
IDQuMEsgMjAwOC0wNC0wOCAxMzozOSAuLi8KLXJ3eHIteHIteCAgMSBoZW5kcnkgaGVuZHJ5IDEu
NksgMjAwOC0wNC0wOCAxMzo1NCBhdXRvZ2VuLnNoKgpkcnd4ci14ci14IDEyIGhlbmRyeSBoZW5k
cnkgNC4wSyAyMDA4LTA0LTA4IDEzOjU0IEJ1Z3NTaXRlLwotcnctci0tci0tICAxIGhlbmRyeSBo
ZW5kcnkgMTA0SyAyMDA4LTA0LTA4IDEzOjU0IENoYW5nZUxvZwotcnctci0tci0tICAxIGhlbmRy
eSBoZW5kcnkgIDE5SyAyMDA4LTA0LTA4IDEzOjU0IGNvbmZpZ3VyZS5hYwpkcnd4ci14ci14ICA4
IGhlbmRyeSBoZW5kcnkgNC4wSyAyMDA4LTA0LTA4IDE0OjM0IC5naXQvCi1ydy1yLS1yLS0gIDEg
aGVuZHJ5IGhlbmRyeSA5LjZLIDIwMDgtMDQtMDggMTM6NTQgR05VbWFrZWZpbGUuYW0KZHJ3eHIt
eHIteCAxMyBoZW5kcnkgaGVuZHJ5IDQuMEsgMjAwOC0wNC0wOCAxMzo1NCBKYXZhU2NyaXB0Q29y
ZS8KZHJ3eHIteHIteCAgNyBoZW5kcnkgaGVuZHJ5IDQuMEsgMjAwOC0wNC0wOCAxMzo1NCBKYXZh
U2NyaXB0R2x1ZS8KZHJ3eHIteHIteCAxOCBoZW5kcnkgaGVuZHJ5IDQuMEsgMjAwOC0wNC0wOCAx
Mzo1NCBMYXlvdXRUZXN0cy8KLXJ3LXItLXItLSAgMSBoZW5kcnkgaGVuZHJ5IDEuMUsgMjAwOC0w
NC0wOCAxMzo1NCBNYWtlZmlsZQotcnctci0tci0tICAxIGhlbmRyeSBoZW5kcnkgMS4xSyAyMDA4
LTA0LTA4IDEzOjU0IE1ha2VmaWxlLnNoYXJlZApkcnd4ci14ci14ICAzIGhlbmRyeSBoZW5kcnkg
NC4wSyAyMDA4LTA0LTA4IDEzOjU0IFBhZ2VMb2FkVGVzdHMvCmRyd3hyLXhyLXggIDUgaGVuZHJ5
IGhlbmRyeSA0LjBLIDIwMDgtMDQtMDggMTM6NTQgUGxhbmV0V2ViS2l0Lwpkcnd4ci14ci14ICA1
IGhlbmRyeSBoZW5kcnkgNC4wSyAyMDA4LTA0LTA4IDEzOjU0IFN1blNwaWRlci8KZHJ3eHIteHIt
eCAyNSBoZW5kcnkgaGVuZHJ5IDQuMEsgMjAwOC0wNC0wOCAxMzo1NCBXZWJDb3JlLwpkcnd4ci14
ci14ICA5IGhlbmRyeSBoZW5kcnkgNC4wSyAyMDA4LTA0LTA4IDEzOjU0IFdlYktpdC8KZHJ3eHIt
eHIteCAgNCBoZW5kcnkgaGVuZHJ5IDQuMEsgMjAwOC0wNC0wOCAxMzo1NCBXZWJLaXRMaWJyYXJp
ZXMvCi1ydy1yLS1yLS0gIDEgaGVuZHJ5IGhlbmRyeSAzLjNLIDIwMDgtMDQtMDggMTM6NTQgV2Vi
S2l0LnByaQotcnctci0tci0tICAxIGhlbmRyeSBoZW5kcnkgIDQ3NCAyMDA4LTA0LTA4IDEzOjU0
IFdlYktpdC5wcm8KZHJ3eHIteHIteCAxNCBoZW5kcnkgaGVuZHJ5IDQuMEsgMjAwOC0wNC0wOCAx
Mzo1NCBXZWJLaXRTaXRlLwpkcnd4ci14ci14IDE5IGhlbmRyeSBoZW5kcnkgNC4wSyAyMDA4LTA0
LTA4IDEzOjU0IFdlYktpdFRvb2xzLwp4NjE6fi9hcGxpeC93ZWJraXQtdGVzdC93ZWJraXQlIGdp
dCBjaGVja291dCAtYiBkZWxldGVtZQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggImRlbGV0ZW1l
Igp4NjE6fi9hcGxpeC93ZWJraXQtdGVzdC93ZWJraXQlIHZpbSBDaGFuZ2VMb2cKeDYxOn4vYXBs
aXgvd2Via2l0LXRlc3Qvd2Via2l0JSBnaXQgY2kKQ3JlYXRlZCBjb21taXQgNGI1NjQyNTogVGVz
dAogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCng2MTp+
L2FwbGl4L3dlYmtpdC10ZXN0L3dlYmtpdCUgZ2l0IHB1c2ggb3JpZ2luIGRlbGV0ZW1lCkZldGNo
aW5nIHJlbW90ZSBoZWFkcy4uLgogIHJlZnMvCiAgcmVmcy9oZWFkcy8KICByZWZzL2hlYWRzL29y
aWdpbi8KICByZWZzL3JlbW90ZXMvCiAgcmVmcy9yZW1vdGVzL3dlYmtpdC8KICByZWZzL3JlbW90
ZXMvb3JpZ2luLwogIHJlZnMvcmVtb3Rlcy9kZWJpYW4vCiAgcmVmcy90YWdzLwp1cGRhdGluZyAn
cmVmcy9oZWFkcy9kZWxldGVtZScKICBmcm9tIDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAKICB0byAgIDRiNTY0MjU0MWE3M2YxMDVjZjZlOTliMGIwYzRlZTAwZjBiODY5
YzIKICAgIHNlbmRpbmcgMjkyNTcgb2JqZWN0cwo=
------=_Part_1879_15818035.1207663013635--
