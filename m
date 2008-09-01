From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] for-each-ref: `:short` format for `refname`
Date: Mon, 1 Sep 2008 19:52:03 +0200
Message-ID: <36ca99e90809011052s568fa6e4y89e56769f63806c1@mail.gmail.com>
References: <7vprnpbqmo.fsf@gitster.siamese.dyndns.org>
	 <1220186467-24623-1-git-send-email-bert.wesarg@googlemail.com>
	 <20080901131523.GA6739@neumann>
	 <36ca99e90809010713h7c673d10j6addd1624a655371@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "=?UTF-8?Q?SZEDER_G=C3=A1bor?=" <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Sep 01 19:53:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaDaV-0002nS-JP
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 19:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbYIARwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 13:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbYIARwH
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 13:52:07 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:8730 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbYIARwF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 13:52:05 -0400
Received: by an-out-0708.google.com with SMTP id d40so323331and.103
        for <git@vger.kernel.org>; Mon, 01 Sep 2008 10:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=BUW9M8BN6f7F5J9su3yCjj/W+P4PHpN0Ow67VVVxVHY=;
        b=WTVoUMwavVyOS9dlHgfC7plqjIxD8DRhYByBm1nUyghmGG7zX5eOJVzNiN5Y7UXInr
         +CUj+TIZn72qkN2skHXxexgTFFzjQMjWdUPTJqRRjhyB96CnGMKyRraIiPffBrUNxeFr
         QLzT4DyI/tDYIhXc3OlUm8DwLPP53REORxXPM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Kmm8IkA9w8FUDvVGjZH4HGXBIVQ6LlmkCyS9JuQ3bZ8vwmu1J5XuK4AoQiD7PmagB7
         kLitBPa0EmoTXIK2jGpscSis1/o+xAGSmUswVe2MKreUy3RlJi5PLI+bpzIc5PMi09Fh
         IDuDGVZec0qBIt6XyonG3MRSmIVeoEdwJjG74=
Received: by 10.100.95.19 with SMTP id s19mr6261300anb.97.1220291523681;
        Mon, 01 Sep 2008 10:52:03 -0700 (PDT)
Received: by 10.70.49.12 with HTTP; Mon, 1 Sep 2008 10:52:03 -0700 (PDT)
In-Reply-To: <36ca99e90809010713h7c673d10j6addd1624a655371@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94597>

T24gTW9uLCBTZXAgMSwgMjAwOCBhdCAxNjoxMywgQmVydCBXZXNhcmcgPGJlcnQud2VzYXJnQGdv
b2dsZW1haWwuY29tPiB3cm90ZToKPiBPbiBNb24sIFNlcCAxLCAyMDA4IGF0IDE1OjE1LCBTWkVE
RVIgR8OhYm9yIDxzemVkZXJAaXJhLnVrYS5kZT4gd3JvdGU6Cj4+IEhvd2V2ZXIsIGlmIHdlIGNv
bnNpZGVyIHBvc3NpYmxlIHVzZSBjYXNlcyBvdGhlciB0aGFuIGJhc2ggY29tcGxldGlvbiwKPj4g
SSBkb24ndCBrbm93IHdoaWNoIG9uZSBpcyBtb3JlIHVzZWZ1bC4gIEZvciBleGFtcGxlLCBpZiB5
b3UgaGF2ZSB0d28KPj4gYnJhbmNoZXMgJ2Zvby9iYXInIGFuZCAnZm9vL2JheicsIHRoZW4gJ2dp
dCBtZXJnZSAkKGdpdCBmb3ItZWFjaC1yZWYKPj4gLS1mb3JtYXQ9JShyZWZiYXNlbmFtZSkgcmVm
cy9oZWFkcy9mb28pJyB3aWxsIHdvcmsgYXMgZXhwZWN0ZWQsIGJ1dAo+PiAncmVmbmFtZTpzaG9y
dCcgbm90LCBhcyBpdCB3aWxsIG91dHB1dCBvbmx5ICdiYXInIGFuZCAnYmF6JyB3aGljaCAnZ2l0
Cj4+IG1lcmdlJyBjYW4gbm90IGZpbmQuCj4gWWVhaCwgdGhhdHMgYW4gZGlzYWR2YW50YWdlIGFu
ZCBJIHRob3VnaHQgYWJvdXQgdGhpcywgdG9vLiBCdXQgSSBoYXZlCj4gbm8gcGFydGljdWxhciBv
cGluaW9uIGFib3V0IGl0LgpPaywgSSBoYXZlIGEgbmV3IGlkZWEsIHdoaWNoIGNvdWxkIGJlIG1h
ZGUgYWxsIGhhcHB5OgoKSU1ITyB0aGUgZ29hbCBvZiB0aGlzIG5ldyBmb3JtYXQgZm9yIHJlZm5h
bWUgc2hvdWxkIGJlLCB0aGF0IGl0IGNhbiBiZQp1c2VkIGFzIGFuIHJlZiBvbiB0aGUgY29tbWFu
ZCBsaW5lLiBUaGlzIGlzbid0IGdpdmVuIHdpdGggbXkgY3VycmVudAo6c2hvcnQgcHJvcG9zYWwg
KHdoaWNoIEkgY2FsbCA6c3RyaXAgYXMgb2Ygbm93KSwgYXMgR8OhYm9yIHNob3dlZC4gV2hhdAp3
ZSBuZWVkIGlzIHRoZSByZXZlcnNlIG9mIHdoYXQgaGFwcGVuZWQgd2l0aCByZWZuYW1lcyBnaXZl
biBvbiB0aGUKY29tbWFuZCBsaW5lIHRvIGNvbW1hbmRzIGxpa2UgY2hlY2tvdXQvbWVyZ2UvLi4u
IFRoZSBvbmx5IHRoaW5nIHRoYXQKY29tZXMgbmVhciB0byB0aGlzIGlzIHRoaXMgZnJvbSByZWZz
LmM6CgogICAgY29uc3QgY2hhciAqcmVmX3Jldl9wYXJzZV9ydWxlc1tdID0gewogICAgICAgICAg
ICAiJS4qcyIsCiAgICAgICAgICAgICJyZWZzLyUuKnMiLAogICAgICAgICAgICAicmVmcy90YWdz
LyUuKnMiLAogICAgICAgICAgICAicmVmcy9oZWFkcy8lLipzIiwKICAgICAgICAgICAgInJlZnMv
cmVtb3Rlcy8lLipzIiwKICAgICAgICAgICAgInJlZnMvcmVtb3Rlcy8lLipzL0hFQUQiLAogICAg
ICAgICAgICBOVUxMCiAgICB9OwoKV2hpY2ggZG9lc24ndCBsb29rIHZlcnkgdXNlZnVsLCBiZWNh
dXNlIGV2ZXJ5IHJlZiBmcm9tIGZvcl9lYWNoX3JlZgp3b3VsZCBtYXRjaCBydWxlIG9uZS4gU28g
d2UgcHJvYmFibHkgbmVlZCB0byB0cnkgdGhlIHJldmVyc2Ugb2YgdGhpcwpsaXN0LiBOb3cgbXkg
a25vd2xlZGdlIGZyb20gZ2l0IGludGVybmFscyBpcyByZWFsbHkgbG93LCBJIGRvbid0IGtub3cK
aWYgdGhpcyBpcyBzYW5lLiBJIGtub3cgdGhhdCB0aGlzIGNhbid0IGJlIGJpamVjdGl2ZSBidXQg
YXQgbGVhc3QgdGhlCmJhc2ggY29tcGxldGlvbiB3b3VsZCBiZSBoYXBweSB3aXRoIHRoaXMgaWRl
YS4KCkNvbW1lbnRzLCB0aG91Z2h0cywgYnJvd24gcGFwZXIgYmFncy4uLgoKVGhhbmtzLApCZXJ0
Cg==
