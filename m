From: Ondrej Certik <ondrej@certik.cz>
Subject: Re: default aliases (ci, di, st, co)
Date: Sat, 11 Jul 2009 23:07:03 -0600
Message-ID: <85b5c3130907112207x74449b12qcff25b96711c42e1@mail.gmail.com>
References: <85b5c3130907081649s37f726f7id1a64f2fdbe609f@mail.gmail.com>
	 <4A55958E.1050401@op5.se>
	 <20090709085837.GA12348@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
To: Luciano Miguel Ferreira Rocha <luciano@eurotux.com>
X-From: git-owner@vger.kernel.org Sun Jul 12 07:07:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPrHZ-0001we-9Y
	for gcvg-git-2@gmane.org; Sun, 12 Jul 2009 07:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbZGLFHH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jul 2009 01:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbZGLFHG
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jul 2009 01:07:06 -0400
Received: from mail-yx0-f184.google.com ([209.85.210.184]:41890 "EHLO
	mail-yx0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbZGLFHF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Jul 2009 01:07:05 -0400
Received: by yxe14 with SMTP id 14so2131945yxe.33
        for <git@vger.kernel.org>; Sat, 11 Jul 2009 22:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=sSJ0DHLx/rb7o9ULERiw7tz4pdVX7UKUFg4uxI7FdoQ=;
        b=teeKY6rRe9z/fly/bneR/9qTCEx8mB3HJgMYeYNN00KHlLzdFjRwgL64b2NmaZoGpW
         VlSf9/fc79Qw8IJaQ4+7QO3fA3KbPeov6MiVmgmUQl6kxXhDOKGSXOYhEsJFBmg2ClQQ
         vH8vBh4AwQptueWdFUHXRFQ7KjL7P42ISbb+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=m74H+k8Kw6v22FytAGH8C5pt/L/rUqII/wLMH7LSkh15T7HbCfDG3ThzdBVht07bOH
         8yc3ShN/QAKVQcWCrnKRa592UK0xFWz2Bs4pWF4k1ILr4KXBOSkwnbJUdlTW3FvfCyjm
         HpAOSeOwEQFNmAElCbFRPtQRHM0RuMY5nRdug=
Received: by 10.100.197.2 with SMTP id u2mr5137640anf.138.1247375223452; Sat, 
	11 Jul 2009 22:07:03 -0700 (PDT)
In-Reply-To: <20090709085837.GA12348@bit.office.eurotux.com>
X-Google-Sender-Auth: c4c45d8e3d60d43e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123136>

On Thu, Jul 9, 2009 at 2:58 AM, Luciano Miguel Ferreira
Rocha<luciano@eurotux.com> wrote:
> On Thu, Jul 09, 2009 at 09:00:30AM +0200, Andreas Ericsson wrote:
>> =C2=A0Ondrej Certik wrote:
>> > Hi,
>> > coming to git from mercurial and svn, here is the alias part of my
>> > .gitconfig:
>> > [alias]
>> > =C2=A0 =C2=A0 ci =3D commit
>> > =C2=A0 =C2=A0 di =3D diff --color-words
>> > =C2=A0 =C2=A0 st =3D status
>> > =C2=A0 =C2=A0 co =3D checkout
>> > And all is fine until I share commands to checkout my branch (for
>> > example) with other people, then basically I have to write those
>> > commands in full (e.g. commit, checkout, ...), since I cannot assu=
me
>> > they have their .gitconfig setup the same way I do. Especially for
>> > people who are new to git.
>> > What is the view on this in the git community?
>>
>>
>> =C2=A0Personally I think "plain" aliases like you use above are evil=
=2E
>> =C2=A0git is not svn or mercurial. If you use it like svn you'll be
>> =C2=A0surprised sooner or later and your workflow will feel awkward =
or
>> =C2=A0just plain wrong. hg and git are very similar, but the fact th=
at
>> =C2=A0hg assumed the svn shorthands implies to me that they've tried
>> =C2=A0to retain a compatibility that does not, in fact, exist.
>
> No, it just means that shorting common commands is useful and common.
>
>> =C2=A0I have no simple aliases for any of the commands. There's just=
 no reason
>> =C2=A0for them since tab completion works so well.
>
> "Intelligent" bash completion always gets in my way, so I can't use i=
t.
>
> I vote yes.



Thanks everyone for contributing to the discussion. So it seems that
most people are against such aliases.

I only want to correct one thing --- I use git exactly because it's
not svn and exactly because it's not mercurial, things like git
branches, git remote branches, rebase -i, are still truly unique, and
in my experience once one tries it, he never wants to come back.

That said, I do use "git ci" and "git st" very often and I don't think
it infers any kind of workflow. TAB completion doesn't help, because I
need to write "git stat<TAB>", e.g. I save exactly one letter., commit
is better, there I just need "git com<TAB>", but I am still faster
with my aliases. Maybe "git co" is nasty, but I never had any problems
with that either.

Ondrej
