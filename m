From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: daemon.c fails to build on Darwin
Date: Thu, 28 Sep 2006 18:01:10 +0200
Message-ID: <81b0412b0609280901q109961cfydeaea7ff305eca67@mail.gmail.com>
References: <86ejtw3sbv.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_6721_18430742.1159459270668"
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Sep 28 18:01:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSyK4-0007GN-MF
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 18:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWI1QBN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 12:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWI1QBN
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 12:01:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:63310 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751159AbWI1QBM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 12:01:12 -0400
Received: by nf-out-0910.google.com with SMTP id o25so762478nfa
        for <git@vger.kernel.org>; Thu, 28 Sep 2006 09:01:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=FCrk4woJvaSkYyGndHAdgdTc+dGtzZ96Z2PPk+zVg6QyaXhobg0SZl5EJ+bDe4T2+I9oDNWnCXr+mlSpfw3cVY4TtiRQYZuS3H2piUzt/xAGojVcru0kYBJe1oG93JdgzfwV7z0g1CHi8DemdhPtblfOvzRjurBEV5iL/daZPBs=
Received: by 10.78.200.20 with SMTP id x20mr1579837huf;
        Thu, 28 Sep 2006 09:01:10 -0700 (PDT)
Received: by 10.78.115.11 with HTTP; Thu, 28 Sep 2006 09:01:10 -0700 (PDT)
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <86ejtw3sbv.fsf@blue.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28010>

------=_Part_6721_18430742.1159459270668
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 28 Sep 2006 08:48:36 -0700, Randal L. Schwartz <merlyn@stonehenge.com> wrote:
>
> If this is obvious, can someone fix it?  If not, I'll try to sort it out later
> tonight.
>

I used the patch attached.

BTW, could we please _use_ the const keyword?

------=_Part_6721_18430742.1159459270668
Content-Type: text/x-diff; name=fix-daemon-no-ipv6.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_esnc3t3q
Content-Disposition: attachment; filename="fix-daemon-no-ipv6.patch"

ZGlmZiAtLWdpdCBhL2RhZW1vbi5jIGIvZGFlbW9uLmMKaW5kZXggNTMzNWQyMS4uOGI1NGM2MyAx
MDA2NDQKLS0tIGEvZGFlbW9uLmMKKysrIGIvZGFlbW9uLmMKQEAgLTgzMCw3ICs4MzAsNyBAQCAj
ZW5kaWYKIAogI2Vsc2UgLyogTk9fSVBWNiAqLwogCi1zdGF0aWMgaW50IHNvY2tzZXR1cChjaGFy
ICpsaXNlbl9hZGRyLCBpbnQgbGlzdGVuX3BvcnQsIGludCAqKnNvY2tsaXN0X3ApCitzdGF0aWMg
aW50IHNvY2tzZXR1cChjaGFyICpsaXN0ZW5fYWRkciwgaW50IGxpc3Rlbl9wb3J0LCBpbnQgKipz
b2NrbGlzdF9wKQogewogCXN0cnVjdCBzb2NrYWRkcl9pbiBzaW47CiAJaW50IHNvY2tmZDsKZGlm
ZiAtLWdpdCBhL2dpdC1jb21wYXQtdXRpbC5oIGIvZ2l0LWNvbXBhdC11dGlsLmgKaW5kZXggN2Vk
MThlMS4uYTU0MjlkMSAxMDA3NTUKLS0tIGEvZ2l0LWNvbXBhdC11dGlsLmgKKysrIGIvZ2l0LWNv
bXBhdC11dGlsLmgKQEAgLTMzLDYgKzMzLDEwIEBAICNpZm5kZWYgUEFUSF9NQVgKICNkZWZpbmUg
UEFUSF9NQVggNDA5NgogI2VuZGlmCiAKKyNpZm5kZWYgSE9TVF9OQU1FX01BWAorI2RlZmluZSBI
T1NUX05BTUVfTUFYIDI1NgorI2VuZGlmCisKICNpZmRlZiBfX0dOVUNfXwogI2RlZmluZSBOT1JF
VFVSTiBfX2F0dHJpYnV0ZV9fKChfX25vcmV0dXJuX18pKQogI2Vsc2UKZGlmZiAtLWdpdCBhL2lu
dGVycG9sYXRlLmMgYi9pbnRlcnBvbGF0ZS5jCmluZGV4IDYyNzAxZDguLjVkOWQxODggMTAwNjQ0
Ci0tLSBhL2ludGVycG9sYXRlLmMKKysrIGIvaW50ZXJwb2xhdGUuYwpAQCAtOCwxMCArOCwxMCBA
QCAjaW5jbHVkZSAiZ2l0LWNvbXBhdC11dGlsLmgiCiAjaW5jbHVkZSAiaW50ZXJwb2xhdGUuaCIK
IAogCi12b2lkIGludGVycF9zZXRfZW50cnkoc3RydWN0IGludGVycCAqdGFibGUsIGludCBzbG90
LCBjaGFyICp2YWx1ZSkKK3ZvaWQgaW50ZXJwX3NldF9lbnRyeShzdHJ1Y3QgaW50ZXJwICp0YWJs
ZSwgaW50IHNsb3QsIGNvbnN0IGNoYXIgKnZhbHVlKQogewogCWNoYXIgKm9sZHZhbCA9IHRhYmxl
W3Nsb3RdLnZhbHVlOwotCWNoYXIgKm5ld3ZhbCA9IHZhbHVlOworCWNoYXIgKm5ld3ZhbCA9IE5V
TEw7CiAKIAlpZiAob2xkdmFsKQogCQlmcmVlKG9sZHZhbCk7CmRpZmYgLS1naXQgYS9pbnRlcnBv
bGF0ZS5oIGIvaW50ZXJwb2xhdGUuaAppbmRleCBhNTVmYjhlLi4xOTBhMTgwIDEwMDY0NAotLS0g
YS9pbnRlcnBvbGF0ZS5oCisrKyBiL2ludGVycG9sYXRlLmgKQEAgLTE2LDcgKzE2LDcgQEAgc3Ry
dWN0IGludGVycCB7CiAJY2hhciAqdmFsdWU7CiB9OwogCi1leHRlcm4gdm9pZCBpbnRlcnBfc2V0
X2VudHJ5KHN0cnVjdCBpbnRlcnAgKnRhYmxlLCBpbnQgc2xvdCwgY2hhciAqdmFsdWUpOworZXh0
ZXJuIHZvaWQgaW50ZXJwX3NldF9lbnRyeShzdHJ1Y3QgaW50ZXJwICp0YWJsZSwgaW50IHNsb3Qs
IGNvbnN0IGNoYXIgKnZhbHVlKTsKIGV4dGVybiB2b2lkIGludGVycF9jbGVhcl90YWJsZShzdHJ1
Y3QgaW50ZXJwICp0YWJsZSwgaW50IG5pbnRlcnBzKTsKIAogZXh0ZXJuIGludCBpbnRlcnBvbGF0
ZShjaGFyICpyZXN1bHQsIGludCByZXNsZW4sCg==
------=_Part_6721_18430742.1159459270668--
