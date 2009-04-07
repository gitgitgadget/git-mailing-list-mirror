From: Baz <brian.ewins@gmail.com>
Subject: Re: [RFC PATCH] git-send-email.txt: clarify which options take an 
	argument.
Date: Tue, 7 Apr 2009 16:06:11 +0100
Message-ID: <2faad3050904070806o55ba937cy1e5cd4fd156a4352@mail.gmail.com>
References: <1239111587-23452-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Apr 07 17:09:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrCty-00052y-PY
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 17:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757557AbZDGPGP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2009 11:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756718AbZDGPGP
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 11:06:15 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:62271 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757084AbZDGPGN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2009 11:06:13 -0400
Received: by fxm2 with SMTP id 2so2375620fxm.37
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 08:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=A4HkwtiNV7v6Ne2rw0moWUl8r7ygg0R3cwL99ZTorVk=;
        b=qp2rYrjnCZFjpsDpJm5irDBj90R5JQKCsfo4iX1LVKZNAT1NflFfyQiEDJY6ADzlH0
         Fkdh/3LDeAoW8G+CURAa6ohk/Pon1Ljs3C2Mmed2yvj9tCA3B+k7gfLsQ2Uf2KJx4c8g
         X2Q6+EHtCOKdb9oULNcSCh52saI7gMMQQiIY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fQcSZzLyGVlrEsO/9VTOOzCSrbdoDH48BBtcXnh/HZmKeLRjikXbA8xdx+XPt/6c0i
         Mb0v7X0EURkAl+e/iOUIl2WlgxeP5Q3Brav/2y4CbT42sjzsCcEOhCjhczXcFVmczSH8
         4HgEM6OCZG7pZcFeyiawsC/7kHJtzWTZuBsGc=
Received: by 10.223.123.210 with SMTP id q18mr121454far.63.1239116771536; Tue, 
	07 Apr 2009 08:06:11 -0700 (PDT)
In-Reply-To: <1239111587-23452-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115962>

2009/4/7 Matthieu Moy <Matthieu.Moy@imag.fr>:
> ---
>
> Can someone more knowledgeable than me proof-read this? I tried to us=
e
> intuitive names for the arguments (like 'address' where an email
> address is expected), but since there are options I never used, I may
> have mis-understood some of them.
>
> Thanks,
>
> =C2=A0Documentation/git-send-email.txt | =C2=A0 36 ++++++++++++++++++=
------------------
> =C2=A01 files changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-sen=
d-email.txt
> index 10dfd66..e25da71 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -39,13 +39,13 @@ OPTIONS
> =C2=A0Composing
> =C2=A0~~~~~~~~~
>
> ---bcc::
> +--bcc=3D'address'::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Specify a "Bcc:" value for each email. Def=
ault is the value of
> =C2=A0 =C2=A0 =C2=A0 =C2=A0'sendemail.bcc'.

A general comment: the other man pages use a style like "--bcc=3D<addre=
ss>".

> =C2=A0+
> =C2=A0The --bcc option must be repeated for each user you want on the=
 bcc list.
>
> ---cc::
> +--cc=3D'address'::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Specify a starting "Cc:" value for each em=
ail.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Default is the value of 'sendemail.cc'.
> =C2=A0+
> @@ -68,24 +68,24 @@ and In-Reply-To headers will be used unless they =
are removed.
> =C2=A0+
> =C2=A0Missing From or In-Reply-To headers will be prompted for.
>
> ---from::
> +--from=3D'address'::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Specify the sender of the emails. =C2=A0Th=
is will default to
> =C2=A0 =C2=A0 =C2=A0 =C2=A0the value GIT_COMMITTER_IDENT, as returned=
 by "git var -l".
> =C2=A0 =C2=A0 =C2=A0 =C2=A0The user will still be prompted to confirm=
 this entry.
>
> ---in-reply-to::
> +--in-reply-to=3D'identifier'::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Specify the contents of the first In-Reply=
-To header.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Subsequent emails will refer to the previo=
us email
> =C2=A0 =C2=A0 =C2=A0 =C2=A0instead of this if --chain-reply-to is set=
 (the default)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Only necessary if --compose is also set. =C2=
=A0If --compose
> =C2=A0 =C2=A0 =C2=A0 =C2=A0is not set, this will be prompted for.
>
> ---subject::
> +--subject=3D'string'::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Specify the initial subject of the email t=
hread.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Only necessary if --compose is also set. =C2=
=A0If --compose
> =C2=A0 =C2=A0 =C2=A0 =C2=A0is not set, this will be prompted for.
>
> ---to::
> +--to=3D'address'::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Specify the primary recipient of the email=
s generated. Generally, this
> =C2=A0 =C2=A0 =C2=A0 =C2=A0will be the upstream maintainer of the pro=
ject involved. Default is the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0value of the 'sendemail.to' configuration =
value; if that is unspecified,
> @@ -97,7 +97,7 @@ The --to option must be repeated for each user you =
want on the to list.
> =C2=A0Sending
> =C2=A0~~~~~~~
>
> ---envelope-sender::
> +--envelope-sender=3D'address'::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Specify the envelope sender used to send t=
he emails.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0This is useful if your default address is =
not the address that is
> =C2=A0 =C2=A0 =C2=A0 =C2=A0subscribed to a list. If you use the sendm=
ail binary, you must have
> @@ -105,12 +105,12 @@ Sending
> =C2=A0 =C2=A0 =C2=A0 =C2=A0the 'sendemail.envelopesender' configurati=
on variable; if that is
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unspecified, choosing the envelope sender =
is left to your MTA.
>
> ---smtp-encryption::
> +--smtp-encryption=3D'mode'::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Specify the encryption to use, either 'ssl=
' or 'tls'. =C2=A0Any other
> =C2=A0 =C2=A0 =C2=A0 =C2=A0value reverts to plain SMTP. =C2=A0Default=
 is the value of
> =C2=A0 =C2=A0 =C2=A0 =C2=A0'sendemail.smtpencryption'.

Maybe <encryption-mode> here. You use <mode> for other options below
to mean something else. However, I doubt the use is all that
confusing.

> ---smtp-pass::
> +--smtp-pass[=3D'password']::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Password for SMTP-AUTH. The argument is op=
tional: If no
> =C2=A0 =C2=A0 =C2=A0 =C2=A0argument is specified, then the empty stri=
ng is used as
> =C2=A0 =C2=A0 =C2=A0 =C2=A0the password. Default is the value of 'sen=
demail.smtppass',
> @@ -122,7 +122,7 @@ or on the command line. If a username has been sp=
ecified (with
> =C2=A0specified (with '--smtp-pass' or 'sendemail.smtppass'), then th=
e
> =C2=A0user is prompted for a password while the input is masked for p=
rivacy.
>
> ---smtp-server::
> +--smtp-server=3D'host'::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0If set, specifies the outgoing SMTP server=
 to use (e.g.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0`smtp.example.com` or a raw IP address). =C2=
=A0Alternatively it can
> =C2=A0 =C2=A0 =C2=A0 =C2=A0specify a full pathname of a sendmail-like=
 program instead;
> @@ -132,7 +132,7 @@ user is prompted for a password while the input i=
s masked for privacy.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0`/usr/lib/sendmail` if such program is ava=
ilable, or
> =C2=A0 =C2=A0 =C2=A0 =C2=A0`localhost` otherwise.
>
> ---smtp-server-port::
> +--smtp-server-port=3D'port'::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Specifies a port different from the defaul=
t port (SMTP
> =C2=A0 =C2=A0 =C2=A0 =C2=A0servers typically listen to smtp port 25 a=
nd ssmtp port
> =C2=A0 =C2=A0 =C2=A0 =C2=A0465). This can be set with 'sendemail.smtp=
serverport'.
> @@ -140,7 +140,7 @@ user is prompted for a password while the input i=
s masked for privacy.
> =C2=A0--smtp-ssl::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Legacy alias for '--smtp-encryption ssl'.
>
> ---smtp-user::
> +--smtp-user=3D'user'::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Username for SMTP-AUTH. Default is the val=
ue of 'sendemail.smtpuser';
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if a username is not specified (with '--sm=
tp-user' or 'sendemail.smtpuser'),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0then authentication is not attempted.
> @@ -149,13 +149,13 @@ user is prompted for a password while the input=
 is masked for privacy.
> =C2=A0Automating
> =C2=A0~~~~~~~~~~
>
> ---cc-cmd::
> +--cc-cmd=3D'cmd'::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Specify a command to execute once per patc=
h file which
> =C2=A0 =C2=A0 =C2=A0 =C2=A0should generate patch file specific "Cc:" =
entries.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Output of this command must be single emai=
l address per line.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Default is the value of 'sendemail.cccmd' =
configuration value.

Why not <command>? The option is short to save typing, doesn't mean
its documentation has to be.

> ---[no-]chain-reply-to::
> +--[no-]chain-reply-to=3D'identifier'::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0If this is set, each email will be sent as=
 a reply to the previous
> =C2=A0 =C2=A0 =C2=A0 =C2=A0email sent. =C2=A0If disabled with "--no-c=
hain-reply-to", all emails after
> =C2=A0 =C2=A0 =C2=A0 =C2=A0the first will be sent as replies to the f=
irst email sent. =C2=A0When using
> @@ -163,7 +163,7 @@ Automating
> =C2=A0 =C2=A0 =C2=A0 =C2=A0entire patch series. Default is the value =
of the 'sendemail.chainreplyto'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0configuration value; if that is unspecifie=
d, default to --chain-reply-to.
>
> ---identity::
> +--identity=3D'identity'::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A configuration identity. When given, caus=
es values in the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0'sendemail.<identity>' subsection to take =
precedence over
> =C2=A0 =C2=A0 =C2=A0 =C2=A0values in the 'sendemail' section. The def=
ault identity is
> @@ -174,7 +174,7 @@ Automating
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cc list. Default is the value of 'sendemai=
l.signedoffbycc' configuration
> =C2=A0 =C2=A0 =C2=A0 =C2=A0value; if that is unspecified, default to =
--signed-off-by-cc.
>
> ---suppress-cc::
> +--suppress-cc=3D'category'::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Specify an additional category of recipien=
ts to suppress the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0auto-cc of:
> =C2=A0+
> @@ -211,7 +211,7 @@ specified, as well as 'body' if --no-signed-off-c=
c is specified.
> =C2=A0Administering
> =C2=A0~~~~~~~~~~~~~
>
> ---confirm::
> +--confirm=3D'mode'::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Confirm just before sending:
> =C2=A0+
> =C2=A0--
> @@ -234,7 +234,7 @@ have been specified, in which case default to 'co=
mpose'.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Make git-send-email less verbose. =C2=A0On=
e line per email should be
> =C2=A0 =C2=A0 =C2=A0 =C2=A0all that is output.
>
> ---[no-]validate::
> +--[no-]validate=3D'mode'::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Perform sanity checks on patches.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Currently, validation means the following:

Is this one correct? Don't you just type --validate, or --no-validate,
without a value?

> =C2=A0+
> --
> 1.6.2.2.449.g92961.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
