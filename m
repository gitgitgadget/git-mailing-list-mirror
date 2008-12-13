From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Git weekly news: 2008-50
Date: Sat, 13 Dec 2008 03:10:17 +0200
Message-ID: <94a0d4530812121710u7755b8a9m87dd134b0c8b04ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
To: "git list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 13 02:11:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBJ2n-000119-NI
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 02:11:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753131AbYLMBKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 20:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752865AbYLMBKV
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 20:10:21 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:62180 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171AbYLMBKU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 20:10:20 -0500
Received: by fg-out-1718.google.com with SMTP id 19so815828fgg.17
        for <git@vger.kernel.org>; Fri, 12 Dec 2008 17:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=C5GxVAW2wWXxuaI66+WGB8nNTyya0xV27tw6WMczCEQ=;
        b=lxmPiGA6zTsZ2mzZ+Yg1pMaYllYheHVwa0nqGHYSPsOAz2l2JQ6rXWBg4xZi9LPEXY
         swW8KATW+BR3eRtVVLym/QSz5GOpz78zJfT9VfyRFL+cnlzLta4RzOEDG2kU0NvdxGGe
         GxpsS/OfxJw6p3tvvVEPRHMCLKcOyRC6WF7rE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=KuoLlHK3Okxe9S/xTjH7xlSkj3lza1hYFiLUP3sTu2SUbavhFG8sSH4mVog/AYA0Xz
         d4R+ramYdYQFGc2SYZg2dZxVycArefRuLpJu7GJ32RrdTpn533iU8TwwXEUDouSm+fQC
         +a5JASr9XS+jtbn47p8d+aEEScVM/xdcQ29VE=
Received: by 10.86.4.2 with SMTP id 2mr2375653fgd.43.1229130617822;
        Fri, 12 Dec 2008 17:10:17 -0800 (PST)
Received: by 10.86.77.17 with HTTP; Fri, 12 Dec 2008 17:10:17 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102973>

SGkgYWxsLAoKVGhpcyB3ZWVrIEknbSB0cnlpbmcgdG8gYWRkcmVzcyBzb21lIG9mIHRoZSBpc3N1
ZXMgbWVudGlvbmVkIGhlcmUuIEkKc3RpbGwgd291bGQgbGlrZSBwZW9wbGUgdG8gcmVxdWVzdCB1
c2VyIGFjY291bnRzIHRvIHRoaXMgYmxvZyBpZiB0aGV5Cndpc2ggdG8gbWFrZSBzb21lIGdpdCBy
ZWxhdGVkIHBvc3RzLgoKaHR0cDovL2dpdGxvZy53b3JkcHJlc3MuY29tLzIwMDgvMTIvMTMvZ2l0
LXdlZWtseS1saW5rcy0yMDA4LTUwLwoKPT0gQXJ0aWNsZXMgPT0KCldoeSBTdWJ2ZXJzaW9uIGRv
ZXMgbm90IHN1Y2sKaHR0cDovL2Jsb2cuYXNzZW1ibGEuY29tL2Fzc2VtYmxhYmxvZy90YWJpZC8x
MjYxOC9iaWQvNzQzNy9XaHktU3VidmVyc2lvbi1kb2VzLW5vdC1zdWNrLmFzcHgKCkFydGljbGVz
IG9uIEdpdCwgYSBkaXN0cmlidXRlZCB2ZXJzaW9uIGNvbnRyb2wgc3lzdGVtCmh0dHA6Ly93d3cu
Z25vbWUub3JnL35mZWRlcmljby9pbmRleC5odG1sI2dpdAoKUHVzaGluZyBhbmQgcHVsbGluZyB3
aXRoIEdpdCwgcGFydCAyCmh0dHA6Ly93d3cuZ25vbWUub3JnL35mZWRlcmljby9uZXdzLTIwMDgt
MTIuaHRtbCNwdXNoaW5nLWFuZC1wdWxsaW5nLXdpdGgtZ2l0LTIKClNldHRpbmcgVXAgUnVieSBv
biBSYWlscyBQcm9qZWN0cyB3aXRoIEdpdCBhbmQgR2l0aHViCkEgc3RyYWlnaHQgZm9yd2FyZCBn
dWlkZSB0byBzZXR1cCBnaXQgYW5kIGdpdGh1YiBpbiBXaW5kb3dzCmh0dHA6Ly9iZWFucy5zZWFy
dGlweS5jb20vMjAwOC8xMi8wOS9zZXR0aW5nLXVwLXJ1Ynktb24tcmFpbHMtcHJvamVjdHMtd2l0
aC1naXQtYW5kLWdpdGh1Yi8KCkluc2lkZXIgR3VpZGUgdG8gR2l0SHViCkNvbXByZWhlbnNpdmUg
c2NyZWVuY2FzdHMgdG8gZ2V0IGZhbWlsaWFyIHdpdGggZ2l0IGJ5IFNjb3R0IENoYWNvbgpodHRw
Oi8vZ2l0aHViLmNvbS9ibG9nLzI2MS1pbnNpZGVyLWd1aWRlLXRvLWdpdGh1Yi1zZXJpZXMKaHR0
cDovL3d3dy5wcmFncHJvZy5jb20vc2NyZWVuY2FzdHMvdi1zY2dpdGh1Yi9pbnNpZGVyLWd1aWRl
LXRvLWdpdGh1YgoKWVVJIG9uIEdpdEh1YgpZYWhvbydzIFVzZXIgSW50ZXJmYWNlIExpYnJhcnkg
aXMgbm93IGhvc3RlZCBwdWJsaWNseSBvbiBHaXRodWIKaHR0cDovL2dpdGh1Yi5jb20vYmxvZy8y
NjIteXVpLW9uLWdpdGh1YgoKTGFzIHZlbnRhamFzIGRlIEdpdApEaXNjdXNzaW9uIGFib3V0IEdp
dCdzIGFkdmFudGFnZXMgaW4gYmFycmFwdW50by5jb20gKFNwYW5pc2gncyBzbGFzaGRvdCkKaHR0
cDovL3ByZWd1bnRhcy5iYXJyYXB1bnRvLmNvbS9hcnRpY2xlLnBsP3NpZD0wOC8xMi8wOC8wMTky
MDMKCj09IEluIEphcGFuZWVzZSAoSSd2ZSBubyBpZGVhKSA9PQoKY29kZXJlcG9zIOOBriBjb21t
aXQg5pWw44OK44Oz44OQ44O877yR44Gu5Lq644GMIGdpdGh1YiDjgpLnt7Tnv5LjgZfjgZ/jg6Hj
g6IKaHR0cDovL2QuaGF0ZW5hLm5lLmpwL3Rva3VoaXJvbS8yMDA4MTIxMi8xMjI5MDgwOTkwCgpn
aXTjgafjg4njg4Pjg4jjg5XjgqHjgqTjg6vjgpLjg5Djg7zjgrjjg6fjg7PnrqHnkIbjgZnjgosK
aHR0cDovL2QuaGF0ZW5hLm5lLmpwL2phdmFzY3JpcHRlci8yMDA4MTIwOC8xMjI4NzMwOTY3Cgpn
aXN044Kz44Oe44Oz44OJ44KI44KK44Gh44KH44Gj44Go5L6/5Yip44GqZ2lzdHkKaHR0cDovL2Qu
aGF0ZW5hLm5lLmpwL3N3ZHloLzIwMDgxMjA3LzEyMjg2NTUxOTgKCj09IFN0aWxsIHBvcHVsYXIg
PT0KCldoeSBHaXQgaXMgQmV0dGVyIHRoYW4gWApCcmllZiBleHBsYW5hdGlvbiBhYm91dCB3aHkg
eW91IHNob3VsZCBzd2l0Y2ggZnJvbSBYIHRvIEdpdApodHRwOi8vd2h5Z2l0aXNiZXR0ZXJ0aGFu
eC5jb20vCgpQb3IgcXXDqSBHaXQgZXMgbWVqb3IgcXVlIFgKQWxzbyB2ZXJ5IHBvcHVsYXIgaXMg
dGhlIFNwYW5pc2ggdmVyc2lvbgpodHRwOi8vZXMud2h5Z2l0aXNiZXR0ZXJ0aGFueC5jb20vCgo9
PSBNeSBwaWNrcyA9PQoKV2hhdCBhcmUgeW91ciBmYXZvcml0ZSBnaXQgZmVhdHVyZXMgb3IgdHJp
Y2tzPwpBIGJ1bmNoIG9mIGdpdCB0cmlja3MKaHR0cDovL3N0YWNrb3ZlcmZsb3cuY29tL3F1ZXN0
aW9ucy8zNDc5MDEvd2hhdC1hcmUteW91ci1mYXZvcml0ZS1naXQtZmVhdHVyZXMtb3ItdHJpY2tz
CgotLSAKRmVsaXBlIENvbnRyZXJhcwo=
