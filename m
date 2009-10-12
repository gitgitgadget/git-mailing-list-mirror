From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] user-manual: add global config section
Date: Mon, 12 Oct 2009 20:09:32 +0300
Message-ID: <94a0d4530910121009r52d45522jf1c27dd102db4ad9@mail.gmail.com>
References: <1255293786-17293-1-git-send-email-felipe.contreras@gmail.com>
	 <1255293786-17293-2-git-send-email-felipe.contreras@gmail.com>
	 <4AD32024.6020005@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"J. Bruce Fields" <bfields@citi.umich.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Oct 12 19:16:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxOVS-0002mb-JJ
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 19:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754851AbZJLRLW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Oct 2009 13:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754783AbZJLRLV
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 13:11:21 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:33890 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556AbZJLRLU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Oct 2009 13:11:20 -0400
Received: by fg-out-1718.google.com with SMTP id d23so517459fga.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 10:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lhUKRc2Yfr/shHZ+SHJuFkwNjT8gZpDt3ZFl37AYyI8=;
        b=hu88mskmfpFFG9xNDz6E5t4IhqdnqiccW2jfP/I0dcuIPbSTi+INaPzxp4QV4WhtAr
         Ev6TULwEfmks27Qa7/9fbxL1QvFkLQF+MHmUu6PESTuQGuVyiKzkw3snhZ4SnF5YbL+f
         g02rlR7KgE/BVsT4OXZv6XLv35Rb5i6xbwDlc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=R9FQKx3asFBx+t4nqe545RWumG2WrvXiL/5nVFKinsNM1WcEL72G97p7A3aTpqST6N
         NeHRporp3CVgI4PflS5bLzJYFDpBxiHOvyf5s0+KKHY0CaxrhbMfT4o49MVDr+xoI3Eh
         X8ubBbwrAmuSfgMBIhdAi6J+/B2KHlJvLuabk=
Received: by 10.86.254.23 with SMTP id b23mr1141320fgi.21.1255367372718; Mon, 
	12 Oct 2009 10:09:32 -0700 (PDT)
In-Reply-To: <4AD32024.6020005@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130034>

On Mon, Oct 12, 2009 at 3:25 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Felipe Contreras venit, vidit, dixit 11.10.2009 22:43:
>> So that users get to know how to configure git from the get-to with =
good
>> practical example (color.ui =3D auto) that most people would probabl=
y like
>> anyway.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>> =C2=A0Documentation/user-manual.txt | =C2=A0 27 ++++++++++++++++++++=
+++++++
>> =C2=A01 files changed, 27 insertions(+), 0 deletions(-)
>>
>> diff --git a/Documentation/user-manual.txt b/Documentation/user-manu=
al.txt
>> index 67ebffa..ff2563a 100644
>> --- a/Documentation/user-manual.txt
>> +++ b/Documentation/user-manual.txt
>> @@ -40,6 +40,33 @@ without any explanation.
>> =C2=A0Finally, see <<todo>> for ways that you can help make this man=
ual more
>> =C2=A0complete.
>>
>> +[[getting-started]]
>> +Getting started
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +Git's configuration is distributed among different locations--this =
manual will
>> +only to deal with 'global' (for the user) and 'repository' variable=
s, where
>> +'repository' variables take precedence over 'global' ones.
>
> Well, you do talk about "system" below, and that's about it. Also, th=
e
> configuration is not really distributed among different locations. Mo=
st
> newbies interested in a *D*VCS will misunderstand this (as git having
> distributed configuration).
>
> Alternative:
>
> Git's default configuration can be changed on a system wide, global (=
per
> user) and local (per repository) level, in the order of increasing
> precedence.

When I read that it's not clear if the local level discards the global
level completely or it's aggregated. If we specify that it's only the
variables that take precedence it might be clearer:

Git's configuration is composed of variables that are stored in
multiple locations: 'system' (all users), 'global' (for the user), and
'repository' -- in decreasing order of precedence.

>> +
>> +You would probably want to start setting up something useful:
>> +------------------------------------------------
>> +$ git config --global color.ui auto
>> +------------------------------------------------
>> +
>> +This will make prettier the output of certain commands such as `git=
 diff`, but
>> +that's not important; what is important here is that `color.ui` has=
 been
>> +stored in the 'global' configuration.
>
> This will make certain commands such as `git diff` use colors in the
> output. What is important here is that the value `auto` for the optio=
n
> `color.ui` has been stored in the 'global' configuration. Use `--syst=
em`
> for the system wide configuration; specifying neither `--system` nor
> `--global` makes `git config` access the local configuration.

I think we should only mention (once) the system wide configuration,
but not cover it. That's for system administrators, not users.

>> +
>> +View and manually modify the configuration by opening `~/.gitconfig=
`:
>
> View and manually modify the global configuration by opening
> `~/.gitconfig` in your editor or using `git config --global --edit`:

I have separate patches for 'git config --edit', but Junio suggested
to hold them back because --edit is a relatively new option.

>> +------------------------------------------------
>> +[color]
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0ui =3D auto
>> +------------------------------------------------
>> +
>> +Other locations are `/etc/gitconfig` (system), and `.git/config` (r=
epository).
>
> I don't even think we should talk about locations here, "git config -=
e"
> should be the first user's way to do it.

I disagree. Most useful configurations (color.ui, user.email) should
be global. The complete newbie might think: cool, now I have my git
properly configured (with 'git config -e'), and then when cloning a
new repo (s)he would think: ok, git just forgot what I told him. When
that happens (s)he would have to re-learn and re-configure git.

When users think about configuration, it's usually a 'global'
configuration, so that's what we should teach from the beginning and
make sure they understand the difference between 'global' and
'repository' configurations.

>> +
>> +More git configurations will be covered in the rest of the manual, =
if you want
>> +to learn more look at linkgit:git-config[1] for details.
>
> "Configurations" is ambiguous, it can be easily (mis)understood as
> "types of configuration" (global, local etc.). Also, the above doesn'=
t
> really cover even one option. How about:
>
> This manual covers many configuration options (such as `color.ui.`). =
=46or
> more details on the `git config` command as well as all configuration
> options see linkgit:git-config[1].

Looks better, except s/configuration options/configuration variables/

Cheers.

--=20
=46elipe Contreras
