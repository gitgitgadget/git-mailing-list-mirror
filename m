From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Extend index to save more flags
Date: Tue, 2 Sep 2008 14:33:56 +0700
Message-ID: <fcaeb9bf0809020033i6ed8c268gac3cedcbebe57e26@mail.gmail.com>
References: <48BBE881.1050206@viscovery.net>
	 <1220278585-26969-1-git-send-email-pclouds@gmail.com>
	 <7vhc8zm2ka.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org, "Johannes Sixt" <johannes.sixt@telecom.at>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 09:35:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaQPp-0000oA-TA
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 09:35:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbYIBHd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 03:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752724AbYIBHd6
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 03:33:58 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:23763 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659AbYIBHd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 03:33:58 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1880350fgg.17
        for <git@vger.kernel.org>; Tue, 02 Sep 2008 00:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=t8t1p+A+W0zFpkQUUvxUsTItprFYg4qjK6oOio1okXM=;
        b=r9IABYt2Mp4FVvA2xXPeXzrqMU2NHYUochdHvTbuaXTnBSqmnkVz6WeEQvKoXcfXHY
         qWMoeHuiWmVub4LO3Tuwpo+TcUkJGpQYilU9XHvgrCs5lsXH9Kk32ufZbKewXCruNueh
         roA1GxaFzZ12P9/6hb2b/43cj3hdrja+2lVtA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=SMeeFLK6s+F4QdpPndru38PS4eNyY2lOzaDEJVvASf2AthgWO81G5uARNZ0BoLMYrS
         rExPwNp8fteoHx3gNsGh+WnsuUpR65xAhDkXjxlpGhyY8PnVSy+oLInLk/G9tRQp2D5E
         nZA285va6VciDZzDacOSCke6y3EcJUsEzY5Ig=
Received: by 10.86.93.19 with SMTP id q19mr5340449fgb.4.1220340836254;
        Tue, 02 Sep 2008 00:33:56 -0700 (PDT)
Received: by 10.86.59.5 with HTTP; Tue, 2 Sep 2008 00:33:56 -0700 (PDT)
In-Reply-To: <7vhc8zm2ka.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94661>

T24gOS8yLzA4LCBKdW5pbyBDIEhhbWFubyA8Z2l0c3RlckBwb2JveC5jb20+IHdyb3RlOgo+IE5n
dXnhu4VuIFRow6FpIE5n4buNYyBEdXkgIDxwY2xvdWRzQGdtYWlsLmNvbT4gd3JpdGVzOgo+Cj4g
ID4gVGhlIG9uLWRpc2sgZm9ybWF0IG9mIGluZGV4IG9ubHkgc2F2ZXMgMTYgYml0IGZsYWdzLCBu
ZWFybHkgYWxsIGhhdmUKPiAgPiBiZWVuIHVzZWQuIFRoZSBsYXN0IGJpdCAoQ0VfRVhURU5ERUQp
IGlzIHVzZWQgdG8gZm9yIGZ1dHVyZSBleHRlbnNpb24uCj4gID4KPiAgPiBUaGlzIHBhdGNoIGV4
dGVuZHMgaW5kZXggZW50cnkgZm9ybWF0IHRvIHNhdmUgbW9yZSBmbGFncyBpbiBmdXR1cmUuCj4g
ID4gVGhlIG5ldyBlbnRyeSBmb3JtYXQgd2lsbCBiZSB1c2VkIHdoZW4gQ0VfRVhURU5ERUQgYml0
IGlzIDEuCj4gID4KPiAgPiBCZWNhdXNlIG9sZGVyIGltcGxlbWVudGF0aW9uIG1heSBub3QgdW5k
ZXJzdGFuZCBDRV9FWFRFTkRFRCBiaXQgYW5kCj4gID4gbWlzcmVhZCB0aGUgbmV3IGZvcm1hdCwg
aWYgdGhlcmUgaXMgYW55IGV4dGVuZGVkIGVudHJ5IGluIGluZGV4LCBpbmRleAo+ICA+IGhlYWRl
ciB2ZXJzaW9uIHdpbGwgdHVybiAzLCB3aGljaCBtYWtlcyBpdCBpbmNvbXBhdGlibGUgZm9yIG9s
ZGVyIGdpdC4KPiAgPiBJZiB0aGVyZSBpcyBub25lLCBoZWFkZXIgdmVyc2lvbiB3aWxsIHJldHVy
biB0byAyIGFnYWluLgo+Cj4KPiBJIHRoaW5rIHRoaXMgaXMgYSBnb29kIGNoYW5nZS4KCkp1c3Qg
ZG9uJ3QgYXBwbHkgaXQgbm93LiBUaGVyZSBpcyBhIGJ1ZyBpbiBkaWUoKSBjb2RlIGZvciB1bmtu
b3duCmZsYWdzLiBJJ2xsIHJlc2VuZCB3aXRoIG5hcnJvdyBjaGVja291dCBzZXJpZXMsIHdoaWNo
IHdpbGwgYWxzbyBiZSBhCnRlc3QgY2FzZSBmb3IgdGhlc2UgY2hhbmdlLgotLSAKRHV5Cg==
