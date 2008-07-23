From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [RFC PATCH 00/12] Sparse checkout
Date: Wed, 23 Jul 2008 23:21:02 +0700
Message-ID: <fcaeb9bf0807230921m114f5ae0ybfec4917432d6dc7@mail.gmail.com>
References: <20080723145518.GA29035@laptop>
	 <alpine.DEB.1.00.0807231713280.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 18:22:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLh6M-0002A3-Hy
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 18:22:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803AbYGWQVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 12:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbYGWQVG
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 12:21:06 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:21965 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741AbYGWQVD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 12:21:03 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1167855fgg.17
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 09:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=DzFXSPAcpGCeHwkeU8BdYyvf0zIoTyz4JL5GgQy/VSA=;
        b=OW8FCWyQVBcpXfHgf2etkD28SHWJbNf0BcojpldN54kcVayOGHng8f+rALI1gPaEHv
         n+Rh88nPzA5ZDQJHE3ySOSojANCq60EpEO6GcC7q8EuTdm68YtmyO26ilcO+yIx9WRnd
         VogdyEVhImn3ojn10/na8bgUbRkckcXQErIqI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=h/sFoAuyn5JNR8Jm8dQyNqWiC7ZEuNguLIj09rZnR0y+mZPjRUMzXpNfzmejZowtFf
         P9wyxaswaP7gxl3HjiHO1YTw4h5+9oT/P0Q3P1ljgo8LFgq0uv5PXzma4Y7sav9+K1i4
         NQPniX0frCPbRFQ3LeKs9M2lCkG0bRaenab8U=
Received: by 10.86.84.5 with SMTP id h5mr229509fgb.58.1216830062342;
        Wed, 23 Jul 2008 09:21:02 -0700 (PDT)
Received: by 10.86.91.2 with HTTP; Wed, 23 Jul 2008 09:21:02 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807231713280.8986@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89701>

T24gNy8yMy8wOCwgSm9oYW5uZXMgU2NoaW5kZWxpbiA8Sm9oYW5uZXMuU2NoaW5kZWxpbkBnbXgu
ZGU+IHdyb3RlOgo+IEhpLAo+Cj4KPiAgT24gV2VkLCAyMyBKdWwgMjAwOCwgTmd1eeG7hW4gVGjD
oWkgTmfhu41jIER1eSB3cm90ZToKPgo+ICA+IFNvIGluIHNob3J0LCBzcGFyc2UgcHJlZml4IHdp
bGwgYmUgc3RvcmVkIGluIGNvbmZpZywgY29yZS5zcGFyc2VjaGVja291dC4KPgo+Cj4gRG8geW91
IHJlYWxseSB0aGluayB0aGUgcHJlZml4IHNob3VsZCBiZSBzdG9yZWQgYW55d2hlcmUgZWxzZSB0
aGFuIHRoZQo+ICBpbmRleD8KPgo+ICBXaXRoIGNvcmUuc3BhcnNlQ2hlY2tvdXQgeW91IGhhdmUg
dG8gaW50cm9kdWNlIGEgX3NoKnRsb2FkXyBvZiBjb25maWcKPiAgbG9hZGVycy4KPgo+ICBBbmQg
d2l0aCBjb3JlLnNwYXJzZUNoZWNrb3V0IHlvdSBhcmUgYXQgdGhlIHdoaW0gb2YgdGhlIHVzZXIs
IHNpbmNlCj4gIC5naXQvY29uZmlnIGlzIF9zdXBwb3NlZF8gdG8gYmUgdXNlci1lZGl0YWJsZS4K
Pgo+ICBGcm9tIGEgbG9naWNhbCBwb2ludCBvZiB2aWV3LCBJJ2Qgc2F5IHRoYXQgdGhlIHNwYXJz
ZSBwcmVmaXggaGFzIG5vdGhpbmcKPiAgdG8gZG8gd2l0aCB0aGUgImNvbmZpZ3VyYXRpb24iIG9m
IHRoZSBsb2NhbCByZXBvc2l0b3J5LgoKV2VsbCwgd2hhdGV2ZXIgcGxhY2UuIEkgY2hvc2UgLmdp
dC9jb25maWcgYmVjYXVzZSBJIGRpZCBub3Qgd2FudCB0bwppbnRyb2R1Y2UgYSBuZXcgY29uZmln
IHBsYWNlLiBCdXQgdGhlbiBob3cgYWJvdXQgLmdpdC9zcGFyc2VjaGVja291dD8KCj4KPiAgQ2lh
bywKPiAgRHNjaG8KPgoKCi0tIApEdXkK
