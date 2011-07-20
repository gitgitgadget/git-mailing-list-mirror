From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC update] Sequencer for inclusion v2
Date: Wed, 20 Jul 2011 14:32:24 +0530
Message-ID: <CALkWK0n9HyzSWq_3y82NgyLqM7Dw5K9X+=N0=cQx+2U7Mx4rCA@mail.gmail.com>
References: <1311095876-3098-1-git-send-email-artagnon@gmail.com> <7vbowq9kfr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 20 11:02:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjSg7-0006Au-LC
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 11:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275Ab1GTJCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 05:02:47 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42461 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269Ab1GTJCq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 05:02:46 -0400
Received: by wyg8 with SMTP id 8so13107wyg.19
        for <git@vger.kernel.org>; Wed, 20 Jul 2011 02:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=pRYtTd4KHToYY9oylm9RBl/nKB/uiGAQ2N+6biMHH2o=;
        b=kgAG0WjxhDuezj2KsVtyOuAjDjO9ruboJkAb1mdH/o1wM5Io5rBWUjK6jEbtmWFWGY
         bYQNo3SLsmq/Fs890ptF1tpOF64Z6NQWTH7KaH64E+P+X3u90vG6FCbr574RDlv3qxac
         xXiaEKi/eySEQWzDJBMc/dkadO+ztXPCWwYIM=
Received: by 10.216.70.14 with SMTP id o14mr8036176wed.111.1311152565103; Wed,
 20 Jul 2011 02:02:45 -0700 (PDT)
Received: by 10.216.234.143 with HTTP; Wed, 20 Jul 2011 02:02:24 -0700 (PDT)
In-Reply-To: <7vbowq9kfr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177527>

SGkgSnVuaW8sCgpKdW5pbyBDIEhhbWFubyB3cml0ZXM6Cj4gUmFta3VtYXIgUmFtYWNoYW5kcmEg
PGFydGFnbm9uQGdtYWlsLmNvbT4gd3JpdGVzOgo+Pj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgaWYgKCFjdXItPm5leHQpCj4+Pj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCAvKgo+Pj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAqIEFuIGVycm9yIHdhcyBlbmNvdW50ZXJlZCB3aGlsZQo+Pj4+ICsgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAqIHBpY2tpbmcgdGhlIGxh
c3QgY29tbWl0OyB0aGUKPj4+PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgKiBzZXF1ZW5jZXIgc3RhdGUgaXMgdXNlbGVzcyBub3cgLS0KPj4+PiArIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKiB0aGUgdXNlciBzaW1wbHkg
bmVlZHMgdG8gcmVzb2x2ZQo+Pj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAqIHRoZSBjb25mbGljdCBhbmQgY29tbWl0Cj4+Pj4gKyDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCovCj4+Pj4gKyDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZW1vdmVfc2VxdWVuY2VyX3N0YXRlKCk7Cj4+Pj4g
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIHJlczsKPj4+PiArIMKgIMKg
IMKgIMKgIMKgIMKgIH0KPj4+PiDCoCDCoCDCoCB9Cj4+Pgo+Pj4gSXQgbWF5IGJlIHVzZWxlc3Mg
Zm9yIC0tY29udGludWUsIGJ1dCB3b3VsZG4ndCAtLWFib3J0IG5lZWQgc29tZSBjbHVlIG9uCj4+
PiB3aGF0IHlvdSB3ZXJlIGRvaW5nPwo+PiAuLi4KPj4gQ29uY2x1c2lvbjogTWFraW5nICJnaXQg
Y29tbWl0IiByZW1vdmUgdGhlIHNlcXVlbmNlciBzdGF0ZSBpcyBXUk9ORy4KPgo+IFdoeSBub3Qg
Y2hvb3NlIHRvIG5vdCB0byBjbGVhbiBpdCBhdCBhbGw/IMKgVGhlbiAicmViYXNlIC0tY29udGlu
dWUiIGFuZAo+IGl0cyBlcXVpdmFsZW50IHRvIGNoZXJyeS1waWNrLCByZWJhc2UgYW5kIGFueSBz
ZXF1ZW5jZSBjb21tYW5kKSBjYW4gKGFuZAo+IGhhdmUgdG8gYW55d2F5KSBub3RpY2UgdGhhdCB0
aGVyZSBpcyBub3RoaW5nIG1vcmUgdG8gZG8sIHJlbW92ZSB0aGUgc3RhdGUKPiBkaXJlY3Rvcnkg
YW5kIHN0YXRlICJ0aGVyZSBpcyBub3RoaW5nIG1vcmUgdG8gZG8iLgoKMS4gV2l0aG91dCB0aGlz
IHBhdGNoLCBzb21lIGV4aXN0aW5nIHRlc3RzIGJyZWFrLgoyLiBUaGVyZSBpcyBub3RoaW5nIG9i
dmlvdXNseSB3cm9uZyB3aXRoIHRoZSBwYXRjaCwgYW5kIGl0IGV2ZW4KZW5oYW5jZXMgdXNlciBl
eHBlcmllbmNlLiAgSGF2ZSB3ZSBwYWlkIGEgaGVhdnkgcHJpY2UgZm9yIG5vdCBicmVha2luZwpl
eGlzdGluZyB0ZXN0cz8KCkkgY291bGQgZHJvcCB0aGUgcGF0Y2ggYW5kIGZpeCBhbGwgdGhlIHRl
c3RzLCBidXQgaXMgdGhhdCB3aGF0IHdlJ2QgbGlrZSB0byBzZWU/CgotLSBSYW0K
