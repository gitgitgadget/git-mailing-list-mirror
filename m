From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Sat, 8 Jun 2013 05:02:44 -0500
Message-ID: <CAMP44s08V1=nVbeo6r8UVT3Fd0=iSpRohinqf77Tmu4=xpDHeg@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<7va9n52zjc.fsf@alter.siamese.dyndns.org>
	<rmivc5rp9w2.fsf@fnord.ir.bbn.com>
	<alpine.DEB.1.00.1306061818191.28957@s15462909.onlinehome-server.info>
	<CACsJy8BMrxLZFGQfUN1YCG+qkAj-91aYkc54R5O4iqgXUNeQOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11c3ecde15c5d404dea1a69a
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Greg Troxel <gdt@ir.bbn.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 12:02:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlFz4-00021o-Mq
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 12:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795Ab3FHKCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 06:02:50 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:35481 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503Ab3FHKCs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 06:02:48 -0400
Received: by mail-la0-f46.google.com with SMTP id eg20so4443937lab.19
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 03:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rczJrIXQyU6hQoWitu6JlSsxxw6tMn9j/hiokURIkBk=;
        b=VioYdAt+LEt0JI57+OfBSCdf8bB/SYikLgMzXvss8Zzl9BN697LvKnZohmsvO21I+z
         rmykUL1n+MUyHu20Un5vKxoyPcX2YbIII3QUp9w6r+/d6aOhQnJIofa0LPONoBMVWVSt
         /4HpVS4KSgMUDXjJ22ZxRTaR+x+QmtRkpMv+mS5u7HJQ0Gg8Gpd8eR/MfE6uD2t0mnQ5
         yLoY3sl2XhU8EYqSbyl/WUFuKKRV8G1ngHS0B4JN1yhFuZhplYrwUio5RkG/7PQDjkNv
         fmoHaGH7KTcy4ql5Ho2s1bdXjXUE3iRSK7j5p8k5M9AMVBb8/D1BH0O8nn0APUBNNI3M
         vXmQ==
X-Received: by 10.112.52.97 with SMTP id s1mr2879835lbo.8.1370685764385; Sat,
 08 Jun 2013 03:02:44 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sat, 8 Jun 2013 03:02:44 -0700 (PDT)
In-Reply-To: <CACsJy8BMrxLZFGQfUN1YCG+qkAj-91aYkc54R5O4iqgXUNeQOw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226794>

--001a11c3ecde15c5d404dea1a69a
Content-Type: text/plain; charset=UTF-8

On Fri, Jun 7, 2013 at 9:17 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Jun 6, 2013 at 11:22 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Hi Greg,
>>
>> On Thu, 6 Jun 2013, Greg Troxel wrote:
>>
>>> As one of the people who helps maintain git packages in pkgsrc, my
>>> initial reaction is negative to adding a ruby dependency.
>>
>> My initial reaction, too. It was hard enough to get Perl included with Git
>> for Windows (because of that pesky Subversion dependency).
>>
>> As you can see from the commit history, I was the primary force behind
>> trying to get everything "core" in Git away from requiring scripting
>> languages (I think it is an awesome thing to provide APIs for as many
>> languages as possible, but a not-so-cool thing to use more than one
>> language in the core code). It does not seem that anybody picked up that
>> task when I left, though.
>
> Nobody seems to mention it yet. There's another reason behind the C
> rewrite effort: fork is costly on Windows. The C rewrite allows us to
> run with one process (most of the time). This applies for shell, perl
> and even ruby scripts because libgit.a is never meant to be used
> outside git.c context (unlike libgit2). In this regard, ruby is just
> as bad as currently supported non-C languages.

Are you sure?

---
#!/bin/sh

cat > /tmp/test <<EOF
require './git'

(1..100).each do |e|
  puts \`git rev-parse HEAD~#{e}\`
end
EOF

strace -o /tmp/log -e fork,clone ruby /tmp/test
cat /tmp/log
---

---
clone(child_stack=0x7f84131dbff0,
flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
parent_tidptr=0x7f84131dc9d0, tls=0x7f84131dc700,
child_tidptr=0x7f84131dc9d0) = 17455
+++ exited with 0 +++
---

I wrote a simple Ruby extension to access Git builtins so `git
rev-parse` actually calls cmd_rev_parse directly. I don't know of any
other language that supports so much extensibility. Of course, as soon
as one command does exit(), the script ends too. It could be useful to
do experiments though.

-- 
Felipe Contreras

--001a11c3ecde15c5d404dea1a69a
Content-Type: text/x-csrc; charset=US-ASCII; name="git.c"
Content-Disposition: attachment; filename="git.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hhoms61p0

I2luY2x1ZGUgPGJ1aWx0aW4uaD4KI2luY2x1ZGUgPGNhY2hlLmg+CiNpbmNsdWRlIDxmY250bC5o
PgoKI3VuZGVmIE5PUkVUVVJOCiN1bmRlZiBQQVRIX1NFUAoKI2luY2x1ZGUgPHJ1YnkuaD4KCnN0
YXRpYyBWQUxVRSBzaGVsbHdvcmRzOwoKc3RydWN0IGNtZF9zdHJ1Y3QgewoJY29uc3QgY2hhciAq
Y21kOwoJaW50ICgqZm4pKGludCwgY29uc3QgY2hhciAqKiwgY29uc3QgY2hhciAqKTsKCWludCBv
cHRpb247Cn07CgojZGVmaW5lIFJVTl9TRVRVUCAoMSA8PCAwKQojZGVmaW5lIFJVTl9TRVRVUF9H
RU5UTFkgKDEgPDwgMSkKI2RlZmluZSBVU0VfUEFHRVIgKDEgPDwgMikKI2RlZmluZSBORUVEX1dP
UktfVFJFRSAoMSA8PCAzKQoKc3RhdGljIHN0cnVjdCBjbWRfc3RydWN0IGNvbW1hbmRzW10gPSB7
Cgl7ICJyZXYtcGFyc2UiLCBjbWRfcmV2X3BhcnNlIH0sCgl7ICJzaG93IiwgY21kX3Nob3csIFJV
Tl9TRVRVUCB9LAp9OwoKc3RhdGljIFZBTFVFIGdpdF9yYl9iYWNrdGlja3MoaW50IG9fYXJnYywg
VkFMVUUgKm9fYXJndiwgVkFMVUUgY3R4KQp7CglpbnQgYXJnYywgaSwgb2xkOwoJaW50IHBpcGVm
ZFsyXTsKCWNvbnN0IGNoYXIgKiphcmd2OwoJY2hhciBidWZbMHgxMDAwXTsKCVZBTFVFIGNvbW1h
bmQ7CglpbnQgZG9fcmVhZDsKCXN0cnVjdCBjbWRfc3RydWN0ICpjbWQgPSBOVUxMOwoJY29uc3Qg
Y2hhciAqcHJlZml4ID0gTlVMTDsKCglpZiAoc3RybmNtcChSU1RSSU5HX1BUUihvX2FyZ3ZbMF0p
LCAiZ2l0ICIsIDQpKSB7CgkJVkFMVUUgcG9ydCwgcmVzdWx0OwoJCXBvcnQgPSByYl9mdW5jYWxs
KHJiX2NJTywgcmJfaW50ZXJuKCJwb3BlbiIpLCAxLCBvX2FyZ3ZbMF0pOwoJCXJlc3VsdCA9IHJi
X2Z1bmNhbGwocG9ydCwgcmJfaW50ZXJuKCJyZWFkIiksIDApOwoJCXJiX2Z1bmNhbGwocmVzdWx0
LCByYl9pbnRlcm4oImNob21wISIpLCAwKTsKCQlyYl9pb19jbG9zZShwb3J0KTsKCQlyZXR1cm4g
cmVzdWx0OwoJfQoKCWNvbW1hbmQgPSByYl9mdW5jYWxsKHNoZWxsd29yZHMsIHJiX2ludGVybigi
c2hlbGxzcGxpdCIpLCAxLCBvX2FyZ3ZbMF0pOwoJcmJfYXJ5X3NoaWZ0KGNvbW1hbmQpOwoKCWFy
Z2MgPSBSQVJSQVlfTEVOKGNvbW1hbmQpOwoJYXJndiA9IHhjYWxsb2Moc2l6ZW9mKCphcmd2KSwg
YXJnYyk7CgoJVkFMVUUgKnJhcnJheSA9IFJBUlJBWV9QVFIoY29tbWFuZCk7Cglmb3IgKGkgPSAw
OyBpIDwgYXJnYzsgaSsrKQoJCWFyZ3ZbaV0gPSBSU1RSSU5HX1BUUihyYXJyYXlbaV0pOwoKCW9s
ZCA9IGR1cCgxKTsKCWkgPSBwaXBlKHBpcGVmZCk7CglkdXAyKHBpcGVmZFsxXSwgMSk7CgljbG9z
ZShwaXBlZmRbMV0pOwoKCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKGNvbW1hbmRzKTsgaSsr
KSB7CgkJc3RydWN0IGNtZF9zdHJ1Y3QgKnAgPSAmY29tbWFuZHNbaV07CgkJaWYgKHN0cmNtcChw
LT5jbWQsIGFyZ3ZbMF0pKQoJCQljb250aW51ZTsKCQljbWQgPSBwOwoJfQoKCWlmICghY21kKQoJ
CXJiX3JhaXNlKHJiX2VBcmdFcnJvciwgInVua25vd24gY29tbWFuZDogJXMiLCBhcmd2WzBdKTsK
CglpZiAoY21kLT5vcHRpb24gJiBSVU5fU0VUVVApCgkJcHJlZml4ID0gc2V0dXBfZ2l0X2RpcmVj
dG9yeSgpOwoKCWkgPSBjbWQtPmZuKGFyZ2MsIGFyZ3YsIHByZWZpeCk7CglyYl9sYXN0X3N0YXR1
c19zZXQoaSwgZ2V0cGlkKCkpOwoKCWZmbHVzaChzdGRvdXQpOwoJZHVwMihvbGQsIDEpOwoKCWkg
PSByZWFkKHBpcGVmZFswXSwgYnVmLCBzaXplb2YoYnVmKSk7CglpZiAoYnVmW2kgLSAxXSA9PSAn
XG4nKQoJCWkgLT0gMTsKCWJ1ZltpXSA9ICdcMCc7CgoJcmV0dXJuIHJiX3N0cl9uZXcoYnVmLCBp
KTsKfQoKdm9pZCBJbml0X2dpdCh2b2lkKQp7CglyYl9yZXF1aXJlKCJzaGVsbHdvcmRzIik7Cglz
aGVsbHdvcmRzID0gcmJfZGVmaW5lX21vZHVsZSgiU2hlbGx3b3JkcyIpOwoJcmJfZGVmaW5lX2ds
b2JhbF9mdW5jdGlvbigiYCIsIGdpdF9yYl9iYWNrdGlja3MsIC0xKTsKfQo=
--001a11c3ecde15c5d404dea1a69a--
