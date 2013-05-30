From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <kernel-hacker@bennee.com>
Subject: Re: Poor performance of git describe in big repos
Date: Thu, 30 May 2013 15:02:50 +0100
Message-ID: <CAJ-05NNB7b5Bgc4B5OUOta+Q08+fgKf_NzuG44z8_teqWgnctQ@mail.gmail.com>
References: <CAJ-05NPQLVFhtb9KMLNLc5MqguBYM1=gKEVrrtT3kSMiZKma_g@mail.gmail.com>
	<20130530114808.GD17475@serenity.lan>
	<CAJ-05NM9EhikDBP0izqWrnLbZW6RcHq_cH-20YTE08SZw5fjqA@mail.gmail.com>
	<CACsJy8A1oEezNeFjXTrQ=+gJ6nxDheFYTU0xtiSRt0aOOvE=Vw@mail.gmail.com>
	<CAJ-05NPacjAEC99Ntd9eMnTD9_PMMYFob-_tAx5CeSB79TkRSg@mail.gmail.com>
	<CACsJy8AuhbwkjGjeQRYe1XZFsAntNdpKYxBM9aeMwF3HpB16Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 16:02:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui3RP-0002Fu-9H
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 16:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756877Ab3E3OCw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 10:02:52 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:55567 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754944Ab3E3OCu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 May 2013 10:02:50 -0400
Received: by mail-ob0-f181.google.com with SMTP id 16so600914obc.40
        for <git@vger.kernel.org>; Thu, 30 May 2013 07:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=+hBKUONyNPWDEhLWFpMM/x5mLo99jeJn4+PeEh3L5ZE=;
        b=H0OKNDzVmBZtd8th2VrGRcVYdmiTV2vPZaae8jAVuDncAkWFhg/2UqvHrxcQrMDDWJ
         Z40Ym0bjjhg4jJseYnX1+gHFGIt3qHyc+abocq0ySw8ltFc2E9wcWe/G/RTf7bRf46/Z
         gHZwER4XagASS43clmzQfUzOQLzpF/SKv6D7dIomfEM0YyWaBMwTPxXLecY5BhkJ3p6u
         Ee0lxWhvV2OKN34pNpedZRas2z9VKMiMWMe9nJmw155rUQN4v/Mf7y4LcAOnuydZT11r
         jfIr+WJnTpZgT7VjZaNOWsi9jPFMV/iQauLGcRF6oKR1o+cSFO+OqNMn1nXweA1YQKZa
         5MPg==
X-Received: by 10.60.65.5 with SMTP id t5mr4178323oes.139.1369922570192; Thu,
 30 May 2013 07:02:50 -0700 (PDT)
Received: by 10.76.98.137 with HTTP; Thu, 30 May 2013 07:02:50 -0700 (PDT)
In-Reply-To: <CACsJy8AuhbwkjGjeQRYe1XZFsAntNdpKYxBM9aeMwF3HpB16Ow@mail.gmail.com>
X-Google-Sender-Auth: d7-ZwPWhBCWePRxH9svUS5AP7_o
X-Gm-Message-State: ALoCoQlBFL9RCpJETUoKOjdAo+b+9bOn15qyTfRLGrIFxOTwHRNOp4GsY0V8gFLE1CTbNJc+/WBS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226001>

On 30 May 2013 14:45, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, May 30, 2013 at 8:34 PM, Alex Benn=C3=A9e <kernel-hacker@benn=
ee.com> wrote:
> <snip>
> Thanks. Can you share "verify-pack -v" output of
> pack-a9ba133a6f25ffa74c3c407e09ab030f8745b201.pack? I think you need
> to put it somewhere on Internet temporarily as it's likely to exceed
> git@vger limits.
> --
> Duy

http://www.bennee.com/~alex/stuff/git-pack-access.tar.bz2

--
Alex, homepage: http://www.bennee.com/~alex/
