From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [QGit] Can't compile under windows (MSVC2008)
Date: Tue, 7 Oct 2008 13:14:03 +0200
Message-ID: <e5bfff550810070414u283f5ccav33712ca1c6212bde@mail.gmail.com>
References: <gbak2u$v9b$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Abdelrazak Younes" <younes@lyx.org>
X-From: git-owner@vger.kernel.org Tue Oct 07 13:15:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnAX9-0003SI-MQ
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 13:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbYJGLOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 07:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752857AbYJGLOI
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 07:14:08 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:31339 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbYJGLOG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 07:14:06 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2746328fkq.5
        for <git@vger.kernel.org>; Tue, 07 Oct 2008 04:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=HhSrC9evUUp3BQHnHsmmH0FcB7J6l+CfIb6c9ythX5o=;
        b=e7RswoBO7TBhS3AExUTr3qVPwJe224CdNeMBr1p+zX4IGpXhm6H7dsP+AnmVjoh03/
         F3FmyB8BvzVWLvleR4t64fxzh/qUJxFsyfCHg/RM/qvnegx7wlX8wZ64IYzcyNcqXQVq
         /sd9YBojsF4i91aMVlZCQv1IBq/onKDbIXZrU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=hxsW4uBCnChhbKhEPWqUYEcNBAaEb8tcrldec9fpxepvLBjzq9x6J93H2lqEs68pnD
         amQQPZTmxqylsV9vPXL9cXesttIDEW2q/LPKL6DhunyleDBhJ5q+jO9ZO5GAiw0FxZ0E
         kaxu06w/e2HhMjOg3W2MHd8gioFg+w79Je1sE=
Received: by 10.180.225.17 with SMTP id x17mr4644193bkg.52.1223378043972;
        Tue, 07 Oct 2008 04:14:03 -0700 (PDT)
Received: by 10.180.220.15 with HTTP; Tue, 7 Oct 2008 04:14:03 -0700 (PDT)
In-Reply-To: <gbak2u$v9b$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97692>

MjAwOC85LzIzIEFiZGVscmF6YWsgWW91bmVzIDx5b3VuZXNAbHl4Lm9yZz46Cj4gSGVsbG8sCj4K
PiBJIHRyaWVkIHRvIGZvbGxvdyBSRUFETUVfV0lOLnR4dDoKPgo+IEM6XGRldmVsXHFnaXRccWdp
dDQ+cW1ha2UgcWdpdC5wcm8KPgo+IFRoZSBNYWtlZmlsZSAoYXR0YWNoZWQgdG8gdGhpcyBtYWls
KSBzZWVtcyB0byBiZSBjb3JyZWN0bHkgZ2VuZXJhdGVkIGluIHRoZQo+IHNhbWUgZGlyZWN0b3J5
IChDOlxkZXZlbFxxZ2l0XHFnaXQ0KS4KPgo+IFRoZW4sIHVuZGVyIE1TVkMyMDA4IEV4cHJlc3Ms
IEkgZ2V0IHRoaXMgZXJyb3I6Cj4KPiAxPi0tLS0tLSBEw6lidXQgZGUgbGEgZ8OpbsOpcmF0aW9u
IDogUHJvamV0IDogcWdpdCwgQ29uZmlndXJhdGlvbiA6IERlYnVnIFdpbjMyCj4gLS0tLS0tCj4g
MT5BY3Rpb25zIGRlIHByb2pldCBNYWtlZmlsZSBlbiBjb3Vycwo+IDE+TWljcm9zb2Z0IChSKSBQ
cm9ncmFtIE1haW50ZW5hbmNlIFV0aWxpdHkgVmVyc2lvbiA5LjAwLjIxMDIyLjA4Cj4gMT5Db3B5
cmlnaHQgKEMpIE1pY3Jvc29mdCBDb3Jwb3JhdGlvbi4gVG91cyBkcm9pdHMgcsOac2VydsOacy4K
PiAxPiBjZCBzcmNcICYmICJDOlxQcm9ncmFtIEZpbGVzXE1pY3Jvc29mdCBWaXN1YWwgU3R1ZGlv
Cj4gOS4wXFZDXGJpblxubWFrZS5leGUiIGRlYnVnCj4gMT5NaWNyb3NvZnQgKFIpIFByb2dyYW0g
TWFpbnRlbmFuY2UgVXRpbGl0eSBWZXJzaW9uIDkuMDAuMjEwMjIuMDgKPiAxPkNvcHlyaWdodCAo
QykgTWljcm9zb2Z0IENvcnBvcmF0aW9uLiBUb3VzIGRyb2l0cyByw5pzZXJ2w5pzLgo+IDE+Tk1B
S0UgOiBmYXRhbCBlcnJvciBVMTA3MzogaW5jYXBhYmxlIGQnb2J0ZW5pciAnc3JjXFxNYWtlZmls
ZScKPiAxPlN0b3AuCj4gMT5OTUFLRSA6IGZhdGFsIGVycm9yIFUxMDc3OiAnY2Qnw6E6IGNvZGUg
cmV0b3VyICcweDInCj4gMT5TdG9wLgo+IDE+UHJvamVjdCA6IGVycm9yIFBSSjAwMTk6IFVuIG91
dGlsIGEgcmV0b3VybsOpIHVuIGNvZGUgZCdlcnJldXIgw6AgcGFydGlyIGRlCj4gIkFjdGlvbnMg
ZGUgcHJvamV0IE1ha2VmaWxlIGVuIGNvdXJzIgo+IDE+TGUgam91cm5hbCBkZSBnw6luw6lyYXRp
b24gYSDDqXTDqSBlbnJlZ2lzdHLDqSDDoCBsJ2VtcGxhY2VtZW50Cj4gImZpbGU6Ly9jOlxkZXZl
bFxxZ2l0XHFnaXQ0XERlYnVnXEJ1aWxkTG9nLmh0bSIKPiAxPnFnaXQgLSAzIGVycmV1cihzKSwg
MCBhdmVydGlzc2VtZW50KHMpCj4gPT09PT09PT09PSBHw6luw6lyYXRpb24gOiAwIGEgcsOpdXNz
aSwgMSBhIMOpY2hvdcOpLCAwIG1pcyDDoCBqb3VyLCAwIGEgw6l0w6kgaWdub3LDqQo+ID09PT09
PT09PT0KPgo+IElkZWEgc29tZW9uZT8KPgoKaGF2ZSB5b3UgdHJpZWQgdG8gc2V0dXAgTVNWQyBm
b3IgY3VzdG9tIGJ1aWxkID8gYW5kIHBhc3MgcHJvcGVyCmNvbWFtbmQgbGluZSB3aXRoIG5tYWtl
ID8KCk1hcmNvCg==
