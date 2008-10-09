From: "Stefan Karpinski" <stefan.karpinski@gmail.com>
Subject: Re: Really remove a file ?
Date: Thu, 9 Oct 2008 16:43:11 -0700
Message-ID: <d4bc1a2a0810091643u3903a1f4h44d3579b98fe6922@mail.gmail.com>
References: <8CAF851B91FEF07-660-20E9@webmail-da15.sysops.aol.com>
	 <81b0412b0810091156v15dea27an95050a06cfb4f8df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: marcreddist@aim.com
X-From: git-owner@vger.kernel.org Fri Oct 10 01:44:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko5BB-0006hJ-7u
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 01:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403AbYJIXnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 19:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751991AbYJIXnO
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 19:43:14 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:54490 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbYJIXnN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 19:43:13 -0400
Received: by an-out-0708.google.com with SMTP id d40so29189and.103
        for <git@vger.kernel.org>; Thu, 09 Oct 2008 16:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=i2PXZQRu7MCyD7ceEcpETTR3ZoMLFz1pcdMfAsPxi/o=;
        b=jVVvQmYvo8Ay4lzYycld50T/DYUHMuCaDjg5RcGuWLbN5Crh4p8GS8rVrDq4mY0RZ2
         Khge1O+86PrBvlDVFLSMxb/9Bc/ZvGcH/VaKO/jTJEaIuhlfdcs3dx5gpcMqXqa7cZZl
         jnvezk7ZTkmU7YOdom91CmLxhFzcmQwHD11FY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=GuRTLUCT0z/x4OZc137nNxWtBRYS+EBXTaKK+HHhZkG8A8PJkI4nIPG9GX1z9JsT8+
         1XDw0H5icy78CP0EHloFGiFjRJ+Y/bSYKy2TPjBdINSZtyWmYCtU6ZAlYCZQA13jhKaK
         Yt6dRwEsTYJtt/ewZUbibfd3VBfufSkuRNRhE=
Received: by 10.100.124.6 with SMTP id w6mr1197827anc.80.1223595792036;
        Thu, 09 Oct 2008 16:43:12 -0700 (PDT)
Received: by 10.100.197.16 with HTTP; Thu, 9 Oct 2008 16:43:11 -0700 (PDT)
In-Reply-To: <81b0412b0810091156v15dea27an95050a06cfb4f8df@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97905>

U3BlY2lmaWNhbGx5LCB5b3UgcHJvYmFibHkgd2FudCB0byBkbyBzb21ldGhpbmcgbGlrZSB0aGlz
OgoKICAkIGdpdCBmaWx0ZXItYnJhbmNoIC0taW5kZXgtZmlsdGVyICdnaXQgdXBkYXRlLWluZGV4
IC0tcmVtb3ZlCjxmaWxlbmFtZT4nIC0tZm9yY2UgLS0gLS1hbGwKCkJld2FyZSB0aGF0IHRoaXMg
d2lsbCBtYWtlIHlvdXIgcmVwb3NpdG9yeSBlZmZlY3RpdmVseSAiaW5jb21wYXRpYmxlIgp3aXRo
IHRob3NlIG9mIG90aGVycyB3aG8ndmUgcHVsbGVkIGZyb20geW91IGJlZm9yZeKAlGJlY2F1c2Ug
YWxsIG9mIHlvdXIKaGlzdG9yeSBpcyBub3cgY29tcGxldGVseSByZXdyaXR0ZW4uIFlvdSBzaG91
bGQgcHJvYmFibHkgaGF2ZSB0aGVtCmNsb25lIGEgbmV3IGNvcHkgZnJvbSB0aGUgcmVwbyB5b3Un
dmUgcnVuIHRoaXMgb24gaW5zdGVhZCBvZiB0cnlpbmcgdG8KY29udGludWUgd29ya2luZyB3aXRo
IHRoZWlyIG9sZCByZXBvcy4gT3RoZXJ3aXNlIGFsbCBoZWxsIGJyZWFrcwpsb29zZS4gWW91J2xs
IHByb2JhYmx5IGFsc28gd2FudCB0byBydW4gImdpdCBnYyIgb24geW91ciByZXBvIHRvCmFjdHVh
bGx5IGdldCByaWQgb2YgdGhlIGh1Z2Ugb2JqZWN0IHRoYXQgd2FzIGFkZGVkIChvciBkb2VzCmZp
bHRlci1icmFuY2ggZG8gdGhpcyBhdXRvbWF0aWNhbGx5PykuCgpPbiBUaHUsIE9jdCA5LCAyMDA4
IGF0IDExOjU2IEFNLCBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPiB3cm90ZToKPgo+
IDIwMDgvMTAvOSAgPG1hcmNyZWRkaXN0QGFpbS5jb20+Ogo+ID4gU28gaXMgdGhlcmUgYSB3YXkg
dG8gcmVhbGx5IHJlbW92ZSBhIGZpbGUgaW4gdGhlIGdpdCByZXBvc2l0b3J5IHNvIHRoYXQgaXQK
PiA+IG5ldmVyIGV4aXN0ZWQgKEkgbWVhbiBub3QgaGF2aW5nIHRoZSBkaWZmIGluIHRoZSBsb2dz
IGFuZCB0aGUgZGF0YSBzdG9yZWQKPiA+IHNvbWV3aGVyZSBpbiB0aGUgLmdpdCBkaXJlY3Rvcnkp
ID8gT3IgaWYgaXQncyBub3QgdGhlIHdhcyBnaXQgaXMgc3VwcG9zZWQgdG8KPiA+IGJlIHVzZWQs
IGlzIHRoZXJlIGEgd2F5IHRvIGhpZGUgdGhlIGRpZmYgKGV2ZW4gZnJvbSBnaXQtbG9nKSBvciBz
b21ldGhpbmcgPwo+Cj4gWWVzLiBCdXQgeW91J2xsIGNoYW5nZSB0aGUgd2hvbGUgaGlzdG9yeSAo
b2YgY291cnNlLCBpdCBzaG91bGQgX25ldmVyXwo+IG1lbnRpb24gdGhlIGZpbGUpLgo+IFNlZSBn
aXQgZmlsdGVyLWJyYW5jaCAodGhlcmUgaXMgZXZlbiBhbiBleGFtcGxlIGF0IHRoZSBlbmQgb2Yg
aXRzIG1hbiBwYWdlLgo+IFJlcGxhY2UgbXYgd2l0aCBybSkKPiAtLQo+IFRvIHVuc3Vic2NyaWJl
IGZyb20gdGhpcyBsaXN0OiBzZW5kIHRoZSBsaW5lICJ1bnN1YnNjcmliZSBnaXQiIGluCj4gdGhl
IGJvZHkgb2YgYSBtZXNzYWdlIHRvIG1ham9yZG9tb0B2Z2VyLmtlcm5lbC5vcmcKPiBNb3JlIG1h
am9yZG9tbyBpbmZvIGF0ICBodHRwOi8vdmdlci5rZXJuZWwub3JnL21ham9yZG9tby1pbmZvLmh0
bWwK
