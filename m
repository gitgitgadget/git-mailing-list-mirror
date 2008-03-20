From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: checkout detached work tree
Date: Thu, 20 Mar 2008 22:01:55 +0700
Message-ID: <fcaeb9bf0803200801y45255591t5c0e9505399cbb30@mail.gmail.com>
References: <slrnfu0k9d.kfv.joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "=?UTF-8?Q?J=C3=B6rg_Sommer?=" <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Thu Mar 20 16:03:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcMHt-0007oP-VF
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 16:02:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756142AbYCTPB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 11:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756124AbYCTPB5
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 11:01:57 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:33097 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756116AbYCTPB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 11:01:56 -0400
Received: by fg-out-1718.google.com with SMTP id l27so862804fgb.17
        for <git@vger.kernel.org>; Thu, 20 Mar 2008 08:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=q0p0DdEC9Ls89l9Y81VAM3wdm5HwMHFNM2iodJSyIug=;
        b=pzsdEVAn1aeipBZp8Z4Bpad4Sc7zV4pZ93Tbcc6tgObKapN4/nfoauqyE7rn1dWZcDjKY8O9zcgasCQuvI7c1FAaQct9qnMU5rwCci8mGwdG0ttYmfK4QO2IV2GYdGbAyK8R87zZaqG6WaST/LpC78BMXd79mZIucQNQ9X1euwY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hM7+2p4byQVTDiWQnowmvWW6paCmBIFCP5GSt9SRexkgM8vHyRTJ9fzeYxj5vEbdL4M+AULSIy0v1vUP8vo5d7J6JocsgTy7YuiHE/e4bdiGRZue/nKAyIqTbCLwzMhtYtr+vsnxF9sYJwEKVc9m5P3CaT2sDEO4XX+wePajSnk=
Received: by 10.86.71.1 with SMTP id t1mr1015485fga.7.1206025315421;
        Thu, 20 Mar 2008 08:01:55 -0700 (PDT)
Received: by 10.86.81.4 with HTTP; Thu, 20 Mar 2008 08:01:55 -0700 (PDT)
In-Reply-To: <slrnfu0k9d.kfv.joerg@alea.gnuu.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77662>

T24gV2VkLCBNYXIgMTksIDIwMDggYXQgNjozMiBBTSwgSsO2cmcgU29tbWVyIDxqb2VyZ0BhbGVh
LmdudXUuZGU+IHdyb3RlOgo+IEhpLAo+Cj4gIGlzIGl0IGNvcnJlY3QgdGhhdCB0aGlzIGNoZWNr
b3V0IGZhaWxzPwo+Cj4gICUgZ2l0IC0tZ2l0LWRpcj0kSE9NRS9naXQvZ2l0Ly5naXQgLS13b3Jr
LXRyZWU9L3RtcC9naXQgc3ltYm9saWMtcmVmIEhFQUQKPiAgcmVmcy9oZWFkcy9tYXN0ZXIKPiAg
JSBnaXQgLS1naXQtZGlyPSRIT01FL2dpdC9naXQvLmdpdCAtLXdvcmstdHJlZT0vdG1wL2dpdCBj
aGVja291dAo+ICBmYXRhbDogL3Vzci9iaW4vZ2l0LWNoZWNrb3V0IGNhbm5vdCBiZSB1c2VkIHdp
dGhvdXQgYSB3b3JraW5nIHRyZWUuCj4KPiAgSSB3YW50IHRvIGRvIGEgY2hlY2tvdXQgaW4gYSBz
Y3JpcHQgd2l0aG91dCBuZWVkIHRvIHdvcnJ5IGFib3V0IHRoZQo+ICBjdXJyZW50IHdvcmtpbmcg
ZGlyZWN0b3J5LiBCdXQgaXQgc2VhbXMgdGhpcyBpcyBub3QgcG9zc2libGUuIE1hbnkKPiAgY29t
bWFuZHMgZmFpbC4gSXMgdGhpcyBiZWhhdmlvdXIgZXhwZWN0ZWQ/CgpXb3JrcyB3ZWxsIGhlcmUg
d2l0aCB2ZXJzaW9uIDEuNS40LjIuMjgxLmcyOGQwZS4gV2hhdCB2ZXJzaW9uIHdlcmUgeW91IHVz
aW5nPwotLSAKRHV5Cg==
