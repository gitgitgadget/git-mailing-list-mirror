From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/14] Sparse checkout
Date: Sun, 21 Sep 2008 00:33:52 +0700
Message-ID: <fcaeb9bf0809201033o1e9298a8ob135c68228b77218@mail.gmail.com>
References: <1221904913-25887-1-git-send-email-pclouds@gmail.com>
	 <m31vzen4v5.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 20 19:35:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kh6Mc-0001Et-T3
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 19:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbYITRdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2008 13:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbYITRdy
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 13:33:54 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:59644 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbYITRdx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 13:33:53 -0400
Received: by fg-out-1718.google.com with SMTP id 19so897233fgg.17
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 10:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=1e+QGZqzQdDOIXT+EpEW5ybIpuAdRsggacwwxc2Yi1Y=;
        b=KXChalx+TAVl9Euotc7W4VWLafCmCznQGOBaGNvBld5V8EBpKnrcR3+lGnVosw9moI
         9DVGlfN90hld632/GxGDtLmxSHnkU3davI2/FhKtj4lXBlNZOvbpNF8KKFzeX9XiVnA5
         Ix+nUa88qAgzsxAt9Ih98mfIcLj139iuOeTvg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=AkFIhq5l2SyOaCFo1onbFZaCqLjkf9MOlhNuGuivg8DGnHYrFpnjrO9Lq0uYdHNGmx
         B2Aej9gXe5b4RV0g/AJqz3eok4SZVn5N+GQQwMhc3XjyRwKgDCf6Zw4clyjbz+47OAW5
         Zsye2T3WGWEy8ejtSss67OP6eHrNey5Qbgimc=
Received: by 10.86.80.17 with SMTP id d17mr3259551fgb.33.1221932032555;
        Sat, 20 Sep 2008 10:33:52 -0700 (PDT)
Received: by 10.86.59.5 with HTTP; Sat, 20 Sep 2008 10:33:52 -0700 (PDT)
In-Reply-To: <m31vzen4v5.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96358>

T24gOS8yMC8wOCwgSmFrdWIgTmFyZWJza2kgPGpuYXJlYkBnbWFpbC5jb20+IHdyb3RlOgo+ICA+
ICAtICJnaXQgY2xvbmUgLS1wYXRoIiA9PiAiZ2l0IGNsb25lIC0tbmFycm93LXBhdGgiCj4gID4g
IC0gImdpdCBjaGVja291dCAtLXBhdGgiID0+ICJnaXQgY2hlY2tvdXQgLS1yZXNldC1wYXRoIgo+
Cj4KPiBJIGFtIG5vdCBzdXJlIGFib3V0IHRoYXQgY2hhbmdlLCBlc3BlY2lhbGx5IHRoZSBmYWN0
IHRoYXQgZ2l0LWNsb25lCj4gIGFuZCBnaXQtY2hlY2tvdXQgdXNlIGRpZmZlcmVudGx5IG5hbWVk
IG9wdGlvbnMsIGJlY2F1c2UgdGhvc2Ugb3B0aW9ucwo+ICBhZmZlY3QgY2xvbmUgb25seSBhcyB0
aGV5IGFmZmVjdCB0aGUgY2hlY2tvdXQgcGFydCBvZiB0aGUgY2xvbmUuICBPbmUKPiAgd291bGQg
dGhpbmsgdGhhdCBnaXQtY2xvbmUgPSBnaXQtaW5pdCArIGdpdC1yZW1vdGUgYWRkICsgZ2l0LWZl
dGNoICsKPiAgZ2l0LWNoZWNrb3V0LCBhbmQgdGhhdCBnaXQtY2xvbmUgd291bGQgc2ltcGx5IHBh
c3Mgc3BhcnNlIGNoZWNrb3V0Cj4gIGZsYWdzIHRvIGdpdC1jaGVja291dC4KPgoKSm9oYW5uZXMg
c2l4dCBzYWlkIC0tcGF0aCB3YXMgdG9vIGdlbmVyaWMgc28gSSBjaGFuZ2VkIHRoZSBuYW1lLiBI
bW0uLgpJIGRpZCBub3QgdGhpbmsgdGhlIHNhbWUgb3B0aW9uIG5hbWUgZm9yIGdpdC1jaGVja291
dCBhbmQgZ2l0LWNsb25lCndhcyBpbXBvcnRhbnQsIHJhdGhlciB3b3JyeSBhYm91dCBwZW9wbGUg
bWF5IG1pc3VuZGVyc3RhbmQgdGhhdCBpdCBpcwoibmFycm93IGNsb25lIiAoZG8gbm90IGZldGNo
IG9iamVjdHMgb3V0c2lkZSBnaXZlbiBwYXRocyBmb3IgYWxsCmhpc3RvcnkpLiBNYXliZSAiZ2l0
IGNsb25lIC0tbmFycm93LWNoZWNrb3V0IiB3b3VsZCBiZSBiZXR0ZXIuCiItLXJlc2V0LXBhdGgi
LCBJIHRoaW5rLCBpcyBhIGJldHRlciBuYW1lIHRob3VnaC4gSXQgd291bGQgZXhwcmVzcyB0aGUK
cmVsYXRpb24gY29tcGFyZWQgdG8gLS1hZGQtcGF0aCBhbmQgLS1yZW1vdmUtcGF0aC4KCj4gID4g
IC0gTmV3IG5hcnJvdyBzcGVjIChvciAic3BhcnNlIHBhdHRlcm5zIiBmcm9tIG5vdykgcmVzZW1i
bGVzCj4gID4gICAgLmdpdGlnbm9yZSBwYXR0ZXJucwo+Cj4KPiBZb3UgbWVhbiBoZXJlIHRoYXQg
cnVsZXMgZm9yIHBhdHRlcm5zIHRvIHNlbGVjdCB3aGljaCBwYXJ0cyBvZiB0cmVlCj4gIG1hcmsg
YXMgIm5vLWNoZWNrb3V0IiBhbmQvb3IgY2hlY2tvdXQvbGVhdmUgaW4gY2hlY2tvdXQgYXJlIHRo
ZSBzYW1lCj4gIChvciBuZWFybHkgdGhlIHNhbWUpIGFzIHJ1bGVzIGZvciBpZ25vcmluZyBmaWxl
cywgaXNuJ3QgaXQ/CgpZZXMsIGFsbW9zdCB0aGUgc2FtZSwgZXhjZXB0aW9ucyBpbmNsdWRlICIu
LyIgc3VwcG9ydCAodGhpcyBtYXkgaGF2ZQp3b3JrZWQgYWxyZWFkeSBmb3IgLmdpdGlnbm9yZSwg
SSBkdW5ubykgYW5kIGJhY2tzbGFzaCBlc2NhcGUgZm9yCmNvbG9ucy4KCj4gIEJUVyBJIHRoaW5r
IHRoYXQgdGhlIHNhbWUgcnVsZXMgYXJlIHVzZWQgaW4gZ2l0YXR0cmlidXRlcywgYXJlbid0Cj4g
IHRoZXk/CgpUaGV5IGhhdmUgZGlmZmVyZW50IGltcGxlbWVudGF0aW9ucy4gVGhvdWdoIHRoZSBy
dWxlcyBtYXkgYmUgdGhlIHNhbWUuCgo+ICA+IE5ndXnDocK74oCmbiBUaMODwqFpIE5nw6HCuyBj
IER1eSAoMTQpOgo+Cj4gIEVycnIuLi4gd2hhdCBoYXBwZW5lZCBoZXJlPyBGb3IgbWUgaXQgZG9l
c24ndCBsb29rIGxpa2UgY29ycmVjdCBVVEYtOAo+ICBlbmNvZGluZywgYnV0IHBlcmhhcHMgdGhh
dCBpdCBpcyBqdXN0IG15IG5ld3MgY2xpZW50IChHbnVzKS4uLgoKVGhlIGNvdmVyIGxldHRlciBs
YWNrcyBNSU1FLVZlcnNpb24gYW5kIENvbnRlbnQtVHlwZSwgaG1tLi4KLS0gCkR1eQo=
