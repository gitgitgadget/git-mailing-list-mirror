From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] git-patch-id.txt: show that you can pipe in git-log
Date: Wed, 16 Feb 2011 23:24:10 +0100
Message-ID: <AANLkTinbatY9KSr63K2sE-CP3r499Hvby8MOwdKq8WYU@mail.gmail.com>
References: <1297853586-812-1-git-send-email-avarab@gmail.com>
	<7vaahvkc1o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 23:24:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PppnH-0005nm-VX
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 23:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754995Ab1BPWYN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Feb 2011 17:24:13 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59874 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753762Ab1BPWYL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Feb 2011 17:24:11 -0500
Received: by fxm20 with SMTP id 20so1933066fxm.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 14:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IuIitgrK0jKzDGyHwDHz5w3oTXTcf8JaHYJbqy1Lppw=;
        b=ugEEE8cHnL5Qa0EWcPb1sjIEB8e+//Y1V0cp83f0dmMzK0jBDL75QOjR/RI6pYcIbm
         DCCAioaBrwBqk7QJNzCJAWHmhX7C5e/hMSh+tkruzd0avXTlMLlpbuQA3o72ACObL9LN
         p81S0c35gKEU6KdsXRNDkii/WxlcKlV1zFyzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rt8OTJ4cWIBikBijjQhvHIOcMxZmEywhTAU1ce/Lhz4knxt+fm8FcI4tWLnabkcwn+
         Q9eHVSqCQAp2av0J2yPv+Th4onKa9qNY7w2v3l2qoWcsIfUISKpnPbeohs5rAeOrSr0a
         Vt0m79i+Q3YiZ2d7qe7mHUPbFvpxWxjbZzwJ4=
Received: by 10.223.114.209 with SMTP id f17mr1425173faq.136.1297895050045;
 Wed, 16 Feb 2011 14:24:10 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Wed, 16 Feb 2011 14:24:09 -0800 (PST)
In-Reply-To: <7vaahvkc1o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167012>

On Wed, Feb 16, 2011 at 20:35, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> write=
s:

> The notation "< <patch>" is used as a way to say "this command reads =
from
> its standard input and acts on it". =C2=A0Anybody who understands wha=
t the
> redirection is knows that a normal command would not mind getting fed=
 from
> a pipe instead of a regular file (they _could_ tell the kind of file
> descriptors, and there indeed are commands that change their behaviou=
r
> depending on the kind of file descriptor they are being fed from, but=
 they
> are exceptions). =C2=A0So I don't think the new information should li=
ve here.

Yes, but see below.

>> =C2=A0DESCRIPTION
>> =C2=A0-----------
>> =C2=A0A "patch ID" is nothing but a SHA1 of the diff associated with=
 a patch, with
>
> How about rewriting the whole thing, along these lines...
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0SYNOPSIS
> =C2=A0 =C2=A0 =C2=A0 =C2=A0--------
> =C2=A0 =C2=A0 =C2=A0 =C2=A0'git patch-id'
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0DESCRIPTION
> =C2=A0 =C2=A0 =C2=A0 =C2=A0-----------
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Reads a patch from the standard input, and=
 outputs the unique ID
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for it. =C2=A0When fed a series of patches=
 that records which commit
> =C2=A0 =C2=A0 =C2=A0 =C2=A0they come from (e.g. output from 'git form=
at-patch --stdout' or
> =C2=A0 =C2=A0 =C2=A0 =C2=A0'git log -p'), reads them and outputs the =
unique IDs for them, one
> =C2=A0 =C2=A0 =C2=A0 =C2=A0per line.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A line in its output consists of two 40-by=
te hexadecimal values;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01. the unique ID for the cha=
nge;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02. a SP; and
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03. the commit object name fo=
r the change if known, or
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 40 "0" letters.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A "patch ID" is nothing but a SHA-1 of ...=
 (original text, but
> =C2=A0 =C2=A0 =C2=A0 =C2=A0needs to rewrite "When dealing with..." pa=
ragraph not to mention
> =C2=A0 =C2=A0 =C2=A0 =C2=A0diff-tree because that is not a user-facin=
g command anymore).
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0EXAMPLES
> =C2=A0 =C2=A0 =C2=A0 =C2=A0--------
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git patch-id <patch.txt::
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0... (describe what this does=
) ...
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git log -3 -p | git patch-id::
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0... (describe what this does=
) ...

This looks much better.

What I was aiming for was not to explain that:

    cat foo | thing
    thing < foo

Are the same thing, but that nothing in git-patch-id's previous
manpage suggested that it could take a stream of commits, from reading
it it looked like I would have to flush each individual patch to disk,
then feed them in one-by-one.

But your revised manpage explains that much better, you should commit
it.
