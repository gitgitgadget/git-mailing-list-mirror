From: Baz <brian.ewins@gmail.com>
Subject: Re: [PATCH 3/3] Adds a #!bash to the top of bash completions so that editors can recognize, it as a bash script. Also adds a few simple comments above commands that, take arguments. The comments are meant to remind editors of potential, problems that
Date: Fri, 16 Jan 2009 15:06:34 +0000
Message-ID: <2faad3050901160706y297a98d4r35340e4811ca3d2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "=?UTF-8?Q?Adeodato_Sim=C3=B3?=" <dato@net.com.org.es>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Ted Pavlic" <ted@tedpavlic.com>, git <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Fri Jan 16 16:08:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNqIl-0008MX-Uj
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 16:08:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758272AbZAPPGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 10:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755025AbZAPPGi
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 10:06:38 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:36519 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbZAPPGh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 10:06:37 -0500
Received: by bwz14 with SMTP id 14so5142999bwz.13
        for <git@vger.kernel.org>; Fri, 16 Jan 2009 07:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=z2W+S3z78K4JUxUOpq8VCaLXeiyPvT+dWMh81qZV6iY=;
        b=rA449kh1QsNeTpvcLgRfmXnNm2byKNyCUhVEhTC9qA1tUUpnuUNQjADrPoa1CNmWm2
         zcF8eslVgUDOFUIqnZhiww1GQruOjwAmKakMedrokOci7YWhtxcIRKgxTP2XTq8ST/tL
         GGbiw/qEDhcUd1DDAexlZi6UviX9+YN3oP2JQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=cgkxGTFK+qjERd9YDD6bMC2u7Pjf8rF6Spkp1giVdpodX4TVYIVL+8XzY0SKGGSp2N
         AEFMbScPCC6FrTYZtOTVy/SEIiemvR0uI5RWeZ0qbmwLnSwLaGS1Mg9D2XG5gd12m7Sx
         zskJ6yBVckSIYVtQEDWk4V2aTSCjSYRWBPqMY=
Received: by 10.223.111.134 with SMTP id s6mr800235fap.60.1232118395001;
        Fri, 16 Jan 2009 07:06:35 -0800 (PST)
Received: by 10.223.105.16 with HTTP; Fri, 16 Jan 2009 07:06:34 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105965>

MjAwOS8xLzE1IE1hcmt1cyBIZWlkZWxiZXJnIDxtYXJrdXMuaGVpZGVsYmVyZ0B3ZWIuZGU+Ogo+
IEFkZW9kYXRvIFNpbcOzLCAxMy4wMS4yMDA5Ogo+PiAqIEJveWQgU3RlcGhlbiBTbWl0aCBKci4g
W1R1ZSwgMTMgSmFuIDIwMDkgMTQ6MDM6MTEgLTA2MDBdOgo+Pgo+PiA+IE9uIFR1ZXNkYXkgMjAw
OSBKYW51YXJ5IDEzIDEwOjQ1OjE4IFNoYXduIE8uIFBlYXJjZSB3cm90ZToKPj4gPiA+U2VlIFsu
Li5dIGhvdyB0aGUgc3ViamVjdCBpcyBhIG5pY2VzaG9ydCwgb25lCj4+ID4gPmxpbmUgc3VtbWFy
eSBvZiB0aGUgbW9kdWxlIGltcGFjdGVkIGFuZCB0aGUgY2hhbmdlPwo+Pgo+PiA+IE15IHJ1bGUg
Zm9yIHRoaXMgaXMgYWJzb2x1dGVseSBubyBtb3JlIHRoYW4gODAgY2hhcmFjdGVycy4KPj4KPj4g
TXkgcnVsZSBmb3IgKmFsbCogb2YgdGhlIGNvbW1pdCBtZXNzYWdlIGlzICJhYnNvbHV0ZWx5IG5v
IG1vcmUgdGhhbiA3Ngo+PiBjaGFyYWN0ZXJzIi4gV2l0aCBtb3JlIHRoYW4gNzYsIGBnaXQgbG9n
YCB3cmFwcyBpbiBhIDgwLWNvbHVtbiB0ZXJtaW5hbC4KPgo+IFdoYXQgYWJvdXQgdGhlIDUwIGNo
YXJhY3RlciBsaW1pdCBwcm9wb3NlZCBpbiB0aGUgZG9jdW1lbnRhdGlvbgo+IChnaXQtY29tbWl0
LCBnaXR0dXRvcmlhbCwgdXNlci1tYW51YWwpPwo+Cj4gQXQgdGhlIGJlZ2lubmluZyBJIHRyaWVk
IHRvIGZ1bGZpbCB0aGlzIGxpbWl0LCBidXQgb2Z0ZW4gaXQncyBub3QgZWFzeS4KPiBTbyBzaG91
bGQgaXQgYmUgYWRqdXN0ZWQgdG8gYSBzbGlnaHRseSBoaWdoZXIgdmFsdWUgaW4gdGhlIGRvY3Vt
ZW50YXRpb24KPiBvciBldmVuIHNwbGl0IGludG8gYSByZWNvbW1lbmRlZCBsaW1pdCAoZS5nLiA1
MCkgYW5kIGEgcmVjb21tZW5kZWQKPiBhYnNvbHV0ZSBtYXhpbXVtIChlLmcuIDc2KT8gSG1tLCB0
aGUgc3BsaXQgd291bGRuJ3QgbWFrZSBzZW5zZSwgSSB0aGluay4KClRoZSA1MCBjaGFyYWN0ZXIg
bGltaXQgaXMgZm9yIHRoZSBmaXJzdCBsaW5lLCB0cnkgImdpdCBsb2cKLS1wcmV0dHk9b25lbGlu
ZSIgYW5kIGl0IHNob3VsZCBiZSBvYnZpb3VzIHdoeS4KVGhlIHJlc3Qgb2YgdGhlIGxpbmVzIGNh
biBiZSBsb25nZXIsIDcyIGlzIGFub3RoZXIgcG9wdWxhciBjaG9pY2UuCgpJJ20gd29uZGVyaW5n
IGlmIHRoZSBkZWZhdWx0IGNvbW1pdC1tc2cgaG9vayBzaG91bGQgaGF2ZSBzb21ldGhpbmcgbGlr
ZToKcGVybCAtbmUgJyRsaW0gPSAoNTAsMCw3MilbKCQuPjM/MzokLiktMV07CiAgICAgICAgICAg
IGNob21wOwogICAgICAgICAgICBpZiAobGVuZ3RoKCRfKSA+ICRsaW0pIHsKICAgICAgICAgICAg
ICBwcmludCBTVERFUlIgIkxpbmUgJC4gb2YgY29tbWl0IG1lc3NhZ2UgZXhjZWVkZWQgJGxpbQpj
aGFyYWN0ZXJzIjsKICAgICAgICAgICAgICBleGl0IDE7CiAgICAgICAgICAgIH0nICQxCgp0byBt
b3JlIGZvcmNlZnVsbHkgc3VnZ2VzdCB3aGF0J3MgaW4gdGhlIG1hbnVhbCwgbGlrZSB0aGUgcHJl
LWNvbW1pdCBob29rIGRvZXMuCgooSSB3aXNoIEknZCBoYWQgc29tZXRoaW5nIGxpa2UgdGhpcyB3
aGVuIG9uZSBvZiB0aGUgZGV2cyBoZXJlIHB1c2hlZCBhCmNvbW1pdCB3aXRoIGEgMzQ2LWxpbmUg
bWVzc2FnZSwKanVzdCBsaXN0aW5nIHdoYXQgZmlsZXMgaGUgd2FzIGNoYW5naW5nLi4uZG9oKQoK
LUJhegoKPgo+IE1hcmt1cwo+Cj4gLS0KPiBUbyB1bnN1YnNjcmliZSBmcm9tIHRoaXMgbGlzdDog
c2VuZCB0aGUgbGluZSAidW5zdWJzY3JpYmUgZ2l0IiBpbgo+IHRoZSBib2R5IG9mIGEgbWVzc2Fn
ZSB0byBtYWpvcmRvbW9Admdlci5rZXJuZWwub3JnCj4gTW9yZSBtYWpvcmRvbW8gaW5mbyBhdCAg
aHR0cDovL3ZnZXIua2VybmVsLm9yZy9tYWpvcmRvbW8taW5mby5odG1sCj4K
