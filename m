From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Problem with --work-tree
Date: Sun, 17 Aug 2008 12:24:42 +0700
Message-ID: <fcaeb9bf0808162224u2d337878vb1dfef09a6b48a16@mail.gmail.com>
References: <48A74325.1040805@school9.perm.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "=?UTF-8?B?0KHQtdGA0LPQtdC5INCo0LDRgNGL0LHQuNC9?=" 
	<nazgul@school9.perm.ru>
X-From: git-owner@vger.kernel.org Sun Aug 17 07:27:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUanR-0000yw-Cl
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 07:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbYHQFYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 01:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbYHQFYo
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 01:24:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:9699 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbYHQFYn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 01:24:43 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1347082fgg.17
        for <git@vger.kernel.org>; Sat, 16 Aug 2008 22:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=vMPReSk34nIeRsdtrRaYdJJkEbzV3XsEcgNnOOo3o34=;
        b=UfDA7MRZqJ8oXqIO0PdMfQjZgDjVccSIcMxmyksWDraIMgca+RwGZYCjMpiNxnRclz
         UXTXCkPvhdGdjhb57JNx49FCUajx9y35PHSGGcjfckm829Ac+zPj6JVB3c8BT3crkJxA
         l1elQhTLlF2L712J4VYcl25YCG7ZOyejuvKfw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=kXiTYYUuu4OR+unYq61ewPx99IcPhgoxVwUdo8G5HKJ9p04fqIgh2oZw7WpXyW4mMW
         o9raZ7sDjOI+dwwqx9NKZAiSz6b2Li1/G/IvhnLumPXcn4ezYpzgkV6ea2bvHXfR8sdy
         8vaNBukPb6LvmZT1H59ywSgIneGuF7T2bZH3g=
Received: by 10.86.97.20 with SMTP id u20mr3512733fgb.15.1218950682246;
        Sat, 16 Aug 2008 22:24:42 -0700 (PDT)
Received: by 10.86.93.13 with HTTP; Sat, 16 Aug 2008 22:24:42 -0700 (PDT)
In-Reply-To: <48A74325.1040805@school9.perm.ru>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92576>

T24gOC8xNy8wOCwg0KHQtdGA0LPQtdC5INCo0LDRgNGL0LHQuNC9IDxuYXpndWxAc2Nob29sOS5w
ZXJtLnJ1PiB3cm90ZToKPiBIaSwKPgo+ICBJJ3ZlIGdvdCB0aGUgZm9sbG93aW5nIHByb2JsZW0u
IEkndmUgZ290IGEgR0lUIHJlcG8gYXQKPiAvaG9tZS9uYXpndWwvc3JjL3Rlc3Qtd29yay10cmVl
IGFuZCBJJ3ZlIGdvdCBzb21lIGNoYW5nZWQKPiBmaWxlcyBpbiB0aGlzIHJlcG8uIEkgd2FudCB0
byBzZWUgdGhpcyBjaGFuZ2VzIHdoZW4gYSBgZ2l0YCBydW5zIG91dHNpZGUKPiB0aGlzIGRpcmVj
dG9yeS4gSSB0cmllZCB0byBydW4gYGdpdAo+IC0tZ2l0LWRpcj0vaG9tZS9uYXpndWwvc3JjL3Rl
c3Qtd29yay10cmVlLy5naXQKPiAtLXdvcmstdHJlZT0vaG9tZS9uYXpndWwvc3JjL3Rlc3Qtd29y
ay10cmVlIGRpZmYtaW5kZXgKPiAtLW5hbWUtc3RhdHVzIEhFQURgIGZyb20gbXkgaG9tZSBkaXJl
Y3RvcnkuIEluIHN1Y2ggd2F5IGRpZmYtaW5kZXggdGVsbHMgbWUKPiB0aGF0IGFsbCBmaWxlcyBm
cm9tIG15IHJlcG8gaGFzIGJlZW4gZGVsZXRlZC4gSSB0aGluayBpdCBpcyBiZWNhdXNlIHRoaXMK
PiBjb21tYW5kIGRvZXMgbm90IHVuZGVyc3RhbmQgYSAtLXdvcmstdHJlZSBwYXJhbWV0ZXIuIEFu
ZCBJIHNhdyB0aGUgc2FtZQo+IHByb2JsZW0gd2l0aCBhIGdpdCBkaWZmIGNvbW1hbmQgKHNvbWV0
aGluZyBsaWtlIHRoYXQ6IGdpdAo+IC0tZ2l0LWRpcj0vaG9tZS9uYXpndWwvc3JjL3Rlc3Qtd29y
ay10cmVlLy5naXQKPiAtLXdvcmstdHJlZT0vaG9tZS9uYXpndWwvc3JjL3Rlc3Qtd29yay10cmVl
IGRpZmYpLgoKSSB0aGluayBpdCdzIGEgYnVnLiBGb3Igbm93IHVzZSAiZ2l0IHN0YXR1cyIgaW5z
dGVhZC4KLS0gCkR1eQo=
