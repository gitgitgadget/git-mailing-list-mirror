From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: git status showing phantom modifications
Date: Wed, 27 Jan 2010 13:14:39 +0800
Message-ID: <be6fef0d1001262114r137ba8ddi60a3a3468950c5ce@mail.gmail.com>
References: <9B3C1167-7667-4B1F-BEE5-F47FE89F8692@xing.com>
	 <be6fef0d1001250303p2c12381ao7d3a8a1d48eebb56@mail.gmail.com>
	 <4017EB11-4B29-4599-B19A-91BC39632BBF@xing.com>
	 <59B5C4C4-6E95-4BAA-9351-B88B6309E022@xing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Ludwig <michael.ludwig@xing.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jan 27 06:15:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na0F5-00063i-Fo
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 06:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736Ab0A0FOo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jan 2010 00:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752621Ab0A0FOl
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 00:14:41 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:43673 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291Ab0A0FOj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2010 00:14:39 -0500
Received: by iwn16 with SMTP id 16so778737iwn.5
        for <git@vger.kernel.org>; Tue, 26 Jan 2010 21:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SWqnZAYH3cK7gzXNoylaq0UEWLwQisGGB1IniRCfj5Y=;
        b=dcftp7ohRr7xA7AwTbuhajH8VMnnV6V+4bDWiGou2Lk0s0SbAwXUEcagUikGyBW6k4
         e/QwLInTQeuonqg116JvMZLeHk/j724vFJHLmQwU61uJkxH1933wyoOF0hQgJ5KXLF9L
         B0FV14MXUEkSKP33eZP5q7vFpxGT6bFCSvczs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JqaR1XUw8GOQ52h1/CsdgVd9C7GlNVRYzNUPaQ9bWxlly6UoGuFy6Y3NHPh3+PV6Ka
         4A3fIS2njQ1YqQZJNodd84FmbgKUSeTkga1FxrD3Y2I1bVzMERa8Ma5uvHlZRj+vZmpK
         Pt7loq3UQg57dDLrNyeHcz0fv3ettiyQqHq0k=
Received: by 10.231.148.13 with SMTP id n13mr2776511ibv.67.1264569279125; Tue, 
	26 Jan 2010 21:14:39 -0800 (PST)
In-Reply-To: <59B5C4C4-6E95-4BAA-9351-B88B6309E022@xing.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138106>

Hi Johannes,

do you happen to have any clue on this?

--=20
Cheers,
Ray Chuan


On Tue, Jan 26, 2010 at 5:14 PM, Michael Ludwig <michael.ludwig@xing.co=
m> wrote:
> Am 25.01.2010 um 12:43 schrieb Michael Ludwig:
>
>> Reading up about core.fileMode in git-config(1), I think you've poin=
ted
>> me to the solution. I should probably just set it to false. If that =
doesn't
>> solve the issue, I'll report back.
>
> Back with more info:
>
> git version 1.6.4.2
>
> Before adding any core.filemode setting to ~/.gitconfig or .git/confi=
g:
>
> michael@wladimir:/cygdrive/m/REPOS6.TECH.git/comp :-) git config -l
> user.name=3DMichael Ludwig
> user.email=3D...
> core.repositoryformatversion=3D0
> core.filemode=3Dtrue =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<=3D =
filemode already present
> core.bare=3Dfalse
> core.logallrefupdates=3Dtrue
> core.ignorecase=3Dtrue
> core.autocrlf=3Dfalse
> svn-remote.svn.ignore-paths=3D^(some|paths)
> svn-remote.svn.url=3Dsvn://localhost
> svn-remote.svn.fetch=3D:refs/remotes/git-svn
> svn.authorsfile=3Dauthors.txt
>
> My git status output after cd to subdir shows many files "modified". =
But
> they aren't! Edited ~/.gitconfig to include core.filemode =3D true [s=
ic].
> Here's the diff for the git config output:
>
> --- /home/michael/a =A0 =A0 2010-01-25 20:36:53.140625000 +0100
> +++ /home/michael/b =A0 =A0 2010-01-25 20:37:01.421875000 +0100
> @@ -4,6 +4,7 @@
> alias.ci=3Dcheckin
> alias.co=3Dcheckout
> alias.br=3Dbranch
> +core.filemode=3Dtrue
> core.repositoryformatversion=3D0
> core.filemode=3Dtrue
> core.bare=3Dfalse
>
> We're seeing core.filemode appear *twice*. Why that?
>
> michael@wladimir:/cygdrive/m/REPOS6.TECH.git/comp :-) git st
> # On branch master
> nothing to commit (working directory clean)
>
> So it seems adding core.filemode =3D true has fixed the issue, or at =
least
> covered the symptoms. Adding core.filemode =3D false did not cause th=
e
> phantom modifications to disappear. Note that from reading git-config=
(1),
> I had rather assumed this latter setting to have the desired effect.
>
> And something seems to be wrong here. Why are modifications flagged w=
hen
> doing git status from a subdir but not from the topdir?
>
> --
> Michael.Ludwig (#) XING.com
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
