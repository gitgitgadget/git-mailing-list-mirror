From: "Erez Zilber" <erezzi.list@gmail.com>
Subject: Re: git-clone works with ssh but not with http/https/git
Date: Tue, 24 Jun 2008 14:45:42 +0300
Message-ID: <ce513bcc0806240445x6d00323g303f218504d2df53@mail.gmail.com>
References: <ce513bcc0806240415h669d1725uf7b6e495995ab459@mail.gmail.com>
	 <1214306517.6441.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Matthias Kestenholz" <mk@spinlock.ch>
X-From: git-owner@vger.kernel.org Tue Jun 24 13:47:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB6zK-0000R9-I2
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 13:47:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755209AbYFXLpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 07:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751925AbYFXLpo
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 07:45:44 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:53653 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbYFXLpn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 07:45:43 -0400
Received: by rv-out-0506.google.com with SMTP id k40so7623074rvb.1
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 04:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=OZNhtnF97EAtTeC/F/89ukvbWOyJQquMNK5GIhAB3CE=;
        b=tDHd3oxcW0cyJj6BoHLpNNNyarGkXQtVd6I+HaNxeWfzlgKbIiz7Sdsk9GGbKqS0Vy
         ddy8SMFOlOt64OED+jINMswHnegc9bck2skmxmNzj+jyQV8DqGbMSPdRaV678q5mkKzG
         iyRzGhcmpqLrL1FbtOQzgEkFfLgYoFdLXjWbs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=KSt57kzBGQJT4EhYR5uKaSY8HW3UqAHl83BfL0assBeqZY+msBvqOsgUPMR+1gZwp/
         AwQxCgGIIZpRIDT1zqNdrx63RYE+F12Rm8lJwVjEIO11aA5vhyVlVcR9YA8lcNsTPd35
         2PWhneOOC/7cm5wL/d2ox+RmngI3TS1CaCGCA=
Received: by 10.140.193.15 with SMTP id q15mr14605429rvf.191.1214307942521;
        Tue, 24 Jun 2008 04:45:42 -0700 (PDT)
Received: by 10.141.195.7 with HTTP; Tue, 24 Jun 2008 04:45:42 -0700 (PDT)
In-Reply-To: <1214306517.6441.10.camel@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86037>

T24gVHVlLCBKdW4gMjQsIDIwMDggYXQgMjoyMSBQTSwgTWF0dGhpYXMgS2VzdGVuaG9seiA8bWtA
c3BpbmxvY2suY2g+IHdyb3RlOgo+IE9uIFR1ZSwgMjAwOC0wNi0yNCBhdCAxNDoxNSArMDMwMCwg
RXJleiBaaWxiZXIgd3JvdGU6Cj4+IEhpLAo+Pgo+PiBJJ20gYWJsZSB0byBnaXQtY2xvbmUgYSB0
cmVlIHVzaW5nIHNzaDoKPj4KPj4gW3Jvb3RAa2QwMDEgdF0jIGdpdC1jbG9uZQo+PiBzc2g6Ly9l
cmV6LnppbGJlckBraXRlcy9wdWIvZ2l0L2VyZXouemlsYmVyL215X3Rlc3QuZ2l0Cj4+IEluaXRp
YWxpemVkIGVtcHR5IEdpdCByZXBvc2l0b3J5IGluIC9ob21lL2VyZXouemlsYmVyL3dvcmsvdG1w
L3QvbXlfdGVzdC8uZ2l0Lwo+PiBlcmV6LnppbGJlckBraXRlcydzIHBhc3N3b3JkOgo+PiByZW1v
dGU6IENvdW50aW5nIG9iamVjdHM6IDksIGRvbmUuCj4+IHJlbW90ZTogQ29tcHJlc3Npbmcgb2Jq
ZWN0czogMTAwJSAoNS81KSwgZG9uZS4KPj4gcmVtb3RlOiBUb3RhbCA5IChkZWx0YSAwKSwgcmV1
c2VkIDAgKGRlbHRhIDApCj4+IFJlY2VpdmluZyBvYmplY3RzOiAxMDAlICg5LzkpLCBkb25lLgo+
Pgo+PiBIb3dldmVyLCBpdCBkb2Vzbid0IHdvcmsgd2l0aCBodHRwL2h0dHBzL2dpdDoKPj4KPj4g
W3Jvb3RAa2QwMDEgdF0jIGdpdC1jbG9uZSBodHRwOi8va2l0ZXMvcHViL2dpdC9lcmV6LnppbGJl
ci9teV90ZXN0LmdpdAo+PiBJbml0aWFsaXplZCBlbXB0eSBHaXQgcmVwb3NpdG9yeSBpbiAvaG9t
ZS9lcmV6LnppbGJlci93b3JrL3RtcC90L215X3Rlc3QvLmdpdC8KPj4gQ2Fubm90IGdldCByZW1v
dGUgcmVwb3NpdG9yeSBpbmZvcm1hdGlvbi4KPj4gUGVyaGFwcyBnaXQtdXBkYXRlLXNlcnZlci1p
bmZvIG5lZWRzIHRvIGJlIHJ1biB0aGVyZT8KPj4KPgo+IE1heWJlIHlvdSBzaG91bGQgcnVuIGdp
dC11cGRhdGUtc2VydmVyLWluZm8gaW4gdGhlIHJlcG9zaXRvcnkgb24gdGhlCj4gc2VydmVyPwoK
Rm9yZ290IHRvIG1lbnRpb24gLSBJIHRyaWVkIHRvIHJ1biBnaXQtdXBkYXRlLXNlcnZlci1pbmZv
IGZyb20gdGhlCnJlcG9zaXRvcnkgb24gdGhlIHNlcnZlci4gSSBnb3QgdGhlIHNhbWUgcmVzdWx0
cy4gQlRXIC0gaWYgaXQgd29ya3MgT0sKd2l0aCBzc2gsIEkgY2FuIG9ubHkgZ3Vlc3MgdGhhdCBn
aXQtdXBkYXRlLXNlcnZlci1pbmZvIHdvbid0IGhlbHAgZm9yCmh0dHAuIHJpZ2h0PwoKPgo+PiBb
cm9vdEBrZDAwMSB0XSMgZ2l0LWNsb25lIGh0dHBzOi8va2l0ZXMvcHViL2dpdC9lcmV6LnppbGJl
ci9teV90ZXN0LmdpdAo+PiBJbml0aWFsaXplZCBlbXB0eSBHaXQgcmVwb3NpdG9yeSBpbiAvaG9t
ZS9lcmV6LnppbGJlci93b3JrL3RtcC90L215X3Rlc3QvLmdpdC8KPj4gQ2Fubm90IGdldCByZW1v
dGUgcmVwb3NpdG9yeSBpbmZvcm1hdGlvbi4KPj4gUGVyaGFwcyBnaXQtdXBkYXRlLXNlcnZlci1p
bmZvIG5lZWRzIHRvIGJlIHJ1biB0aGVyZT8KPgo+Cj4g77u/TWF5YmUgeW91IHNob3VsZCBydW4g
Z2l0LXVwZGF0ZS1zZXJ2ZXItaW5mbyBpbiB0aGUgcmVwb3NpdG9yeSBvbiB0aGUKPiBzZXJ2ZXI/
Cj4KPiBCeSB0aGUgd2F5LCB0cnkgZW5hYmxpbmcgdGhlIHBvc3QtdXBkYXRlIGhvb2sgLS0gaXQg
cnVucwo+IHVwZGF0ZS1zZXJ2ZXItaW5mbyBmb3IgeW91IGF1dG9tYXRpY2FsbHkgYWZ0ZXIgcHVz
aGluZyB0byB5b3VyIHNlcnZlcgo+IChtYWtlIHRoZSBzY3JpcHQgJEdJVF9ESVIvaG9va3MvcG9z
dC11cGRhdGUgZXhlY3V0YWJsZSkKCk1ha2UgaXQgZXhlY3V0YWJsZSBvbiB0aGUgY2xpZW50IHNp
ZGUgYmVmb3JlIHB1c2hpbmcgKGkuZS4gaW4KLmdpdC9ob29rcy9wb3N0LXVwZGF0ZSkgb3Igb24g
dGhlIHNlcnZlciBzaWRlIGFmdGVyIHB1c2hpbmc/Cgo+Cj4+IFtyb290QGtkMDAxIHRdIyBnaXQt
Y2xvbmUgZ2l0Oi8va2l0ZXMvcHViL2dpdC9lcmV6LnppbGJlci9teV90ZXN0LmdpdAo+PiBJbml0
aWFsaXplZCBlbXB0eSBHaXQgcmVwb3NpdG9yeSBpbiAvaG9tZS9lcmV6LnppbGJlci93b3JrL3Rt
cC90L215X3Rlc3QvLmdpdC8KPj4ga2l0ZXNbMDogMTcyLjE2LjEuMTFdOiBlcnJubz1Db25uZWN0
aW9uIHJlZnVzZWQKPj4gZmF0YWw6IHVuYWJsZSB0byBjb25uZWN0IGEgc29ja2V0IChDb25uZWN0
aW9uIHJlZnVzZWQpCj4+IGZldGNoLXBhY2sgZnJvbSAnZ2l0Oi8va2l0ZXMvcHViL2dpdC9lcmV6
LnppbGJlci9teV90ZXN0LmdpdCcgZmFpbGVkLgo+Pgo+Cj4gSXMgdGhlIGdpdCBkYWVtb24gcnVu
bmluZyBvbiB5b3VyIHNlcnZlcj8gWW91IG5lZWQgdG8gY29uZmlndXJlIGluZXRkIG9yCj4gZ2l0
LWRhZW1vbiB5b3Vyc2VsZiwgdGhhdCBpcyBub3QgZG9uZSBhdXRvbWF0aWNhbGx5IGZvciB5b3Uu
Cj4KCkkgcmFuIGdpdC1kYWVtb24gb24gdGhlIHNlcnZlciBzaWRlIGxpa2UgdGhpczoKCnN1ZG8g
Z2l0LWRhZW1vbiAtLWJhc2UtcGF0aD0vcHViL2dpdC8gLS1leHBvcnQtYWxsIC0tbGlzdGVuPWtp
dGVzCgpFcmV6Cg==
