From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [RFC PATCH 0/9] Narrow/Sparse checkout round 3: "easy mode"
Date: Sat, 30 Aug 2008 16:21:50 +0700
Message-ID: <fcaeb9bf0808300221q12d1d984mdf78c81363a909d1@mail.gmail.com>
References: <20080815142439.GA10609@laptop>
	 <loom.20080819T210550-149@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "James Pickens" <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 11:22:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZMfa-0004Dn-Da
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 11:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbYH3JVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 05:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752409AbYH3JVx
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 05:21:53 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:42837 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbYH3JVw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 05:21:52 -0400
Received: by fg-out-1718.google.com with SMTP id 19so749253fgg.17
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 02:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=fuPFPBT5eupdk3keohAsfMZ5EuUu8ie7Ykxs5CI3OLE=;
        b=ZR6CHBGgfIWfg1jT+gpZJxDaa/86QoDa2cF5vSNDiEDf5ZMwR5+ZQJSutaUraHBxsW
         eMb631a3MyZp9xi0I6kowVU9UvlOukuVY1zdUfnkxcSDlz2yuxyFnlrb67rk2CHmRpaE
         t6uJNKzxe1skxL6afg4qZ+FT/LlWVlb4ygTfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=GuXz3heQLYkA0wCXOGBwaXbFkBicLAV1239nUzLYHVA4EJMmWt9i3KeZJ9l7FWGM6E
         MsZlGS6hL4xspBhU4QyFn2JO6iyE8VVQ1oq7tCKqvbnftRAvhWfMzgf8eidOqOf3g/uy
         gRidFNXVtxctgyFFCyaXUXcK4GUTE8f1lmoiA=
Received: by 10.86.93.19 with SMTP id q19mr2804394fgb.76.1220088110753;
        Sat, 30 Aug 2008 02:21:50 -0700 (PDT)
Received: by 10.86.30.20 with HTTP; Sat, 30 Aug 2008 02:21:50 -0700 (PDT)
In-Reply-To: <loom.20080819T210550-149@post.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94364>

T24gOC8yMC8wOCwgSmFtZXMgUGlja2VucyA8amVwaWNrZW5AZ21haWwuY29tPiB3cm90ZToKPiBO
Z3V54buFbiBUaMOhaSBOZ+G7jWMgRHV5IDxwY2xvdWRzIDxhdD4gZ21haWwuY29tPiB3cml0ZXM6
Cj4KPiAgPiBGcm9tIHVzZXIgUE9WLCB3ZSBjYW4gbm93IGNoZWNrb3V0IGEgc2luZ2xlIGZpbGUg
b3IgYQo+ICA+IHN1YmRpcmVjdG9yeSAoY2hlY2tpbmcgb3V0IHN1YmRpcmVjdG9yeSBub24tcmVj
dXJzaXZlbHkgaXMKPiAgPiBwb3NzaWJsZSB0b28pLiBZb3UgbWF5IHN0YXJ0IHdpdGggYSBuYXJy
b3cgY2xvbmUgbGlrZToKPgo+Cj4gSXMgdGhlcmUgYW55IHJlYXNvbiBmb3IgdGhlIGNoYW5nZSBp
biB0ZXJtaW5vbG9neSBmcm9tICJzcGFyc2UiCj4gIHRvICJuYXJyb3ciPyAgSSB1bmRlcnN0YW5k
IHRoZSBkaWZmZXJlbmNlIGJldHdlZW4gInBhcnRpYWwiCj4gIGFuZCAic3BhcnNlIiwgYnV0IEkg
Y2FuJ3QgdGVsbCBpZiB0aGVyZSdzIGFueSBkaWZmZXJlbmNlCj4gIGJldHdlZW4gIm5hcnJvdyIg
YW5kICJzcGFyc2UiLiAgSWYgdGhleSBhcmUgdGhlIHNhbWUgdGhpbmcsIHRoZW4KPiAgSSB0aGlu
ayAic3BhcnNlIiBpcyB0aGUgYmV0dGVyIHRlcm0uCgpJIGhhdmUgbm8gcGFydGljdWxhciBwcmVm
ZXJlbmNlLiBJdCdzIHVwIHRvIHRoZSBjb21tdW5pdHkgdG8gY2hvb3NlIHRoZSBuYW1lLgoKPiAg
PiBMYXN0IGJpdC4gIk5hcnJvdyBydWxlcyIgZm9yIC0tcGF0aHwtLWFkZC1wYXRofC0tcmVtb3Zl
LXBhdGggaXMKPiAgPiBjdXJyZW50bHkgd2lsZGNhcmRzIHNlcGFyYXRlZCBieSBjb2xvbnMuIFdo
aWxlIGl0IGRvZXMgdGhlIGpvYiwKPiAgPiBpdCBkb2VzIG5vdCBhbGxvdyB0byBjaGVja291dCBl
YXNpbHkgYSBzdWJkaXJlY3RvcnkKPiAgPiBub24tcmVjdXNpdmVseS4gSSB3YXMgdGhpbmtpbmcg
YWJvdXQgJyonIGFzICJtYXRjaCBldmVyeXRoaW5nCj4gID4gZXhjZXB0IHNsYXNoZXMiIGFuZCAn
KionIGFzICJtYXRjaCBldmVyeXRoaW5nIGV2ZW4gc2xhc2hlcyIuCj4KPgo+IEkgbGlrZSB0aGlz
IGlkZWEgLSBpdCB3b3VsZCBtYWtlIHRoaXMgbXVjaCBtb3JlIGludHVpdGl2ZSB0byB1c2UsCj4g
IHNpbmNlICcqJyBhbmQgJyoqJyB3b3VsZCB3b3JrIHRoZSBzYW1lIGFzIHRoZXkgZG8gaW4gdGhl
Cj4gIHNoZWxsIChmb3Igc2hlbGxzIHRoYXQgc3VwcG9ydCAnKionIGF0IGxlYXN0KS4gIEkgdHJp
ZWQgdGhlIHBhdGNoCj4gIGluIGl0J3MgY3VycmVudCBmb3JtLCBhbmQgaXQgdG9vayBtZSBhIHdo
aWxlIHRvIGZpZ3VyZSBvdXQgdGhhdAo+ICBwYXRocyB3ZXJlIG5vbi1yZWN1cnNpdmUgYW5kICcq
JyB3YXMgbWF0Y2hpbmcgZXZlcnl0aGluZywKPiAgaW5jbHVkaW5nIHNsYXNoZXMuCgpUcmllZCB0
aGUgbGFzdCBmZXcgZGF5cyBidXQgaXQgd2FzIG5vdCBlYXN5LCBuZWVkZWQgdG8gZHVwbGljYXRl
CmZubWF0Y2ggY29kZS4gSSBtYXkgY29tZSB1cCB3aXRoIGEgbGVzcyBwb3dlcmZ1bCBzeW50YXgg
Zm9yCnJlY3VzaXZlL25vbi1yZWN1cnNpdmUgJyonLgotLSAKRHV5Cg==
