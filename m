From: "=?UTF-8?Q?Eddy_Petri=C8=99or?=" <eddy.petrisor@gmail.com>
Subject: Re: [PATCH] git svn: should not display zombie externals
Date: Tue, 12 Aug 2008 20:05:49 +0300
Message-ID: <60381eeb0808121005h72ee6ef2g8a979d9f6875ee51@mail.gmail.com>
References: <48923DAF.7070900@gmail.com> <48923E95.2020302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 19:07:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSxKp-00053B-PB
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 19:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450AbYHLRFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 13:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752579AbYHLRFx
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 13:05:53 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:33920 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbYHLRFw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 13:05:52 -0400
Received: by yx-out-2324.google.com with SMTP id 8so958186yxm.1
        for <git@vger.kernel.org>; Tue, 12 Aug 2008 10:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=GTMMXlQpmuZKHnUJcnyd6h1TIaXkEvTK/GjOGopnbn0=;
        b=WTCbSkunybSke1nH5ONzG769qyZchIOUM3B6ynISJeybmOqUObEdSVvpycjfgH0RwK
         uDWlTUroofgEimOKXovb0m/He5kjn0JjXcVHLZ6fn7kNg3pSx6x5Fw1HLzllbL4YdGfu
         3wN7YvkF4e8OvwOP4b63nPGa7GI/OTY7I74Pc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=dRVSJdYlOipq1s+Vpc4zroX0SDIcj7pWyiEnYJBY9nT+751hX9MLAuPklCzt6d8Vmb
         bVqCcDaZsAlkKoesJI4kO4AuqFYUbx5L7vHTgDj1PmPvN8dRN9pKsdTJRfJpFZnmmoIP
         TKVWleLeLU4irsxEUHkptzhLRtER8deTLxgHQ=
Received: by 10.114.158.1 with SMTP id g1mr5140651wae.111.1218560749201;
        Tue, 12 Aug 2008 10:05:49 -0700 (PDT)
Received: by 10.114.153.16 with HTTP; Tue, 12 Aug 2008 10:05:49 -0700 (PDT)
In-Reply-To: <48923E95.2020302@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92117>

MjAwOC84LzEgRWRkeSBQZXRyaciZb3IgPGVkZHkucGV0cmlzb3JAZ21haWwuY29tPjoKPgo+IGR1
cmluZyB0aGUgaGlzdG9yeSBvZiBhIHJlcG8gYSBzdm46ZXh0ZXJuYWwgY291bGQgYmUgYWRkZWQg
YW5kIGxhdGVyCj4gcmVtb3ZlZDsgc3VjaCBleHRlcm5hbHMgc2hvdWxkbid0IGJlIGRpc3BsYXll
ZCBzaW5jZSBvbmx5IHRoZSBjdXJyZW50Cj4gc3RhdGUgaXMgcmVsZXZhbnQKPgo+IEkgaGF2ZSBl
bmNvdW50ZXJlZCB0aGUgYnJva2VuIGJlaGF2aW91ciBvbiBhIGdpdC1zdm4gcmVwbyB3aXRoIHRo
ZSBzdm4KPiBvcmlnaW4gYSByZXBvIHNlcnZlZCB2aWEgaHR0cHMgKGdpdCAxOjEuNS42LTF+YnBv
NDArMSBmcm9tIERlYmlhbiBFdGNoCj4gYmFja3BvcnRzLikgSSBob3BlIHRoaXMgYnVnIGRvZXNu
J3QgaGF2ZSB0byBkbyB3aXRoIHRoZSBzdm4gcmVwbyBiZWluZwo+IHNlcnZlZCB2aWEgaHR0cHMu
CgpJIGhhdmUgZmluYWxseSBmb3VuZCB0aGUgcm9vdCBvZiB0aGlzIGJyZWFrYWdlLiBJdCBzZWVt
cyB0aGF0IHRoZQpvbGRlciB2ZXJzaW9ucyBvZiBzdWJ2ZXJzaW9uIGFsbG93ZWQgYSBzdm46ZXh0
ZXJuYWwgcHJvcGVydHkgdG8gYmUKZW1wdHksIHRodXMgZ2VuZXJhdGluZyB0aGUgem9tYmllIGV4
dGVybmFscy4gTmV3ZXIgdmVyc2lvbnMgb2YKc3VidmVyc2lvbiAoSSBjaGVja2VkIHRoaXMgd2l0
aCAxLjQuMiAocjIyMTk2KSBmcm9tIERlYmlhbiBFdGNoKSBkbwpub3QgYWxsb3cgc3VjaCBlbXB0
eSBzdm46ZXh0ZXJuYWxzLgoKPiBTaWduZWQtb2ZmLWJ5OiBFZGR5IFBldHJpyJlvciA8ZWRkeS5w
ZXRyaXNvckBnbWFpbC5jb20+Cj4gLS0tCj4gIHQvdDkxMDEtZ2l0LXN2bi1wcm9wcy5zaCB8ICAg
MjMgKysrKysrKysrKysrKysrKysrKysrKy0KPiAgMSBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL3QvdDkxMDEtZ2l0LXN2bi1w
cm9wcy5zaCBiL3QvdDkxMDEtZ2l0LXN2bi1wcm9wcy5zaAo+IGluZGV4IGY0MjA3OTYuLmU1YWI3
NDggMTAwNzU1Cj4gLS0tIGEvdC90OTEwMS1naXQtc3ZuLXByb3BzLnNoCj4gKysrIGIvdC90OTEw
MS1naXQtc3ZuLXByb3BzLnNoCj4gQEAgLTIxMSw3ICsyMTEsMjggQEAgRU9GCj4KPiAgdGVzdF9l
eHBlY3Rfc3VjY2VzcyAndGVzdCBwcm9wbGlzdCcgIgo+ICAgICAgICBnaXQtc3ZuIHByb3BsaXN0
IC4gfCBjbXAgLSBwcm9wLmV4cGVjdCAmJgo+IC0gICAgICAgZ2l0LXN2biBwcm9wbGlzdCBuZXN0
ZWQvZGlyZWN0b3J5Ly5rZWVwIHwgY21wIC0gcHJvcDIuZXhwZWN0Cj4gKyAgICAgICBnaXQtc3Zu
IHByb3BsaXN0IG5lc3RlZC9kaXJlY3RvcnkvLmtlZXAgfCBjbXAgLSBwcm9wMi5leHBlY3QgJiYK
PiArICAgICAgIGNkIC4uCj4gKyAgICAgICAiCj4gKwo+ICt0ZXN0X2V4cGVjdF9zdWNjZXNzICdz
aG93IGV4dGVybmFsJyAiCj4gKyAgICAgICBjZCB0ZXN0X3djICYmCj4gKyAgICAgICAgICAgICAg
IHN2biBwcm9wc2V0IHN2bjpleHRlcm5hbHMgJ3pvbWJpZSBmaWxlOi8vL2Zha2UvZXh0ZXJuYWwn
IC4KPiAmJgo+ICsgICAgICAgICAgICAgICBzdm4gY2kgLW0gJ2FkZGVkIGEgZmFrZSBzdm46ZXh0
ZXJuYWwnICYmCj4gKyAgICAgICBjZCAuLiAmJgo+ICsgICAgICAgZ2l0LXN2biBmZXRjaCAmJgo+
ICsgICAgICAgZ2l0LW1lcmdlIGdpdC1zdm4gJiYKPiArICAgICAgIGdpdC1zdm4gc2hvdy1leHRl
cm5hbHMgfCBncmVwIC1xICd6b21iaWUnCj4gKyAgICAgICAiCj4gKwo+ICt0ZXN0X2V4cGVjdF9z
dWNjZXNzICdyZW1vdmUgZXh0ZXJuYWwnICIKPiArICAgICAgIGNkIHRlc3Rfd2MgJiYKPiArICAg
ICAgICAgICAgICAgc3ZuIHByb3BkZWwgc3ZuOmV4dGVybmFscyAuICYmCj4gKyAgICAgICAgICAg
ICAgIHN2biBjaSAtbSAnZGVsZXRlZCB0aGUgZmFrZSBleHRlcm5hbCcgJiYKPiArICAgICAgIGNk
IC4uICYmCj4gKyAgICAgICBnaXQtc3ZuIGZldGNoICYmCj4gKyAgICAgICBnaXQtbWVyZ2UgZ2l0
LXN2biAmJgo+ICsgICAgICAgZ2l0LXN2biBzaG93LWV4dGVybmFscyB8IGdyZXAgLXEgLXYgJ3pv
bWJpZScKPiAgICAgICAgIgo+Cj4gIHRlc3RfZG9uZQo+IC0tCj4gMS41LjYuMwo+Cj4KPiBUaGlz
IG9uZSBpcyBwcm9wZXJseSBmb3JtYXRlZCAodGhlIHByZXZpb3VzIG9uZSB3YXMgYSBjb3B5L3Bh
c3RlIGZyb20gdGhlCj4gb3V0cHV0IG9mIHRoZSBjb25zb2xlKS4KPgoKCgotLSAKUmVnYXJkcywK
RWRkeVAKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiJJbWFn
aW5hdGlvbiBpcyBtb3JlIGltcG9ydGFudCB0aGFuIGtub3dsZWRnZSIgQS5FaW5zdGVpbgo=
