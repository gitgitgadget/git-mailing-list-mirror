From: "=?UTF-8?Q?Eddy_Petri=C8=99or?=" <eddy.petrisor@gmail.com>
Subject: Re: [PATCH 0/3] git-svn-externals PoC (in a sh script)
Date: Wed, 10 Sep 2008 16:59:18 +0300
Message-ID: <60381eeb0809100659m2d553da7w4e18377a479b9d61@mail.gmail.com>
References: <60381eeb0808281702q3dc7543enff2b35ebbcc80d08@mail.gmail.com>
	 <20080829092927.GA7500@yp-box.dyndns.org>
	 <60381eeb0809100656u1117cfb6i72e327495d513f9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 10 16:01:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdQFB-0003Bn-E9
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 16:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbYIJN7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 09:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbYIJN7W
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 09:59:22 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:40690 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbYIJN7V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 09:59:21 -0400
Received: by gxk9 with SMTP id 9so13640496gxk.13
        for <git@vger.kernel.org>; Wed, 10 Sep 2008 06:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=FZJ8l9qR1U3Hz33Q/uBgQj00uo3cTzrNkffoTEEBuyg=;
        b=OMAoq63cmDpnaQ2gNhFn9z9npaXzewANORTak0JsR9Mz+MUNDJE7WLHzC5WM1b/s7k
         UdUDNPQzKFZjqB/uOws9iYOs0jhszh4CtVyTkxBqw0VW1lbCQeSkKSIzjtYO0QSOndol
         0uahpnFQrgmTaIheuDzyVHjKoeuawnIvHY0FQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=LknyP67vj/fkKVe9VglFWXdQ4Vs4ov4/3ttyvxJLIGz9/EgrJTC7Ed2tTFM7u7og4n
         NmTunpCW+wrmpdpGbqQieXwU5T+OQSg5HNsOzNuDI+kznKq2KISwOMDeT++bHEU17BZ/
         gSBEbXdT8I6cCWpIFSxk/2egShmmEvhuh/PJc=
Received: by 10.150.54.1 with SMTP id c1mr2114304yba.62.1221055158477;
        Wed, 10 Sep 2008 06:59:18 -0700 (PDT)
Received: by 10.150.182.11 with HTTP; Wed, 10 Sep 2008 06:59:18 -0700 (PDT)
In-Reply-To: <60381eeb0809100656u1117cfb6i72e327495d513f9c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95519>

MjAwOC85LzEwIEVkZHkgUGV0cmnImW9yIDxlZGR5LnBldHJpc29yQGdtYWlsLmNvbT46Cj4gKFBs
ZWFzZSBrZWVwIHRoZSBDQy4gVGhhbmtzKQo+IEkgYWxyZWFkeSBoYXZlL3dyb3RlIHNvbWUgY29k
ZSB0aGF0IGZvbGxvd3MgdGhlIHJlbW90ZSBIRUFEIG9yIGEKPiBzcGVjaWZpYyBmb3IgdGhlIG5l
Y2Vzc2FyeSwgYnV0IEkgYW0gdW5zdXJlIGlmIGlzIHN0aWxsIHByZXNlbnQgaW4gdGhlCgpUaGF0
IHdhcyBzdXBwb3NlZCB0byBiZToKCj4gc3BlY2lmaWMgcmV2aXNpb24gZm9yIHN1Y2ggY2FzZXMs
IGJ1dCBJIGFtIHVuc3VyZSBpZiBpcyBzdGlsbCBwcmVzZW50IGluIHRoZQoKCi0tIApSZWdhcmRz
LApFZGR5UAo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KIklt
YWdpbmF0aW9uIGlzIG1vcmUgaW1wb3J0YW50IHRoYW4ga25vd2xlZGdlIiBBLkVpbnN0ZWluCg==
