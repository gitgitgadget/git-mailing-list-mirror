From: Gisle Aas <gisle@aas.no>
Subject: Re: [PATCH] More precise description of 'git describe --abbrev'
Date: Fri, 30 Oct 2009 20:27:02 +0100
Message-ID: <b48ea8a00910301227l4714eca9l767afd036938f494@mail.gmail.com>
References: <b48ea8a00910291438r8b66a0fq9e821393ecfff0bf@mail.gmail.com>
	 <7vws2d4y3d.fsf@alter.siamese.dyndns.org>
	 <b48ea8a00910300101i38f2e4a8q2c2e014d2df1a150@mail.gmail.com>
	 <7viqdwlnam.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001485f6d2f037969804772c0328
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 20:27:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3x7z-0007SD-FQ
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 20:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757055AbZJ3T1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 15:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbZJ3T1A
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 15:27:00 -0400
Received: from mail-ew0-f228.google.com ([209.85.219.228]:45409 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756311AbZJ3T07 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 15:26:59 -0400
Received: by ewy28 with SMTP id 28so3354929ewy.18
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 12:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type;
        bh=UEDLdV/YI2AJpUjlo+oXeN0fp2xzbEFIj/ou3OjG/Xw=;
        b=q4i/9WI60ZVaAGxiX/ndAj7VTYhAMBrtjOLvjUWXXonUBTbtAAkcNRC/mjYNRs+o/K
         Bb1NNS697FV+naHhhJ3IDlZoCssCcrDx+EraHbPgvEz+t/pmpk9TQv2ukju7uJ9bnV8x
         egnZ9QDlzr7ofbkb9VFMylpEC+5iDteN9ZONs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=EZ0LWE3bNUhMeZhhwlFD+8fTT6r/9tnCba/RYaOHBQ4VsmvitnLOlD23Nj/x67aALH
         FzVrrUwHtUO3xqbr83g/iBXxV/OYlgLrHVdIYF6O77SeQfuJSfy5nR2mdyhAROP9YhxV
         +/ktkXWNgA8eAPdkHuD5zy8xmQDWx2LdIbiho=
Received: by 10.239.145.165 with SMTP id s37mr218309hba.43.1256930823083; Fri, 
	30 Oct 2009 12:27:03 -0700 (PDT)
In-Reply-To: <7viqdwlnam.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 853b597c390cb7aa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131733>

--001485f6d2f037969804772c0328
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2009 at 20:00, Junio C Hamano <gitster@pobox.com> wrote:
> Adding an explanation like this so that nobody will be tempted to "fix"
> the example would be the best, I think.

Updated patch attached.

>
> =C2=A0 =C2=A0 [torvalds@g5 git]$ git describe --all --abbrev=3D4 v1.0.5^2
> =C2=A0 =C2=A0 tags/v1.0.0-21-g975b
>
> =C2=A0 =C2=A0 Note that the suffix you get if you type this command today=
 may be
> =C2=A0 =C2=A0 longer than what Linus saw above when he ran this command, =
as your
> =C2=A0 =C2=A0 git repository may have new commits whose object names begi=
n with
> =C2=A0 =C2=A0 975b that did not exist back then, and "-g975b" suffix alon=
e is not
> =C2=A0 =C2=A0 sufficient to disambiguate these commits.
>
>

--001485f6d2f037969804772c0328
Content-Type: application/octet-stream; 
	name="0001-More-precise-description-of-git-describe-abbrev.patch"
Content-Disposition: attachment; 
	filename="0001-More-precise-description-of-git-describe-abbrev.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g1fc4fgp0

RnJvbSA1ZjZiNDA1ZmEyNDg2MWFlODkyMDdkMzM0ZWEyZTExZjM4M2E3ZTRlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHaXNsZSBBYXMgPGdpc2xlQGFhcy5ubz4KRGF0ZTogVGh1LCAy
OSBPY3QgMjAwOSAyMjoyOTozNSArMDEwMApTdWJqZWN0OiBbUEFUQ0hdIE1vcmUgcHJlY2lzZSBk
ZXNjcmlwdGlvbiBvZiAnZ2l0IGRlc2NyaWJlIC0tYWJicmV2JwoKQWxzbyBhZGRzIGEgbm90ZSBh
Ym91dCB3aHkgdGhlIG91dHB1dCBpbiB0aGUgZXhhbXBsZXMgbWlnaHQgZ2l2ZQpkaWZmZXJlbnQg
b3V0cHV0IHRvZGF5LgoKU2lnbmVkLW9mZi1ieTogR2lzbGUgQWFzIDxnaXNsZUBhYXMubm8+Ci0t
LQogRG9jdW1lbnRhdGlvbi9naXQtZGVzY3JpYmUudHh0IHwgICAxNyArKysrKysrKysrKysrLS0t
LQogMSBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZ2l0LWRlc2NyaWJlLnR4dCBiL0RvY3VtZW50YXRpb24v
Z2l0LWRlc2NyaWJlLnR4dAppbmRleCBiMjMxZGJiLi5mOGQ5MWIxIDEwMDY0NAotLS0gYS9Eb2N1
bWVudGF0aW9uL2dpdC1kZXNjcmliZS50eHQKKysrIGIvRG9jdW1lbnRhdGlvbi9naXQtZGVzY3Jp
YmUudHh0CkBAIC00NCw3ICs0NCw5IEBAIE9QVElPTlMKIAogLS1hYmJyZXY9PG4+OjoKIAlJbnN0
ZWFkIG9mIHVzaW5nIHRoZSBkZWZhdWx0IDcgaGV4YWRlY2ltYWwgZGlnaXRzIGFzIHRoZQotCWFi
YnJldmlhdGVkIG9iamVjdCBuYW1lLCB1c2UgPG4+IGRpZ2l0cy4KKwlhYmJyZXZpYXRlZCBvYmpl
Y3QgbmFtZSwgdXNlIDxuPiBkaWdpdHMgb3IgYXMgbWFueSBkaWdpdHMKKwlhcmUgbmVlZGVkIHRv
IGZvcm0gYSB1bmlxdWUgb2JqZWN0IG5hbWUuICBBbiA8bj4gb2YgMAorCXdpbGwgc3VwcHJlc3Mg
bG9uZyBmb3JtYXQsIG9ubHkgc2hvd2luZyB0aGUgY2xvc2VzdCB0YWcuCiAKIC0tY2FuZGlkYXRl
cz08bj46OgogCUluc3RlYWQgb2YgY29uc2lkZXJpbmcgb25seSB0aGUgMTAgbW9zdCByZWNlbnQg
dGFncyBhcwpAQCAtNjgsOCArNzAsOCBAQCBPUFRJT05TCiAJVGhpcyBpcyB1c2VmdWwgd2hlbiB5
b3Ugd2FudCB0byBzZWUgcGFydHMgb2YgdGhlIGNvbW1pdCBvYmplY3QgbmFtZQogCWluICJkZXNj
cmliZSIgb3V0cHV0LCBldmVuIHdoZW4gdGhlIGNvbW1pdCBpbiBxdWVzdGlvbiBoYXBwZW5zIHRv
IGJlCiAJYSB0YWdnZWQgdmVyc2lvbi4gIEluc3RlYWQgb2YganVzdCBlbWl0dGluZyB0aGUgdGFn
IG5hbWUsIGl0IHdpbGwKLQlkZXNjcmliZSBzdWNoIGEgY29tbWl0IGFzIHYxLjItMC1kZWFkYmVl
ZiAoMHRoIGNvbW1pdCBzaW5jZSB0YWcgdjEuMgotCXRoYXQgcG9pbnRzIGF0IG9iamVjdCBkZWFk
YmVlZi4uLi4pLgorCWRlc2NyaWJlIHN1Y2ggYSBjb21taXQgYXMgdjEuMi0wLWdkZWFkYmVlICgw
dGggY29tbWl0IHNpbmNlIHRhZyB2MS4yCisJdGhhdCBwb2ludHMgYXQgb2JqZWN0IGRlYWRiZWUu
Li4uKS4KIAogLS1tYXRjaCA8cGF0dGVybj46OgogCU9ubHkgY29uc2lkZXIgdGFncyBtYXRjaGlu
ZyB0aGUgZ2l2ZW4gcGF0dGVybiAoY2FuIGJlIHVzZWQgdG8gYXZvaWQKQEAgLTEwOCw3ICsxMTAs
NyBAQCB0aGUgb3V0cHV0IHNob3dzIHRoZSByZWZlcmVuY2UgcGF0aCBhcyB3ZWxsOgogCVt0b3J2
YWxkc0BnNSBnaXRdJCBnaXQgZGVzY3JpYmUgLS1hbGwgLS1hYmJyZXY9NCB2MS4wLjVeMgogCXRh
Z3MvdjEuMC4wLTIxLWc5NzViCiAKLQlbdG9ydmFsZHNAZzUgZ2l0XSQgZ2l0IGRlc2NyaWJlIC0t
YWxsIEhFQUReCisJW3RvcnZhbGRzQGc1IGdpdF0kIGdpdCBkZXNjcmliZSAtLWFsbCAtLWFiYnJl
dj00IEhFQUReCiAJaGVhZHMvbHQvZGVzY3JpYmUtNy1nOTc1YgogCiBXaXRoIC0tYWJicmV2IHNl
dCB0byAwLCB0aGUgY29tbWFuZCBjYW4gYmUgdXNlZCB0byBmaW5kIHRoZQpAQCAtMTE3LDYgKzEx
OSwxMyBAQCBjbG9zZXN0IHRhZ25hbWUgd2l0aG91dCBhbnkgc3VmZml4OgogCVt0b3J2YWxkc0Bn
NSBnaXRdJCBnaXQgZGVzY3JpYmUgLS1hYmJyZXY9MCB2MS4wLjVeMgogCXRhZ3MvdjEuMC4wCiAK
K05vdGUgdGhhdCB0aGUgc3VmZml4IHlvdSBnZXQgaWYgeW91IHR5cGUgdGhlc2UgY29tbWFuZHMg
dG9kYXkgbWF5IGJlCitsb25nZXIgdGhhbiB3aGF0IExpbnVzIHNhdyBhYm92ZSB3aGVuIGhlIHJh
biB0aGlzIGNvbW1hbmQsIGFzIHlvdXIKK2dpdCByZXBvc2l0b3J5IG1heSBoYXZlIG5ldyBjb21t
aXRzIHdob3NlIG9iamVjdCBuYW1lcyBiZWdpbiB3aXRoCis5NzViIHRoYXQgZGlkIG5vdCBleGlz
dCBiYWNrIHRoZW4sIGFuZCAiLWc5NzViIiBzdWZmaXggYWxvbmUgaXMgbm90CitzdWZmaWNpZW50
IHRvIGRpc2FtYmlndWF0ZSB0aGVzZSBjb21taXRzLgorCisKIFNFQVJDSCBTVFJBVEVHWQogLS0t
LS0tLS0tLS0tLS0tCiAKLS0gCjEuNi4yLjk1Lmc5MzRmNwoK
--001485f6d2f037969804772c0328--
