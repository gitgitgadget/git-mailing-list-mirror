From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: Re: [PATCH] CodingGuidelines: Fix a typo
Date: Sat, 09 Oct 2010 19:35:09 +0200
Message-ID: <87y6a7s20i.fsf@gmail.com>
References: <1286623119-13766-1-git-send-email-stepnem@gmail.com>
	<20101009152758.GA17799@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 09 19:36:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4dLL-0002Ds-CJ
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 19:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755972Ab0JIRgS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Oct 2010 13:36:18 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63555 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754168Ab0JIRgR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Oct 2010 13:36:17 -0400
Received: by bwz15 with SMTP id 15so923821bwz.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 10:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject
         :in-reply-to:references:user-agent:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=uD9cXkVPXkJBQK5XjaNUmg2cASES5l9/rTaW42bf4fA=;
        b=ejEvKxUWSPx7ADUjDifEtNvQuD06xI3Gbayed7VMV+U3yM9Q9+RSyCCg+FPD1BUfbr
         nV7s2sB860sdPrfMmw5E7kuS7Ev/aeyQEtva+ce1VwqULUXNwR7VFAaMpv3ojeBcm+/j
         VF//OTEumM8h36xBJyF0J7XpiTgoaV827YU3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        b=kPpQnUswWELSGV0Sa6JRZJg/qslGPuYdJqvFvb5U9XL72o/d87kIZsxIfBnWE8s5DH
         45sXLzbpONzgKJAsDRTFkrsV+iJRfDGBvxT5WFVwlDSU69BTYZRqP9tUFPdrcm53a4Eq
         ZapykSyVDhiLcL8c/UFKq2qnJGu5QfAlZEyH4=
Received: by 10.204.115.133 with SMTP id i5mr821580bkq.27.1286645774999;
        Sat, 09 Oct 2010 10:36:14 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id u4sm1268312bkz.5.2010.10.09.10.36.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 10:36:12 -0700 (PDT)
In-Reply-To: <20101009152758.GA17799@burratino> (Jonathan Nieder's message of
	"Sat, 9 Oct 2010 10:27:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158594>

Jonathan Nieder <jrnieder@gmail.com> writes:

> stepnem@gmail.com wrote:
>
>> `${parameter/pattern/string}' shell expansion uses glob patterns, so
>> talking about `regexp' is confusing.
>
> Okay.
>
>> - - No regexp ${parameter/pattern/string}.
>> + - No substitution ${parameter/pattern/string}.
>
> A bit confusing, since ${parameter%word} and $parameter are
> substitutions, too.

Not really. They are all parameter expansions. The former a "pattern
removal", the latter a plain expansion (yeah I know you can _call_ it a
substitution anyway, but I assume you were trying to be precise/match
the Bash manual wording here).

But I agree "pattern substitution" is even clearer, thanks.

BTW, when we continue on this slightly bike-shedding note, it would mak=
e
sense to unify the capitalisation of those termini technici in there
("Arithmetic Expansion", "Process Substitution"). Personally I would
prefer having them all in lower-case; it feels a bit funny to read "We
use Arithmetic Expansion". WDYT?

I hope the whitespace goes through undisturbed this time:

--- 8< ---
Subject: CodingGuidelines: Fix a typo

    `${parameter/pattern/string}' shell expansion uses glob patterns, s=
o
    talking about `regexp' is confusing.

Signed-off-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com>
---
 Documentation/CodingGuidelines |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuide=
lines
index 8346c19..e52474b 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -53,7 +53,7 @@ For shell scripts specifically (not exhaustive):

  - No strlen ${#parameter}.

- - No regexp ${parameter/pattern/string}.
+ - No pattern substitution ${parameter/pattern/string}.

  - We do not use Process Substitution <(list) or >(list).

--
