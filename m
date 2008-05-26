From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: git-diff cr/nl files on linux
Date: Mon, 26 May 2008 15:04:45 +0700
Message-ID: <fcaeb9bf0805260104p72828318p202d3bceaa676daa@mail.gmail.com>
References: <fcaeb9bf0805240554j71693d5eo2a425ee0efe2f364@mail.gmail.com>
	 <483811BF.3090302@dirk.my1.cc>
	 <fcaeb9bf0805252115q60f784aax6b1f267c476960b4@mail.gmail.com>
	 <483A59FD.6020906@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "=?UTF-8?Q?Dirk_S=C3=BCsserott?=" <newsletter@dirk.my1.cc>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon May 26 10:06:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0Xi9-0003He-MR
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 10:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408AbYEZIEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 04:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752710AbYEZIEs
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 04:04:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:39835 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbYEZIEq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 04:04:46 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1164599fgg.17
        for <git@vger.kernel.org>; Mon, 26 May 2008 01:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=D435IM0BNnFdinHkHfO0joIdzBdvIo+/nJ9bdjzKBBs=;
        b=Msj81XuLNXaup+LC+2Sp2ZrbWI+MfbNuOhLVAR3Uoa88DR4P5G4jRXKNDxVb3NTvgmVu5kDw2ujndtsBwiuBz+c/NR9FtI05UFaiU8vPwFYp2peWoeyXEerjxf9jb4pbAaDE/BEl5vEXxXL00S7vcsW3UnF2OrdksTeN0lMDvU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SHQszr96ZQGomkOGd/1gqunnYbD9Qv4fAkZyRowCuF9RDN5JPH2PKZnOX/zN+L4sr0XtYZL+Mmm8L4an5pKqu/I9evEz2/mJ6fxI8LDp/Ry4Rjux4kDAnnQukrLujcdgXp+aZJLrNAa35Pl5V87CjTfiA6+0pmYuDB4Kz01R+e0=
Received: by 10.86.52.6 with SMTP id z6mr447317fgz.48.1211789085075;
        Mon, 26 May 2008 01:04:45 -0700 (PDT)
Received: by 10.86.62.13 with HTTP; Mon, 26 May 2008 01:04:45 -0700 (PDT)
In-Reply-To: <483A59FD.6020906@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82906>

T24gTW9uLCBNYXkgMjYsIDIwMDggYXQgMTozNCBQTSwgSm9oYW5uZXMgU2l4dCA8ai5zaXh0QHZp
c2NvdmVyeS5uZXQ+IHdyb3RlOgo+IE5ndXllbiBUaGFpIE5nb2MgRHV5IHNjaHJpZWI6Cj4+IE9u
IFNhdCwgTWF5IDI0LCAyMDA4IGF0IDg6MDEgUE0sIERpcmsgU8O8c3Nlcm90dCA8bmV3c2xldHRl
ckBkaXJrLm15MS5jYz4gd3JvdGU6Cj4+PiBOZ3V5ZW4gVGhhaSBOZ29jIER1eSBzY2hyaWViOgo+
Pj4+IEhpLAo+Pj4+Cj4+Pj4gSXMgdGhlcmUgYW55IHdheSB0aGF0IGNhbiBtYWtlIGdpdC1kaWZm
IHNob3cgY3IvbmwgZW5kaW5nIGZpbGVzIG9uCj4+Pj4gbGludXggd2l0aG91dCBeTSBhdCB0aGUg
ZW5kPwo+Pj4+Cj4+Pj4gVGhhbmtzCj4+Pj4KPj4+IFdoYXQgYWJvdXQgJ2dpdCBkaWZmIC13Jz8g
SXQgZHJvcHMgYW55IHdoaXRlc3BhY2UgY2hhbmdlcywgaW5jbHVkaW5nIF5NJ3MuCj4+PiBOb3Qg
c3VyZSB3aGV0aGVyIHRoYXQgaXMgd2hhdCB5b3UgbWVhbnQuCj4+Cj4+IFRoYXQgd29uJ3QgaGVs
cC4gSGVyZSBpcyBhIHNuaXBwZXQgb2Ygd2hhdCBJIHNlZToKPj4KPj4gZGlmZiAtLWdpdCBhL2Fi
Yy5jIGIvYWJjLmMKPj4gaW5kZXggMDY0YTc2OS4uNjQ3YjlhZSAxMDA2NDQKPj4gLS0tIGEvYWJj
LmMKPj4gKysrIGIvYWJjLmMKPj4gQEAgLTg1OSw3ICs4NTksMTAgQEAgaW50IGRlZgo+PiAgICAg
ICkKPj4gICAgICB7Cj4+ICAgICAgRkFTVCBpbnQgYXNkc2E7Cj4+IC0gICAgRkFTVCBpbnQgZHNk
c2FkOwo+PiArICAgIEZBU1QgaW50IGRzYWRhZGQ7ICAgICAgICAgIC8qIEVSUk9SIGFsc28gbWVh
bnMgQUFTQVMgKi9eTQo+PiArI2lmbmRlZiBKSEFTSEpKSF5NCj4+ICsgICAgc3RydWN0IHNkZGRk
IGRhc2RhZGE7Xk0KPj4gKyNlbmRpZl5NCj4+ICAgICAgdW5pb24gc2RkZCBhc2RzZGFkOwo+PiAg
ICAgIEZBU1QgU1RBVFVTIGRzYWRhZGFkOwo+PiAgICAgIHVuc2lnbmVkIGludCBzZGFkYWRhZCA9
IDA7Cj4+Cj4+IFdpdGggY29sb3IgdHVybmluZyBvZmYsIGl0IGRvZXMgbm90IHNob3cgXk0gc28g
cHJvYmFibHkgc29tZXRoaW5nIHRvCj4+IGRvIHdpdGggdGhlIGNvbG9yaW5nLiBsZXNzIGlzIGF0
IHZlcnNpb24gMzk0Lgo+Cj4gbGVzcyBkb2VzIG5vdCBzaG93IFxyIGlmIGl0IGNvbWVzIHJpZ2h0
IGJlZm9yZSBcbi4gQnV0IHdpdGggZGlmZi1jb2xvcmluZwo+IHR1cm5lZCBvbiwgdGhlICdyZXNl
dCBjb2xvcicgc2VxdWVuY2UgaXMgaW5zZXJ0ZWQgYmV0d2VlbiBcciBhbmQgXG47IG5vdwo+IGxl
c3Mgc2hvd3MgXk0gZm9yIHRoZSBcciBiZWNhdXNlIGl0J3Mgbm90IG5leHQgdG8gdGhlIFxuIGFu
eW1vcmUuCj4KClJpZ2h0LiBBbmQgc2V0dGluZyBjb3JlLndoaXRlc3BhY2UgPSBjci1hdC1lb2wg
Zml4ZXMgaXQgKGFsdGhvdWdoCmRpZmZpY3VsdCB0byBmaW5kKS4gVGhhbmsgeW91IGFsbC4KCj4g
LS0gSGFubmVzCj4KCgoKLS0gCkR1eQo=
