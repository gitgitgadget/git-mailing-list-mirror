From: "=?ISO-8859-2?Q?=A3ukasz_Lew?=" <lukasz.lew@gmail.com>
Subject: Re: How to maintain private/secret/confidential branch.
Date: Sun, 14 Dec 2008 17:48:30 +0100
Message-ID: <c55009e70812140848j79202b0aqc6ffbfecfff50757@mail.gmail.com>
References: <c55009e70812140549t6547c1d6jf7780f91b5074e73@mail.gmail.com>
	 <20081214145518.GA26380@mail.local.tull.net>
	 <c55009e70812140738l8b51adax77cc6e507971554e@mail.gmail.com>
	 <20081214160645.GA21358@myhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: base64
Cc: "Nick Andrew" <nick@nick-andrew.net>, git@vger.kernel.org
To: "Alexander Potashev" <aspotashev@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 14 17:49:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBuAB-0006Pj-9v
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 17:49:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499AbYLNQse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 11:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753462AbYLNQse
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 11:48:34 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:57460 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753387AbYLNQsd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 11:48:33 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1008219fgg.17
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 08:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=8NtLs+/97UMEFnkBIBA+UpjAE68Z/Gq5P0pQraGnrco=;
        b=JqHKMMgdcByuJnhlvsi0KDGzeM/brEQ5U5abtxi2/9Uqz/5NLeqP8ljbHXc8knmJuw
         X36JPNdTwuSiwMNlZuRojxSDf3iS0eSj3JGwB7gwi3SlgnWYKJ8rCcemSUfKOensTN61
         78XM7D4/JF6BfnCk0Wf4WFRJPKdNG14inNYnY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=d57QjVTM+sESRYhfGVc5/1t6DQR0LidCLES74tDsnCWqrn727NcS9PSQH2JMZXu5EQ
         O1s1IDN8/kCQCbqFaLBK+vwq+qg2t56D6kUuBGimeGP2P4eG+8e5oJG/oEbOPgMnEj0G
         aqoIkvFNXpuqYdltiCCuSYa3Z6eyvJJNCJEHw=
Received: by 10.86.72.15 with SMTP id u15mr3271707fga.45.1229273311088;
        Sun, 14 Dec 2008 08:48:31 -0800 (PST)
Received: by 10.86.93.2 with HTTP; Sun, 14 Dec 2008 08:48:30 -0800 (PST)
In-Reply-To: <20081214160645.GA21358@myhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103093>

SGkgQWxleGFuZGVyLAoKT24gU3VuLCBEZWMgMTQsIDIwMDggYXQgMTc6MDYsIEFsZXhhbmRlciBQ
b3Rhc2hldiA8YXNwb3Rhc2hldkBnbWFpbC5jb20+IHdyb3RlOgo+IEhlbGxvLCCjdWthc3ohCj4K
PiBPbiAxNjozOCBTdW4gMTQgRGVjICAgICAsIKN1a2FzeiBMZXcgd3JvdGU6Cj4+IFRoYW5rcyBO
aWNrLCB0aGF0cyByZWFsbHkgaGVscGZ1bCAoYW5kIHN1cnByaXNpbmdseSBzaW1wbGUpLgo+PiBJ
IGhhdmUgYSBjb3VwbGUgbW9yZSBxdWVzdGlvbnM6Cj4+Cj4+IE9uIFN1biwgRGVjIDE0LCAyMDA4
IGF0IDE1OjU1LCBOaWNrIEFuZHJldyA8bmlja0BuaWNrLWFuZHJldy5uZXQ+IHdyb3RlOgo+PiA+
IE9uIFN1biwgRGVjIDE0LCAyMDA4IGF0IDAyOjQ5OjUwUE0gKzAxMDAsIKN1a2FzeiBMZXcgd3Jv
dGU6Cj4+ID4+IEkgZG9uJ3Qga25vdyBob3cgdG8gbWFrZSBzdWNoIGEgc2NlbmFyaW8gd29yazoK
Pj4gPj4gLSB0d28gcmVwb3NpdG9yaWVzOiBwdWIsIHByaXYKPj4gPj4gLSBwcml2IGlzIGNsb25l
L2JyYW5jaCBvZiBwdWIKPj4gPj4gLSB0aGVyZSBpcyBzb21lIGNvbnN0YW50IGRldmVsb3BlbWVu
dCBib3RoIGluIHB1YiBhbmQgcHJpdgo+PiA+PiAtIHRoZXJlIGFyZSByZWd1bGFyIHN5bmNzIHdp
dGggcHViIGluIHByaXYKPj4gPj4KPj4gPj4gUHJvYmxlbToKPj4gPj4gT2NjYXNpb25hbGx5IEkg
d2FudCB0byBwdXNoIHNvbWUgY2hhbmdlcyBmcm9tIHByaXYgdG8gcHViLgo+PiA+PiBUaGVuIGFm
dGVyIHN5bmNpbmcgd2l0aCBwdWIgSSB3YW50IHRvIGdldCBhcyBmZXcgY29uZmxpY3RzIGFzIHBv
c3NpYmxlLgo+PiA+Pgo+PiA+PiBJcyBpdCBwb3NzaWJsZSB0byBkbyB3aXRoIGdpdD8KPj4gPgo+
PiA+IEdpdCBjYW4gZG8gYWxtb3N0IGFueXRoaW5nLiBPbmUgc2hvdWxkIGluc3RlYWQgYXNrICJI
b3cgdG8gZG8gdGhpcwo+PiA+IHdpdGggZ2l0PyIgOi0pCj4+Cj4+IFNvIEkndmUgaGVhcmQsIGJ1
dCBub3QgeWV0IGV4cGVyaWVuY2VkIGl0IG15c2VsZi4gSSdtIHRocmlsbGVkIHRvIHRyeS4KPj4K
Pj4gPgo+PiA+IElmIEkgdW5kZXJzdGFuZCB5b3VyIHByb2JsZW0sIHlvdSBjb3VsZCBzb2x2ZSBp
dCB3aXRoIGdpdCBjaGVycnktcGljawo+PiA+IGFuZCByZWJhc2UuIE9uIHByaXYsIG1ha2UgYSBm
b3ItcHVibGljIGJyYW5jaCBmcm9tIGEgcHViIGJyYW5jaC4gVGhlbgo+PiA+IGNoZXJyeS1waWNr
IHRoZSBjb21taXRzIHlvdSB3YW50IGZyb20geW91ciBwcml2YXRlIGJyYW5jaCBpbnRvIHRoZQo+
PiA+IGZvci1wdWJsaWMgYnJhbmNoLgo+Pgo+PiBUaGF0IGFsbW9zdCB3b3Jrcy4gQ2FuIEkgc29t
ZWhvdyBzcGxpdCBleGlzdGluZyBjb21taXRzIGp1c3QgbGlrZSBpbiBnaXQtYWRkIC1wPwo+IEl0
J3MsIGhvd2V2ZXIsIGJldHRlciB0byBtYWtlIG1vcmUgY29tbWl0cyB0byBub3QgZXhwZXJpZW5j
ZSB0aGUgbmVlZCBvZgo+IGNvbW1pdCBzcGxpdHRpbmcuCgpJbmRlZWQgZ29vZCBhZHZpY2UgYW5k
IGJlc3QgcHJhY3RpY2UsIGJ1dCBhbm90aGVyIGJlc3QgcHJhY3RpY2UgaXMgdG8Kbm90IGNvbW1p
dCBub3QgY29tcGlsaW5nIHN0YXRlLgpNeSBjb21tb24gc2NlbmFyaW8gaXMgdGhhdCBJIGNvZGUg
YSBiaWcgY2hhbmdlIGluIHByaXYgcmVwb3NpdG9yeSwgYW5kCmFmdGVyIHRoYXQgSSBmaW5kIHRo
YXQgc29tZSBvZiBpdHMgcGFydHMgY2FuIGFuZCBzaG91bGQgYmUgbW92ZWQgdG8KcHViLgoKPgo+
IEJ1dCB5b3UgY2FuIHVzZSAnLS1uby1jb21taXQnIG9wdGlvbiBvZiAnZ2l0IGNoZXJyeS1waWNr
JyBhbmQgJ2dpdCBtZXJnZScKPiAoYW5kICdnaXQgcHVsbCcgYXMgd2VsbCBhcyAnZ2l0IG1lcmdl
JykuIEZvciBleGFtcGxlOgo+Cj4gICAgICAgIGdpdCBjaGVycnktcGljayAtLW5vLWNvbW1pdCA8
c2hhMT4gICAgIyBjaGVycnktcGljayB3aXRob3V0IGNvbW1pdGluZwo+ICAgICAgICBnaXQgcmVz
ZXQgLS0gICAgICAgICAgICAgICAgICAgICAgICAgICMgdW5zdGFnZSBhbGwgY2hhbmdlcwo+ICAg
ICAgICBnaXQgYWRkIC1wICAgICAgICAgICAgICAgICAgICAgICAgICAgICMgcGF0Y2ggdXBkYXRl
Cj4KPiBZb3UgY2FuIGFsc28gdXNlICdnaXQgYWRkIC1pJyAoaW50ZXJhdGl2ZSBtb2RlKSBpbnN0
ZWFkIG9mICdnaXQgYWRkIC1wJy4KClRoYXQncyBhIHBvc3NpYmxlIHNvbHV0aW9uIGluZGVlZC4K
Tm93IEkgc2VlIHRoYXQgdGhlIHJpZ2h0ICJwbHVtYmluZyIgSSBuZWVkIGlzIHNwbGl0dGluZyBh
IGNvbW1pdCBpbnRvCnNtYWxsZXIgcGFydHMgYW5kIG1lcmdpbmcgc2V2ZXJhbCBjb21taXRzIGlu
dG8gYSBsYXJnZXIgb25lLgoKSSB0aGluayB0aGF0IHdvdWxkIGJlIG5pY2UgZnVuY3Rpb25hbGl0
eS4KCkRvIHlvdSBrbm93IGFueSB0b29sIHRoYXQgd291bGQgYWxsb3cgc3VjaCBhIG1hbmlwdWxh
dGlvbiBvbiBjb21taXRzCmluIGhpc3Rvcnk/CgpUaGFua3MKTHVrYXN6Cgo+Cj4+Cj4+ID4gUHVz
aCB5b3VyIGZvci1wdWJsaWMgYnJhbmNoIHRvIHB1YiwKPj4gPiB0aGVuIHJlYmFzZSB5b3VyIHBy
aXZhdGUgYnJhbmNoLgo+Pgo+PiBSZWJhc2UgdG8gdGhlIHRpcCBvZiBtYXN0ZXI/IElzIGl0IG5l
ZWRlZD8gSWUuIGNoZXJyeS1waWNrIGRvZXMgbm90Cj4+IHJlbW92ZSB0aGUgcGF0Y2ggZnJvbQo+
PiB0aGUgbWFzdGVyIGluIHByaXYuCj4+Cj4+IElmIEkgbm93IHB1bGwgZnJvbSBwdWIsIEkgd2ls
bCBnZXQgdGhlIHNhbWUgY2hhbmdlIGFuZCBpdCBtZXJlZ2VzIG5pY2VseSA6RAo+Pgo+PiBDYW4g
SSBnZXQgYXdheSB3aXRob3V0IGNyZWF0aW5nIGZvcl9wdWIgYnJhbmNoPyBtYXliZSBjaGVycnkg
cGljayBpbgo+PiBwdWIgZnJvbSBwcml2IHNvbWVob3c/Cj4+Cj4+ID4KPj4gPiBOaWNrLgo+PiA+
Cj4KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBbGV4YW5kZXIKPgo=
