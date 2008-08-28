From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [QGIT RFC] Unit tests for QGit
Date: Thu, 28 Aug 2008 20:54:44 +0200
Message-ID: <e5bfff550808281154h67392297y3a08d4ed8aea408f@mail.gmail.com>
References: <20080808211318.GA4396@efreet.light.src>
	 <e5bfff550808170846y522cc6a8w59b696be39df311b@mail.gmail.com>
	 <20080817195839.GB4542@efreet.light.src>
	 <e5bfff550808171330w28dda6a2m32b0e51b1ef73cdc@mail.gmail.com>
	 <20080818180048.GA15520@efreet.light.src>
	 <e5bfff550808190753t4f99ddb6q83886dbca27dbf03@mail.gmail.com>
	 <20080827201819.GD15520@efreet.light.src>
	 <e5bfff550808280429h63496f9byfa4454af7adb0e86@mail.gmail.com>
	 <20080828153118.GA13169@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Jan Hudec" <bulb@ucw.cz>, git@vger.kernel.org
To: "=?UTF-8?Q?Karl_Hasselstr=C3=B6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 20:57:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYmeu-0003ia-O0
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 20:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948AbYH1Syq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 14:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752818AbYH1Syq
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 14:54:46 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:53494 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbYH1Syp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 14:54:45 -0400
Received: by wa-out-1112.google.com with SMTP id j37so249332waf.23
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 11:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=9G8plwlPqWqPioFjcBegeNWyI4r+HsEx8NCd9kbg8Ik=;
        b=huFydSNmBwqS9BIbl8KVdiY90dX6QpqTkbUgKxq5iuKy5VOo9OzCI+nj7tMiZcv4zb
         tstrL1dsqa7GM8cZVVSoy+uifUUDrfVT2AD2w/lDDRKNq1KHWgiZPoQRUNOWORaejnGM
         jkocjaMDHZLyv369jXD3r1+rCIBCxW3VipA7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=lwzbtPxo2o9GO0Mk7JHdJYBpTDeAHPGRWo7kmC4YhgEDayrY7f20CgRTzwfdNiFTpY
         NF6gJqFO5+JVTStLd8ffkwN2JMFNPpUscu9Wd7M+1zglKQzzBBuVLJZ2lDOuPKc9u1jP
         CB4rGTSbYOkQBKeN0eLpCeYm9iWd4HZK2XrLs=
Received: by 10.114.25.19 with SMTP id 19mr1773680way.225.1219949685056;
        Thu, 28 Aug 2008 11:54:45 -0700 (PDT)
Received: by 10.114.174.5 with HTTP; Thu, 28 Aug 2008 11:54:44 -0700 (PDT)
In-Reply-To: <20080828153118.GA13169@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94114>

T24gVGh1LCBBdWcgMjgsIDIwMDggYXQgNTozMSBQTSwgS2FybCBIYXNzZWxzdHLDtm0gPGtoYUB0
cmVza2FsLmNvbT4gd3JvdGU6Cj4KPiBTdEdpdCBoYXMgbm8gcGVyLXJlcG8gZGF0YS4gSXQncyBh
bGwgcGVyLWJyYW5jaC4gInN0ZyBpbml0IiBvcGVyYXRlcwo+IG9uIHRoZSBjdXJyZW50IGJyYW5j
aCwgbm90IHRoZSB3aG9sZSByZXBvLgo+CgpPay4gVGhhbmtzLiBJbiB0aGlzIGNhc2UgdGhlIGNo
ZWNrIHFnaXQgZG9lcyBpcyBicm9rZW4sIGFuZCBJIHRoaW5rCm5vdCBvbmx5IHRoYXQgYmVjYXVz
ZSBJIG5ldmVyIGhhZCB0aGlzIHBvaW50IGNsZWFyIHdoaWxlIGRldmVsb3BpbmcKdGhlIGludGVy
ZmFjZS4KCj4KPiBIbW0uIEZvciBtZSwgInN0ZyBicmFuY2giIHN1Y2NlZWRzIGV2ZW4gaWYgInN0
ZyBpbml0IiBoYXMgbm90IHlldCBiZWVuCj4gcnVuICh3aGljaCBpcyBhcmd1YWJseSBhcyBpdCBz
aG91bGQgYmUsIHNpbmNlIGl0IGRvZXNuJ3QgcmVxdWlyZSB0aGF0Cj4gc3RnIGluaXQgaGFzIGJl
ZW4gcnVuIGluIHRoZSBjdXJyZW50IGJyYW5jaCkuICJzdGcgc2VyaWVzIiBvcgo+IHNvbWV0aGlu
ZyBpcyBwcm9iYWJseSBiZXR0ZXIgZm9yIHRoaXMgcHVycG9zZS4KPgoKQnV0IGlmIEkgcnVuICdz
dGcgYnJhbmNoJyBpbiBhIGdpdC1vbmx5IHJlcG8gdGhpcyBnaXZlcyBhbiBlcnJvci4gVGhpcwpj
b25kaXRpb25zLCBhdCBsZWFzdCB1bnRpbCBub3csIGhhcyBhbHdheXMgYmVlbiB3b3JraW5nIGZv
ciBtZS4KCgo+IFRob3VnaCBpZiB5b3UncmUgY29uY2VybmVkIGFib3V0IHNwZWVkIChhcyB0aGUg
Y29tbWVudCBpbmRpY2F0ZXMpLCB5b3UKPiBzaG91bGQgcHJvYmFibHkgZG8gc29tZXRoaW5nIGNo
ZWFwZXIgdGhhbiBydW5uaW5nIHN0Zywgc3VjaCBhcwo+IGNoZWNraW5nIGlmIC5naXQvcGF0Y2hl
cy88YnJhbmNobmFtZT4gZXhpc3RzLgo+CgpBY3R1YWxseSB0aGUgYWN0dWFsIGNvZGUgY2h1bmsg
aXM6CgogICAgICAgIC8vIGNoZWNrIGZvciBhIFN0R0lUIHN0YWNrCiAgICAgICAgIFFEaXIgZCA9
IGdpdERpcjsKCiAgICAgICAgIGlmIChkLmV4aXN0cygicGF0Y2hlcyIpKSB7IC8vIGVhcmx5IHNr
aXAKCiAgICAgICAgICAgICAgICAgaXNTdEdJVCA9IHJ1bigic3RnIGJyYW5jaCIsICZzdGdDdXJC
cmFuY2gpOyAvLyBzbG93IGNvbW1hbmQKCiAgICAgICAgICAgICAgICAgc3RnQ3VyQnJhbmNoID0g
c3RnQ3VyQnJhbmNoLnRyaW1tZWQoKTsKICAgICAgICAgfSBlbHNlCiAgICAgICAgICAgICAgICAg
aXNTdEdJVCA9IGZhbHNlOwoKCgpJbmRlZWQgSSBuZWVkIHRoZSBTdGdpdCBjdXJyZW50IGJyYW5j
aCBuYW1lIHRvIGZpbHRlciBvdXQgdGhlIHJlZnMKZm91bmQgd2l0aCBhIGZvbGxvd2luZyAiZ2l0
IHNob3ctcmVmIC1kIiBjb21tYW5kOgoKVGhlIGNvZGUgY2h1bmsgaXMgYWN0dWFsbHkKCi8vIHJ1
biB0aGUgY29tbWFuZCBhbmQgc2F2ZSBvdXRwdXQgaW4gcnVuT3V0cHQKaWYgKCFydW4oImdpdCBz
aG93LXJlZiAtZCIsICZydW5PdXRwdXQpKQogICAgICAgcmV0dXJuIGZhbHNlOwoKUVN0cmluZ0xp
c3QgcmVmc0xpc3QgPSBydW5PdXRwdXQuc3BsaXQoJ1xuJywgUVN0cmluZzo6U2tpcEVtcHR5UGFy
dHMpOwoKRk9SRUFDSF9TTCAoaXQsIHJlZnNMaXN0KSB7CgogICAgICBRU3RyaW5nIHJldlNoYSA9
ICgqaXQpLmxlZnQoNDApOwogICAgICBRU3RyaW5nIHJlZk5hbWUgPSAoKml0KS5taWQoNDEpOwoK
ICAgICAgLy8gc2F2ZSBTdEdJVCBwYXRjaCBzaGEsIHRvIGJlIHVzZWQgbGF0ZXIKICAgICAgaWYg
KHJlZk5hbWUuc3RhcnRzV2l0aCgicmVmcy9wYXRjaGVzLyIgKyBzdGdDdXJCcmFuY2ggKyAiLyIp
KSB7CgogICAgICAgICAgICAgIC4uLi4gd2UgaGF2ZSBmb3VuZCBhIHJlZmVyZW5jZSB0byBhIFN0
R2l0IHBhdGNoIG9mCmN1cnJlbnQgYnJhbmNoIC4uLgogICAgICB9CgouLi4uLi4KCn0KCgoKPj4g
U28gaXQncyBub3QgdmVyeSBjbGVhciB0byBtZSB3aGF0IGRvZXMgaXQgbWVhbiAic3dpdGNoaW5n
IGZyb20KPj4gbm9uLXN0Z2l0IGJyYW5jaCB0byBhIHN0Z2l0IG9uZSIKPgo+IFN3aXRjaGluZyBm
cm9tIGEgYnJhbmNoIHdoZXJlICJzdGcgaW5pdCIgaGFzbid0IGJlZW4gcnVuLCB0byBvbmUgd2hl
cmUKPiBpdCBoYXMuCj4KClRoYW5rcyBhZ2Fpbi4gSSBkb24ndCBrbm93IHdoeSBidXQgSSB3YXMg
c29tZWhvdyBzdGlja2VkIHRvIHRoZSBpZGVhCnRoYXQgJ3N0ZyBpbml0JyB3YXMgYmVoYXZpbmcg
c2ltaWxhciB0byAnZ2l0IGluaXQnLCBpLmUuIHlvdSBuZWVkIHRvCnJ1biBpdCBvbmx5IG9uY2Ug
cGVyIHJlcG8uCgpNYXJjbwo=
