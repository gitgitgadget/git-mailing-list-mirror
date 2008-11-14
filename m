From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH v2 02/11] gitweb: git_get_heads_list accepts an optional list of refs.
Date: Fri, 14 Nov 2008 22:52:45 +0100
Message-ID: <cb7bb73a0811141352p6e46196cq9272b60bba89b951@mail.gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1226616555-24503-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <1226616555-24503-3-git-send-email-giuseppe.bilotta@gmail.com>
	 <200811141948.57785.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 22:54:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L16c7-00006w-Hr
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 22:54:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbYKNVws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 16:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbYKNVws
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 16:52:48 -0500
Received: from qb-out-0506.google.com ([72.14.204.237]:21122 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbYKNVwr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 16:52:47 -0500
Received: by qb-out-0506.google.com with SMTP id f11so1604266qba.17
        for <git@vger.kernel.org>; Fri, 14 Nov 2008 13:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=F7+vCiJhgx61Q31Ch0hvMhDmn8OpZ9/7vSGRgRUCGt8=;
        b=r5Tmf+rakOz6dzfF2UPrHOfJkiLoCKBHNdFcUky9BF0llWv0Zqh0brguyU9Gr8jCMN
         RnhaXMYXNW/Y7Z7Yczju4CjT9qCQqCnlX/AzJP5hpfvPfJprhYQVebMLFtzu95Qxbn5E
         jg6APmvRyaC9TfqUqp5d9LdMkah74DhTDPpJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Pm9sAPEamqaXfDTz6d9/TaaRYze3EI3WPs5F4lwy0xYTwWuEf4NqX4qeFzmRXSddw+
         dXhq6VUtJ2OTKLEuzC4ot9reRbvBpVKT8dmrK/0DUMujqjzwsqMqjPgGHCLRcXZ2bOl2
         JCJ5r9xtEx6DRrzs9oG/7kTM57jNHUtj6XjyQ=
Received: by 10.210.51.10 with SMTP id y10mr1559316eby.98.1226699565698;
        Fri, 14 Nov 2008 13:52:45 -0800 (PST)
Received: by 10.210.132.16 with HTTP; Fri, 14 Nov 2008 13:52:45 -0800 (PST)
In-Reply-To: <200811141948.57785.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101020>

T24gRnJpLCBOb3YgMTQsIDIwMDggYXQgNzo0OCBQTSwgSmFrdWIgTmFyZWJza2kgPGpuYXJlYkBn
bWFpbC5jb20+IHdyb3RlOgo+IERuaWEgY3p3YXJ0ZWsgMTMuIGxpc3RvcGFkYSAyMDA4IDIzOjQ5
LCBHaXVzZXBwZSBCaWxvdHRhIG5hcGlzYbM6Cj4KPj4gZ2l0X2dldF9oZWFkc19saXN0KGxpbWl0
LCBkaXIxLCBkaXIyLCAuLi4pIGNhbiBub3cgYmUgdXNlZCB0byByZXRyaWV2ZQo+PiByZWZzL2Rp
cjEsIHJlZnMvZGlyMiBldGMuIERlZmF1bHRzIHRvICgnaGVhZHMnKSBvciAoJ2hlYWRzJywgJ3Jl
bW90ZXMnKQo+PiBkZXBlbmRpbmcgb24gdGhlIHJlbW90ZV9oZWFkcyBvcHRpb24uCj4KPiBNaW5v
ciBuaXQ6IEkgdGhpbmsgaXQgd291bGQgYmUgYmV0dGVyIHRvIHVzZSB0aGUgc2FtZSB0ZXJtaW5v
bG9neSBpbgo+IGNvbW1pdCBtZXNzYWdlIGFzIGluIGNvZGUsIGkuZS4gJ2NsYXNzMScgaW5zdGVh
ZCBvZiAnZGlyMScsIG9yIHBlcmhhcHMKPiAncmVmX2NsYXNzMScgaWYgaXQgd291bGQgYmUgYmV0
dGVyLgoKVWhtLCByZWYvcmVmX2NsYXNzMSByZWFkcyBob3JyaWJsZSwgYnV0IHN0aWNraW5nIHdp
dGggYSB1bmlmb3JtCnRlcm1pbm9sb2d5IGlzIGEgZ29vZCBwb2ludC4gSSBhZGp1c3RlZCB0aGUg
Y29tbWl0IG1lc3NhZ2UKY29uc2VxdWVudGx5LgoKPiBUaGlzIGlzIG9ubHkgYSBzdWdnZXN0aW9u
LCBidXQgcGVyaGFwcyB0aGlzIHBhdGNoIGNvdWxkIGJlIHNxdWFzaGVkCj4gd2l0aCBhIGxhdGVy
IG9uZT8KCk9yIHdpdGggdGhlIHByZXZpb3VzIG9uZSwgc2luY2UgYXMgeW91IHJlbWFyayBpdCdz
IGEgZ2VuZXJhbGl6YXRpb24gb2YKdGhlIHByZXZpb3VzLgoKPj4gICAgICAgbXkgQGhlYWRzbGlz
dDsKPj4KPj4gLSAgICAgbXkgKCRyZW1vdGVfaGVhZHMpID0gZ2l0d2ViX2NoZWNrX2ZlYXR1cmUo
J3JlbW90ZV9oZWFkcycpOwo+PiAtCj4+ICAgICAgIG9wZW4gbXkgJGZkLCAnLXwnLCBnaXRfY21k
KCksICdmb3ItZWFjaC1yZWYnLAo+PiAgICAgICAgICAgICAgICgkbGltaXQgPyAnLS1jb3VudD0n
LigkbGltaXQrMSkgOiAoKSksICctLXNvcnQ9LWNvbW1pdHRlcmRhdGUnLAo+PiAgICAgICAgICAg
ICAgICctLWZvcm1hdD0lKG9iamVjdG5hbWUpICUocmVmbmFtZSkgJShzdWJqZWN0KSUwMCUoY29t
bWl0dGVyKScsCj4+IC0gICAgICAgICAgICAgJ3JlZnMvaGVhZHMnLCAoICRyZW1vdGVfaGVhZHMg
PyAncmVmcy9yZW1vdGVzJyA6ICcnKQo+PiArICAgICAgICAgICAgIEByZWZzCj4+ICAgICAgICAg
ICAgICAgb3IgcmV0dXJuOwo+PiAgICAgICB3aGlsZSAobXkgJGxpbmUgPSA8JGZkPikgewo+PiAg
ICAgICAgICAgICAgIG15ICVyZWZfaXRlbTsKPgo+IFNvIHRoaXMgaXMgYSBiaXQgb2YgZ2VuZXJh
bGl6YXRpb24gb2YgKHBhcnQgb2YpIHByZXZpb3VzIHBhdGNoLAo+IGlzbid0IGl0PwoKUHJlY2lz
ZWx5LiBJIG11c3Qgc2F5IEkgaGFkIHByb2JsZW1zIGZpbmRpbmcgdGhlIHByb3BlciBzcGxpdHRp
bmcKcG9pbnQgZm9yIHNvbWUgb2YgdGhlc2UgcGF0Y2hlcywgYmVjYXVzZSB0aGV5IGhhZCBhIHZl
cnkgb3JnYW5pYwpldm9sdXRpb24sIGJ1dCBhdCB0aGUgc2FtZSB0aW1lIHNxYXNoaW5nIHRoZW0g
dG9nZXRoZXIgd291bGQgZ2l2ZSB0b28KbGFyZ2UgY2hhbmdlc2V0cyBhdCBvbmNlLiBZb3UnbGwg
ZmluZCB0aGF0IHRoaXMgaXMgbm90IHRoZSBvbmx5IHBhdGNoCnRoYXQgbWFrZXMgdGhlIG1vc3Qg
c2Vuc2Ugb25seSBhZnRlciBzZWVpbmcgd2hhdCBjb21lcyBsYXRlci4KCi0tIApHaXVzZXBwZSAi
T2Jsb21vdiIgQmlsb3R0YQo=
