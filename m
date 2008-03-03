From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [RFC] git reset --recover
Date: Tue, 4 Mar 2008 00:47:08 +0800
Message-ID: <46dff0320803030847t42583badw1f5163d600a6fafb@mail.gmail.com>
References: <46dff0320803030659j2fa0325lf9c88b915ddb70da@mail.gmail.com>
	 <8aa486160803030713r7bdcf825sf994cbb20f096ccd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "=?UTF-8?Q?Santi_B=C3=A9jar?=" <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 17:47:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWDpN-0000zD-Nh
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 17:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720AbYCCQrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 11:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753629AbYCCQrK
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 11:47:10 -0500
Received: from an-out-0708.google.com ([209.85.132.240]:12612 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905AbYCCQrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 11:47:09 -0500
Received: by an-out-0708.google.com with SMTP id d31so21177and.103
        for <git@vger.kernel.org>; Mon, 03 Mar 2008 08:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=HQ7PuktV2TfIWqePlX+YrLkgHR2hLxqKIVvePBenuI8=;
        b=GNwC8Ge8EA4fh6hl8+7HAdqFxrAv5LGlFx1botFUYuEHMmO4Z0uu/oGezLmopg+T3z/8VAt8g5fN6XmIpQV7rY8PKDzOO5oz4fhfTbR/UJSwioQl9Q47mb1mfw2dr1qiW9PgJRl40UuYl6fIvVSe+EQv2UBmgwk6+rxRunZ63Ag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=u9GQBoIjMw1BDPK313F3kBlLjyBVhXWtT1uPBtBJaW6Lhy8mEkJ7ctqX75Gbzx/PhF/1vfkLgTyxwveVmoBFEEWwL2yUWmX2fyIqOjRc/vwJByFWY0NG8HMiYh78lX5uvhYBbNP+zAlCZbkvsXGyP8S0K3KT5Cl/ss3cLE388DA=
Received: by 10.100.95.19 with SMTP id s19mr341521anb.48.1204562828224;
        Mon, 03 Mar 2008 08:47:08 -0800 (PST)
Received: by 10.100.95.20 with HTTP; Mon, 3 Mar 2008 08:47:08 -0800 (PST)
In-Reply-To: <8aa486160803030713r7bdcf825sf994cbb20f096ccd@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75942>

T24gTW9uLCBNYXIgMywgMjAwOCBhdCAxMToxMyBQTSwgU2FudGkgQsOpamFyIDxzYmVqYXJAZ21h
aWwuY29tPiB3cm90ZToKPiBPbiBNb24sIE1hciAzLCAyMDA4IGF0IDM6NTkgUE0sIFBpbmcgWWlu
IDxwa3VmcmFua3lAZ21haWwuY29tPiB3cm90ZToKPiAgPiBUb2RheSBpIHVzZSBnaXQgcmVzZXQg
Y2FyZWxlc3NseSBhbmQgbG9zZSBhbGwgbXkgY2hhbmdlcyEKPiAgPgoKPiAgPgo+ICA+ICBidXQg
aSBmb2dvdCB0byB0eXBlICJnaXQgaW5pdCIgd2hpY2ggcmVzdWx0cyB0aGF0IGZpbGUxIGFuZCBm
aWxlMiBhcmUKPiAgPiAgYWRkZWQgdG8gaW5kZXggb2YgZm9vIHJlcG9zaXRvcnkuIEkgdHJpZWQg
dG8gcmV2ZXJ0IHRoZSBvcGVyYXRpb24KPiAgPiAgdXNpbmcgImdpdCByZXNldCIuIEFuZCB0aGUg
dHJhZ2VkeSBoYXBwZW5lZCBhdCB0aGF0IHRpbWUgYmVjYXVzZSBpCj4gID4gIG1hZGUgc28gZmF0
YWwgIGEgbWlzdGFrZSB0aGF0IGkgdHlwZWQgImdpdCByZXNldCAtLWhhcmQiLiBBbmQgaSBsb3N0
Cj4gID4gIGFsbCBteSBmaWxlcyBpbiBiYXIgZGlyIQo+Cj4gICJnaXQgcmVzZXQiIHdhcyBzdWZm
aWNpZW50Lgo+Ckkga25vdyBhYm91dCB0aGlzLCBidXQgaSB3YXMganVzdCB0b28gY2FyZWxlc3Mu
Cj4KPiAgPgo+ICA+ICBTbywgY2FuIHdlIGludHJvZHVjZSBhIC0tcmVjb3ZlciBvcHRpb24gZm9y
ICJnaXQgcmVzZXQiIHRvIHNhdmUgdGhlCj4gID4gIGZvb2xpc2ggb3IgY2FyZWxlc3MgcGVvcGxl
IGxpa2UgbWU/Cj4KPiAgQW5vdGhlciBwb3NzaWJpbGl0eSB3b3VsZCBiZSB0byBub3QgZGVsZXRl
IGEgZmlsZSB0aGF0IGlzIGFic2VudCBpbgo+ICBib3RoIHRoZSBvbGQgYW5kIG5ldyBIRUFELCBl
dmVuIGlmIGl0IHdhcyBpbiB0aGUgaW5kZXguCj4KU291bmRzIGludGVyZXN0aW5nLgo+ICBTYW50
aQo+CgoKCi0tIApQaW5nIFlpbgo=
