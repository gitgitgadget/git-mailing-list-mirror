From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC (take 3)] Git User's Survey 2007
Date: Sat, 4 Aug 2007 14:10:21 +0200
Message-ID: <200708041410.22449.jnareb@gmail.com>
References: <200707250358.58637.jnareb@gmail.com> <200708040250.55180.jnareb@gmail.com> <20070804054157.GN20052@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 14:11:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHITv-0002JL-6Q
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 14:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756129AbXHDML2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 4 Aug 2007 08:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755488AbXHDML2
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 08:11:28 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:52557 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754165AbXHDML1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 08:11:27 -0400
Received: by fk-out-0910.google.com with SMTP id z23so934993fkz
        for <git@vger.kernel.org>; Sat, 04 Aug 2007 05:11:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=lQvvL9RwFhPfHEBae948ti1pwMzAfaFF2VtAHNQ0/TBWEC2WyKmzszzQfgRLOGNopKoD8lz7Yk1YnXCbTPye38laKktqMJf9ZRgxQO42XS1fPbcliBph7qsC3H5M6jMnmstXAua4eqQPz31qaeMpPGCSfDskqyt0xfSZI4s/rOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=NfS43XmKMDjWJMCtWcqngDwb+ksxbbe9TkqMRqwTLfX3KcemN0//IghQWCQ7HoNuRbypBi/17sL3pW/b7XxYRe7+bhGQOyVRixmRNhwXo7bkTfyPB4ByJ69VF65cx345vlQ+oC1Vbm3OEkw+eqGS2yLgRTg1CMUIMmpBG8Qk8FQ=
Received: by 10.86.86.12 with SMTP id j12mr2929011fgb.1186229485732;
        Sat, 04 Aug 2007 05:11:25 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id b17sm8355851fka.2007.08.04.05.11.17
        (version=SSLv3 cipher=OTHER);
        Sat, 04 Aug 2007 05:11:18 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070804054157.GN20052@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54833>

On Sat, 4 August 2007, Shawn O. Pearce wrote:

>> How you use GIT
>>=20
>>     1. Do you use GIT for work, unpaid projects, or both?
>>        work/unpaid projects/both/none(*)
>>        (*)I use git to interact with some project I'm interested in
>=20
> I don't understand the (*) point here.  What's the middle ground
> between work and unpaid projects?  Paid projects that aren't work?
> Isn't that the definition of work?  Very confused...

I meant here to add an option for people who use git (or git web=20
interface) only for tracking some project(s). For example what if I'm=20
tracking git.git repository, but do not have repositories with my own=20
projects? It is a bit of gray area if you publish your own changes to=20
somebody else project if it is "none" or "unpaid projects".
=20
But perhaps it is too vague distinction. One can always not to answer=20
this question, if one does not have any projects, and do not use git=20
for work.

I'll think about removing this option.

>>     8. Which porcelains do you use?
>>        (zero or more: multiple choice)
>>     -  core-git, cogito, StGIT, pg, guilt, other
>=20
> I really hope nobody chooses pg.  I haven't supported it in a very
> long time.  Might be a good idea to keep it in this survey just to
> make sure its 0, then omit it from the next survey.  :-)

I'd use "core-git, cogito (deprecated), StGIT, guilt, pg (deprecated),=20
other", then.
=20
>> Changes in GIT (since year ago, or since you started using it)
> ...
>>     5. Which of the new features do you use?
>>        (zero or more: multiple choice)
>>     -  git-gui, bundle, eol conversion, gitattributes,
>>        submodules, worktree, release notes, user's manual,
>>        reflog, stash, shallow clone, detached HEAD, fast-import,
>>        mergetool, interactive rebase, commit template, blame
>>        improvements, other (not mentioned here)
>=20
> Wow.
>=20
> This community has accomplished a lot since the last survey.
> That list covers most of the major items over the past year, if
> not all of them.  But I'd never really seen it all written out
> in such a concise list; there's so much blood, sweat and tears
> in those topics from everyone on (and off) this mailing list.
> Reading it now is bringing back a lot of memories for me.
>=20
> Sorry, I just had a very emotional reaction to seeing how much we
> have managed to accomplish in so little time.  Thank you to everyone
> who has made this list possible!

And that are only user visible features! This list does not include
improvements to git "engine", like better support for huge files, or
"thickening" downloaded pack during fetch, or non-feature improvements
to git UI, like git-gc, git-remote, changes to git-diff, git-log,=20
git-show, making separate remote layout default, etc.

On the other hand this list might include some features which were=20
present at the time of previous (first) survey, like reflog, but were=20
not enabled by default and had almost no porcelain support.

>> Getting help, staying in touch
>>=20
>>     1. Have you tried to get GIT help from other people?
>>     -  yes/no
>>     2. If yes, did you get these problems resolved quickly
>>        and to your liking?
>>     -  yes/no
>=20
> Possible new item:
>=20
>   Would commerical (paid) support from a support vendor be of
>   interest to you/your organization?

This is a very good idea. I'd add this question to the list.

> I think Sam Vilain was suggesting he sell Git support
> to my day-job company, so my coworkers could call him and ask him
> questions, and he could ask me those same questions on #git, then
> mail me a 6-pack of beer[*1*] for my troubles. =A0:)
>
>
> [*1*] And sadly I don't drink beer...

So what would be the proper compensation? Bottle of wine? Bar of=20
chocolate? ;-p

--=20
Jakub Narebski
Poland
