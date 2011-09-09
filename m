From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Fwd: RFD: leveraging GitHub's asciidoc rendering for our Documentation/
Date: Fri, 9 Sep 2011 21:25:59 +0530
Message-ID: <CAMK1S_iSOY6DuP8-u1txUOyA393XjF4GF3m6VQfPgG5bx2QcPA@mail.gmail.com>
References: <4E6A23DB.1040606@drmicha.warpmail.net>
	<CAMK1S_hOY-riZnHAZhC32UAA0BYF1YyXUPujj_jFUEjcYC_4ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 09 17:56:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R23R1-0001td-1a
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 17:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758674Ab1IIP4A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Sep 2011 11:56:00 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:60985 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758006Ab1IIP4A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2011 11:56:00 -0400
Received: by vxi9 with SMTP id 9so1200339vxi.19
        for <git@vger.kernel.org>; Fri, 09 Sep 2011 08:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=wh5ljcwv2WMR7BqHu+wOE5d8Zii69bBg6f6blk9ysyY=;
        b=UCCyinzyEIve1KmJ2uH8iswI0g4+uVIVMHjc/E7eb8SSuM7J7HRdH6E6uwMPRNEBtT
         KLTCLrwZYAvSjm8O17Aohn+AJ8vlucTK9wLqg2Nu/mNgEM4we+cCcqhgIMX229fIqbNW
         6AjvB/uLVJK/xy9WtGSBv5qYRMQvr1R1w55RY=
Received: by 10.52.187.233 with SMTP id fv9mr1521488vdc.179.1315583759581;
 Fri, 09 Sep 2011 08:55:59 -0700 (PDT)
Received: by 10.52.161.197 with HTTP; Fri, 9 Sep 2011 08:55:59 -0700 (PDT)
In-Reply-To: <CAMK1S_hOY-riZnHAZhC32UAA0BYF1YyXUPujj_jFUEjcYC_4ZA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181082>

forgot to copy the list; sorry...


---------- Forwarded message ----------
=46rom: Sitaram Chamarty <sitaramc@gmail.com>
Date: Fri, Sep 9, 2011 at 9:24 PM
Subject: Re: RFD: leveraging GitHub's asciidoc rendering for our Docume=
ntation/
To: Michael J Gruber <git@drmicha.warpmail.net>


On Fri, Sep 9, 2011 at 8:04 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Hi there,
>
> I've been looking more to GitHub lately and was wondering whether it =
is
> worth to leverage their automatic asciidoc rendering for our asciidoc
> files. I have put up a test tree at
>
> https://github.com/gitigit/git/tree/githubtest
>
> which has all the renaming (*.txt -> *.asciidoc) and Makefile and scr=
ipt
> changes, but is missing some include changes (because include breaks
> anyway, see below).
>
> The simple renaming already gives a rendered display of blobs for
> simpler asciidoc files like release notes
>
> https://github.com/gitigit/git/blob/githubtest/Documentation/RelNotes=
/1.7.7.asciidoc
>
> and api documentation
>
> https://github.com/gitigit/git/blob/githubtest/Documentation/technica=
l/api-credentials.asciidoc
>
> For the man pages, there are several problems as can be seen here:
>
> https://github.com/gitigit/git/blob/githubtest/Documentation/git-blam=
e.asciidoc
>
> Our own customisation is not loaded (of course) so that, e.g., the
> linkgit macro does not work; and the include statement makes GitHub's
> parser unhappy and choke.

maybe github will consider supporting linkgit? =C2=A03 letters are comm=
on anyway :)

> Does anybody feel this is worth pursuing?

=46or a long time, I relied on github's rendering for all of my
(gitolite) documentation. =C2=A0Eventually I realised it is too slow to
render. =C2=A0More importantly, the whole github "presence" was extrane=
ous
to the manpage, and often distracted my readers.

Eventually I started pre-rendering my documentation to HTML myself and
pushing it to a branch called "gh-pages". =C2=A0Contrast the visual app=
eal
of the github-rendered page [1] versus the pre-rendered page [2]. =C2=A0=
(I
admit I do have some very minimal CSS in my version but that's another
plus point for pre-rendering)

[1]: https://github.com/sitaramc/gitolite/blob/pu/README.mkd
[2]: http://sitaramc.github.com/gitolite/README.html

--=20
Sitaram
