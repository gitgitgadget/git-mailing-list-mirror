From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Paginate project list
Date: Mon, 12 May 2008 17:43:06 +0200
Message-ID: <8c5c35580805120843j9b401f8mfa104806880a51c2@mail.gmail.com>
References: <200805011220.58871.jnareb@gmail.com>
	 <1210485210.11526.145.camel@localhost.localdomain>
	 <8c5c35580805102356p7e5532aah319af921f9b19392@mail.gmail.com>
	 <200805120903.25040.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: warthog19@eaglescrag.net, git@vger.kernel.org,
	"Petr Baudis" <pasky@suse.cz>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 17:44:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvaC3-00053m-P8
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 17:44:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753062AbYELPnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 11:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752985AbYELPnN
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 11:43:13 -0400
Received: from ti-out-0910.google.com ([209.85.142.189]:27007 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbYELPnM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 11:43:12 -0400
Received: by ti-out-0910.google.com with SMTP id b6so799741tic.23
        for <git@vger.kernel.org>; Mon, 12 May 2008 08:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=xlGfNHYttn0pQWik8ZU7G8oCDzhvcMIRzevYk11JABo=;
        b=Y74+gLWXv2j/v0V8Sq5KoEG/Xh0bGtdhZMFJs/6SVDxc+wjV9kgyPA2pTw6sT+dS+ulPhS8Uv9YaG2VZ7diBMDb62+S1ScjSlFuFbAQSxt3NTtRuZam6rOo2g8Y3mj9PZ1yquhaHQanK9ZMVqDqrkqD73u7Z7pOWcDmonkxt0dI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PZrS0IvO/CCVb7Y0/LU3HJynF/XOAMkE1YsXbaMteqsNxTaoVHFoHd6l/fctsRawp0tx5P1Mc/dRmqRsHYZ4JnaL2yot4+6KoumwUJZGdKESbtvSTkU1M/7IKj9WuC7YDS6UvXPongRsvneHqHppQgJEGWI/h3E/TBSBAV9gxnk=
Received: by 10.150.68.2 with SMTP id q2mr8368176yba.91.1210606986430;
        Mon, 12 May 2008 08:43:06 -0700 (PDT)
Received: by 10.151.39.3 with HTTP; Mon, 12 May 2008 08:43:06 -0700 (PDT)
In-Reply-To: <200805120903.25040.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81875>

T24gNS8xMi8wOCwgSmFrdWIgTmFyZWJza2kgPGpuYXJlYkBnbWFpbC5jb20+IHdyb3RlOgo+IFtU
aGUgb3JpZ2luYWwgZW1haWwgYnkgTGFycyBkaWRuJ3QgZ2V0IHRvIGdpdCBtYWlsaW5nIGxpc3Qg
YmVjYXVzZSBvZgo+ICAgbGFjayBvZiBxdW90ZXMgYXJvdW5kIEouSC4gaW4gIkouSC4iIDx3YXJ0
aG9nMTlAZWFnbGVzY3JhZy5uZXQ+Cj4gICBlbWFpbCBhZGRyZXNzIGluIENjOl0KCkdhYWgsIGJh
ZCBnbWFpbC4uLgoKCj4gIERuaWEgbmllZHppZWxhIDExLiBtYWphIDIwMDggMDg6NTYsIExhcnMg
SGplbWxpIG5hcGlzYcWCOgo+Cj4gID4gSXQgc2VlbXMgdG8gbWUgdGhhdCAicHJvamVjdGxpc3Qg
aW4gYSBzaW5nbGUgZmlsZSIgYW5kICJjYWNoZSByZXN1bHRzCj4gID4gb2YgZmlsbGVkIGluIEAk
cHJvamxpc3QiIGFyZSBkaWZmZXJlbnQgc29sdXRpb25zIHRvIHRoZSBzYW1lIHByb2JsZW06Cj4g
ID4gcmFwaWRseSBmaWxsaW5nIGEgcGVybCBkYXRhc3RydWN0dXJlLgo+Cj4gV2VsbCwgeWVzIGFu
ZCBuby4gICJQcm9qZWN0bGlzdCBpbiBzaW5nbGUgZmlsZSIgaXMgYWJvdXQgX3N0YXRpY18gZGF0
YQo+ICAod2hpY2ggY2hhbmdlcyBvbmx5IGlmIHByb2plY3RzIGFyZSBhZGRlZCwgZGVsZXRlZCwg
aXRzIGRlc2NyaXB0aW9uCj4gIGNoYW5nZWQ7IHRob3NlIGFyZSB1c3VhbGx5IHJhcmUgZXZlbnRz
KSwgYW5kIGF2b2lkaW5nIG1haW5seSBJL08gYW5kCj4gIG5vdCBDUFUgKHNjYW5uaW5nIGZpbGVz
eXN0ZW0gZm9yIHJlcG9zaXRvcmllcywgcmVhZGluZyBjb25maWcgYW5kCj4gIGRlc2NyaXB0aW9u
LCBldGMuKS4KPgo+ICAiQ2FjaGUgZGF0YSIgaXMgYWJvdXQgY2FjaGluZyBfdmFyaWFibGVfIGRh
dGEsIHN1Y2ggYXMgIkxhc3QgY2hhbmdlZCIKPiAgaW5mb3JtYXRpb24gZm9yIHByb2plY3QuICBD
YWNoaW5nIGRhdGEgaW5zdGVhZCBvZiBjYWNoaW5nIG91dHB1dAo+ICAoY2FjaGluZyBIVE1MKSBh
bGxvd3MgdG8gc2hhcmUgY2FjaGUgZm9yIGRpZmZlcmVudCBwcmVzZW50YXRpb24gb2YKPiAgdGhl
IHZlcnkgc2FtZSBkYXRhIChlLmcuICdoaXN0b3J5Jy8nc2hvcnRsb2cnIHZzICdyc3MnKS4gIEFu
ZCBmb3Igc29tZQo+ICBwYWdlcywgbGlrZSBwcm9qZWN0IHNlYXJjaCByZXN1bHRzLCBjYWNoaW5n
IEhUTUwgb3V0cHV0IGRvZXNuJ3QgbWFrZQo+ICBtdWNoIHNlbnNlLCB3aGlsZSBjYWNoaW5nIGRh
dGEgaGFzIGl0LgoKV2hpbGUgSSBhZ3JlZSB0aGF0IGNhY2hpbmcgc2VhcmNoIHJlc3VsdCBvdXRw
dXQgYWxtb3N0IG5ldmVyIG1ha2VzCnNlbnNlLCBJIHRoaW5rIGl0J3MgbW9yZSBpbXBvcnRhbnQg
dGhhdCBjYWNoZSBoaXRzIHJlcXVpcmVzIG1pbmltYWwKcHJvY2Vzc2luZy4gVGhpcyBpcyB3aHkg
SSd2ZSBjaG9zZW4gdG8gY2FjaGUgdGhlIGZpbmFsIHJlc3VsdCBpbnN0ZWFkCm9mIGFuIGludGVy
bWVkaWF0ZSBzdGF0ZSwgYnV0IGJvdGggc29sdXRpb25zIG9idmlvdXNseSBnb3Qgc29tZSBwcm9z
CmFuZCBjb25zLgoKPiAgPiBUaGlzIHVzZWQgdG8gYmUgZXhwZW5zaXZlIGluIHRlcm1zIG9mIGNh
Y2hlIHNpemUgKHNpbWlsYXIgdG8gay5vcmdzCj4gID4gMjBHKSwgYnV0IGN1cnJlbnQgY2dpdCBz
b2x2ZXMgdGhpcyBieSB0cmVhdGluZyB0aGUgY2FjaGUgYXMgYSBoYXNoCj4gID4gdGFibGU7IGNn
aXRyYyBoYXMgYW4gb3B0aW9uIHRvIHNldCB0aGUgY2FjaGUgc2l6ZSAobnVtYmVyIG9mIGZpbGVz
KSwKPiAgPiBlYWNoIGZpbGVuYW1lIGlzIGdlbmVyYXRlZCBhcyBgaGFzaCh1cmwpICUgY2FjaGVz
aXplYCBhbmQgZWFjaCBmaWxlCj4gID4gY29udGFpbnMgdGhlIGZ1bGwgdXJsICh0byBkZXRlY3Qg
aGFzaCBjb2xsaXNpb25zKSBmb2xsb3dlZCBieSB0aGUKPiAgPiBjYWNoZWQgY29udGVudCBmb3Ig
dGhhdCB1cmwgKHNlZQo+ICA+IGh0dHA6Ly9oamVtbGkubmV0L2dpdC9jZ2l0L3RyZWUvY2FjaGUu
YyBmb3IgdGhlIGRldGFpbHMpLgo+Cj4KPiBJIGd1ZXNzIHRoYXQgaXMgdGhlIHNpbXBsZXN0IHNv
bHV0aW9uLCBidXQgSSBkb24ndCB0aGluayB0aGF0IGlzCj4gIHRoZSBiZXN0IHNvbHV0aW9uIHRv
IGhhdmUgc2l6ZS1saW1pdGVkIGNhY2hlLiAgRm9yIGV4YW1wbGUgQ1BBTiBQZXJsCj4gIG1vZHVs
ZSBDYWNoZTo6U2l6ZUF3YXJlQ2FjaGUgYW5kIGl0cyBkZXJpdmF0aXZlcyB1c2UgdGhlIGZvbGxv
d2luZwo+ICBhbGdvcml0aG0KPgo+ICAgVGhlIGRlZmF1bHQgY2FjaGUgc2l6ZSBsaW1pdGluZyBh
bGdvcml0aG0gd29ya3MgYnkgcmVtb3ZpbmcgY2FjaGUKPiAgIG9iamVjdHMgaW4gdGhlIGZvbGxv
d2luZyBvcmRlciB1bnRpbCB0aGUgZGVzaXJlZCBsaW1pdCBpcyByZWFjaGVkOgo+Cj4gICAgIDEp
IG9iamVjdHMgdGhhdCBoYXZlIGV4cGlyZWQKPiAgICAgMikgb2JqZWN0cyB0aGF0IGFyZSBsZWFz
dCByZWNlbnRseSBhY2Nlc3NlZAo+ICAgICAzKSBvYmplY3RzIHRoYXQgdGhhdCBleHBpcmUgbmV4
dAoKQWdhaW4sIG1pbmltYWwgcHJvY2Vzc2luZyBpcyB0aGUgZ29hbCBvZiBjZ2l0cyBjYWNoZSBp
bXBsZW1lbnRhdGlvbiwKaGVuY2UgdGhlIHNpbXBsZSBzb2x1dGlvbi4KCj4gID4gQnR3OiBnaXR3
ZWIgYW5kIGNnaXQgc2VlbXMgdG8gYXF1aXJlIHRoZSBzYW1lIGZlYXR1cmVzIHRoZXNlIGRheXM6
Cj4gID4gY2dpdCByZWNlbnRseSBnb3QgcGFnaW5hdGlvbiArIHNlYXJjaCBvbiB0aGUgcHJvamVj
dCBsaXN0Lgo+Cj4KPiBJIGhhdmVuJ3QgY2hlY2tlZCB3aGF0IGZlYXR1cmVzIGNnaXQgaGFzIGxh
dGVseS4uLgo+Cj4gIEdpdHdlYiBkZXZlbG9wbWVudCBzZWVtcyBhIGJpdCBzdGFsbGVkOyBJIGdv
dCBubyByZXNwb25zZSB0byBsYXRlc3QKPiAgdHVybiBvZCBnaXR3ZWIgVE9ETyBhbmQgd2lzaGxp
c3QgbGlzdC4uLgoKV2VsbCwgSSBmb3Igb25lIGZvdW5kIHRoZSB3aXNobGlzdCBpbnRlcmVzdGlu
ZzsgSSd2ZSBiZWVuIHBvbmRlcmluZyBvbgppbXBsZW1lbnRpbmcgYSBncmFwaGljIGxvZyBpbiBj
Z2l0IChpbnNwaXJlZCBieSBnaXQtZm9yZXN0IGFuZApnaXQtZ3JhcGgpLCBidXQgSSByZWZ1c2Ug
dG8gcGVyZm9ybSBhICB0b3BvLXNvcnQgOy0pCgpIb3BlZnVsbHkgSSBjYW4gZXhwbG9pdCB0aGUg
ZmFjdCB0aGF0IGNnaXQgbmV2ZXIgdXNlcyBtb3JlIHRoYW4gb25lCmNvbW1pdCBhcyBzdGFydGlu
ZyBwb2ludCBmb3IgbG9nIHRyYXZlcnNhbCwgY29tYmluZWQgd2l0aCBoZXVyaXN0aWNzCm9uIGNv
bW1pdCBkYXRlLCB0byBlbmFibGUgYSBmYXN0IGdyYXBoaWMgbG9nIHRoYXQgd2lsbCBiZSBjb3Jy
ZWN0IGZvcgphbGwgYnV0IHRoZSBtb3N0IHBhdGhvbG9naWNhbCBjYXNlcy4KCi0tCmxhcnNoCg==
