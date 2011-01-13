From: JT Olds <jtolds@xnet5.com>
Subject: Re: Git Rebase blows away GIT_AUTHOR_NAME
Date: Thu, 13 Jan 2011 10:11:04 -0700
Message-ID: <AANLkTimvK3p3M8kbGzLxyhchoFONiD4=FGPWxxs=i0GA@mail.gmail.com>
References: <AANLkTinMX0yEPvSc-c=96R42SbFZTjW5Mnveuxk3ZHS=@mail.gmail.com>
	<20110112182150.GC31747@sigill.intra.peff.net>
	<AANLkTimanDRHwoqSj7i9sVCZkze1L3Qp-zFYwTwHAOHX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 13 18:14:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdQkl-0002lV-Jt
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 18:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756944Ab1AMROX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Jan 2011 12:14:23 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48969 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756717Ab1AMROV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jan 2011 12:14:21 -0500
Received: by eye27 with SMTP id 27so958747eye.19
        for <git@vger.kernel.org>; Thu, 13 Jan 2011 09:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=K7prZUQKKZmNEBfYxD3CFRK8C5Ak/INpQFcAdTFDjIs=;
        b=vG/hHXgAnTCfNL3giYK0n34m+lVvfAoYGPXaeKhCdCDKpXkBV7OI/3SMWLp5mINN+4
         PF8jrLblMDlRa558DkL99aMT6J+kAxAynIo1UwKhUdZwiBI/WcZbxyVld8FUBdvqGNB/
         76G2mGoVgNc2oJaMYwa9T+u2YA4+f4HL6F4vg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=D0f+znajlqjgu2hrh1Sgxi1RtjtvgPBUxJ3WTTy2Lyh3uixk0vzVTJ1ebwrN6ddqu9
         220XrVkADVL3fIsWFpFdIY19BmbUboCLoOJhVWsEOwXfrnnDF8j/06EQ6hkIUqoujVsY
         FyvERxbtcvXaQb/QFlCtUmj3JyauHKRxh8tvc=
Received: by 10.216.183.145 with SMTP id q17mr2226666wem.5.1294938664267; Thu,
 13 Jan 2011 09:11:04 -0800 (PST)
Received: by 10.216.2.194 with HTTP; Thu, 13 Jan 2011 09:11:04 -0800 (PST)
In-Reply-To: <AANLkTimanDRHwoqSj7i9sVCZkze1L3Qp-zFYwTwHAOHX@mail.gmail.com>
X-Google-Sender-Auth: TJLHyq4lIHLNlr68frtsH926TXw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165057>

I got a copy of git-sh-setup. All of my commits (that have either
worked or that I fixed) look like this:

GIT_AUTHOR_NAME=3D'JT'
GIT_AUTHOR_EMAIL=3D'jt@instructure.com'
GIT_AUTHOR_DATE=3D'1294756950 -0700'
Author: jt@instructure.com
Email: jt@instructure.com
Subject: removing nondeterminism from test
Date: Tue, 11 Jan 2011 07:42:30 -0700

Should "Author" be my name? Could that be what's going on? I don't
even know where that gets set. The ones that I failed to notice that
they broke before I pushed them look like this:

GIT_AUTHOR_NAME=3D'jt@instructure.com'
GIT_AUTHOR_EMAIL=3D'jt@instructure.com'
GIT_AUTHOR_DATE=3D'1294775987 -0700'
Author: jt@instructure.com
Email: jt@instructure.com
Subject: some cleanup
Date: Tue, 11 Jan 2011 12:59:47 -0700

Thanks again for the help. This has been frustrating me for months.
Still working on a duplicate-the-problem script.

-JT

On Thu, Jan 13, 2011 at 10:00 AM, JT Olds <jtolds@xnet5.com> wrote:
>> Some things off the top of my head: Does your GIT_AUTHOR_NAME or
>> GIT_AUTHOR_EMAIL contain any odd characters that might confuse a par=
ser?
>
> Nah, from my .git/config
>
> [user]
> =A0 =A0 =A0 =A0name =3D JT
> =A0 =A0 =A0 =A0email =3D jt@instructure.com
>
>> Do you do anything special with setting up those environment variabl=
es
>> in your shell (e.g., in a .bashrc or .profile; those files _shouldn'=
t_
>> be read by a non-interactive shell, but it's something to investigat=
e)?
>
> Nope, the only place in my entire home directory where those get set
> are in my filter-branch script to fix them, which I only run after th=
e
> problem manifests itself.
>
>> For that matter, how do you set up your identity in general (by
>> environment, or in ~/.gitconfig, or a local .git/config in each repo=
),
>> and what does it contain?
>
> I have a global identity in ~/.gitconfig
>
> [user]
> =A0 =A0name =3D JT
> =A0 =A0email =3D hello@jtolds.com
>
> and then in particular topic branches in their .git/config like befor=
e.
>
>> Can you try running this in a repo that's giving you problems:
>>
>> =A0. git-sh-setup
>> =A0git log --format=3D%H --author=3Dyour.name |
>> =A0while read rev; do
>> =A0 =A0get_author_ident_from_commit $rev
>> =A0 =A0git format-patch -1 --stdout $rev |
>> =A0 =A0 =A0git mailinfo /dev/null /dev/null
>> =A0done | less
>
> I don't have git-sh-setup, which seems like it should be included in
> the git-core package, but it's not. I have git-core
> 1:1.7.1-1.1ubuntu0.1 installed. Obviously this precludes
> get_author_ident_from_commit from working.
>
>> If that doesn't turn up anything, I think the next thing to try woul=
d be
>> making a script that reproduces the problem for you, and see if I ca=
n
>> reproduce it here.
>
> Alright, I'll see what I can do. Thanks.
>
