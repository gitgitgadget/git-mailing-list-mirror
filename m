From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: [PATCH] Revert "git-svn: Speed up fetch"
Date: Sun, 29 Jun 2008 01:51:09 +0200
Message-ID: <237967ef0806281651p3abf6ae4j9169cdc5bbf8f85d@mail.gmail.com>
References: <20080628194808.GA29908@atjola.homenet>
	 <1214686673-28099-1-git-send-email-apenwarr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Eric Wong" <normalperson@yhbt.net>,
	"Adam Roben" <aroben@apple.com>,
	"Samuel Bronson" <naesten@gmail.com>, B.Steinbrink@gmx.de,
	git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 01:52:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCkDn-0006CN-In
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 01:52:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbYF1XvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 19:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbYF1XvL
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 19:51:11 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:31647 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbYF1XvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 19:51:09 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1123720rvb.1
        for <git@vger.kernel.org>; Sat, 28 Jun 2008 16:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=UsbVtZiPXY+xG+8VDqtk0yQ6hP+SK9epcHEYwHHJDsk=;
        b=tpU/VXd97sglkeYCGpLg9SE+RIC4N3nHXF8NyUWI8TQOZRT/oyng7ZGJG3pOkWGFxu
         NK6GyzmEKchoFKf4LqNfJBjkHSdyimldoFpk4QW+lLK5LhasEGXNJKsnWp6w4zt4BSXv
         V0QPuuNh8VEGefPWfdsl9NHNemLUYGo/V9LAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=NgH2xcZcchzGtHSS+RmcaSUBA8DHiJ4rifsqGEdFgwhtvizXi6VtyyafGDaa8VDQ9H
         EZpjXpSugotCQMK1zr5tGlCwLgUEZqf6Yvf7C0hKvVHcPg2OKAdzLIqLj6tQi4xLk9gu
         gDJ5GhgcE1r8TO6TMtNgShclpOGo4AyXeBw58=
Received: by 10.141.43.5 with SMTP id v5mr1702577rvj.216.1214697069251;
        Sat, 28 Jun 2008 16:51:09 -0700 (PDT)
Received: by 10.141.68.4 with HTTP; Sat, 28 Jun 2008 16:51:09 -0700 (PDT)
In-Reply-To: <1214686673-28099-1-git-send-email-apenwarr@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86749>

MjAwOC82LzI4IEF2ZXJ5IFBlbm5hcnVuIDxhcGVud2FyckBnbWFpbC5jb20+Ogo+IFRoaXMgcmV2
ZXJ0cyBjb21taXQgZmZlMjU2ZjliYWM4YTQwZmY3NTFhOTM0MWE1ODY5ZDk4ZjcyYzI4NSwgYmVj
YXVzZSBpdAo+IHdhcyBjYXVzaW5nIGVycm9ycyBvZiB0aGUgZm9ybToKPgo+IENoZWNrc3VtIG1p
c21hdGNoOiB0cnVuay8uZGVwZW5kIDE2ZTc0OGMyMTlmOWY5NWJmM2QwNWM2YjJhZjU0NDQyOTBi
Yzg0NzEKPiBleHBlY3RlZDogMDVmYjVlZGI4YzgwNTdiZTAwNmM3ZTkxM2FlMGM3NjQKPiAgICAg
Z290OiA3NjNiOWE0MjZjNWJkNjFlMGE4NTI1MjQ1OWQzN2NmYQo+Cj4gTm90ZSB0aGF0IHRoZSBl
eGFjdCBmYWlsaW5nIGZpbGUgYW5kIGNoZWNrc3VtIHNlZW1zIHRvIHZhcnkgaWYgeW91IGNsZWFy
Cj4gdGhlIHJlcG9zaXRvcnkgYW5kIHRyeSBhZ2Fpbi4KPgo+IENvbmZsaWN0czoKPgo+ICAgICAg
ICBnaXQtc3ZuLnBlcmwKCldhc24ndCB0aGlzIHRoZSBwcm9ibGVtIHRoYXQgd2FzIGZpeGVkIGJ5
CmQ2ODNhMGUwMGNkNDczNGI0ZmFiNzA0YmFlZjFlZTc2MjA1NzIyYmVbMV0/CgotLSAKTWlrYWVs
IE1hZ251c3NvbgoKWzFdCgpjb21taXQgZDY4M2EwZTAwY2Q0NzM0YjRmYWI3MDRiYWVmMWVlNzYy
MDU3MjJiZQpBdXRob3I6IEp1bmlvIEMgSGFtYW5vIDxnaXRzdGVyQHBvYm94LmNvbT4KRGF0ZTog
ICBUdWUgTWF5IDI3IDIzOjMzOjIyIDIwMDggLTA3MDAKCiAgICBHaXQ6OmNhdF9ibG9iOiBhbGxv
dyB1c2luZyBhbiBlbXB0eSBibG9iIHRvIGZpeCBnaXQtc3ZuIGJyZWFrYWdlCgogICAgUmVjZW50
ICJnaXQtc3ZuIG9wdGltaXphdGlvbiIgc2VyaWVzIGludHJvZHVjZWQgR2l0OjpjYXRfYmxvYigp
IHN1YnJvdXRpbmUKICAgIHdob3NlIGludGVyZmFjZSB3YXMgYnJva2VuIGluIHRoYXQgaXQgcmV0
dXJuZWQgdGhlIHNpemUgb2YgdGhlIGJsb2IgYnV0CiAgICBzaWduYWxsZWQgYW4gZXJyb3IgYnkg
cmV0dXJuaW5nIDAuICBZb3UgY2FuIG5ldmVyIHVzZSBhbiBlbXB0eSBibG9iIHdpdGgKICAgIHN1
Y2ggYW4gaW50ZXJmYWNlLgoKICAgIFRoaXMgZml4ZXMgdGhlIGludGVyZmFjZSB0byByZXR1cm4g
YSBuZWdhdGl2ZSB2YWx1ZSB0byBzaWduYWwgYW4gZXJyb3IuCgogICAgUmVwb3J0ZWQgYnkgQmrD
tnJuIFN0ZWluYnJpbmsuCgogICAgU2lnbmVkLW9mZi1ieTogSnVuaW8gQyBIYW1hbm8gPGdpdHN0
ZXJAcG9ib3guY29tPgo=
