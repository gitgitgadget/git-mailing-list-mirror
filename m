From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: [PATCH (GITK)] gitk: Fix transient windows on Win32 and MacOS.
Date: Wed, 12 Nov 2008 13:36:48 +0300
Message-ID: <bb6f213e0811120236j7c65bfe4xf95f88df440cbafb@mail.gmail.com>
References: <200811112355.43352.angavrilov@gmail.com>
	 <491A827C.3010000@viscovery.net>
	 <18714.36964.666759.654975@cargo.ozlabs.ibm.com>
	 <491A9398.1060100@viscovery.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_4398_8467751.1226486208519"
Cc: "Paul Mackerras" <paulus@samba.org>, git@vger.kernel.org
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 12 11:38:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0D6s-0008K7-GS
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 11:38:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbYKLKgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 05:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbYKLKgv
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 05:36:51 -0500
Received: from wf-out-1314.google.com ([209.85.200.174]:62821 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbYKLKgu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 05:36:50 -0500
Received: by wf-out-1314.google.com with SMTP id 27so366461wfd.4
        for <git@vger.kernel.org>; Wed, 12 Nov 2008 02:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type:references;
        bh=0BiFq13T8IFGSANQyZ83YGIHvNsPFVWOfyMD2zeda58=;
        b=ZASOShY0So9E+jfGdWdAbB2k/kLWwOPFvfXa35gwNrZ4qmHKKNYDMkdlME/SVwVatt
         HfCWMmzhmaa3DVuJfm7VTsIutpoLVl4AUJgbhcos2UwpL3jix191Vy1a3sIDBw7l51G7
         01eg0sgChC38KzK7PCFpUMWJz4zDuUpTN3I+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:references;
        b=NrwDPN0r1XVQ5Z/JZ0sSiZA2uKEvTzoWdp0LcG4HIbymx77/I7TjLL2gQ5B41LCBoE
         giXWwKa6jJHMWq7ZvHP/h4I//Pp5yLNGRYTbBFauRhG8KtkyxjSS0GIfcxyRgOW1qmnE
         tfmRzFt3TWYymGPckLzPFAQHjk2zeEXKg023U=
Received: by 10.142.238.12 with SMTP id l12mr3461081wfh.222.1226486208506;
        Wed, 12 Nov 2008 02:36:48 -0800 (PST)
Received: by 10.142.216.21 with HTTP; Wed, 12 Nov 2008 02:36:48 -0800 (PST)
In-Reply-To: <491A9398.1060100@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100738>

------=_Part_4398_8467751.1226486208519
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, Nov 12, 2008 at 11:28 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> I assume that Alexander has another patch applied in addition to the one
> that he submitted, which, therefore, is no longer "based on a publically
> available version".

I'm sorry, it is indeed applied over another patch (attached because I
only have access to Gmail Web UI right now). These patches eventually
come from two ends of one long series that has been gradually applied
over the time, so I still think of them as a unit.

Alexander

------=_Part_4398_8467751.1226486208519
Content-Type: text/x-patch;
 name=0001-gitk-Add-accelerators-to-frequently-used-menu-comma.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fnftyp710
Content-Disposition: attachment;
 filename=0001-gitk-Add-accelerators-to-frequently-used-menu-comma.patch

RnJvbSBmYzZiMzcyOGUxNTQ4MzczNGVlNDRhMzVkNTAyMzY2MGE3ZGE4ODgyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4YW5kZXIgR2F2cmlsb3YgPGFuZ2F2cmlsb3ZAZ21haWwu
Y29tPgpEYXRlOiBTdW4sIDkgTm92IDIwMDggMTM6MDA6NDUgKzAzMDAKU3ViamVjdDogW1BBVENI
XSBnaXRrOiBBZGQgYWNjZWxlcmF0b3JzIHRvIGZyZXF1ZW50bHkgdXNlZCBtZW51IGNvbW1hbmRz
LgoKVGhpcyBjb21taXQgZG9jdW1lbnRzIGtleWJvYXJkIGFjY2VsZXJhdG9ycyB1c2VkIGZvciBt
ZW51CmNvbW1hbmRzIGluIHRoZSBtZW51LCBhcyBpdCBpcyB1c3VhbGx5IGRvbmUsIGFuZCBhZGRz
IHNvbWUKbW9yZSwgZS5nLiBGNCB0byBpbnZva2UgRWRpdCBWaWV3LgoKVGhlIGNoYW5nZXMgaW5j
bHVkZSBhIHdvcmthcm91bmQgZm9yIGhhbmRsaW5nIFNoaWZ0LUY0IG9uCnN5c3RlbXMgd2hlcmUg
WEtCIGJpbmRzIHNwZWNpYWwgWEY4Nl9Td2l0Y2hfVlRfKiBzeW1ib2xzCnRvIEN0cmwtQWx0LUYq
IGNvbWJpbmF0aW9ucy4gVGsgb2Z0ZW4gcmVjZWl2ZXMgdGhlc2UgY29kZXMKd2hlbiBTaGlmdC1G
KiBpcyBwcmVzc2VkLCBzbyBpdCBpcyBuZWNlc3NhcnkgdG8gYmluZCB0aGUKcmVsZXZhbnQgYWN0
aW9ucyB0byB0aGVtIGFzIHdlbGwuCgpTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgR2F2cmlsb3Yg
PGFuZ2F2cmlsb3ZAZ21haWwuY29tPgotLS0KIGdpdGsgfCAgIDM2ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCA3
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2dpdGsgYi9naXRrCmluZGV4IDE4ZDE1M2UuLjli
MmE2ZTUgMTAwNzU1Ci0tLSBhL2dpdGsKKysrIGIvZ2l0awpAQCAtMTgwMSw2ICsxODAxLDExIEBA
IHByb2Mgc2V0b3B0aW9ucyB7fSB7CiAjIGNvbW1hbmQgdG8gaW52b2tlIGZvciBjb21tYW5kLCBv
ciB7dmFyaWFibGUgdmFsdWV9IGZvciByYWRpb2J1dHRvbgogcHJvYyBtYWtlbWVudSB7bSBpdGVt
c30gewogICAgIG1lbnUgJG0KKyAgICBpZiB7W3RrIHdpbmRvd2luZ3N5c3RlbV0gZXEge2FxdWF9
fSB7CisJc2V0IE1ldGExIENtZAorICAgIH0gZWxzZSB7CisJc2V0IE1ldGExIEN0cmwKKyAgICB9
CiAgICAgZm9yZWFjaCBpICRpdGVtcyB7CiAJc2V0IG5hbWUgW21jIFtsaW5kZXggJGkgMV1dCiAJ
c2V0IHR5cGUgW2xpbmRleCAkaSAyXQpAQCAtMTgyNiw3ICsxODMxLDkgQEAgcHJvYyBtYWtlbWVu
dSB7bSBpdGVtc30gewogCQkgICAgLXZhbHVlIFtsaW5kZXggJHRoaW5nIDFdCiAJICAgIH0KIAl9
Ci0JZXZhbCAkbSBhZGQgJHBhcmFtcyBbbHJhbmdlICRpIDQgZW5kXQorCXNldCB0YWlsIFtscmFu
Z2UgJGkgNCBlbmRdCisJcmVnc3ViIC1hbGwge1x5TWV0YTFceX0gJHRhaWwgJE1ldGExIHRhaWwK
KwlldmFsICRtIGFkZCAkcGFyYW1zICR0YWlsCiAJaWYgeyR0eXBlIGVxICJjYXNjYWRlIn0gewog
CSAgICBtYWtlbWVudSAkbS4kc3VibWVudSAkdGhpbmcKIAl9CkBAIC0xODYwLDE3ICsxODY3LDE3
IEBAIHByb2MgbWFrZXdpbmRvdyB7fSB7CiAgICAgbWFrZW1lbnUgLmJhciB7CiAJe21jICJGaWxl
IiBjYXNjYWRlIHsKIAkgICAge21jICJVcGRhdGUiIGNvbW1hbmQgdXBkYXRlY29tbWl0cyAtYWNj
ZWxlcmF0b3IgRjV9Ci0JICAgIHttYyAiUmVsb2FkIiBjb21tYW5kIHJlbG9hZGNvbW1pdHN9CisJ
ICAgIHttYyAiUmVsb2FkIiBjb21tYW5kIHJlbG9hZGNvbW1pdHMgLWFjY2VsZXJhdG9yIE1ldGEx
LUY1fQogCSAgICB7bWMgIlJlcmVhZCByZWZlcmVuY2VzIiBjb21tYW5kIHJlcmVhZHJlZnN9Ci0J
ICAgIHttYyAiTGlzdCByZWZlcmVuY2VzIiBjb21tYW5kIHNob3dyZWZzfQotCSAgICB7bWMgIlF1
aXQiIGNvbW1hbmQgZG9xdWl0fQorCSAgICB7bWMgIkxpc3QgcmVmZXJlbmNlcyIgY29tbWFuZCBz
aG93cmVmcyAtYWNjZWxlcmF0b3IgRjJ9CisJICAgIHttYyAiUXVpdCIgY29tbWFuZCBkb3F1aXQg
LWFjY2VsZXJhdG9yIE1ldGExLVF9CiAJfX0KIAl7bWMgIkVkaXQiIGNhc2NhZGUgewogCSAgICB7
bWMgIlByZWZlcmVuY2VzIiBjb21tYW5kIGRvcHJlZnN9CiAJfX0KIAl7bWMgIlZpZXciIGNhc2Nh
ZGUgewotCSAgICB7bWMgIk5ldyB2aWV3Li4uIiBjb21tYW5kIHtuZXd2aWV3IDB9fQotCSAgICB7
bWMgIkVkaXQgdmlldy4uLiIgY29tbWFuZCBlZGl0dmlldyAtc3RhdGUgZGlzYWJsZWR9CisJICAg
IHttYyAiTmV3IHZpZXcuLi4iIGNvbW1hbmQge25ld3ZpZXcgMH0gLWFjY2VsZXJhdG9yIFNoaWZ0
LUY0fQorCSAgICB7bWMgIkVkaXQgdmlldy4uLiIgY29tbWFuZCBlZGl0dmlldyAtc3RhdGUgZGlz
YWJsZWQgLWFjY2VsZXJhdG9yIEY0fQogCSAgICB7bWMgIkRlbGV0ZSB2aWV3IiBjb21tYW5kIGRl
bHZpZXcgLXN0YXRlIGRpc2FibGVkfQogCSAgICB7eHggIiIgc2VwYXJhdG9yfQogCSAgICB7bWMg
IkFsbCBmaWxlcyIgcmFkaW9idXR0b24ge3NlbGVjdGVkdmlldyAwfSAtY29tbWFuZCB7c2hvd3Zp
ZXcgMH19CkBAIC0yMjMyLDcgKzIyMzksMTIgQEAgcHJvYyBtYWtld2luZG93IHt9IHsKICAgICBi
aW5ka2V5IDxLZXktUmV0dXJuPiB7ZG9maW5kIDEgMX0KICAgICBiaW5ka2V5ID8ge2RvZmluZCAt
MSAxfQogICAgIGJpbmRrZXkgZiBuZXh0ZmlsZQotICAgIGJpbmRrZXkgPEY1PiB1cGRhdGVjb21t
aXRzCisgICAgYmluZCAuIDxGNT4gdXBkYXRlY29tbWl0cworICAgIGJpbmQgLiA8JE0xQi1GNT4g
cmVsb2FkY29tbWl0cworICAgIGJpbmQgLiA8RjI+IHNob3dyZWZzCisgICAgYmluZCAuIDxTaGlm
dC1GND4ge25ld3ZpZXcgMH0KKyAgICBjYXRjaCB7IGJpbmQgLiA8U2hpZnQtS2V5LVhGODZfU3dp
dGNoX1ZUXzQ+IHtuZXd2aWV3IDB9IH0KKyAgICBiaW5kIC4gPEY0PiBlZGl0X29yX25ld3ZpZXcK
ICAgICBiaW5kIC4gPCRNMUItcT4gZG9xdWl0CiAgICAgYmluZCAuIDwkTTFCLWY+IHtkb2ZpbmQg
MSAxfQogICAgIGJpbmQgLiA8JE0xQi1nPiB7ZG9maW5kIDEgMH0KQEAgLTM2MjQsNiArMzYzNiwx
NiBAQCBwcm9jIGRlY29kZV92aWV3X29wdHMge24gdmlld19hcmdzfSB7CiAgICAgc2V0IG5ld3Zp
ZXdvcHRzKCRuLGFyZ3MpIFtzaGVsbGFyZ2xpc3QgJG9hcmdzXQogfQogCitwcm9jIGVkaXRfb3Jf
bmV3dmlldyB7fSB7CisgICAgZ2xvYmFsIGN1cnZpZXcKKworICAgIGlmIHskY3VydmlldyA+IDB9
IHsKKwllZGl0dmlldworICAgIH0gZWxzZSB7CisJbmV3dmlldyAwCisgICAgfQorfQorCiBwcm9j
IGVkaXR2aWV3IHt9IHsKICAgICBnbG9iYWwgY3VydmlldwogICAgIGdsb2JhbCB2aWV3bmFtZSB2
aWV3cGVybSBuZXd2aWV3bmFtZSBuZXd2aWV3b3B0cwotLSAKMS42LjAuMi5HSVQKCg==
------=_Part_4398_8467751.1226486208519--
