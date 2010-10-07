From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] New commit option --fixup.
Date: Thu, 7 Oct 2010 08:35:43 +0000
Message-ID: <AANLkTimQbYi=MmodFuyDdgeoYXQ42j2Jq4a+BmohGG0W@mail.gmail.com>
References: <1286405901-13586-1-git-send-email-rodolfo.borges@gmail.com>
	<AANLkTimHz3sCDh-aicw1agi_mrL8pUztfi32vWv1pXUM@mail.gmail.com>
	<AANLkTi=c9zCKUnZp3B=m9C99FKOTtz+hY5-GvSXjozHD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Notz <patnotz@gmail.com>,
	Rodolfo Borges <rodolfo.borges@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 10:35:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3lx7-0007F3-K2
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 10:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760179Ab0JGIfo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 04:35:44 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50679 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472Ab0JGIfn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 04:35:43 -0400
Received: by iwn9 with SMTP id 9so551146iwn.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 01:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tsyTvoTiGpvpDX7FIs7GJ23pWWw1OcpQ7fWpb5EMOSQ=;
        b=iasa9fSrARd1TWAph5fQmxgUAhTE+GnaWY8j/ZlRbquCGZCIWCAdqIMBQcww+0EEd+
         OSsfvvTxDLjTS7+kS8k+dEeP0luLiV/9Ku34F84CCalonViltT+luArJvYxjtRykkezc
         wS4mRaJYnTLgmamJS+4C9pum+fZ695CVMkQ9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KeytAHZhO/AvvvnUgAydEYAsBsw/Mi3TY/dB7C/zFn8aqocrQoyvWhCu4+xDvZ4i/1
         FVSzCj/cToiBYoCd7wCHk4DttoglmCMeT+fRxvqXNjGDa1zmdYw8TfKxXDuQxmMnji1h
         HrxsYK9NeMcbU2FvsCHuyWbSrp1UkYJQ+I5NE=
Received: by 10.42.243.72 with SMTP id ll8mr238508icb.158.1286440543360; Thu,
 07 Oct 2010 01:35:43 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Thu, 7 Oct 2010 01:35:43 -0700 (PDT)
In-Reply-To: <AANLkTi=c9zCKUnZp3B=m9C99FKOTtz+hY5-GvSXjozHD@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158386>

On Thu, Oct 7, 2010 at 08:09, Sverre Rabbelier <srabbelier@gmail.com> w=
rote:
> Heya,
>
> On Thu, Oct 7, 2010 at 02:38, Pat Notz <patnotz@gmail.com> wrote:
>> Why not just use an alias for this? =C2=A0I do:
>>
>> git config alias.fixup "commit --amend -C HEAD"
>
> I have a similar alias:
>
> git config alias.amendall "commit --amend -a -C HEAD"
>
> I don't think we need a command to do this, but I'm starting to think
> we really should have a list of aliases either ship with git itself,
> or with the git documentation.

=46WIW that's one of the things I want to do if I pick up my .gitconfig
inclusion patch again. Have aliases files that ship with Git itself
that you can include in ~/.gitconfig.
