From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 0/2] test: tests for the "double > from mailmap" bug
Date: Tue, 14 Feb 2012 23:52:11 +0200
Message-ID: <CAMP44s0Dp9Av+ikFHa=QcqKFA5XL9ESBrzWLY0jkSCdH-NxhMw@mail.gmail.com>
References: <1329235894-20581-1-git-send-email-felipe.contreras@gmail.com>
	<20120214203431.GB13210@burratino>
	<20120214211402.GC23291@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 14 22:52:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxQIM-0007Fq-HL
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 22:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490Ab2BNVwO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 16:52:14 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:46998 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757319Ab2BNVwN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 16:52:13 -0500
Received: by lagu2 with SMTP id u2so434866lag.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 13:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=GAE+VtjKAb7UVUlEQ2HRQFNCbsrITQCclurUchxXTZc=;
        b=aL+rV3f6EXyGNvDrze8L4ZeiEinOYMrz7/pyutFe8YGDRhb0UYp44EeXs/ybrbsaOi
         Pyo41xQSMuUBeIyO7rO3aKVgDvfTNXXIvBlUGc5SBZepquFhsE6nZIwFZalv2s37swzl
         eTHpDr+UeqtdtBFIsYlq9OD7dOw5s7S4bjeuw=
Received: by 10.112.86.67 with SMTP id n3mr7900757lbz.29.1329256332013; Tue,
 14 Feb 2012 13:52:12 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Tue, 14 Feb 2012 13:52:11 -0800 (PST)
In-Reply-To: <20120214211402.GC23291@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190768>

On Tue, Feb 14, 2012 at 11:14 PM, Jeff King <peff@peff.net> wrote:
> My general review process is (in this order):
>
> =C2=A01. Figure out why a change is needed. This should be explained =
in the
> =C2=A0 =C2=A0 commit message. And no, just adding tests is not assume=
d to be
> =C2=A0 =C2=A0 needed. =C2=A0Why did the old tests not cover this case=
?

As I already mentioned more than once; the first patch is not related
to any fix.

>     The answer can
> =C2=A0 =C2=A0 be a simple "nobody bothered to write them", and that's=
 OK.

 That can be derived from the word "add". You can't add something that
is already there.

>     But
> =C2=A0 =C2=A0 some description of the current state can help reviewer=
s understand
> =C2=A0 =C2=A0 the rationale (e.g., "we tested with shortlog, but not =
mailmap, and
> =C2=A0 =C2=A0 certain code paths are only exposed through mailmap").

You are assuming too much. That's not the purpose, that's why I didn't =
menti

> =C2=A02. Figure out what the change should be doing.

t: mailmap: add 'git blame -e' tests

That's what the change should be doing; nothing more, nothing less.

I wonder why you have to assume the worst. When I see a commit message
like that, I assume that there were no previous tests for that (thus
the word 'add'), and that's all I need to know.

If you want to extrude meaning from where there isn't, well, go ahead,
but there's nothing else really.

Cheers.

--=20
=46elipe Contreras
