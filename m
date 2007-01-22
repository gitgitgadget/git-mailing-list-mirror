From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Insert ACTIVESTATE_STRING in Git.pm
Date: Mon, 22 Jan 2007 15:43:48 +0100
Message-ID: <81b0412b0701220643s3d337664jcddfffd35071b08e@mail.gmail.com>
References: <81b0412b0701220632t50ad42c4ucb0ebae140a9706a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_154969_23026467.1169477028804"
Cc: "Junio C Hamano" <junkio@cox.net>, "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jan 22 15:44:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H90Op-0002rD-NQ
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 15:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbXAVOnv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 09:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbXAVOnv
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 09:43:51 -0500
Received: from wr-out-0506.google.com ([64.233.184.239]:51685 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbXAVOnu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 09:43:50 -0500
Received: by wr-out-0506.google.com with SMTP id i22so672647wra
        for <git@vger.kernel.org>; Mon, 22 Jan 2007 06:43:49 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=PlINKRJBzQw1eUOXz+14AHKUkz1WTYG2CwOVYMOJ+pDwAJLLtxudThwEeZTv5PrrWzZXmAr1aUCfWRWK+IOoDz2LL7uptocrgVEnB0WuFSEqFKLoE5AOxRjaQGTaSBUox6jBjOF30QMoSfqunDpb1I06DnaaOobPaflq4itvdsA=
Received: by 10.90.68.15 with SMTP id q15mr6293366aga.1169477029555;
        Mon, 22 Jan 2007 06:43:49 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Mon, 22 Jan 2007 06:43:48 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
In-Reply-To: <81b0412b0701220632t50ad42c4ucb0ebae140a9706a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37413>

------=_Part_154969_23026467.1169477028804
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Also add "git" to the pipe parameters, otherwise it does not work at all, as
no git commands are usable out of git context.

---

Oh, fine, just what I needed... Forgot to attach the patch!

> This is not enough to make it work on ActiveState. It's just to
> fix obvious TODOs, which should help someone to get it going.
> The other problems are:
>  - tie refuses to bind a handle class activestate_pipe to a scalar $fh
>    (a patch follows)
>  - there are some unexplained warnings about uninitialized values
>  - cygwin-windows pathname conversion (not fixable at all)
>
>  perl/Git.pm |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
>

------=_Part_154969_23026467.1169477028804
Content-Type: application/xxxxx; 
	name=0001-Insert-ACTIVESTATE_STRING-in-Git.pm.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ex90f2pe
Content-Disposition: attachment; filename="0001-Insert-ACTIVESTATE_STRING-in-Git.pm.patch"

RnJvbSBkY2ZmOTYyYWE5YmY0M2VhMTA3MzA0MTcyZGU2YjBhNTAzMjIxM2MyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBNb24sIDIyIEphbiAyMDA3IDE1OjIxOjMzICswMTAwClN1YmplY3Q6IFtQQVRDSF0gSW5zZXJ0
IEFDVElWRVNUQVRFX1NUUklORyBpbiBHaXQucG0KCkFsc28gYWRkICJnaXQiIHRvIHRoZSBwaXBl
IHBhcmFtZXRlcnMsIG90aGVyd2lzZSBpdCBkb2VzIG5vdCB3b3JrIGF0IGFsbCwgYXMKbm8gZ2l0
IGNvbW1hbmRzIGFyZSB1c2FibGUgb3V0IG9mIGdpdCBjb250ZXh0LgotLS0KIHBlcmwvR2l0LnBt
IHwgICAgNyArKysrLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9wZXJsL0dpdC5wbSBiL3BlcmwvR2l0LnBtCmluZGV4IDM0
NzRhZDMuLjU4NDE0ZTMgMTAwNjQ0Ci0tLSBhL3BlcmwvR2l0LnBtCisrKyBiL3BlcmwvR2l0LnBt
CkBAIC03MzYsNyArNzM2LDcgQEAgc3ViIF9jb21tYW5kX2NvbW1vbl9waXBlIHsKIAlfY2hlY2tf
dmFsaWRfY21kKCRjbWQpOwogCiAJbXkgJGZoOwotCWlmICgkXk8gZXEgJyMjSU5TRVJUX0FDVElW
RVNUQVRFX1NUUklOR19IRVJFIyMnKSB7CisJaWYgKCReTyBlcSAnTVNXaW4zMicpIHsKIAkJIyBB
Y3RpdmVTdGF0ZSBQZXJsCiAJCSNkZWZpbmVkICRvcHRze1NUREVSUn0gYW5kCiAJCSMJd2FybiAn
aWdub3JpbmcgU1RERVJSIG9wdGlvbiAtIHJ1bm5pbmcgdy8gQWN0aXZlU3RhdGUnOwpAQCAtODA5
LDggKzgwOSw5IEBAIHN1YiBUSUVIQU5ETEUgewogCSMgRklYTUU6IFRoaXMgaXMgcHJvYmFibHkg
aG9ycmlibGUgaWRlYSBhbmQgdGhlIHRoaW5nIHdpbGwgZXhwbG9kZQogCSMgYXQgdGhlIG1vbWVu
dCB5b3UgZ2l2ZSBpdCBhcmd1bWVudHMgdGhhdCByZXF1aXJlIHNvbWUgcXVvdGluZywKIAkjIGJ1
dCBJIGhhdmUgbm8gQWN0aXZlU3RhdGUgY2x1ZS4uLiAtLXBhc2t5Ci0JbXkgJGNtZGxpbmUgPSBq
b2luICIgIiwgQHBhcmFtczsKLQlteSBAZGF0YSA9IHF4eyRjbWRsaW5lfTsKKwkjIExldCdzIGp1
c3QgaG9wZSBBY3RpdmVTdGF0ZSBQZXJsIGRvZXMgYXQgbGVhc3QgdGhlIHF1b3RpbmcKKwkjIGNv
cnJlY3RseS4KKwlteSBAZGF0YSA9IHF4e2dpdCBAcGFyYW1zfTsKIAlibGVzcyB7IGkgPT4gMCwg
ZGF0YSA9PiBcQGRhdGEgfSwgJGNsYXNzOwogfQogCi0tIAoxLjUuMC5yYzIuZzNmMWEKCg==
------=_Part_154969_23026467.1169477028804--
