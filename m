From: "=?UTF-8?Q?Jo=C3=A3o_Abecasis?=" <joao@abecasis.name>
Subject: Re: [PATCH] git-svn: follow revisions of svm-mirrored repositories
Date: Tue, 17 Jun 2008 21:57:29 -0500
Message-ID: <7bf6f1d20806171957k29dbdd4fh52c3b515e7b573d@mail.gmail.com>
References: <7bf6f1d20806132102x71422617s26260fdc348a7c04@mail.gmail.com>
	 <485589F5.6020409@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Sam Vilain" <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Jun 18 04:58:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8nsR-0005xh-Vi
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 04:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756023AbYFRC5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 22:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756183AbYFRC5c
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 22:57:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:19294 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755731AbYFRC5b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 22:57:31 -0400
Received: by ug-out-1314.google.com with SMTP id h2so701839ugf.16
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 19:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=NgoekFdszNLeBa6RQiWBAKnRcwwtKN5mIWWvWM6bCc0=;
        b=ok4nsiQHCSWUyseMsGq2oVQA/3/sizhUEqufRCfMyZ/k2thaESnF/QkFzVMtN5JiLI
         3UlNedhyZLHZcRuu9tcHe49Tp9T6SiVtBVfI/h07OIwmpZzEVYp8Uul2FyC1oJ0cw/Q/
         RL6lqcjCILwk0g43falKbhR5QAU+/0dnz+2ls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=l6N1MKGhFiubqLfweNJ9Sv5ivdWjteb7JOxpL3gToVnBtZ/3MyrwHpHr2DY3xyDF2I
         Oww7Gi42N5WTXloBbnQK7IOGc3s2zExOLDowdhed6if3ui51MF7+FKA4AVRrPo9dwXh2
         QnH+DMyaBi3N6qnlhiDV6SeMJDXpdDEZgKx60=
Received: by 10.67.115.9 with SMTP id s9mr8823753ugm.81.1213757849657;
        Tue, 17 Jun 2008 19:57:29 -0700 (PDT)
Received: by 10.67.94.6 with HTTP; Tue, 17 Jun 2008 19:57:29 -0700 (PDT)
In-Reply-To: <485589F5.6020409@vilain.net>
Content-Disposition: inline
X-Google-Sender-Auth: 68c02d0ff0d08b3f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85352>

SGkgU2FtLAoKVGhhbmtzIGZvciB5b3VyIHJlcGx5LiBJJ20gY3VycmVudGx5IG9uIHRoZSByb2Fk
IHNvIG1heSBiZSBhIGxpdHRsZQpzbG93IHRvIHJlc3BvbmQuIFBsZWFzZSBiZWFyIHdpdGggbWUu
CgpTYW0gVmlsYWluIHdyb3RlOgo+PiBXaGVuIHVzaW5nIGFuIHN2ayBtaXJyb3IgcmVwb3NpdG9y
eSBhcyB0aGUgc291cmNlIGZvciBnaXQtc3ZuLAo+PiBmaW5kLXJldiBhbmQgcmViYXNlIGRvbid0
IHdvcmsuCj4+Cj4+IGZpbmQtcmV2IHRha2VzIGEgd2hpbGUsIHdoaWxlIGl0IHRyYXZlcnNlcyBh
bmQgcHJvY2Vzc2VzIGNvbW1pdCBsb2dzCj4+IGZvciB0aGUgYnJhbmNoLCBhbmQgdWx0aW1hdGVs
eSBmYWlscyB3aXRoIHRoZSBlcnJvciBtZXNzYWdlOiAiVW5hYmxlCj4+IHRvIGRldGVybWluZSB1
cHN0cmVhbSBTVk4gaW5mb3JtYXRpb24gZnJvbSBnaXQtc3ZuIGhpc3RvcnkiLiBUaGlzCj4+IGhh
cHBlbnMgYmVjYXVzZSBmaW5kLXJldiBkb2Vzbid0IHJlbGF0ZSBpbmZvcm1hdGlvbiBpbiB0aGUg
Y29tbWl0Cj4+IG1lc3NhZ2VzIHRvIHRoZSBpbnRlcm5hbCBzdm0tc291cmNlIHJldmlzaW9uIG1h
cHMuCj4+Cj4+IFNpbWlsYXJseSwgcmViYXNlIGlzIGZhc3RlciBidXQgc3RpbGwgZXhpdHMgd2l0
aCB0aGUgbWVzc2FnZSAiVW5hYmxlCj4+IHRvIGRldGVybWluZSB1cHN0cmVhbSBTVk4gaW5mb3Jt
YXRpb24gZnJvbSB3b3JraW5nIHRyZWUgaGlzdG9yeSIuCj4+Cj4+IFRoZSBhdHRhY2hlZCBwYXRj
aCBmaXhlcyBhIGNvdXBsZSBvZiB1bmRlcmx5aW5nIGlzc3VlcyB0byBnZXQgYXQgbGVhc3QKPj4g
dGhlc2UgdHdvIGNvbW1hbmRzIHdvcmtpbmcuIEFGQUlDVCBpdCBzdGlsbCB3b3JrcyB3ZWxsIHdp
dGggcGxhaW4gc3ZuCj4+IHJlcG9zaXRvcmllcy4KPj4KPj4gQ2FuIHRoaXMgYmUgbWVyZ2VkIHVw
c3RyZWFtPyBBbnkgY29tbWVudHMgYXJlIHdlbGNvbWUuCj4KPiBDYW4geW91IGdpdmUgYW4gYXBw
cm94aW1hdGUgc2VyaWVzIG9mIGNvbW1hbmRzIHRoYXQgbGVkIHRvIHRoaXMgbm90Cj4gd29ya2lu
Zz8gIEp1c3QgdG8gY2xhcmlmeSB3aGF0IGhhcHBlbmVkLiAgSWRlYWxseSwgaXQgd291bGQgYmUg
YSB0ZXN0Cj4gY2FzZTsgc2VlIGlmIHlvdSBjYW4gYWRkIGl0IHRvIHRoZSBleGlzdGluZyBTVk0g
dGVzdCBjYXNlLiAgSW4gZmFjdCB0aGlzCj4gbWlnaHQgYmUgYSByZWdyZXNzaW9uIGNvbXBhcmVk
IHRvIHRoZSBvcmlnaW5hbCBzdXBwb3J0LCBkdWUgdG8gbGFjayBvZgo+IHRlc3RzIC0gaW4gd2hp
Y2ggY2FzZSBpdCB3b3VsZCBiZSBnb29kIHRvIGZpeCB0aGlzICJmb3IgZ29vZCIuCgpJIGhhdmVu
J3QgdHJpZWQgdGhlIHRlc3QgY2FzZXMgeWV0LCBidXQgd2lsbCBsb29rIGludG8gaXQuIFBlcmhh
cHMKdGhhdCBjYW4gYWxzbyBoYW1tZXIgb3V0IG90aGVyIHBsYWNlcyB3aGVyZSBzdm0tbWlycm9y
IHN1cHBvcnQgaXMKaW5jb21wbGV0ZS4KCkluIHRoZSBtZWFudGltZSwgcmVwcm9kdWNpbmcgdGhl
IDIgaXNzdWVzIG15IHBhdGNoIGlzIHN1cHBvc2VkIHRvIGZpeAppcyByYXRoZXIgc3RyYWlnaHRm
b3J3YXJkLCBidXQgdGhlcmUgY291bGQgYmUgc29tZXRoaW5nIHRoYXQgSSBtaXNzZWQsCnNvIGhl
cmUgZ29lczoKCiAgICAjIFByZXBhcmF0aW9uLCBza2lwcGVkIGluZm9ybWF0aW9uYWwgbWVzc2Fn
ZXMuCiAgICAkIGdpdCBpbml0CiAgICAkIGdpdCBzdm4gaW5pdCAtLXVzZS1zdm0tcHJvcHMgLXMg
ZmlsZTovLy9wYXRoL3RvL3N2ay9yZXBvc2l0b3J5L2FuZC9taXJyb3IvCiAgICAjIFBvcHVsYXRl
IHJlcG9zaXRvcnkKICAgICQgZ2l0IHN2biBmZXRjaAoKICAgICMgQW5kIHRoZSBtaXNzaW5nIGZ1
bmN0aW9uYWxpdHkuCiAgICAkIGdpdCBzdm4gcmViYXNlCiAgICBVbmFibGUgdG8gZGV0ZXJtaW5l
IHVwc3RyZWFtIFNWTiBpbmZvcm1hdGlvbiBmcm9tIHdvcmtpbmcgdHJlZSBoaXN0b3J5CgogICAg
JCBnaXQgc3ZuIGZpbmQtcmV2IHI1CiAgICBVbmFibGUgdG8gZGV0ZXJtaW5lIHVwc3RyZWFtIFNW
TiBpbmZvcm1hdGlvbiBmcm9tIEhFQUQgaGlzdG9yeQoKQW5kIHRyeWluZyBvdXQgdGhlIHRlc3Qg
Y2FzZSBJIGp1c3Qgbm90aWNlZCBhbiBpc3N1ZSB3aXRoIG15IHByZXZpb3VzCnBhdGNoLCB3aXRo
IG1pc3BsYWNlZCAvLyAtLSBzb21laG93IGl0IGRpZG4ndCBzaG93IHVwIGluIG15IHByZXZpb3Vz
CnRlc3RzLiBJJ2xsIHBvc3QgYW4gdXBkYXRlZCBwYXRjaCwgc2hvcnRseS4KCj4gQWxzbywgcGxl
YXNlIHRyeSB0byBzZW5kIHlvdXIgcGF0Y2hlcyBpbmxpbmUgaWYgcG9zc2libGUsIG9yIGF0IGxl
YXN0Cj4gdHJ5IHRvIGdldCB0aGVtIHRvIGJlIENvbnRlbnQtRGlzcG9zaXRpb246IGlubGluZSwg
aXQgbWFrZXMgcmV2aWV3Cj4gZWFzaWVyIGZvciBjYXN1YWwgbGlzdCBzdWJzY3JpYmVycy4KCkkg
d2FzIHdvcnJpZWQgdGhhdCBzZW5kaW5nIHBhdGNoZXMgaW5saW5lZCB3b3VsZCBicmVhayB0aGUg
cGF0Y2gKYmVjYXVzZSBvZiBsaW5lIGxlbmd0aHMgYW5kIHN1Y2gsIHNpbmNlIEknbSB1c2luZyBH
bWFpbCdzIHdlYgppbnRlcmZhY2UuIEFueXdheSwgSSdsbCB0cnkgdGhhdCB3ZSdsbCBzZWUgaG93
IHRoYXQgZ29lcy4KCkNoZWVycywKCgpKb8Ojbwo=
