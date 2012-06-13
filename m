From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] notes: attach help text to subcommands
Date: Wed, 13 Jun 2012 17:04:04 +0200
Message-ID: <CAMP44s0YrKJiLiinpScun4mJXC6W11SA=zEtAn5bWbLMnbFa5A@mail.gmail.com>
References: <7vd359eu4s.fsf@alter.siamese.dyndns.org>
	<1339169317-12134-1-git-send-email-artagnon@gmail.com>
	<20120608153607.GC10380@burratino>
	<CAMP44s28aoKkXyTr4Stow-empen9_CUxAWTDi_gcSUpKjMzg6Q@mail.gmail.com>
	<CALkWK0k_tP7qGJ9zvAvrPtqMqAtK2QE7mibf2Yt1gssN10a1NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 17:04:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sep7F-0001IY-R4
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 17:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754228Ab2FMPEI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jun 2012 11:04:08 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:65051 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754197Ab2FMPEH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jun 2012 11:04:07 -0400
Received: by lbbgm6 with SMTP id gm6so1298917lbb.19
        for <git@vger.kernel.org>; Wed, 13 Jun 2012 08:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=J0402BQHmpF8fvPa81lofbe+7HvNKhn17LjuHhl1EdQ=;
        b=O8hsnkEv1vmHJ8q7o3ZrE+Hdl9wZit4QFmTaom7/pVB6jKemWd2dLvpSQK0D1X/tGu
         +hUYveE6vfVA2Sm3OEU9OhyNxeWdG/+iQcSvUgbefac+J1Wi67SdYkFETtruG+DyxAfa
         nXbYw0hMEUeSmSx4NW8ibUvNKbX5Pkuie3roMXK/08yYJ/d0OZCnpvXPbuQ7LUpvwzWZ
         lZflLzA8n8d4eo7m1zUXygonnCr3PVr/hgiIVcFEy4zfklBykg/8yFXbWgIR/NC6UtJv
         zIQJdF7BXX+aE83s462H1ZEy6BAhr+ZfAm6FFUuvMxFsmUNc3f/eeQktDe7Rz5AliDNE
         e5CQ==
Received: by 10.152.112.138 with SMTP id iq10mr24873147lab.13.1339599844489;
 Wed, 13 Jun 2012 08:04:04 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Wed, 13 Jun 2012 08:04:04 -0700 (PDT)
In-Reply-To: <CALkWK0k_tP7qGJ9zvAvrPtqMqAtK2QE7mibf2Yt1gssN10a1NA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199896>

On Fri, Jun 8, 2012 at 6:34 PM, Ramkumar Ramachandra <artagnon@gmail.co=
m> wrote:
> Hi Jonathan and Felipe,
>
> Jonathan Nieder wrote:
>> Ramkumar Ramachandra wrote:
>>
>>> =C2=A0Thanks. =C2=A0I wish we could do something aout USAGE_OPTS_WI=
DTH and
>>> =C2=A0USAGE_GAP; I stole them from parse-options.
>>
>> Expose them in parse-options.h? =C2=A0Or put this functionality in a
>> parseopt-related file?
>
> Exposing a `subcommand_usage` in parse-options.h may not be a bad ide=
a.
>
> Felipe Contreras wrote:
>> There's many commands that would benefit from this. In addition to
>> provide a better help for subcommands, this can be used to generate
>> automatically the shell completion list of subcommands.
>>
>> Even more; in zsh it would be possible to show this help text direct=
ly
>> in the completion.
>
> How exactly is that going to work? =C2=A0`git notes -h` doesn't outpu=
t
> this- so the only way to get this output is to invoke `git notes` wit=
h
> an invalid subcommand. =C2=A0To fix that, I'd have to teach parse-opt=
ions
> about subcommands.

Yeah, something like that. See this proposal:

http://mid.gmane.org/1334140165-24958-2-git-send-email-bebarino@gmail.c=
om

I would prefer something like 'git info --subcommands notes' or
something like that.

Cheers.

--=20
=46elipe Contreras
