From: Al Haraka <alharaka@gmail.com>
Subject: Re: Gitweb 1.7.5 and Textconv Configuration
Date: Sun, 3 Jul 2011 00:10:38 +0300
Message-ID: <CALWDD1w-sVcPbU1_yHacw5yfrwoK1hOgfRu2X04JsFrq1WZJCg@mail.gmail.com>
References: <CALWDD1x-_rEx+c9bpAgVk-hvnGz1bt0mbJoDkSjZkbe=gLscUg@mail.gmail.com>
	<20110702104313.GA10245@sigill.intra.peff.net>
	<20110702104437.GA10538@sigill.intra.peff.net>
	<CALWDD1woB0ytL6T-DwD92f824dnpz0mek=SYgz5jwqR0efnkpw@mail.gmail.com>
	<20110702185724.GA14390@sigill.intra.peff.net>
	<CALWDD1zrOUwS2FeQs1SsFuLnaDzhCHZVFLvFXv7aLex1K2v5zw@mail.gmail.com>
	<20110702195735.GA15542@sigill.intra.peff.net>
	<m3aacw5t5x.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 02 23:10:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qd7Sg-0002yl-Bk
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 23:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755793Ab1GBVKk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Jul 2011 17:10:40 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:54101 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754538Ab1GBVKj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jul 2011 17:10:39 -0400
Received: by fxd18 with SMTP id 18so4155153fxd.11
        for <git@vger.kernel.org>; Sat, 02 Jul 2011 14:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=1OviNqFOYtKdJL1e4o7gqCrHa//ya9RG2cLA4AKooO8=;
        b=sq9AuTM7rbzWbFf2iFWOpiUtGc/qXaM0OikKE/kNkaAV/Qu03DSKHhflgnYFRei0AZ
         8SUhhVskr+E6O8HRoN56f6HHuwmzxnTFPwOTSlagSqYK/P12lEwFj08KaMw5wqd7WH10
         I+392jZTQHvnnarRPt36+qHVRu2f+/oOqKlIo=
Received: by 10.223.75.138 with SMTP id y10mr6911220faj.36.1309641038186; Sat,
 02 Jul 2011 14:10:38 -0700 (PDT)
Received: by 10.223.101.207 with HTTP; Sat, 2 Jul 2011 14:10:38 -0700 (PDT)
In-Reply-To: <m3aacw5t5x.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176570>

On Sat, Jul 2, 2011 at 11:23 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> Jeff King <peff@peff.net> writes:
>> On Sat, Jul 02, 2011 at 10:18:55PM +0300, Al Haraka wrote:
>>
>> > > which will make the repository-wide non-version-controlled gitat=
tributes
>> > > the same as the last committed version. The problem is that it w=
on't be
>> > > automatically updated as you commit and push changes to .gitattr=
ibutes.
>> >
>> > I thought my plan was to try and avoid this by using the
>> > core.attributesfile directive, forcing this stuff to operate syste=
m
>> > (well, account, besides the point here) wide on all repos with
>> > specifying a .gitattributes (or, since it base bare, as you pointe=
d
>> > out yourself, $GIT_REPO_DIR/info/attributes) every single time. =C2=
=A0Did I
>> > misunderstand the mailing list thread that mentioned this a while
>> > back?
>>
>> Ah, I see. That seems like a reasonable solution. Are you sure that =
the
>> user running gitweb as a CGI is the same as the user you log in as? =
That
>> is, are you sure that ~/.gitconfig is being parsed when it is called=
 as
>> a CGI, and it's not looking in ~www/.gitconfig or something?
>>
>> It would depend how your hosting is set up.
>
> Well, there is also system wide $(prefix)/etc/gitconfig file...

Unfortunately, this is on Dreamhost.  I do not have root access, and
this is a kludge.  I know what I am asking for is a very exclusive use
case, but I would love to have this kind of feature until people tell
me it cannot be done.  Haha.

>> > This is the reason I went through the trouble of compiling an upda=
ted
>> > version in my account (as opposed to the installed version on the
>> > Dreamhost box; they are stuck at version 1.7.1.1; I saw this menti=
oned
>> > on a thread somewhere and wanted to get the "latest" (well latest
>> > stable version) to avoid this kind of problem? =C2=A0Was that the =
right
>> > thing to do? =C2=A0Will it even work in this case? =C2=A0I get the=
 feeling from
>> > your response I was expecting a lot with RTFM'ing more.
>>
>> It sounds like it should work to me, but I've not tested it (nor do =
I
>> even run gitweb; I just have an interest in textconv).
>
> The question is if --textconv works with git-diff-tree, because that
> is what gitweb uses.

It does work on git-dif-tree when I just checked.  So, I presume that
this means Jeff is right, and it must be not pulling the config from
the right location?

Jeff, on that note, I fear you are right about the appropriate user
executing the script:

http://wiki.dreamhost.com/Suexec

I get the feeling this is the case because in several instances I
thought I was clever with my use of ~ or $HOME, or the tutorial writer
had been himself.  In those instances, using full paths and not
user-specific environment vars fixed the issues.  So, I guess I need
to figure a way to pass the config vars appropriately?  I already
changed the core.attributesfile from ~/.gitattributes to
/home/dreamhost_user/.gitattributes in anticipation, but I know that
is only the first step.  I need to go to head out for a bit.  I will
revisit the issue tomorrow morning when I have time to think about the
right way to fix passing the environment variables for suexec.  I am
an idiot.

> BTW. we could use --textconv in 'blob' and 'blame' views (it is
> documented that git-cat-file supports --textconv, and it is checked i=
n
> git testsuite but not documented that git-blame supports --textconv).
> But it would require changes to gitweb.
>
>
> Hoping that this email will made it...

It made it indeed.  Much appreciated for both your efforts so far.

> --
> Jakub Narebski
> Poland
> ShadeHawk on #git
>



--=20
Alexander J. Stein
Cell:=C2=A0 +974 70013750
Email: alharaka@gmail.com
Skype: alexander.j.stein
