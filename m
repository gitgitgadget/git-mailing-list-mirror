From: "Jeff Whiteside" <jeff.m.whiteside@gmail.com>
Subject: Re: how to combine 2 commits?
Date: Tue, 13 Jan 2009 00:08:32 -0500
Message-ID: <3ab397d0901122108t7ae465feocd09b73ce4d525b2@mail.gmail.com>
References: <20090113045422.GA6940@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: base64
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 13 06:10:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMbXK-0002Wp-Mc
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 06:09:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbZAMFIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 00:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbZAMFIe
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 00:08:34 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:59594 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbZAMFId (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 00:08:33 -0500
Received: by qw-out-2122.google.com with SMTP id 3so10052374qwe.37
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 21:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=1PS7YeWkesReriGSxZOPbXL6aJB2wKixxB34vgfloyE=;
        b=Am1GOVptwUeCohSjx7LIPHcS/sPYzE65B+3O4/fo6Nrq8vYjqkphqHA0CYmcRMGJ52
         mS58mfDmJdLRadaa7Wd6XVw5oLuJ/WlMZ49pfugf9XAvuqDcHu081njGO0wUg5fWmekP
         n0p6HCSBld9XBv4XEq3jz5d1qC0eiBSlvVdG8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=iFdseHtbNFyxwD3rjwdMdapyoOdsbniXsUB4Ssq4BzaelMUsrcV0st8XVacJTEYy7q
         IAe+PAvlvn5uT42QgJvjTEN6oab8QXqfgauTW3pT7qSE1xsjRAL6XbtRWHORaoW75sKA
         wU7WNDqdLufeiQEFviHeb+H1o7+u7dWNS2TpE=
Received: by 10.214.183.11 with SMTP id g11mr26277278qaf.228.1231823312363;
        Mon, 12 Jan 2009 21:08:32 -0800 (PST)
Received: by 10.215.41.3 with HTTP; Mon, 12 Jan 2009 21:08:32 -0800 (PST)
In-Reply-To: <20090113045422.GA6940@b2j>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105456>

Z2l0IHRlcm1pbm9sb2d5IGlzICJzcXVhc2giCgpPbiBNb24sIEphbiAxMiwgMjAwOSBhdCAxMTo1
NCBQTSwgYmlsbCBsYW0gPGNiaWxsLmxhbUBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gU29ycnkgSSBk
b24ndCBrbm93IHRoZSBjb3JyZWN0IGdpdCB0ZXJtaW5vbG9neSBmb3IgaXQuICBJIG1ha2Ugc29t
ZQo+IGNoYW5nZXMgdG8gc2NyaXB0cyBidXQgYWxzbyBhY2NpZGVudGFsbHkgY2hhbmdlZCBhbGwg
c2NyaXB0cyB0byB1c2UKPiBkb3MgbGluZWZlZWQuICBGYWlsZWQgdG8gbm90aWNlIHRoaXMgYW5k
IGNvbW1pdCBhbGwgY2hhbmdlcy4gVGhlbiBJCj4gdHJpZWQgdG8gY29ycmVjdCBpdCBieSBjaGFu
Z2luZyBhbGwgc2NyaXB0cyBiYWNrIHRvIHVuaXggbGluZWZlZWQgYW5kIGNvbW1pdCBhZ2Fpbi4K
Pgo+IEhvdyB0byBjb21iaW5lIHRoZXNlIDIgY29tbWl0cyBzbyB0aGF0IHRoZSBjaGFuZ2VzIG9m
IGxpbmVmZWVkIGNhbmNlbAo+IG91dCBlYWNoIG90aGVyIGFuZCB0aGUgaGlzdG9yeSBvbmx5IHNo
b3dzIHRoZSBpbnRlbmRlZCBjaGFuZ2VzIG9mIHRoZQo+IGZldyBzY3JpcHRzLgo+Cj4gLS0KPiBy
ZWdhcmRzLAo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KPiBHUEcga2V5IDEwMjRELzQ0MzRCQUIzIDIwMDgtMDgtMjQKPiBncGcgLS1rZXlzZXJ2
ZXIgc3Via2V5cy5wZ3AubmV0IC0tcmVjdi1rZXlzIDQ0MzRCQUIzCj4gzMbUijIzNCDA7rDXICDU
ucfpCj4gICAgw8DIy5LU1um6nyAgye7X+PW+turDvCAgtavSipxJutud8SAgsrvWqtDEut7VbAo+
IC0tCj4gVG8gdW5zdWJzY3JpYmUgZnJvbSB0aGlzIGxpc3Q6IHNlbmQgdGhlIGxpbmUgInVuc3Vi
c2NyaWJlIGdpdCIgaW4KPiB0aGUgYm9keSBvZiBhIG1lc3NhZ2UgdG8gbWFqb3Jkb21vQHZnZXIu
a2VybmVsLm9yZwo+IE1vcmUgbWFqb3Jkb21vIGluZm8gYXQgIGh0dHA6Ly92Z2VyLmtlcm5lbC5v
cmcvbWFqb3Jkb21vLWluZm8uaHRtbAo=
