From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: [PATCH] rebase -i: add exec command to launch a shell command
Date: Thu, 5 Aug 2010 11:37:40 -0700
Message-ID: <AANLkTi=P4iinacNXgPN8ZCtjiggBEj-OzF8TkKG5pZgU@mail.gmail.com>
References: <1281013217-29577-1-git-send-email-Matthieu.Moy@imag.fr> 
	<AANLkTinWvJvNOj6Ga7LgTMmEF37GbZN=hQBFJz4EBry5@mail.gmail.com> 
	<vpqfwytnh0m.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 05 20:38:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh5Ka-0001Gl-3f
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 20:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758656Ab0HESiF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 14:38:05 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55357 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758123Ab0HESiD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Aug 2010 14:38:03 -0400
Received: by wyb39 with SMTP id 39so6944099wyb.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 11:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=4v3fY0sjVuBtAZHl1U5fviN0KiGVXC7Usew8i90tqMQ=;
        b=N4J1ueKfbwsJSMpUK+gHAhYVX+J38ODh5USoF31A7FmWmLuCEBmpaLV9joKJH7cest
         gSMPrfA76SdFLviUfvKlMYePLDmDAgzDqkZPj8V04ply8zf0GdwckJD+1lN8HPLVk5Zn
         qN13pWuZdCoYG8q0wA1O+IRKdTeFPlsTab5lY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=UGZjhMUyHGMH3uEgQDlIBjCg17k6HgirTU4SLEIf0/3GPx0bpNjG0le3Q861OTSAIA
         BS5mTG81VI34pSsFDHze0hveK1qGhUrZYPRsqRJyZfYK2XAMX9nNezUw1CGI8u+MMv5Y
         BzXOWjKL3Zaj+C00QRotp6KPfhoFrFvzcSWRk=
Received: by 10.216.11.131 with SMTP id 3mr3928162wex.92.1281033480123; Thu, 
	05 Aug 2010 11:38:00 -0700 (PDT)
Received: by 10.216.151.25 with HTTP; Thu, 5 Aug 2010 11:37:40 -0700 (PDT)
In-Reply-To: <vpqfwytnh0m.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152700>

On Thu, Aug 5, 2010 at 09:47, Matthieu Moy <Matthieu.Moy@grenoble-inp.f=
r> wrote:
> =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason <avarab@gmail.com> writes:
>
>>> +in `$SHELL`, or the default shell if `$SHELL` is not set), so you =
can
>>> +use usual shell commands like "cd". The command is run from the
>>
>> I think that needs a definite article: ".. use the usual ..".
>
> I don't think so, especially with a plural "commands" after.
> Googlefight agrees with me ("use the usual commands" =3D> 350 results=
,
> "use usual commands" =3D> 4900), but that's not a proof. Perhaps a
> native speaker could help?
>

You could probably just drop "usual" entirely: ..., so you can use
shell commands like "cd".

I'm not sure that "usual" really adds anything there, and might
actually be confusing.  Does it mean that "unusual" ones won't work?
What are "unusual" ones?

Possibly make 'like "cd"', parenthetical to further show that it's an
example, and not saying that only commands along the lines of "cd"
will work?  ..., so you can use shell commands (for example: cd).

-Jacob
