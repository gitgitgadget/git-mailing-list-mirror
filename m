From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH v2] Let mailsplit and mailinfo handle mails with CRLF 
	line-endings
Date: Wed, 5 Aug 2009 00:04:13 +0200
Message-ID: <81b0412b0908041504p335c05c9ibed039a4b3cd9c33@mail.gmail.com>
References: <4A7735B0.2040703@zytor.com>
	 <81b0412b0908032335s3363849aj32a0e93efa15c012@mail.gmail.com>
	 <7v7hxk5b4y.fsf@alter.siamese.dyndns.org>
	 <20090804172638.GA15136@blimp.localdomain>
	 <20090804210327.GA23747@blimp.localdomain>
	 <H9KDJzU0XgndJHC8J4OETn7kxYhGP3gl0YJPR0low0hfIHjZOUsoxw@cipher.nrlssc.navy.mil>
	 <81b0412b0908041458w7e76854bn96c4cb71a5e91e74@mail.gmail.com>
	 <81b0412b0908041503o21f6347ewe60e92a4cb277fd9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: Junio C Hamano <gitster@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Aug 05 00:04:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYS7V-0002A1-1s
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 00:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933417AbZHDWEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 18:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933411AbZHDWEO
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 18:04:14 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:55797 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933407AbZHDWEO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 18:04:14 -0400
Received: by fxm17 with SMTP id 17so3556016fxm.37
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 15:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xbr9xSglAF8r3GQMe5H9wnkpWyN7LeAxef6zYnOLs68=;
        b=UmzG5fRhlfeXMZnNU2yDHFAHBKK4crOXPhOT3g7UIkPGOEFCv63HYjAjdEwrr9KBWS
         ubYVDbWa08f3uBTXvkZ1CJUDrs0x1ofGY2V+MNhWqlefm14mcGPkp2NAi6paPHQZjXTp
         UzCqTTlliSYJn02pxJgS+SP/Lvppdjk/iRINs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MWjnM9Q10B7n1uSkLg+m/g5dS/QODqb/kxwJ3JBs1LKEDuCAP+6XPaSdvKM+2eCIEF
         BE2q1wsPrQTEkD6IyQQZqLRyqXtgnE7LsdfdOlufg3Cxk1UTPIBZXW1L1MYX1ZJdXoNH
         e8MXwV0ovsmTnpvHot0CS5P6mII38C79aylRY=
Received: by 10.204.50.195 with SMTP id a3mr158123bkg.123.1249423453544; Tue, 
	04 Aug 2009 15:04:13 -0700 (PDT)
In-Reply-To: <81b0412b0908041503o21f6347ewe60e92a4cb277fd9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124824>

T24gV2VkLCBBdWcgNSwgMjAwOSBhdCAwMDowMywgQWxleCBSaWVzZW48cmFhLmxrbWxAZ21haWwu
Y29tPiB3cm90ZToKPiBPbiBUdWUsIEF1ZyA0LCAyMDA5IGF0IDIzOjU4LCBBbGV4IFJpZXNlbjxy
YWEubGttbEBnbWFpbC5jb20+IHdyb3RlOgo+PiBpbnQgcmVhZF9saW5lX3dpdGhfbnVsKGNoYXIg
KmJ1ZiwgaW50IHNpemUsIEZJTEUgKmluKQo+PiB7Cj4+IMKgIMKgIMKgIMKgaW50IGxlbiA9IDAs
IGM7Cj4+Cj4+IMKgIMKgIMKgIMKgd2hpbGUgKGxlbiA8IHNpemUpIHsKPgo+ICJmb3IgKDs7KSIs
IG9mIGNvdXJzZS4gTGVmdG92ZXIgZnJvbSBkZXZlbG9wbWVudCBwcm9jZXNzCgpBaG0uLi4gTm8s
IGl0cyBub3QhIEl0cyBjb3JyZWN0IDopCkdvb2QgbmlnaHQsIGV2ZXJ5Ym9keS4KCj4+IMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgYyA9IGdldGMoaW4pOwo+PiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGlmIChjID09IEVPRikKPj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVh
azsKPj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBidWZbbGVuKytdID0gYzsKPj4gwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBpZiAoYyA9PSAnXG4nKQo+PiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGJyZWFrOwo+PiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVsc2UgaWYgKGxlbiA9
PSBzaXplKQo+PiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGMgPSAwOwo+PiDC
oCDCoCDCoCDCoH0KPj4gwqAgwqAgwqAgwqBpZiAoYyA9PSAnXG4nICYmIGxlbiA+IDEgJiYgYnVm
W2xlbiAtIDJdID09ICdccicpCj4+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnVmWy0tbGVuIC0g
MV0gPSAnXG4nOwo+PiDCoCDCoCDCoCDCoGJ1ZltsZW5dID0gJ1wwJzsKPj4KPj4gwqAgwqAgwqAg
wqByZXR1cm4gbGVuOwo+PiB9Cj4+Cj4K
