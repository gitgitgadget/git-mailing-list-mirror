From: Baz <brian.ewins@gmail.com>
Subject: Re: [RFC PATCH] git-send-email.txt: clarify which options take an 
	argument.
Date: Tue, 7 Apr 2009 16:48:45 +0100
Message-ID: <2faad3050904070848k3c0d7018n4cacf8cf1aadd9ab@mail.gmail.com>
References: <1239111587-23452-1-git-send-email-Matthieu.Moy@imag.fr>
	 <2faad3050904070806o55ba937cy1e5cd4fd156a4352@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Apr 07 17:50:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrDZA-0003x6-Bt
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 17:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753070AbZDGPst convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2009 11:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751863AbZDGPst
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 11:48:49 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:34367 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720AbZDGPss convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2009 11:48:48 -0400
Received: by fxm2 with SMTP id 2so2393705fxm.37
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 08:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zUc/kwl8d/EiKRY/kTwsAebQ1xDyOYsjr4NV6hNE9lI=;
        b=R8ojHkLDqoUbmMxRzs0Kw18Q9oknVGGGFUuGiis9+eDzviEntbxwvJ1X9rsbbr73rX
         udElc7khTaLExyVdgNm4ymGbWVSHoHF8jmyM7uvf6uTzPK49urJV5FDPu2jJWFR8AQYI
         iWUovkOn4FYU88f0g2rVNq7N1IWjAtOAJ1dOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qp7iyCH+qe2pyuDL7jwWpJApcv4kwNMXXEH5vKo++e0wVX9LbFBsocEqcQTBv2nSc6
         b2PpOWujHrvaXDLNx97KwFKP1pzc/H7EaZ+ot0l1jZ0I4NaCCklGrSm1LgNl1BYYZzW+
         +9m4YWqSJPjN8WfiyXxE83g+nS+oWtLLGvujY=
Received: by 10.223.126.145 with SMTP id c17mr120094fas.102.1239119325650; 
	Tue, 07 Apr 2009 08:48:45 -0700 (PDT)
In-Reply-To: <2faad3050904070806o55ba937cy1e5cd4fd156a4352@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115965>

2009/4/7 Baz <brian.ewins@gmail.com>:
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
>> =C2=A0Documentation/git-send-email.txt | =C2=A0 36 +++++++++++++++++=
+------------------
>> =C2=A01 files changed, 18 insertions(+), 18 deletions(-)
>>
>> diff --git a/Documentation/git-send-email.txt b/Documentation/git-se=
nd-email.txt
>> index 10dfd66..e25da71 100644
>> --- a/Documentation/git-send-email.txt
>> +++ b/Documentation/git-send-email.txt
>> @@ -39,13 +39,13 @@ OPTIONS
>> =C2=A0Composing
>> =C2=A0~~~~~~~~~
>>
>> ---bcc::
>> +--bcc=3D'address'::
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Specify a "Bcc:" value for each email. De=
fault is the value of
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0'sendemail.bcc'.
>
> A general comment: the other man pages use a style like "--bcc=3D<add=
ress>".
>
>> =C2=A0+
>> =C2=A0The --bcc option must be repeated for each user you want on th=
e bcc list.
>>
>> ---cc::
>> +--cc=3D'address'::
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Specify a starting "Cc:" value for each e=
mail.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Default is the value of 'sendemail.cc'.
>> =C2=A0+
>> @@ -68,24 +68,24 @@ and In-Reply-To headers will be used unless they=
 are removed.
>> =C2=A0+
>> =C2=A0Missing From or In-Reply-To headers will be prompted for.
>>
>> ---from::
>> +--from=3D'address'::
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Specify the sender of the emails. =C2=A0T=
his will default to
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0the value GIT_COMMITTER_IDENT, as returne=
d by "git var -l".
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0The user will still be prompted to confir=
m this entry.
>>
>> ---in-reply-to::
>> +--in-reply-to=3D'identifier'::
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Specify the contents of the first In-Repl=
y-To header.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Subsequent emails will refer to the previ=
ous email
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0instead of this if --chain-reply-to is se=
t (the default)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Only necessary if --compose is also set. =
=C2=A0If --compose
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0is not set, this will be prompted for.
>>
>> ---subject::
>> +--subject=3D'string'::
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Specify the initial subject of the email =
thread.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Only necessary if --compose is also set. =
=C2=A0If --compose
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0is not set, this will be prompted for.
>>
>> ---to::
>> +--to=3D'address'::
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Specify the primary recipient of the emai=
ls generated. Generally, this
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0will be the upstream maintainer of the pr=
oject involved. Default is the
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0value of the 'sendemail.to' configuration=
 value; if that is unspecified,
>> @@ -97,7 +97,7 @@ The --to option must be repeated for each user you=
 want on the to list.
>> =C2=A0Sending
>> =C2=A0~~~~~~~
>>
>> ---envelope-sender::
>> +--envelope-sender=3D'address'::
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Specify the envelope sender used to send =
the emails.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0This is useful if your default address is=
 not the address that is
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0subscribed to a list. If you use the send=
mail binary, you must have
>> @@ -105,12 +105,12 @@ Sending
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0the 'sendemail.envelopesender' configurat=
ion variable; if that is
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0unspecified, choosing the envelope sender=
 is left to your MTA.
>>
>> ---smtp-encryption::
>> +--smtp-encryption=3D'mode'::
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Specify the encryption to use, either 'ss=
l' or 'tls'. =C2=A0Any other
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0value reverts to plain SMTP. =C2=A0Defaul=
t is the value of
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0'sendemail.smtpencryption'.
>
> Maybe <encryption-mode> here. You use <mode> for other options below
> to mean something else. However, I doubt the use is all that
> confusing.
>
>> ---smtp-pass::
>> +--smtp-pass[=3D'password']::
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Password for SMTP-AUTH. The argument is o=
ptional: If no
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0argument is specified, then the empty str=
ing is used as
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0the password. Default is the value of 'se=
ndemail.smtppass',
>> @@ -122,7 +122,7 @@ or on the command line. If a username has been s=
pecified (with
>> =C2=A0specified (with '--smtp-pass' or 'sendemail.smtppass'), then t=
he
>> =C2=A0user is prompted for a password while the input is masked for =
privacy.
>>
>> ---smtp-server::
>> +--smtp-server=3D'host'::
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0If set, specifies the outgoing SMTP serve=
r to use (e.g.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0`smtp.example.com` or a raw IP address). =
=C2=A0Alternatively it can
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0specify a full pathname of a sendmail-lik=
e program instead;
>> @@ -132,7 +132,7 @@ user is prompted for a password while the input =
is masked for privacy.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0`/usr/lib/sendmail` if such program is av=
ailable, or
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0`localhost` otherwise.
>>
>> ---smtp-server-port::
>> +--smtp-server-port=3D'port'::
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Specifies a port different from the defau=
lt port (SMTP
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0servers typically listen to smtp port 25 =
and ssmtp port
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0465). This can be set with 'sendemail.smt=
pserverport'.
>> @@ -140,7 +140,7 @@ user is prompted for a password while the input =
is masked for privacy.
>> =C2=A0--smtp-ssl::
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Legacy alias for '--smtp-encryption ssl'.
>>
>> ---smtp-user::
>> +--smtp-user=3D'user'::
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Username for SMTP-AUTH. Default is the va=
lue of 'sendemail.smtpuser';
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if a username is not specified (with '--s=
mtp-user' or 'sendemail.smtpuser'),
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0then authentication is not attempted.
>> @@ -149,13 +149,13 @@ user is prompted for a password while the inpu=
t is masked for privacy.
>> =C2=A0Automating
>> =C2=A0~~~~~~~~~~
>>
>> ---cc-cmd::
>> +--cc-cmd=3D'cmd'::
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Specify a command to execute once per pat=
ch file which
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0should generate patch file specific "Cc:"=
 entries.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Output of this command must be single ema=
il address per line.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Default is the value of 'sendemail.cccmd'=
 configuration value.
>
> Why not <command>? The option is short to save typing, doesn't mean
> its documentation has to be.
>
>> ---[no-]chain-reply-to::
>> +--[no-]chain-reply-to=3D'identifier'::
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0If this is set, each email will be sent a=
s a reply to the previous
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0email sent. =C2=A0If disabled with "--no-=
chain-reply-to", all emails after
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0the first will be sent as replies to the =
first email sent. =C2=A0When using
>> @@ -163,7 +163,7 @@ Automating
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0entire patch series. Default is the value=
 of the 'sendemail.chainreplyto'
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0configuration value; if that is unspecifi=
ed, default to --chain-reply-to.
>>
>> ---identity::
>> +--identity=3D'identity'::
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0A configuration identity. When given, cau=
ses values in the
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0'sendemail.<identity>' subsection to take=
 precedence over
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0values in the 'sendemail' section. The de=
fault identity is
>> @@ -174,7 +174,7 @@ Automating
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0cc list. Default is the value of 'sendema=
il.signedoffbycc' configuration
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0value; if that is unspecified, default to=
 --signed-off-by-cc.
>>
>> ---suppress-cc::
>> +--suppress-cc=3D'category'::
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Specify an additional category of recipie=
nts to suppress the
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0auto-cc of:
>> =C2=A0+
>> @@ -211,7 +211,7 @@ specified, as well as 'body' if --no-signed-off-=
cc is specified.
>> =C2=A0Administering
>> =C2=A0~~~~~~~~~~~~~
>>
>> ---confirm::
>> +--confirm=3D'mode'::
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Confirm just before sending:
>> =C2=A0+
>> =C2=A0--
>> @@ -234,7 +234,7 @@ have been specified, in which case default to 'c=
ompose'.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Make git-send-email less verbose. =C2=A0O=
ne line per email should be
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0all that is output.
>>
>> ---[no-]validate::
>> +--[no-]validate=3D'mode'::
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Perform sanity checks on patches.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Currently, validation means the following=
:
>
> Is this one correct? Don't you just type --validate, or --no-validate=
,
> without a value?

Sorry, I should have stated that more clearly, since you said you're
unfamiliar with some of the options. This one is incorrect - you don't
pass an argument to --validate. The default value referred to is a
boolean, but its unclear from the text, I guess thats what misled you.
=46ollowing the examples in git-format-patch, the line below might be
better rewritten as:

If this is set, sanity checks will be performed on patches, overriding
the configuration setting of sendemail.validate. The configuration
setting defaults to true. Currently, validation means the following:
(etc)

>
>> =C2=A0+
>> --
>> 1.6.2.2.449.g92961.dirty
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
>
