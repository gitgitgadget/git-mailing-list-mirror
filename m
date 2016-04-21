From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: history damage in linux.git
Date: Thu, 21 Apr 2016 10:43:17 -0700
Message-ID: <CA+55aFwOtyW7zLHdJND=FGBWKBfhQV95RPVRG5gcoRUrtGCrAQ@mail.gmail.com>
References: <20160421113004.GA3140@aepfle.de>
	<87lh473xic.fsf@linux-m68k.org>
	<CA+55aFx8hPKKcuwe-HHoO7LHVYLmJ6khndd-OtQotMs3EJzZ0w@mail.gmail.com>
	<CA+55aFzk4rZFdhOjkPDqFC3_tk4BUvx4-STsY2L_tKMH2FxCCA@mail.gmail.com>
	<xmqqvb3aswp0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=047d7bf0cefad275040531023e56
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Olaf Hering <olaf@aepfle.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 19:43:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atIdP-0004wZ-5h
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 19:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753167AbcDURnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 13:43:19 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:33056 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720AbcDURnS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 13:43:18 -0400
Received: by mail-ig0-f195.google.com with SMTP id g8so11175643igr.0
        for <git@vger.kernel.org>; Thu, 21 Apr 2016 10:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=QnTkSn4vtU6K8o6SpGTUBEITRWeIR/4chV3Xm0TFtKg=;
        b=pfV/HJF1Uf1MgN60r15tTDFOlxi469EdLu1/hSabzydACNGZ+cJqmTwatZk1D9aXfa
         rRRoiga7paFJayJZPM/efaZQtZHdLtQTt6MxiJCMu1mwuf9bc+GhQgS8fFCfHJtyYIOt
         lib/EDtJoGdrVyfcefuK191//q1cP0X5JTi4PuwHNv8OBw/i7m9TBol/7/VInSZIkLRr
         t9L/oNA5vi9sSTjaavzccxo4r8HxDze6KBsWUfnpWVzgsXg0Yb8nVS2KA8dQd0m6JneN
         5xh+gzeq1oRtSfWb3sSTtf+cttraxf/e62/3IJ0c0EG1rTS5DzQ0kOYbYq9tknqSB9ro
         optA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=QnTkSn4vtU6K8o6SpGTUBEITRWeIR/4chV3Xm0TFtKg=;
        b=YabVbYppBFdaC1N9jRZ/P5zesqf9lRnrRL6PHkCyrRf12m0rHuRLfarDlglm8RuvA7
         +Rci+IhYblMZRaepcQGZgoW2fbDBf2l5V87Kml0OYPjk8lpzIjmnw64Q+/TmqT+xBCo/
         h9GPzYr//a6OPDQSBqSzoPIi+36UazCvGuPdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=QnTkSn4vtU6K8o6SpGTUBEITRWeIR/4chV3Xm0TFtKg=;
        b=Q5cY+r+Tz/TX4Qsv24dE/1ooWy2kk/+gcS4GgEXbjCFvxJVG6RM9Mw1xlhmNg7P25U
         1NYWTDedhuM+tHDKTwFoBM5TpBzVXkO6em3lqpc/GkogzHyYPjySUzmGIyl1xAkeY3TZ
         BHkp+nDV1s0XAlnNEr60Upa36VVkN6hhaTd/Ao9xI6dceBd4AJ87yu4fB2d8AIolAhmy
         3+LjjMTRB5q7DELYNifLb2B+hhndRsmPRatNvuk/jYco3U8Y+O8IiH4JqJoyHiP05+3C
         gPspOvpYuFJjs62LGgHCVjE5qrAYtU12jc8TuOv586XBrgsYPXRS3KAqFWk7FdQH3Jl4
         LR/w==
X-Gm-Message-State: AOPr4FV83IaXu6lwyOVBVspyvyezyhT3R5Da2CrA063Yn5JPgD4Fw455Yn/uQLgFTg/a74fnJKQ9r4rxabDk1w==
X-Received: by 10.50.24.131 with SMTP id u3mr5353729igf.93.1461260597216; Thu,
 21 Apr 2016 10:43:17 -0700 (PDT)
Received: by 10.36.2.9 with HTTP; Thu, 21 Apr 2016 10:43:17 -0700 (PDT)
In-Reply-To: <xmqqvb3aswp0.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: YIY-ghoIWaWOu4MXqzsQxQqPYgU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292133>

--047d7bf0cefad275040531023e56
Content-Type: text/plain; charset=UTF-8

On Thu, Apr 21, 2016 at 10:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I think avoiding side branches to describe with the weight is a
> right thing to do, i.e. if you have this history:
>
>     X---o---o---o---o---v4.6
>      \             /
>       o-----------o
>
> you do not want to explain X as "v4.6~^2~2", and instead you want it
> as "v4.6~5", even though the former is 4 hops while the latter is 5
> hops (which is longer).

Yes. I have a new suggestion: make the "merge weight" depend on how
complex the name ends up being.

And that algorithm actually gives a completely new and improved path:

   aed06b9 tags/v3.13-rc2~32^2^2~47

which is still complex, but is actually the best one I've found so far.

To compare against the previous ones I looked at:

   v4.6-rc1~9^2~792    <- current git code
   v3.13-rc2~32^2^2~47     <- new with attached patch
   v3.13-rc7~9^2~14^2~42     <- merge weight 500
   v3.13~5^2~4^2~2^2~1^2~42   <- merge weight 1

that new one is actually the second-most dense, and uses the oldest
tag. So it's a good combination of denseness, but still gets the best
actual base tag.

The logic of the patch is that there are different "complexities" in
the naming, and it's not just whether you are following a second
parent, it's also if you're doing generational hops.

So when you do a first-parent change, the name stays simple (the last
number changes), and that means that the "distance" weight is low (so
that's the normal "+1" we do for first-parent.

But if it's not a first parent, there are two different cases:

 - generation > 0: we add "~%d^%d", and we approximate that with "four
characters", and use a cost that is four orders of magnitude higher
(so 10000).

 - generation == 0: we add just "^%d", so generally just two
characters. So use a cost that is just two orders of magnitude higher
(so 100).

In other words, I'm trying to convince people that my patch not only
gives a good result, but that the "weight numbers" I use make some
kind of conceptual sense from a complexity cost angle.

With that, the patch itself is attached.

I think it's better than what "git name-rev" does now. Is it optimal?
No, I think the *optimal* would use some kind of "does one tag contain
the other" logic, and discarding all base names that are just
supersets of another base that still reaches the target.

But this patch is small and simple, and has some excuses for its
behavior. What do people think?

                 Linus

--047d7bf0cefad275040531023e56
Content-Type: text/plain; charset=US-ASCII; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_inakqucr0

IGJ1aWx0aW4vbmFtZS1yZXYuYyB8IDE2ICsrKysrKysrKystLS0tLS0KIDEgZmlsZSBjaGFuZ2Vk
LCAxMCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2J1aWx0aW4v
bmFtZS1yZXYuYyBiL2J1aWx0aW4vbmFtZS1yZXYuYwppbmRleCAwOTJlMDNjM2NjOWIuLjAzNTRj
OGQyMjJlMSAxMDA2NDQKLS0tIGEvYnVpbHRpbi9uYW1lLXJldi5jCisrKyBiL2J1aWx0aW4vbmFt
ZS1yZXYuYwpAQCAtMTYsOSArMTYsNiBAQCB0eXBlZGVmIHN0cnVjdCByZXZfbmFtZSB7CiAKIHN0
YXRpYyBsb25nIGN1dG9mZiA9IExPTkdfTUFYOwogCi0vKiBIb3cgbWFueSBnZW5lcmF0aW9ucyBh
cmUgbWF4aW1hbGx5IHByZWZlcnJlZCBvdmVyIF9vbmVfIG1lcmdlIHRyYXZlcnNhbD8gKi8KLSNk
ZWZpbmUgTUVSR0VfVFJBVkVSU0FMX1dFSUdIVCA2NTUzNQotCiBzdGF0aWMgdm9pZCBuYW1lX3Jl
dihzdHJ1Y3QgY29tbWl0ICpjb21taXQsCiAJCWNvbnN0IGNoYXIgKnRpcF9uYW1lLCBpbnQgZ2Vu
ZXJhdGlvbiwgaW50IGRpc3RhbmNlLAogCQlpbnQgZGVyZWYpCkBAIC01NSwxOSArNTIsMjYgQEAg
Y29weV9kYXRhOgogCQkJcGFyZW50czsKIAkJCXBhcmVudHMgPSBwYXJlbnRzLT5uZXh0LCBwYXJl
bnRfbnVtYmVyKyspIHsKIAkJaWYgKHBhcmVudF9udW1iZXIgPiAxKSB7CisJCQlpbnQgd2VpZ2h0
OwogCQkJc2l6ZV90IGxlbjsKIAkJCWNoYXIgKm5ld19uYW1lOwogCiAJCQlzdHJpcF9zdWZmaXgo
dGlwX25hbWUsICJeMCIsICZsZW4pOwotCQkJaWYgKGdlbmVyYXRpb24gPiAwKQorCisJCQkvLyBU
aGUgZXh0cmEgbWVyZ2UgdHJhdmVyc2FsICJ3ZWlnaHQiIGRlcGVuZHMKKwkJCS8vIG9uIGhvdyBj
b21wbGV4IHRoZSByZXN1bHRpbmcgbmFtZSBpcy4KKwkJCWlmIChnZW5lcmF0aW9uID4gMCkgewor
CQkJCXdlaWdodCA9IDEwMDAwOwogCQkJCW5ld19uYW1lID0geHN0cmZtdCgiJS4qc34lZF4lZCIs
IChpbnQpbGVuLCB0aXBfbmFtZSwKIAkJCQkJCSAgIGdlbmVyYXRpb24sIHBhcmVudF9udW1iZXIp
OwotCQkJZWxzZQorCQkJfSBlbHNlIHsKKwkJCQl3ZWlnaHQgPSAxMDA7CiAJCQkJbmV3X25hbWUg
PSB4c3RyZm10KCIlLipzXiVkIiwgKGludClsZW4sIHRpcF9uYW1lLAogCQkJCQkJICAgcGFyZW50
X251bWJlcik7CisJCQl9CiAKIAkJCW5hbWVfcmV2KHBhcmVudHMtPml0ZW0sIG5ld19uYW1lLCAw
LAotCQkJCWRpc3RhbmNlICsgTUVSR0VfVFJBVkVSU0FMX1dFSUdIVCwgMCk7CisJCQkJZGlzdGFu
Y2UgKyB3ZWlnaHQsIDApOwogCQl9IGVsc2UgewogCQkJbmFtZV9yZXYocGFyZW50cy0+aXRlbSwg
dGlwX25hbWUsIGdlbmVyYXRpb24gKyAxLAogCQkJCWRpc3RhbmNlICsgMSwgMCk7Cg==
--047d7bf0cefad275040531023e56--
