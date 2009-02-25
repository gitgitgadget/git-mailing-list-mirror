From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH RESEND] Fix a bunch of pointer declarations (codestyle)
Date: Wed, 25 Feb 2009 12:02:25 +0200
Message-ID: <94a0d4530902250202rb12a4e7leb9856258dafc488@mail.gmail.com>
References: <1235512745-26814-1-git-send-email-felipe.contreras@gmail.com>
	 <7veixnaqrn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 11:03:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcGcQ-0005BG-Fx
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 11:03:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759436AbZBYKCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 05:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758991AbZBYKCa
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 05:02:30 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:55483 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756320AbZBYKC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 05:02:29 -0500
Received: by fg-out-1718.google.com with SMTP id 16so231073fgg.17
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 02:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=U87IwltqwMyrXApXFx+TFkw0XyfFbu23qeQNrNodiK0=;
        b=V7PbbyBv66zguuqG7+IFxkP5L+UVFL9sicS7RSiT77hlc9cqpSa5ukKGxttHjyjbpA
         NAQTzIbKs7Ulr22KTpQSLk7py46z6ULjvOwibMtmS1qrKR5Arm2Lg6rSJnPkDOh+ZNL/
         nEyizrslrOu4svxr0ALWrUt+RqWfGuYCLV24I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=X5h4OZTEhC46JuD7uzZWL9q72jvMv0DHc9fQIUm9x8G1baPQPqSFGKRPd3Aq3KIK0q
         51TvcECka3kEFGv7n+b5FshBfP0GFiEZIypRNWRpYMVGtRH9vCQco4AKejuSLgJi5HhI
         Q3szBY0EE4qxoLGYF0lTwjknWkBkAaBJb4eqM=
Received: by 10.86.95.20 with SMTP id s20mr397774fgb.43.1235556145671; Wed, 25 
	Feb 2009 02:02:25 -0800 (PST)
In-Reply-To: <7veixnaqrn.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111434>

T24gV2VkLCBGZWIgMjUsIDIwMDkgYXQgMTA6MDIgQU0sIEp1bmlvIEMgSGFtYW5vIDxnaXRzdGVy
QHBvYm94LmNvbT4gd3JvdGU6Cj4gRmVsaXBlIENvbnRyZXJhcyA8ZmVsaXBlLmNvbnRyZXJhc0Bn
bWFpbC5jb20+IHdyaXRlczoKPgo+PiBUaGlzIGFwcGxpZXMgb24gdG9wIG9mIHRoZSAnbmV4dCcg
YnJhbmNoLgo+Pgo+PiDCoGFsaWFzLmMgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgfCDCoCDCoDQgKy0KPj4gwqBhbGxvYy5jIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHwgwqAgwqAyICstCj4+IMKgYXR0
ci5jIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
fCDCoCDCoDQgKy0KPj4gwqBidWlsdGluLWJsYW1lLmMgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgfCDCoCDCoDggKysrLS0tCj4+IMKgYnVpbHRpbi1jaGVja291dC1pbmRl
eC5jIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfCDCoCDCoDQgKy0KPj4gwqBidWlsdGluLWRl
c2NyaWJlLmMgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IMKgIMKgNCArLQo+
PiDCoGJ1aWx0aW4tZmV0Y2gtcGFjay5jIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
fCDCoCDCoDIgKy0KPj4gwqBidWlsdGluLWhlbHAuYyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHwgwqAgwqA2ICsrLS0KPj4gwqBidWlsdGluLXVwZGF0ZS1pbmRleC5j
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfCDCoCDCoDYgKystLQo+PiDCoGNhY2hlLmgg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfCDCoCDC
oDIgKy0KPj4gwqBjb21iaW5lLWRpZmYuYyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHwgwqAgwqA0ICstCj4+IMKgY29tcGF0L21pbmd3LmMgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IMKgIMKgMiArLQo+PiDCoGNvbmZpZy5jIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfCDCoCAzMCArKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tCj4+IMKgY29udHJpYi9jb252ZXJ0LW9iamVjdHMvY29u
dmVydC1vYmplY3RzLmMgfCDCoCDCoDYgKystLQo+PiDCoGRpZmYtbm8taW5kZXguYyDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8IMKgIMKgMiArLQo+PiDCoGRpZmYuYyDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHwgwqAg
wqA2ICsrLS0KPj4gwqBkaXIuYyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCB8IMKgIMKgMiArLQo+PiDCoGZhc3QtaW1wb3J0LmMgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfCDCoCAxNCArKysrKystLS0tLS0KPj4g
wqBnaXQuYyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCB8IMKgIMKgOCArKystLS0KPj4gwqBodHRwLmMgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IMKgIMKgNCArLQo+PiDCoGxvY2tmaWxlLmMg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IMKgIMKgMiAr
LQo+PiDCoHJlZmxvZy13YWxrLmMgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgfCDCoCDCoDIgKy0KPj4gwqBydW4tY29tbWFuZC5jIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHwgwqAgwqAyICstCj4+IMKgc2VydmVyLWluZm8uYyDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8IMKgIMKgNCArLQo+PiDCoHNo
YTFfZmlsZS5jIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHwg
wqAgwqAyICstCj4+IMKgd3Qtc3RhdHVzLmMgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgfCDCoCDCoDIgKy0KPgo+IFNvcnJ5LCBidXQgSSBjYW5ub3QgdGFrZSB0
aGlzIGFzIGlzLgo+Cj4gVGhlc2UgdHJpdmlhbCBjbGVhbi11cHMgYXJlIHdlbGNvbWUgZWl0aGVy
IGFzIHBhcnQgb2YgYSBwcmVwYXJhdG9yeQo+IGNsZWFuLXVwIGJlZm9yZSBzdGFydGluZyB0byB3
b3JrIGluIHRoZSBhcmVhIG9mIGNvZGUgeW91IGFyZSB0b3VjaGluZywgb3IKPiBhcyBhIHN0YW5k
YWxvbmUgcGF0Y2ggdG8gZmlsZXMgdGhhdCBub2JvZHkgaXMgY3VycmVudGx5IHdvcmtpbmcgb24u
Cj4KPiBUaGVyZSBpcyBhIGh1Z2Ugb3ZlcmxhcCBiZXR3ZWVuICJnaXQgZGlmZiAtLW5hbWUtb25s
eSBtYXN0ZXIuLnB1IiBhbmQgdGhlCj4gYWJvdmUgbGlzdCwgc28gaXQgaXMgaW1wb3NzaWJsZSBm
b3IgbWUgdG8gdGFrZSB0aGUgcGF0Y2ggYW5kIEkgY2Fubm90Cj4gYWZmb3JkIHRoZSB0aW1lIHRv
IHNpZnQgdGhyb3VnaCBnZW1zIG91dCBvZiBzdG9uZXMuCgogSXQncyB1bmRlcnN0YW5kYWJsZS4g
V291bGQgdGhlcmUgYmUgYSBiZXR0ZXIgdGltZSB0byBzZW5kIHRoaXMgcGF0Y2g/CkFmdGVyIDEu
Ni4yLCBvciBpbiBhIGRpZmZlcmVudCBmb3JtPwoKLS0gCkZlbGlwZSBDb250cmVyYXMK
