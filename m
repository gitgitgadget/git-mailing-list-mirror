From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [RFC PATCH] git-send-email.txt: clarify which options take an  argument.
Date: Tue, 07 Apr 2009 18:59:26 +0200
Message-ID: <vpqvdpg8knl.fsf@bauges.imag.fr>
References: <1239111587-23452-1-git-send-email-Matthieu.Moy@imag.fr>
	<2faad3050904070806o55ba937cy1e5cd4fd156a4352@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Baz <brian.ewins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 19:26:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrF4E-0006pJ-MU
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 19:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755783AbZDGRY5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2009 13:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755472AbZDGRY5
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 13:24:57 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:51576 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755315AbZDGRY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 13:24:56 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id n37HM86B024330;
	Tue, 7 Apr 2009 19:22:13 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LrEdy-0006YK-LA; Tue, 07 Apr 2009 18:59:26 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LrEdy-0000kx-Ir; Tue, 07 Apr 2009 18:59:26 +0200
In-Reply-To: <2faad3050904070806o55ba937cy1e5cd4fd156a4352@mail.gmail.com> (Baz's message of "Tue\, 7 Apr 2009 16\:06\:11 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Tue, 07 Apr 2009 19:22:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115966>

Baz <brian.ewins@gmail.com> writes:

> 2009/4/7 Matthieu Moy <Matthieu.Moy@imag.fr>:
>> ---
>>
>> Can someone more knowledgeable than me proof-read this? I tried to u=
se
>> intuitive names for the arguments (like 'address' where an email
>> address is expected), but since there are options I never used, I ma=
y
>> have mis-understood some of them.
>>
>> Thanks,
>>
>> =A0Documentation/git-send-email.txt | =A0 36 ++++++++++++++++++-----=
-------------
>> =A01 files changed, 18 insertions(+), 18 deletions(-)
>>
>> diff --git a/Documentation/git-send-email.txt b/Documentation/git-se=
nd-email.txt
>> index 10dfd66..e25da71 100644
>> --- a/Documentation/git-send-email.txt
>> +++ b/Documentation/git-send-email.txt
>> @@ -39,13 +39,13 @@ OPTIONS
>> =A0Composing
>> =A0~~~~~~~~~
>>
>> ---bcc::
>> +--bcc=3D'address'::
>> =A0 =A0 =A0 =A0Specify a "Bcc:" value for each email. Default is the=
 value of
>> =A0 =A0 =A0 =A0'sendemail.bcc'.
>
> A general comment: the other man pages use a style like "--bcc=3D<add=
ress>".

Almost all ;-). A quick grep showed me git-rev-list.txt and I did the
same. I'll send another patch to make it consistant.

>> +--smtp-encryption=3D'mode'::
>> =A0 =A0 =A0 =A0Specify the encryption to use, either 'ssl' or 'tls'.=
 =A0Any other
>> =A0 =A0 =A0 =A0value reverts to plain SMTP. =A0Default is the value =
of
>> =A0 =A0 =A0 =A0'sendemail.smtpencryption'.
>
> Maybe <encryption-mode> here. You use <mode> for other options below
> to mean something else. However, I doubt the use is all that
> confusing.

Changed to just "encryption", since this is the word used just below
in the sentence.

>> ---cc-cmd::
>> +--cc-cmd=3D'cmd'::
>> =A0 =A0 =A0 =A0Specify a command to execute once per patch file whic=
h
>> =A0 =A0 =A0 =A0should generate patch file specific "Cc:" entries.
>> =A0 =A0 =A0 =A0Output of this command must be single email address p=
er line.
>> =A0 =A0 =A0 =A0Default is the value of 'sendemail.cccmd' configurati=
on value.
>
> Why not <command>? The option is short to save typing, doesn't mean
> its documentation has to be.

Done.

>> ---[no-]validate::
>> +--[no-]validate=3D'mode'::
>> =A0 =A0 =A0 =A0Perform sanity checks on patches.
>> =A0 =A0 =A0 =A0Currently, validation means the following:
>
> Is this one correct? Don't you just type --validate, or --no-validate=
,
> without a value?

=46ixed too.

Thanks, new patch follows.

--=20
Matthieu
