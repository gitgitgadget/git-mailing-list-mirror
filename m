From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] Document git-blame triple -C option
Date: Fri, 8 Jan 2010 19:40:51 +0530
Message-ID: <f3271551001080610p62ef6abfge1c96648d1ea948f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016361e7b2c8799d1047ca7c2d2
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 15:16:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTFdM-00010l-Rp
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 15:16:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495Ab0AHOQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 09:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753490Ab0AHOQF
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 09:16:05 -0500
Received: from mail-gx0-f211.google.com ([209.85.217.211]:39885 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457Ab0AHOQB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 09:16:01 -0500
Received: by gxk3 with SMTP id 3so8556775gxk.1
        for <git@vger.kernel.org>; Fri, 08 Jan 2010 06:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=wHZfLUpZBpd+UAwEzcpJ/aGrvWkHWndFgC7BBNVz5DU=;
        b=EziCzFdqXuuD89KLrD1t5U8WVmTZWLYLSPA8F6B1PFvf0vLBIeIJRrB7Gr5Ojaxl0n
         CjmmPUTgas2bHbyX5SABVjXNJWU8QShr7IiN+2Vqt5mIrwUyErCqt4fWGvdSZNV+tGid
         jG/33nyK6NBxeEK9tmjFNq4H9eNvHfjoEQ7QQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=civrg/X+1r2alulNsy5Sto1HzdlVathFFIogFNg9XFffqVeSd1VPHDm2RuzHm/rdsb
         08paXHTKOvT96OhGEWxGtxPTzTxUjDB3b1RZiUJZv7n4wniqHE8oQ1cQpo3xaQBGvlt3
         kMYJMqxq9+cdA6IicG5UpKc4WRlKMOBvYQunc=
Received: by 10.90.8.13 with SMTP id 13mr3676agh.89.1262959871628; Fri, 08 Jan 
	2010 06:11:11 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136439>

--0016361e7b2c8799d1047ca7c2d2
Content-Type: text/plain; charset=ISO-8859-1

The git-blame -CCC option is undocumented. This patch fixes that.

--0016361e7b2c8799d1047ca7c2d2
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-Document-git-blame-triple-C-option.patch"
Content-Disposition: attachment; 
	filename="0001-Document-git-blame-triple-C-option.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g471evq00

RnJvbSAyNzMyYmY0MGY3NjA3OTQxY2UxZDY1Y2U0ZDBlZmZjMGU4YTBhNTkzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYW1rdW1hciBSYW1hY2hhbmRyYSA8YXJ0YWdub25AZ21haWwu
Y29tPgpEYXRlOiBGcmksIDggSmFuIDIwMTAgMTk6Mjk6MDIgKzA1MzAKU3ViamVjdDogW1BBVENI
XSBEb2N1bWVudCBnaXQtYmxhbWUgdHJpcGxlIC1DIG9wdGlvbgoKZ2l0LWJsYW1lIC1DQ0MgaXMg
ZXhwbGFpbmVkIGluIGJ1aWxpbi1ibGFtZS5jIGxpbmUgMjE3MSwgYnV0IGlzCnVuZXhwbGFpbmVk
IGluIHRoZSBkb2N1bWVudGF0aW9uLiBUaGlzIHBhdGNoIGZpeGVzIHRoYXQuCgpTaWduZWQtb2Zm
LWJ5OiBSYW1rdW1hciBSYW1hY2hhbmRyYSA8YXJ0YWdub25AZ21haWwuY29tPgotLS0KIERvY3Vt
ZW50YXRpb24vYmxhbWUtb3B0aW9ucy50eHQgfCAgIDEzICsrKysrKystLS0tLS0KIERvY3VtZW50
YXRpb24vZ2l0LWJsYW1lLnR4dCAgICAgfCAgICAyICstCiAyIGZpbGVzIGNoYW5nZWQsIDggaW5z
ZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Js
YW1lLW9wdGlvbnMudHh0IGIvRG9jdW1lbnRhdGlvbi9ibGFtZS1vcHRpb25zLnR4dAppbmRleCAx
NjI1ZmZjLi5lMWFiZjFlIDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL2JsYW1lLW9wdGlvbnMu
dHh0CisrKyBiL0RvY3VtZW50YXRpb24vYmxhbWUtb3B0aW9ucy50eHQKQEAgLTk0LDEyICs5NCwx
MyBAQCB3aXRoaW4gYSBmaWxlIGZvciBpdCB0byBhc3NvY2lhdGUgdGhvc2UgbGluZXMgd2l0aCB0
aGUgcGFyZW50CiBjb21taXQuCiAKIC1DfDxudW0+fDo6Ci0JSW4gYWRkaXRpb24gdG8gYC1NYCwg
ZGV0ZWN0IGxpbmVzIGNvcGllZCBmcm9tIG90aGVyCi0JZmlsZXMgdGhhdCB3ZXJlIG1vZGlmaWVk
IGluIHRoZSBzYW1lIGNvbW1pdC4gIFRoaXMgaXMKLQl1c2VmdWwgd2hlbiB5b3UgcmVvcmdhbml6
ZSB5b3VyIHByb2dyYW0gYW5kIG1vdmUgY29kZQotCWFyb3VuZCBhY3Jvc3MgZmlsZXMuICBXaGVu
IHRoaXMgb3B0aW9uIGlzIGdpdmVuIHR3aWNlLAotCXRoZSBjb21tYW5kIGFkZGl0aW9uYWxseSBs
b29rcyBmb3IgY29waWVzIGZyb20gYWxsIG90aGVyCi0JZmlsZXMgaW4gdGhlIHBhcmVudCBmb3Ig
dGhlIGNvbW1pdCB0aGF0IGNyZWF0ZXMgdGhlIGZpbGUuCisJSW4gYWRkaXRpb24gdG8gYC1NYCwg
ZGV0ZWN0IGxpbmVzIGNvcGllZCBmcm9tIG90aGVyIGZpbGVzIHRoYXQKKwl3ZXJlIG1vZGlmaWVk
IGluIHRoZSBzYW1lIGNvbW1pdC4gIFRoaXMgaXMgdXNlZnVsIHdoZW4geW91CisJcmVvcmdhbml6
ZSB5b3VyIHByb2dyYW0gYW5kIG1vdmUgY29kZSBhcm91bmQgYWNyb3NzIGZpbGVzLgorCVdoZW4g
dGhpcyBvcHRpb24gaXMgZ2l2ZW4gdHdpY2UsIHRoZSBjb21tYW5kIGFkZGl0aW9uYWxseQorCWxv
b2tzIGZvciBjb3BpZXMgZnJvbSBvdGhlciBmaWxlcyBpbiB0aGUgY29tbWl0IHRoYXQgY3JlYXRl
cworCXRoZSBmaWxlLiBXaGVuIHRoaXMgb3B0aW9uIGlzIGdpdmVuIHRocmljZSwgdGhlIGNvbW1h
bmQKKwlhZGRpdGlvbmFsbHkgbG9va3MgZm9yIGNvcGllcyBmcm9tIG90aGVyIGZpbGVzIGluIGFu
eSBjb21taXQuCiArCiA8bnVtPiBpcyBvcHRpb25hbCBidXQgaXQgaXMgdGhlIGxvd2VyIGJvdW5k
IG9uIHRoZSBudW1iZXIgb2YKIGFscGhhbnVtZXJpYyBjaGFyYWN0ZXJzIHRoYXQgZ2l0IG11c3Qg
ZGV0ZWN0IGFzIG1vdmluZwpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9naXQtYmxhbWUudHh0
IGIvRG9jdW1lbnRhdGlvbi9naXQtYmxhbWUudHh0CmluZGV4IDhjN2I3YjAuLjI1YmM0MTYgMTAw
NjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vZ2l0LWJsYW1lLnR4dAorKysgYi9Eb2N1bWVudGF0aW9u
L2dpdC1ibGFtZS50eHQKQEAgLTksNyArOSw3IEBAIFNZTk9QU0lTCiAtLS0tLS0tLQogW3ZlcnNl
XQogJ2dpdCBibGFtZScgWy1jXSBbLWJdIFstbF0gWy0tcm9vdF0gWy10XSBbLWZdIFstbl0gWy1z
XSBbLXBdIFstd10gWy0taW5jcmVtZW50YWxdIFstTCBuLG1dCi0gICAgICAgICAgICBbLVMgPHJl
dnMtZmlsZT5dIFstTV0gWy1DXSBbLUNdIFstLXNpbmNlPTxkYXRlPl0KKyAgICAgICAgICAgIFst
UyA8cmV2cy1maWxlPl0gWy1NXSBbLUNdIFstQ10gWy1DXSBbLS1zaW5jZT08ZGF0ZT5dCiAJICAg
IFs8cmV2PiB8IC0tY29udGVudHMgPGZpbGU+IHwgLS1yZXZlcnNlIDxyZXY+XSBbLS1dIDxmaWxl
PgogCiBERVNDUklQVElPTgotLSAKMS42LjUKCg==
--0016361e7b2c8799d1047ca7c2d2--
