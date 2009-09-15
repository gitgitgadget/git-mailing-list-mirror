From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: Commited to wrong branch
Date: Tue, 15 Sep 2009 21:52:10 +0100
Message-ID: <26ae428a0909151352v1cc27b6dw1d77ac6dda0411ff@mail.gmail.com>
References: <26ae428a0909150331q391ed39ak622902d175b46d84@mail.gmail.com>
	 <46a038f90909150355h20b39c71w4af7e2be2920fdbb@mail.gmail.com>
	 <26ae428a0909150405v3087016fxee5ac98057868677@mail.gmail.com>
	 <46a038f90909150416h60ea7d74xd2337fe50f603dcb@mail.gmail.com>
	 <26ae428a0909150510n56b1d4eg6565a6cca8c9b46c@mail.gmail.com>
	 <46a038f90909150546i508d3781id1dcd8e6c64942cf@mail.gmail.com>
	 <26ae428a0909150558i508e5878q8a1ee7cb7311fc57@mail.gmail.com>
	 <20090915130640.GC31846@atjola.homenet>
	 <46a038f90909150654t73cab47ckfd02f8a2f4353722@mail.gmail.com>
	 <20090915203948.GA14652@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 15 22:52:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnf0f-0003Aa-4W
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 22:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757146AbZIOUwL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Sep 2009 16:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756797AbZIOUwK
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 16:52:10 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:43996 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755648AbZIOUwJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Sep 2009 16:52:09 -0400
Received: by ewy2 with SMTP id 2so858637ewy.17
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 13:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=5SYQ2khJu0HhyKETYvNv8B7ujLkL3IvUtO3v130p8Nc=;
        b=ZzKjQT5oae0VRFCE9oBgCNDVJZj6cnfFIblfgtcKCpkUXz9c5Zm6syUe/YZ5YtXvvI
         BXLb3MAgKKCw6cN9v6YD1MkUdpv7ZoHGuCOipzk6704wQmkPFR6b9NGzJnMKecTjuB81
         m+MwZPHygu0wFbA0892UHA2F6hXLsbNzLK/Mw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=TJ7lZL/EE2VFAh2y3ht5N+bDpRYYx/VNISf74+dHH91fSxC+Gs/yQkiMrcYjW6OOTT
         F4yUxQBJllXQZ/YXRHsU0DDWJPNHuz8kj3L/agfDFXrq6vex4AI1zG8WGx8Rpe/KXn6g
         vGRLZZznZUYakL4Spaq41BycLeAUu4cmV4sss=
Received: by 10.216.70.195 with SMTP id p45mr1200853wed.66.1253047931050; Tue, 
	15 Sep 2009 13:52:11 -0700 (PDT)
In-Reply-To: <20090915203948.GA14652@atjola.homenet>
X-Google-Sender-Auth: 163ae95f42072044
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128589>

I don't imagine having a problem with conflict markers although I've
never had any in a git related project (yet!). I'm in the happy
position of working by myself at the moment which, in the end, is how
I got out of my problem because I knew where all the changes where.
Interestingly, the whole .rej file thing IS new to me. I've been using
patch files for years and have never had that happen before. Hmmm...

Never used emacs either - I'm a Vim-kid :-)

Martin's point about simply copying the repo so you have a backup is
at the same time dead simple and brilliant. It's almost an undo. I
have an idea that I could now fumble my way through a problem like
this. The bother is that git has too many commands and too little
(idiot proof) help which is a shame. Not everybody is a power user -
but we are just the sort of people who mess up. I'm trying to put a
positive spin on things - we need a git tips wiki or something.
Version control to me is a dull necessity - I don't want to have to
think about it!

Howard

2009/9/15 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
> On 2009.09.15 15:54:58 +0200, Martin Langhoff wrote:
>> 2009/9/15 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
>> > Just don't use patch(1), there's no sane reason to do that, you're
>> > sacrificing all of what git can offer there.
>>
>> Oh, yes there is, specially for newcomers used to patch, and how it
>> handles conflicts.
>
> Sooner or later you'll hit a merge conflict anyway, and conflict mark=
ers
> aren't that hard to understand, and IMHO are easier to handle than .r=
ej
> files, as you get to edit everything in-place.
>
>> In this case, I happen to know that Howard is a refugee from CVS lan=
d
>> (the moodle project in this case), and he is familiar with the outpu=
t
>> of patch if things go wrong.
>
> Uhm, CVS uses the same conflict markers that git uses.
>
>> It's not what I'd recommend to someone that is deep in git-land. But
>> even myself (with a bit of code in git) sometimes use patch when
>> git-apply tries to be too clever and I just want a damn .rej file to
>> review and edit with emacs.
>
> Well, you likely shouldn't be using git-apply, which is plumbing, and
> can't easily make use of the "index" information in git patches to do=
 a
> three-way merge instead of a "stupid" patch application. Instead use
> git-am --3way to make git perform a three-way merge, leading to
> conflicts instead of plain patch rejection.
>
> And in a case like Howard's, in which nothing is coming from outside =
the
> repo, there's not even any reason to use am. It's already all in ther=
e,
> so "checkout -m", "stash/stash apply" (uncommitted changes) and
> "cherry-pick", "rebase [-i]" are way better than manually dealing wit=
h
> format-patch + am or even apply.
>
> Bj=F6rn
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
