From: Alexander Rettig <alexander.rettig@askvisual.de>
Subject: Re: Gitk cannot start in the latest version when using --all
Date: Wed, 30 Sep 2015 14:06:04 +0000 (UTC)
Message-ID: <loom.20150930T155320-343@post.gmane.org>
References: <560A94E7.9090506@notk.org> <20150929164951.cd5dea4ab0e866e4a0b74d6f@domain007.com> <560A9772.80503@notk.org> <20150929165903.893d668b86583dcf2085884b@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 30 16:10:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhI5H-000674-CQ
	for gcvg-git-2@plane.gmane.org; Wed, 30 Sep 2015 16:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536AbbI3OKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 10:10:10 -0400
Received: from plane.gmane.org ([80.91.229.3]:41701 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751914AbbI3OKI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 10:10:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZhI57-0005z6-20
	for git@vger.kernel.org; Wed, 30 Sep 2015 16:10:05 +0200
Received: from 79.171.91.23 ([79.171.91.23])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 Sep 2015 16:10:05 +0200
Received: from alexander.rettig by 79.171.91.23 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 Sep 2015 16:10:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 79.171.91.23 (Mozilla/5.0 (X11; Linux x86_64; rv:40.0) Gecko/20100101 Firefox/40.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-Spam-Report: 5.4 points;
 *  2.6 RCVD_NUMERIC_HELO Received: contains an IP address used for HELO
 *  2.8 BASE64_LENGTH_79_INF BODY: BASE64_LENGTH_79_INF
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278846>

S29uc3RhbnRpbiBLaG9tb3V0b3YgPGtvc3RpeCtnaXQgPGF0PiAwMDdzcGIucnU+IHdyaXRlczoKCj4gCj4gT24gVHVlLCAyOSBTZXAgMjAxNSAxNTo1MTo0NiArMDIwMAo+IENocmlzdG9waGUgQ09FVk9FVCA8c3RvZiA8YXQ+IG5vdGsub3JnPiB3cm90ZToKPiAKPiA+ID4+IEknbSBpbnN0YWxsaW5nIGdpdCBhbmQgZ2l0ayBmcm9tIHRoZSBVYnVudHUgUFBBIG1haW50YWluZWQgYnkgdGhlCj4gPiA+PiBHaXQgdGVhbS4gSSByZWNlaXZlZCB0aGUgR2l0IDIuNiB1cGRhdGUgdG9kYXkuCj4gPiA+PiBTaW5jZSB0aGlzIHVwZGF0ZSwgSSdtIHVuYWJsZSB0byBsYXVuY2ggZ2l0ayB3aXRoIC0tYWxsLiBJJ20KPiA+ID4+IHJlY2VpdmluZyB0aGUgZm9sbG93aW5nIGVycm9yIG1lc3NhZ2U6Cj4gPiA+Pgo+ID4gPj4gRXJyb3IgaW4gc3RhcnR1cCBzY3JpcHQ6IGJhZCBtZW51IGVudHJ5IGluZGV4ICLDiWRpdGVyIGxhIHZ1ZS4uLiIKPiA+ID4+ICAgICAgIHdoaWxlIGV4ZWN1dGluZwo+ID4gPj4gIi5iYXIudmlldyBlbnRyeWNvbmYgW21jYSAiRWRpdCB2aWV3Li4uIl0gLXN0YXRlIG5vcm1hbCIKPiA+ID4+ICAgICAgIGludm9rZWQgZnJvbSB3aXRoaW4KPiA+
 ID4+ICJpZiB7JGNtZGxpbmVfZmlsZXMgbmUge30gfHwgJHJldnRyZWVhcmdzIG5lIHt9IHx8ICRyZXZ0cmVlYXJnc2NtZAo+ID4gPj4gbmUge319IHsKPiA+ID4+ICAgICAgICMgY3JlYXRlIGEgdmlldyBmb3IgdGhlIGZpbGVzL2RpcnMgc3BlY2lmaWVkIG9uIHRoZSBjb21tYW5kCj4gPiA+PiAgICAgICAjIGxpbmUKPiA+ID4+ICAgICAgIHNlLi4uIgo+ID4gPj4gICAgICAgKGZpbGUgIi91c3IvYmluL2dpdGsiIGxpbmUgMTI0NDIpCj4gWy4uLl0KPiA+ID4gRG9lcyBpdCBzdGFydCBpZiB5b3UgcnVuIGl0IHZpYQo+ID4gPgo+ID4gPiAkIExBTkc9QyBnaXRrIC0tYWxsCj4gPiA+Cj4gPiA+IG9yCj4gPiA+Cj4gPiA+ICQgTEFORz1lbl9VUy5VVEYtOCBnaXRrIC0tYWxsCj4gPiA+Cj4gPiA+ID8KPiA+IFllYWgsIGJvdGggb2YgdGhlc2UgY29tbWFuZHMgYXJlIHdvcmtpbmcgZmluZS4KPiAKPiBPSywgc28gdGhlIHByb2JsZW0gaXMgdGhhdCBzb21lIG1lbnUgZW50cnkgaGFzIHRoZSB0aXRsZSAiRWRpdCB2aWV3Li4uIgo+IHdoaWNoIGlzIGZvciBzb21lIHJlYXNvbiBub3QgdHJhbnNsYXRlZCBmb3IgeW91ciBjdXJyZW50IGxvY2FsZSwKPiBhbmQgdG
 hlbiBzb21lIGNvZGUgdHJpZXMgdG8gbG9jYXRlIGl0IHVzaW5nIHRoZSBvcmlnaW5hbCB0aXRsZQo+IHRyYW5zbGF0ZWQgdG8gRnJlbmNoIC0tIEkgZmF0aG9tIHRoZSBjb21tYW5kIFttY2FdIGJlaW5nIGNhbGxlZCBoZXJlCj4gc3RhbmRzIGZvciAiTWVzc2FnZSBDYXRhbG9nIEEtc29tZXRoaW5nIiAKPgoKSGVsbG8sIEkgbm90aWNlIHRoZSBzYW1lIHByb2JsZW0gKHVwZGF0ZWQgdG8gZ2l0ayAyLjYuMCBvbiBvcGVuU1VTRSkKCkl0IGlzIG5vdCBvbmx5IGEgcHJvYmxlbSB3aXRoIHRoZSBHZXJtYW4gdHJhbnNsYXRpb24gYnV0IGFsc28gd2l0aCBvdGhlcnMsIEkKYWRkaXRpb25hbGx5IHRyaWVkIEZyZW5jaCBhbmQgSmFwYW5lc2UuCgpCdXQgZXZlbiBzdHJhbmdlciwgZ2l0ayBzdGFydHMgY29ycmVjdGx5LCB3aGVuIG5vIGNvbW1hbmQgbGluZSBhcmd1bWVudHMgYXJlCmdpdmVuIGluIHRoZXNlIGxvY2FsZXMgKGFuZCB0aGUgR2VybWFuIGxvY2FsZSksIGJ1dCB3aXRoIGFueSBjb21tYW5kIGxpbmUKYXJndW1lbnQgSSB0cmllZCAoZS5nLiBvbmx5ICdnaXRrIC4nKSBpdCBjcmFzaGVzIHdpdGggdGhlIGVycm9yIG1lc3NhZ2UKbWVudGlvbmVkIGFi
 b3ZlICh0aGV5IGRpZmZlciBpbiB0aGUgdGV4dCAnYmFkIG1lbnUgZW50cnkgaW5kZXggIsOJZGl0ZXIgbGEKdnVlLi4uIicsIHRoZXJlIHRoZSB0cmFuc2xhdGVkIHRleHQgb2YgdGhlIGxvY2FsZSBpcyBzaG93bikKCkZ1cnRoZXJtb3JlIEkgY2hlY2tlZCB0aGUgdHJhbnNsYXRpb24gZmlsZXMsIHRoZXJlIHNlZW1zIHRvIGJlIGFuCmFwcHJvcHJpYXRlIGVudHJ5IGZvciAiRWRpdCB2aWV3Li4uIiBmb3IgYWxsIGxhbmd1YWdlcy4K
