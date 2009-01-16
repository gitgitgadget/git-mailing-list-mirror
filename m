From: "=?UTF-8?Q?Jonas_Flod=C3=A9n?=" <jonas@floden.nu>
Subject: [PATCH/RFC] git-am: Make it easier to see which patch failed
Date: Fri, 16 Jan 2009 15:34:47 +0100
Message-ID: <636ecac0901160634r586c72a0r9bb63c6f019f5bff@mail.gmail.com>
References: <636ecac0901160518o16706bbia9acaf09fdf92946@mail.gmail.com>
	 <alpine.DEB.1.00.0901161513400.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 16 15:36:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNpny-0002Pl-2i
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 15:36:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758222AbZAPOev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 09:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757749AbZAPOev
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 09:34:51 -0500
Received: from qb-out-0506.google.com ([72.14.204.229]:26316 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757710AbZAPOet (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 09:34:49 -0500
Received: by qb-out-0506.google.com with SMTP id f11so737847qba.17
        for <git@vger.kernel.org>; Fri, 16 Jan 2009 06:34:48 -0800 (PST)
Received: by 10.143.2.7 with SMTP id e7mr1062885wfi.246.1232116487290;
        Fri, 16 Jan 2009 06:34:47 -0800 (PST)
Received: by 10.142.253.12 with HTTP; Fri, 16 Jan 2009 06:34:47 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901161513400.3586@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105964>

V2hlbiBnaXQtYW0gZmFpbHMgaXQncyBub3QgYWx3YXlzIGVhc3kgdG8gc2VlIHdoaWNoIHBhdGNo
IGZhaWxlZCwKc2luY2UgaXQncyBvZnRlbiBoaWRkZW4gYnkgYSBsb3Qgb2YgZXJyb3IgbWVzc2Fn
ZXMuCkFkZCBhbiBleHRyYSBsaW5lIHdoaWNoIHByaW50cyB0aGUgbmFtZSBvZiB0aGUgZmFpbGVk
IHBhdGNoIGp1c3QKYmVmb3JlIHRoZSByZXNvbHZlIG1lc3NhZ2UgdG8gbWFrZSBpdCBlYXNpZXIg
dG8gZmluZC4KClNpZ25lZC1vZmYtYnk6IEpvbmFzIEZsb2TDqW4gPGpvbmFzQGZsb2Rlbi5udT4K
LS0tCkpvaGFubmVzIFNjaGluZGVsaW4gd3JvdGU6Cj4gTWF5YmUKPgo+IC0gICAgICAgICAgICAg
ICBlY2hvIFBhdGNoIGZhaWxlZCBhdCAkbXNnbnVtLgo+ICsgICAgICAgICAgICAgICBlY2hvIFBh
dGNoIGZhaWxlZCBhdCAkbXNnbnVtKCRGSVJTVExJTkUpLgoKSG93IGFib3V0IHRoaXMgaW5zdGVh
ZC4gVGhvdWdoIHRoZSBsaW5lIGNvdWxkIGdldCB2ZXJ5IGxvbmcuClRoaXMgbWFrZXMgdGhlIGxp
bmUgc3RhbmQgb3V0IGEgbGl0dGxlIG1vcmUuCgogZ2l0LWFtLnNoIHwgICAgMiArLQogMSBmaWxl
cyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
Z2l0LWFtLnNoIGIvZ2l0LWFtLnNoCmluZGV4IDRiMTU3ZmUuLjA5YzJmOWMgMTAwNzU1Ci0tLSBh
L2dpdC1hbS5zaAorKysgYi9naXQtYW0uc2gKQEAgLTUwMSw3ICs1MDEsNyBAQCBkbwogCWZpCiAJ
aWYgdGVzdCAkYXBwbHlfc3RhdHVzICE9IDAKIAl0aGVuCi0JCWVjaG8gUGF0Y2ggZmFpbGVkIGF0
ICRtc2dudW0uCisJCXByaW50ZiAnXG5QYXRjaCBmYWlsZWQgYXQgJXMgKCVzKVxuJyAiJG1zZ251
bSIgIiRGSVJTVExJTkUiCiAJCXN0b3BfaGVyZV91c2VyX3Jlc29sdmUgJHRoaXMKIAlmaQoKLS0g
CjEuNi4xLjI4LmdjMzJmNzYK
