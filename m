From: "Sean Davis" <sdavis2@mail.nih.gov>
Subject: Re: Problems with git over http
Date: Sat, 20 Sep 2008 16:40:11 -0400
Message-ID: <264855a00809201340r397d2901h14a7e33a3eed5f06@mail.gmail.com>
References: <264855a00809201013h6003abbfr9bbdd20c92e9201d@mail.gmail.com>
	 <20080920184257.GD18932@strlen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=" <ukleinek@strlen.de>
X-From: git-owner@vger.kernel.org Sat Sep 20 22:41:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kh9Ge-0008Ht-3k
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 22:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbYITUkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2008 16:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbYITUkP
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 16:40:15 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:30995 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbYITUkO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 16:40:14 -0400
Received: by an-out-0708.google.com with SMTP id d40so79520and.103
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 13:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=prfW5/l18ZsXDhWbm+IFgJ/X3DMB+8MRBi2uFbYUDow=;
        b=QoRo+tzxVPcwawtdHguPeKph7/ZSaZPOWaRrDN/7mEfjMtq9wE0rzbbUn7HtqcwcL/
         1f/4Ucn5XvsDKJIr//+Hj4oHsE0UsedPx4nQ94XAk2q61RceYd0IL+m7mqbsW60qqewR
         6s1c7EisCe6NNovk2ybvIgdsxkyZFh0T+eggE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=OSWPukDd7ieqZ27YAtuXT3K0rA2VnaZovPsYsW0lh19mXahRX+ChNn67PtaiCfPZNt
         YdPPjiI7KMotQ1DWx2L3dF+zGOxsZM+BmtpAto/Vp3RV8+5pnRQnjKZwcRgo34Y624To
         42dhSwbcyu0SiKacWSAft137O1LHb2GQAcGME=
Received: by 10.100.12.2 with SMTP id 2mr1506904anl.143.1221943211508;
        Sat, 20 Sep 2008 13:40:11 -0700 (PDT)
Received: by 10.100.197.2 with HTTP; Sat, 20 Sep 2008 13:40:11 -0700 (PDT)
In-Reply-To: <20080920184257.GD18932@strlen.de>
Content-Disposition: inline
X-Google-Sender-Auth: d8c7c5ff6997de89
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96364>

T24gU2F0LCBTZXAgMjAsIDIwMDggYXQgMjo0MiBQTSwgVXdlIEtsZWluZS1Lw7ZuaWcgPHVrbGVp
bmVrQHN0cmxlbi5kZT4gd3JvdGU6Cj4gSGVsbG8gU2VhbiwKPgo+IE9uIFNhdCwgU2VwIDIwLCAy
MDA4IGF0IDAxOjEzOjUzUE0gLTA0MDAsIFNlYW4gRGF2aXMgd3JvdGU6Cj4+IEkgYW0gbmV3IHRv
IGdpdCBhbmQgdHJ5aW5nIHRvIHNldCB1cCBhIHJlbW90ZSByZXBvc2l0b3J5IG92ZXIgaHR0cC4g
IEkKPj4gaGF2ZSBjb25maWd1cmVkIGFwYWNoZTIgYW5kIHRoZSBiYXJlLCBlbXB0eSByZXBvc2l0
b3J5LiAgVXNpbmcgY3VybCwgSQo+PiBjYW4gZ2V0IHRoZSBmaWxlIEhFQUQgd2l0aG91dCBhIHBh
c3N3b3JkIChzZWVtcyAubmV0cmMgaXMgY29ycmVjdD8pLgo+PiBIb3dldmVyLCB3aGVuIEkgdHJ5
IHRvIHB1c2ggdG8gdGhlIHJlcG9zaXRvcnksIEkgZ2V0IHRoZSBmb2xsb3dpbmc6Cj4+Cj4+IHNk
YXZpc0BsZXN0cmFkZTovdG1wL3Rlc3Rpbmc+IGdpdCBwdXNoCj4+IGh0dHA6Ly9zZGF2aXNAd2F0
c29uLm5jaS5uaWguZ292L2dpdC9zZWFuX2dpdC5naXQvIG1hc3Rlcgo+PiBmYXRhbDogZXhlYyBo
dHRwLXB1c2ggZmFpbGVkLgo+PiBlcnJvcjogZmFpbGVkIHRvIHB1c2ggc29tZSByZWZzIHRvCj4+
ICdodHRwOi8vc2RhdmlzQHdhdHNvbi5uY2kubmloLmdvdi9naXQvc2Vhbl9naXQuZ2l0LycKPj4K
Pj4gV2hhdCBjYW4gSSBkbyB0byB0cnkgdG8gZGVidWcgdGhpcywgYXMgdGhlIGVycm9yIG1lc3Nh
Z2UgaXNuJ3QgaGVscGluZwo+PiBtZSB0byBzb3J0IG91dCB3aGF0IGlzIHdyb25nLiAgVGhlIGNs
aWVudCBhbmQgc2VydmVyIGFyZSBib3RoIHJ1bm5pbmcKPj4gZ2l0LTEuNS54IChhbHRob3VnaCB0
aGUgbWlub3IgdmVyc2lvbnMgYXJlIGEgYml0IGRpZmZlcmVudCkuICBBbnkKPj4gc3VnZ2VzdGlv
bnM/Cj4gVHJ5IGNsb25pbmcgZmlyc3QuICBBbmQgY2hlY2sgdGhlIGVycm9yIGxvZyBvZiBhcGFj
aGUuICBJIGRvbid0IGtub3cgaG93Cj4gcHVzaGluZyBvdmVyIGh0dHAgd29ya3MsIGJ1dCBtYXli
ZSB5b3UgaW5zdGFsbGVkIGdpdCBpbnRvIC91c3IvbG9jYWwgYW5kCj4gL3Vzci9sb2NhbC9iaW4g
aXMgbm90IGluIHRoZSBQQVRIIGZvciB0aGUgYXBhY2hlIHVzZXI/CgpUaGFua3MsIFV3ZS4gIEdv
b2QgaWRlYS4gIE9uIHRoZSBjbGllbnQ6CgpvcmYtMDE1NjkwNDk6L3RtcCBzZGF2aXMkIGdpdCBj
bG9uZQpodHRwOi8vc2RhdmlzQHdhdHNvbi5uY2kubmloLmdvdi9naXQvc2Vhbl9naXQuZ2l0LwpJ
bml0aWFsaXplZCBlbXB0eSBHaXQgcmVwb3NpdG9yeSBpbiAvdG1wL3NlYW5fZ2l0Ly5naXQvCmNh
dDogL3RtcC9zZWFuX2dpdC8uZ2l0L3JlZnMvcmVtb3Rlcy9vcmlnaW4vbWFzdGVyOiBObyBzdWNo
IGZpbGUgb3IgZGlyZWN0b3J5Ci91c3IvbG9jYWwvYmluL2dpdC1jbG9uZTogbGluZSA0OiBjZDoK
L3RtcC9zZWFuX2dpdC8uZ2l0L3JlZnMvcmVtb3Rlcy9vcmlnaW46IE5vIHN1Y2ggZmlsZSBvciBk
aXJlY3RvcnkKZmF0YWw6IE5vdCBhIHZhbGlkIG9iamVjdCBuYW1lIEhFQUQKCk5vdGhpbmcgaW4g
dGhlIGVycm9yX2xvZyBvbiBhcGFjaGUuICBXaHkgd291bGQgZ2l0IGJlIGxvb2tpbmcgZm9yIGEK
cmVtb3RlcyBvcmlnaW4gc2luY2UgSSBhbSBjbG9uaW5nIGZyb20gYSByZW1vdGUgc291cmNlPwoK
U2Vhbgo=
