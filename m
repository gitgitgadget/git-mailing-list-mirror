From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Add persistent-https to contrib
Date: Thu, 24 May 2012 13:46:36 -0700
Message-ID: <CAJo=hJt4Suu5=kYh3kyOpDSPKr0jiZka=9g6U841PbiWCAQ_pQ@mail.gmail.com>
References: <1337792767-18914-1-git-send-email-cranger@google.com>
 <7v62blxx2m.fsf@alter.siamese.dyndns.org> <CAJo=hJt=q-ZnLrqzcfGrKNcao2MPDSRt3Y_r2OOfu75++N+3zw@mail.gmail.com>
 <20120524202930.GB18936@sigill.intra.peff.net> <CAJo=hJsfRr7MKcmn8owuyYf7LJ2jzpqgCfkijQ6ahrZfz3CDpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Stenberg <daniel@haxx.se>,
	Junio C Hamano <gitster@pobox.com>,
	Colby Ranger <cranger@google.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 24 22:47:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXew2-0001fP-A2
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 22:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755787Ab2EXUq5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 May 2012 16:46:57 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51511 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181Ab2EXUq4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 May 2012 16:46:56 -0400
Received: by pbbrp8 with SMTP id rp8so769607pbb.19
        for <git@vger.kernel.org>; Thu, 24 May 2012 13:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=9L9sSfkubwH96yJEkTiMiTWXT3MP6hgPynQvtMbQDPk=;
        b=KKoPrWueC13g9/OvIhj10laKGlppl1+n+xYXqrcDwRg6RxLk0M41Fu2Dk25VGlY1Sb
         X8BaubZEf7NQT+YwdSW/dztZDvrxksgUx4pQBLJ1cxvb1vAR2atevqa0duUnE6VoBDgR
         JmWd3XDkObllOrRiMC96eY3i9Yyj7oVJUbp3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=9L9sSfkubwH96yJEkTiMiTWXT3MP6hgPynQvtMbQDPk=;
        b=mREwK0LO/fTkqIV+oXK+WA4yvey+HT5sCUWH4/v9R/PW2sJPgGvqwMPctZ5SUz7Yql
         Tk3u6DB3REV4d7aNrsYD6fS2HQumTxzjI1z5NlD6hnut6sdNFvtw2CVUVrWy4c8CwlGS
         HcAenyzSH6uQ3655G08ZeIwbIDG+tuC7Dy0e6KAqm2vKjnBbPPfhmbZUb8kl3aM3og8f
         Q+UUdGDopmf0TYoOCd3LCtTRt05hNmRS994Ia0rr0Rdz7reCy4H1GwC61QI9jI1QjRrQ
         RjJTfuxHwNHI4EegQpCoDzjhSTy/31dY7aCq9GT8ZrLTM0LfEwIm1NjhU3BZGEcEA1n+
         JVkg==
Received: by 10.68.202.136 with SMTP id ki8mr12592118pbc.65.1337892416408;
 Thu, 24 May 2012 13:46:56 -0700 (PDT)
Received: by 10.68.52.169 with HTTP; Thu, 24 May 2012 13:46:36 -0700 (PDT)
In-Reply-To: <CAJo=hJsfRr7MKcmn8owuyYf7LJ2jzpqgCfkijQ6ahrZfz3CDpw@mail.gmail.com>
X-Gm-Message-State: ALoCoQna88GuJut33Hl9frzo9dm85Xs918HPlMs4JkEz+gyv/V5SbvEb+hFnU0W+mhkB45ezbcpm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198423>

On Thu, May 24, 2012 at 1:42 PM, Shawn Pearce <spearce@spearce.org> wro=
te:
> On Thu, May 24, 2012 at 1:29 PM, Jeff King <peff@peff.net> wrote:
>> On Thu, May 24, 2012 at 12:33:08PM -0700, Shawn O. Pearce wrote:
>>
>>> $ (for i in {1..5}; do time git ls-remote
>>> persistent-https://kernel.googlesource.com/pub/scm/linux/kernel/git=
/torvalds/linux
>>> >/dev/null;done) 2>&1 | grep real
>>> real =A00m0.208s
>>> real =A00m0.085s
>>> real =A00m0.079s
>>> real =A00m0.067s
>>> real =A00m0.059s
>>
>> Nice numbers. And as clever as I find this helper-wrapping-a-helper
>> solution, I wonder if the right layer for a fix isn't inside curl. I=
t
>> already keeps an ssl session-id cache in memory; how hard would it b=
e to
>> turn that into an on-disk cache?
=2E..
> Well, this helper "solution" also has the benefit of HTTP keep-alive
> working across Git command invocations.

Here is plaintext HTTP, where the benefit is from HTTP keep-alive:

  (for i in {1..5}; do time git ls-remote
http://android.googlesource.com/tools/repo >/dev/null;done) 2>&1  |
grep real
  real	0m0.098s
  real	0m0.097s
  real	0m0.106s
  real	0m0.095s
  real	0m0.105s

  (for i in {1..5}; do time git ls-remote
persistent-http://android.googlesource.com/tools/repo >/dev/null;done)
2>&1  | grep real
  real	0m0.134s
  real	0m0.065s
  real	0m0.063s
  real	0m0.061s
  real	0m0.067s

Notice we still save 30ms or so in this case. That is about the RTT
for my workstation to that server. :-)
