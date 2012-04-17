From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Tue, 17 Apr 2012 10:10:12 +0300
Message-ID: <CAMP44s3OSepH_XpCcTWLN=bF0+P9fmHtyPnWdQnEocW25jHTpA@mail.gmail.com>
References: <7vaa2by8nj.fsf@alter.siamese.dyndns.org>
	<20120416160729.GM5813@burratino>
	<CAMP44s2_VYNFeBi9GPa9CeqT=oRmSq1J1XaSP+aKgC6bJ55Lfg@mail.gmail.com>
	<20120416200941.GD12613@burratino>
	<CAMP44s0CVsmHw4jQqHvZMi342V8-Yh2zYYcAE_5EHu5OAiktcw@mail.gmail.com>
	<20120416203320.GF12613@burratino>
	<7v7gxftn78.fsf@alter.siamese.dyndns.org>
	<CAMP44s1TkE=rd8AxbBnR4a8FwY+H9MHxYOhcks9fsnuK1iL_oA@mail.gmail.com>
	<20120416224411.GU12613@burratino>
	<CAMP44s0cdSaiCoMLk7oTHE4dies5-G0C7-RczK5OFEK=pYUW_A@mail.gmail.com>
	<20120416231626.GW12613@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 09:11:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SK2Yx-0003kd-0f
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 09:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441Ab2DQHKP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 03:10:15 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:40643 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab2DQHKO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2012 03:10:14 -0400
Received: by eekc41 with SMTP id c41so1488772eek.19
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 00:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=+wE+duZsHf5o2LB5anrVbl2INOpzK6Q8ZQTTmv8FIqE=;
        b=ixkiXkHYuS+uP3OD8SbU8k2c+ZIZcebhqat/mDNt6aNXxA26LecFbK+Ua48cZxS+QM
         3kkSpvO2LEyYMGzIxZ+dT+b2u9+b2HkuaJNLnEuUJRs7KVrv2DGEoqB/C6amraBTNWCw
         OLgMlxYjQifYpXqadk0ommjDOXZxNIH0zkmZUQ8RuzLRalWuQegy/wDwoQ0dnPyNHumo
         UQ5CR3fPQKN8B6k2iA4b+bxjDrlhr/1WZstpIWOF1LNHOzBWpdLqjK4JVRR7Wtkduhlj
         4xZjFqSDDJ5z7vbPb5Vs72qzDxjwohLxc/kvfI0Rwo3CEDlmTkvnO2NGj+xNIxHWE8Ni
         xVvQ==
Received: by 10.213.6.195 with SMTP id a3mr1007247eba.78.1334646612480; Tue,
 17 Apr 2012 00:10:12 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Tue, 17 Apr 2012 00:10:12 -0700 (PDT)
In-Reply-To: <20120416231626.GW12613@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195735>

On Tue, Apr 17, 2012 at 2:16 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Felipe Contreras wrote:
>
>> What makes you think this is public? It's under the section '# helpe=
r
>> functions', which doesn't seem to be public. Plus, it's repeated in
>> rpm, rpmbuild, and rpmbuild-md5.
>
> Ok, you win. =C2=A0I hadn't realized we were having a debate, but now=
 I do,
> and you have won.

I thought we were trying to agree on a good name for possibly the
first (or second, depending how you count) public function. It's
important to choose a good name because we can't just change it again
in a month.

You are the one who brought the argument that even public functions
have the '_' prefix, so it's *your* responsibility to substantiate
that argument. I don't think it would be easy to find a precedent like
this, but you can prove me wrong by providing the evidence; so far, I
don't think that has happened.

> Can we get back to making the completion script nicer for human
> beings that have been using it, please?

Sure, but we need some sort of git_completion function if we want to
make it easy for people to define aliases for git commands. And this
is a known issue that has been brought in the past.

> The following summary may sound annoyed, because I am. =C2=A0On the o=
ther
> hand I know you mean well and am grateful for your work.
>
> I have said that the convention for bash completion scripts is to
> precede all exposed identifier names with an underscore. =C2=A0You
> mentioned some old counterexamples that have been grandfathered in.
> You mentioned that you do not trust me. =C2=A0Your bash completion sc=
ript
> gets loaded immediately instead of being lazy-loaded, probably becaus=
e
> it is not in /usr/share/bash-completion/completions/. =C2=A0You claim=
ed
> that nobody would _ever_ ask for bash completion support at the end o=
f
> their .profile and after their custom functions in .profile that do
> something unrelated,

I did not claim such thing. I said that I *doubted* it, not that it
was most definitely the case.

> though I used to do that for a long time and
> Debian's default .bashrc loads /etc/bash_completion at the end, too.

I see. That would be troublesome indeed (if somebody chose to add the
function before that line, and not at the end), *if* somehow they used
git_completion in their scripts.

> I still maintain that namespaces are useful and we should follow the
> conventional ones when they exist. =C2=A0What is the next step?

What about this?

if ! type git_complete >/dev/null 2>&1; then
git_complete ()
{
	echo "WARNING: This function is not meant for public use; the name" \
		"might change. Use __git_complete for now."
	__git_complete "$@"
}
else
type git_complete | grep -q "WARNING" ||
echo "git_complete is already being used, please notify
git@vger.kernel.org, to" \
	"avoid overriding this function in the future."
fi

We can use that for 1.7.11, and if nobody complains remove the
warnings for 1.7.12.

--=20
=46elipe Contreras
