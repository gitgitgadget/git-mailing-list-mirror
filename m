From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH v3] add --abbrev to 'git cherry'
Date: Sat, 30 May 2009 14:13:51 -0700
Message-ID: <780e0a6b0905301413o2686fe34qaa076209c26c0b55@mail.gmail.com>
References: <20090530140349.GA25265@unpythonic.net> <200905301826.11924.markus.heidelberg@web.de> 
	<20090530165306.GA1142@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org, markus.heidelberg@web.de
To: Jeff Epler <jepler@unpythonic.net>
X-From: git-owner@vger.kernel.org Sat May 30 23:14:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAVt7-0008Iu-1O
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 23:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759025AbZE3VOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2009 17:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755006AbZE3VOL
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 17:14:11 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:47087 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754755AbZE3VOK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2009 17:14:10 -0400
Received: by yx-out-2324.google.com with SMTP id 3so3760997yxj.1
        for <git@vger.kernel.org>; Sat, 30 May 2009 14:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=v/bYbgK937i2lmSCmRteI6QdKG3FdcTmIFeyrBgVrd8=;
        b=adDiHw6AKa9AU/WTRy+Cp5YuRz4phfU6uqidiQvhOmp+iHI1X86CDtEVo59kmGkP+w
         St/W6hJex0PvE+KMmLUrZVcC0Ii/XDb8fp+jdllegzYJPjl8CwEDASwagdV9vMuVAzDV
         bRuFxfq1BCAojOLOyzfwsRQ73bz7ZxxM1FlB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=BMZhilc1nqvSfVxc6THWTArLpE0bGytxqoeFu2TggsrEH2lLj/k/fGRMQF8Ypc+/R5
         hT4nIJuc/MFwrMHfpDV4691mg4OeOS39xd7L6FqmSxjnkpTWMibc32tb6WKe6I2dHKFF
         NKgo1typwB/Tevni9NgTKEApJL/Acv+iruMso=
Received: by 10.100.109.13 with SMTP id h13mr5562618anc.16.1243718051266; Sat, 
	30 May 2009 14:14:11 -0700 (PDT)
In-Reply-To: <20090530165306.GA1142@unpythonic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120364>

T24gU2F0LCBNYXkgMzAsIDIwMDkgYXQgOTo1MyBBTSwgSmVmZiBFcGxlciA8amVwbGVyQHVucHl0
aG9uaWMubmV0PiB3cm90ZToKPiBAQCAtMTE0Miw5ICsxMTQyLDIzIEBAIGludCBjbWRfY2hlcnJ5
KGludCBhcmdjLCBjb25zdCBjaGFyICoqYXJndiwgY29uc3QgY2hhciAqcHJlZml4KQo+IMKgIMKg
IMKgIMKgY29uc3QgY2hhciAqaGVhZCA9ICJIRUFEIjsKPiDCoCDCoCDCoCDCoGNvbnN0IGNoYXIg
KmxpbWl0ID0gTlVMTDsKPiDCoCDCoCDCoCDCoGludCB2ZXJib3NlID0gMDsKPiArIMKgIMKgIMKg
IGludCBhYmJyZXYgPSA0MDsKPiArCj4gKyDCoCDCoCDCoCB3aGlsZShhcmdjID4gMSAmJiBhcmd2
WzFdWzBdID09ICctJykgewo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKCFzdHJjbXAoYXJn
dlsxXSwgIi12IikpIHsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHZlcmJv
c2UgPSAxOwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfSBlbHNlIGlmKCFzdHJjbXAoYXJndlsx
XSwgIi0tYWJicmV2IikpIHsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGFi
YnJldiA9IERFRkFVTFRfQUJCUkVWOwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfSBlbHNlIGlm
KCFwcmVmaXhjbXAoYXJndlsxXSwgIi0tYWJicmV2PSIpKSB7Cj4gKyDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBhYmJyZXYgPSBzdHJ0b2woYXJndlsxXSArIDksIE5VTEwsIDEwKTsK
PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmKGFiYnJldiA8IE1JTklNVU1f
QUJCUkVWKQo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
YWJicmV2ID0gTUlOSU1VTV9BQkJSRVY7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBlbHNlIGlmKGFiYnJldiA+IDQwKQo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgYWJicmV2ID0gNDA7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9
IGVsc2Ugewo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZGllKCJ1bnJlY29n
bml6ZWQgYXJndW1lbnQ6ICVzIiwgYXJndlsxXSk7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9
Cj4KCllvdSBtaWdodCB3YW50IHRvIGxvb2sgYXQgdXNpbmcgdGhlIHBhcnNlIG9wdGlvbnMgQVBJ
LiBJdCBoYXMgb3B0aW9ucwpmb3IgdmVyYm9zZSBhbmQgYWJicmV2IGJ1aWx0aW4sIHNvIHlvdSBk
b24ndCBoYXZlIHRvIGRvIGFueSBleHRyYQp3b3JrLiBQbHVzIHlvdSBnZXQgYSBuaWNlIHVzYWdl
IG1lc3NhZ2UgZm9yIGZyZWUuIFNlZQpEb2N1bWVudGF0aW9uL3RlY2huaWNhbC9hcGktcGFyc2Ut
b3B0aW9ucy50eHQgZm9yIG1vcmUgaW5mby4KCj4gZGlmZiAtLWdpdCBhL2NvbnRyaWIvY29tcGxl
dGlvbi9naXQtY29tcGxldGlvbi5iYXNoIGIvY29udHJpYi9jb21wbGV0aW9uL2dpdC1jb21wbGV0
aW9uLmJhc2gKPiBpbmRleCBjODRkNzY1Li41MzZhNzY5IDEwMDc1NQo+IC0tLSBhL2NvbnRyaWIv
Y29tcGxldGlvbi9naXQtY29tcGxldGlvbi5iYXNoCj4gKysrIGIvY29udHJpYi9jb21wbGV0aW9u
L2dpdC1jb21wbGV0aW9uLmJhc2gKPiBAQCAtODA0LDcgKzgwNCwxNSBAQCBfZ2l0X2NoZWNrb3V0
ICgpCj4KPiDCoF9naXRfY2hlcnJ5ICgpCj4gwqB7Cj4gLSDCoCDCoCDCoCBfX2dpdGNvbXAgIiQo
X19naXRfcmVmcykiCj4gKyDCoCDCoCDCoCBsb2NhbCBjdXI9IiR7Q09NUF9XT1JEU1tDT01QX0NX
T1JEXX0iCj4gKyDCoCDCoCDCoCBjYXNlICIkY3VyIiBpbgo+ICsgwqAgwqAgwqAgLSopCj4gKyDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBfX2dpdGNvbXAgIi12IC0tYWJicmV2IC0tYWJicmV2PSIKPiAr
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIDs7Cj4gKyDCoCDCoCDCoCAqKQo+ICsgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgX19naXRjb21wICIkKF9fZ2l0X3JlZnMpIgo+ICsgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgOzsKPiArIMKgIMKgIMKgIGVzYWMKCkNvbXBsZXRpb24gZG9lc24ndCBpbmNsdWRlIHNob3J0
IG9wdGlvbnMgKC12KS4gVGhpcyBhbHNvIG1lYW5zIHRoYXQKLS0qIGlzIHVzZWQgaW5zdGVhZCBv
ZiAtKgoKRmluYWxseSwgeW91J2xsIHdhbnQgdG8gQ2MgU2hhd24gKFNoYXduIE8uIFBlYXJjZQo8
c3BlYXJjZUBzcGVhcmNlLm9yZz4pIG9uIGJhc2ggY29tcGxldGlvbi4K
