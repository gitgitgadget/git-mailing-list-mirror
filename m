From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: git describe --tags --long barfs on new tags?
Date: Wed, 2 Jul 2008 21:56:19 +0200
Message-ID: <237967ef0807021256j3e67bceaoecbb8f37112db2ab@mail.gmail.com>
References: <20080702154506.7b83bae8@crow>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Mark Burton" <markb@ordern.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 21:57:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE8S5-0007mB-7Q
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 21:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753587AbYGBT4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 15:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753551AbYGBT4U
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 15:56:20 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:59176 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550AbYGBT4T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 15:56:19 -0400
Received: by rv-out-0506.google.com with SMTP id k40so592152rvb.1
        for <git@vger.kernel.org>; Wed, 02 Jul 2008 12:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=AU4tjTw6+9+rw3jkpYoyQxrPHmqz+P1/MpeSvlM878o=;
        b=QnjhzYohFN+pBGbdBoxAqRmxXxUKoK7FheJ5P5mAWhw1pvAaF3pLqs7QuOXE6zoepl
         AZjn68hw+Wkdj/cBNa2SzCgcTXI5lR4uirENXwuDbZ0E+jsqUkNB/SW2KWnABG1O9l7G
         +4zWx32YLcDncP0VY1bZ36DMm+IsR2TtGMJRA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=c2frfQcM59/vbPUp5iajp8G0Z0H3iSLEsTnJdhjzxOJoBHohYkwLhulcAss6YLWWVq
         qfWNlZHU6FvPjKjFyW04UTjKwZ12BGYPSOQmQvGkMy3azkjNyzyHgi9qCJDd5NCcXmG6
         Lyho1ENuVWwRsdXbuXrF7V9UyEAYPhjT8Tq0Q=
Received: by 10.141.171.1 with SMTP id y1mr4619353rvo.86.1215028579159;
        Wed, 02 Jul 2008 12:56:19 -0700 (PDT)
Received: by 10.141.68.4 with HTTP; Wed, 2 Jul 2008 12:56:19 -0700 (PDT)
In-Reply-To: <20080702154506.7b83bae8@crow>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87188>

MjAwOC83LzIgTWFyayBCdXJ0b24gPG1hcmtiQG9yZGVybi5jb20+Ogo+Cj4gSG93ZHkgZm9sa3Ms
Cj4KPiBEaXNjb3ZlcmVkIHRoaXMgdG9kYXk6Cj4KPiB+L2dpdFttYXN0ZXJdJCBnaXQgdGFnIG1i
Cj4gfi9naXRbbWFzdGVyXSQgZ2l0IGRlc2NyaWJlCj4gdjEuNS42LjEtMTU2LWdlOTAzYjQwCj4g
fi9naXRbbWFzdGVyXSQgZ2l0IGRlc2NyaWJlIC0tdGFncwo+IG1iCj4gfi9naXRbbWFzdGVyXSQg
Z2l0IGRlc2NyaWJlIC0tdGFncyAtLWxvbmcKPiBTZWdtZW50YXRpb24gZmF1bHQgKGNvcmUgZHVt
cGVkKQo+Cj4gSG9wZSB0aGlzIGlzIHVzZWZ1bCBpbmZvLgo+Cj4gQlRXIC0ganVzdCBzdGFydGVk
IHVzaW5nIGdpdCBhbmQgSSBhbSB2ZXJ5IGltcHJlc3NlZCB3aXRoIGl0IC0gdG9vayBtZSBhIHdo
aWxlIHRvIGdldCBteSBoZWFkIGFyb3VuZCB0aGUgImluZGV4IiBidXQgbm93IEkgd29uZGVyIHdo
YXQgdGhlIHByb2JsZW0gd2FzLgoKCkhlcmUncyBhIGJhY2t0cmFjZSwgaSB0cmllZCB0byBmb2xs
b3cgdGhlIGNvZGUgYnV0IGdvdCBjb25mdXNlZCBhbmQgZ2F2ZSB1cC4KClByb2dyYW0gcmVjZWl2
ZWQgc2lnbmFsIFNJR1NFR1YsIFNlZ21lbnRhdGlvbiBmYXVsdC4KW1N3aXRjaGluZyB0byBUaHJl
YWQgMHhhN2NkMjZjMCAoTFdQIDk2NzApXQoweDA4MDYxNWYyIGluIGRlc2NyaWJlIChhcmc9MHg4
MGU0ZTllICJIRUFEIiwgbGFzdF9vbmU9MSkgYXQKYnVpbHRpbi1kZXNjcmliZS5jOjIwNwoyMDcJ
CQkJc2hvd19zdWZmaXgoMCwgbi0+dGFnLT50YWdnZWQtPnNoYTEpOwooZ2RiKSBidAojMCAgMHgw
ODA2MTVmMiBpbiBkZXNjcmliZSAoYXJnPTB4ODBlNGU5ZSAiSEVBRCIsIGxhc3Rfb25lPTEpIGF0
CmJ1aWx0aW4tZGVzY3JpYmUuYzoyMDcKIzEgIDB4MDgwNjFiZDggaW4gY21kX2Rlc2NyaWJlIChh
cmdjPTAsIGFyZ3Y9MHhhZmNkMjVmNCwgcHJlZml4PTB4MCkKYXQgYnVpbHRpbi1kZXNjcmliZS5j
OjM2MAojMiAgMHgwODA0YjFiZiBpbiBoYW5kbGVfaW50ZXJuYWxfY29tbWFuZCAoYXJnYz0zLCBh
cmd2PTB4YWZjZDI1ZjQpIGF0IGdpdC5jOjI1MgojMyAgMHgwODA0Yjg4OCBpbiBtYWluIChhcmdj
PTMsIGFyZ3Y9MHg0MWMyOTRjMCkgYXQgZ2l0LmM6NDYzCihnZGIpIHByaW50IG4KJDEgPSA8dmFs
dWUgb3B0aW1pemVkIG91dD4KKGdkYikgcHJpbnQgY21pdAokMyA9IChzdHJ1Y3QgY29tbWl0ICop
IDB4ODE0NzZhOAooZ2RiKSBwcmludCBjbWl0LT51dGlsCiQ0ID0gKHZvaWQgKikgMHg4MTQ3NDMw
CihnZGIpIHByaW50ICooc3RydWN0IGNvbW1pdF9uYW1lKiljbWl0LT51dGlsCiQ1ID0ge3RhZyA9
IDB4MCwgcHJpbyA9IDEsIHNoYTEgPQoiXHRFdFwiwrFkNsKqXDAzM1wwMDVcMjMwXDIzN1wwMzXD
q1JcMjI2wrzDoVwwMTdcMjMwIiwKICBwYXRoID0gMHg4MTQ3NDRjICJtYiJ9CgotLSAKTWlrYWVs
IE1hZ251c3Nvbgo=
