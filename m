From: John Szakmeister <john@szakmeister.net>
Subject: Re: The config include mechanism doesn't allow for overwriting
Date: Tue, 23 Oct 2012 20:46:47 -0400
Message-ID: <CAEBDL5V0Ffyp306rVo-USCBy_AXXMHXN1yrWmkF1BhzFaq60nA@mail.gmail.com>
References: <CACBZZX4cu9XuS5AtduWrNeXNUeZ4rqDUzRdmyz2b3cXtmo1nqQ@mail.gmail.com>
	<20121022211505.GA3301@sigill.intra.peff.net>
	<CACBZZX5mOb7_i9r8AqNK5V3r-gVnzN+rkeY9xrhecGv1rS-anA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 02:47:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQp7h-0003OP-Bd
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 02:47:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933702Ab2JXAqt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Oct 2012 20:46:49 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:45399 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933677Ab2JXAqs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Oct 2012 20:46:48 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so6244710iea.19
        for <git@vger.kernel.org>; Tue, 23 Oct 2012 17:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4a+CWWVB0cbaL8kJC1FZsP7JLZstnCgz3251iNI0iQw=;
        b=XDyufCPuWJEMUtWK4FfoDGm3c7TTXcvQ75LgBAqqgp7OzqFvvFcX64rYd62h8iXbcE
         FPtV3SiWLULBeyDj67wHBTMcPjWz+HW9jnwUDYCqunfRpGUopdS9Zk3/JWr1PdxLlxCP
         JVEDHqTHS1tkTlFg4lcCAhSiYceLEISsW9Fv+5ehlm4DQG5ODH1Fl2KQWnIr/eEGZI7L
         xj3hoQQVCMipLp3pMxSKHWAYxlgkJvaS710wD2hkRN1b1SdZLAshTkSN29XCaFOsujpV
         7ULB0kaIkum0LHPNd6KX0f1joYlw45pNf9c9OYOZ51ap+C6I9w/G/UaW9FFMJHYOmcQ7
         Nf7Q==
Received: by 10.50.151.210 with SMTP id us18mr997860igb.1.1351039607948; Tue,
 23 Oct 2012 17:46:47 -0700 (PDT)
Received: by 10.50.2.106 with HTTP; Tue, 23 Oct 2012 17:46:47 -0700 (PDT)
In-Reply-To: <CACBZZX5mOb7_i9r8AqNK5V3r-gVnzN+rkeY9xrhecGv1rS-anA@mail.gmail.com>
X-Google-Sender-Auth: sIMy--PrrUCuMbNHCkvlcrLp6bc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208276>

On Tue, Oct 23, 2012 at 10:13 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n
<avarab@gmail.com> wrote:
[snip]
> And git config --get foo.bar will give you:
>
>     $ git config -f /tmp/test --get foo.bar
>     one
>     error: More than one value for the key foo.bar: two
>     error: More than one value for the key foo.bar: three
>
> I think that it would be better if the config mechanism just silently
> overwrote keys that clobbered earlier keys like your patch does.
>
> But in addition can we simplify things for the consumers of
> "git-{config,var} -l" by only printing:
>
>     foo.bar=3Dthree
>
> Or are there too many variables like "include.path" that can
> legitimately appear more than once.

I frequently use pushurl in my remotes to push my master branch both
to the original repo and my forked version.  I find it very helpful in
my workflow, and would hate to lose that.  That said, I do like the
idea of having a config file and the ability to override some of the
variables.

-John
