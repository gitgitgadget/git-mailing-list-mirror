Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="CjRQ7xid"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188D81A3
	for <git@vger.kernel.org>; Tue, 21 Nov 2023 06:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1700576720; x=1701181520; i=johannes.schindelin@gmx.de;
	bh=5M6busmg9QBQTceGU5KEvr2Uppc9ZKW4IadgKzTnS3I=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=CjRQ7xidz+mAiRuQevsMniZyx4KHVZQm2/eFJhaD4X/+LqwaL/LUv/Yl2nn9+J0O
	 jbLUbmPkcE/8EMIFem7+ykfGemC4XQZOPzAPwR0GE+HUdubl2qScXkn6/kEKh6FAh
	 sedHblcFaBYsWu+KmrK3/CSfzJ6zlQnp0QZx/ciAxGlLHn71DAp4mjx4u+XU1VZoj
	 NOQB8n4VYvMkSsib1BXZ5tZMNhLmFqjpCVjCvTjORl4NPh6H//b/RAjqSfWwXRoUX
	 vd2jgTm9zwYxAi1wpcsz9LAHRI4jxZ/CCLUxOaLMWzPJnr663TT3V6u3EvHlMp4ds
	 L/FMXeLqgatl7JHZig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.165]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIx3C-1qmG780gVW-00KRuw; Tue, 21
 Nov 2023 15:25:20 +0100
Date: Tue, 21 Nov 2023 15:25:18 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Todd Zullinger <tmz@pobox.com>
cc: git@vger.kernel.org, Matt Burke <spraints@gmail.com>, 
    Victoria Dye <vdye@github.com>, 
    =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>
Subject: Re: Migration of git-scm.com to a static web site: ready for
 review/testing
In-Reply-To: <ZVgoKPAg6jKZk_M6@pobox.com>
Message-ID: <1d83b8f8-b739-6277-ac4f-e7fe6ff2d2fe@gmx.de>
References: <6f7d20b4-a725-0ef9-f6d3-ff2810da9e7a@gmx.de> <ZVeUQEG5jIzKbvmT@pobox.com> <4dd9b45d-b352-d8ba-3314-96ab48f7abf7@gmx.de> <ZVgoKPAg6jKZk_M6@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1593516225-1700576720=:482"
X-Provags-ID: V03:K1:CYwI+5TWZoJ0QvLjAcH2jPE2Ukt82OKcpKmrzVxoqEWYT7QyMHa
 2gypzXXWVOE7Pae2YRXWzZtDYAYTeVYUO7LVw2eRIsrK432mQv6YCH9qsk3Zg2bO80R5F2E
 SiX+gOfIBrFuPjXl92jVL1zExBKmR2WHQh9DKeljHRPbPFSBP/q/J3nO4pYvissC0+Pd5ED
 Qh1+sE7Th+PrIkAKrAsRw==
UI-OutboundReport: notjunk:1;M01:P0:dtFPcB24opY=;CZAdxI0jFMlnBuE22lJBnAG7pQ5
 cVCUDkVSOD2OttR6finAyXJLhHDEnlM08yvGHqhtUrTTLqe1vvMNDY/JnMuJcyxRZg1i6lXvX
 9KmhUc31viCRvU/xhske7Ikb2Djd+RIEWR+wIhc0Jnx8To5CDxskwe8qorXJw0VKjC5LRl9Ld
 3fxRpaekDc8B1sN46XQoCubY9Ijg6nqjhFLq6+vDZcxWN0qTDhkUvBXH0HBr0MFNHrdw8cSNo
 Fp0kp7dyXXkengng08Pr28ptMh3LC0d+/CrTUmK8N4MvH9uo4GIAXxW9I1mAJD9zVUxYBd+fe
 K5EsLtUEq3Ay+H2QQgVawTFUy5abt4MQZp5NtfwS6lANQZitq+b92yNj63lv76OZrCEDDYfkX
 BeNZIZTjWIL7jwQXzpM4AXM464UpbuVLudS3PBeBpU1sOiHPJEL5VV8tZZwqbRV8T2IoScZAX
 J6P/3JJLKgprVeTRbubDGB53Eaj7aMRLYGcK3sSMyIhy1vpY5KljNdXb6gcMD+TfAmRsj37EN
 kaFPryqu8lDb23mxx/QmexWm/Y9UkTpAKeUt5oMOCeOmb5AQQx2/CYZPY3LUUuAYJRNWyppWH
 U6tVehKoWd0DQ5WnQEQEBtqk3yN3V0oTk8vDX11xFt2R2OTlbgFpdIycUeiOOBnu/h79VA+bw
 yhEWCHrQNtU0SVO7/M7TKrSkRZcqFZOyLNlcnnMHviw6BIqHrOLTDIpM6pZ3TACJ9OlO3yhro
 kPWjVzFqi3dQiVh99H73vn+oU+shunzxRAyV1u9g55U1dgPgI+87mpedbrIOUuWVt+zOG8gJC
 NeYNIqyLUuI1+YMb4341awxy/5ZD+vX+DCAOZUxSUprr61atDkjU0hU3iILCGMjCk2fk2wtTD
 4npiF51WKnh6b5iNnifeJkhmkKR698b1fiI9wTRMOel0f494zXFDnTbnfY2YYZNh49QB3Olxa
 MaU0Fl4k0PNpHKFlNDcRuWqvlm8=

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1593516225-1700576720=:482
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Todd,

On Fri, 17 Nov 2023, Todd Zullinger wrote:

> Johannes Schindelin wrote:
> >> For checking links, a tool like linkcheker[1] is very handy.
> >> This is run against the local docs in the Fedora package
> >> builds to catch broken links.
> >
> > Hmm, `linkchecker` is really slow for me, even locally.
>
> Yeah, it took an hour and a half to run for me, both on an
> old laptop and a fast server with plenty of threads,
> bandwidth, and memory.
>
> Checking the git HTML documentation takes under 30 seconds,
> which is largely the only place I've used it.  It has been
> very helpful in catching broken links in the docs during the
> build and the time is short enough that I never minded.

I found https://lychee.cli.rs/#/ in the meantime and figured out how to
use it in a local setup:

First, I run:

	HUGO_TIMEOUT=3D777 HUGO_BASEURL=3D HUGO_UGLYURLS=3Dfalse time hugo

The first `HUGO_*` setting is to make sure that even though I sometimes
use all of the cores of my laptop's CPU it should not fail. The other two
are to override settings from `hugo.yml` so that `lychee` can handle the
output (`lychee` will not auto-append `.html`, unlike GitHub Pages, and
would therefore mis-detect tons of broken links, without
`HUGO_UGLYURLS=3Dfalse`).

In my setup, this command typically runs for something like half a minute,
but sometimes takes for as long as 1 minute. (I noticed that it is much
slower when I open the directory in VS Code because I'm running this in
WSL and the filesystem watcher kind of eats all resources.)

After that, I run:

	time lychee --offline --exclude-mail \
	        --exclude file:///path/to/repo.git/ \
		--exclude file:///caminho/para/o/reposit%C3%B3rio.git/ \
		--exclude file:///ruta/a/repositorio.git/ \
		--exclude file:///sl%C3%B3%C3%B0/til/hirsla.git/ \
		--exclude file:///Pfad/zum/Repo.git/ \
		--exclude file:///chemin/du/d%C3%A9p%C3%B4t.git/ \
		--exclude file:///srv/git/project.git \
		--exclude "file://$PWD/public/pagefind/pagefind-ui.css" \
		--format markdown -o lychee-local.md public/

Without `--offline`, there would be a couple of broken links (the
http://git.or.cz/gitwiki/InterfacesFrontendsAndTools link leads to
"Forbidden", it needs to be changed to https://).

The `file:///` URLs are all examples that are not expected to be valid.
And we do not want to check the emails (tons of `xyz@example.com` would be
"broken").

This command typically takes another half minute, sometimes a bit longer.

Given those times and the configurability (and the lure of a GitHub
Action that could be easily integrated into a GitHub workflow:
https://github.com/marketplace/actions/lychee-broken-link-checker), I have
up on linkchecker and focused exclusively on lychee.

Now, when I started working on this on Friday, lychee reported about
12,000 broken links.

There were a couple of legitimate mistakes I made (when feeding paths to
Hugo's `relURL` function, the path must not have a leading slash or it
will remain unchanged, for example). These are fixed.

But there were also many other issues such as some manual page translation
being incomplete yet linking to not-yet-existing pages. In those cases, I
changed he code to generate redirects to the English version. For example,
https://git.github.io/git-scm.com/docs/git-clone/fr#_git has a link to
`git[1]` that _should_ lead to the French version of the `git` manual
page. However, that does not exist. So both the Rails App as well as the
static website redirect to the English variant of that page.

My most recent lychee run results in 0 broken links.

As a bonus, some of the links that are currently broken on
https://git-scm.com/ are fixed in https://git.github.io/git-scm.com/.
For example, following the `Pull Request Referl=C9=99ri` link at the top o=
f
https://git-scm.com/book/az/v2/Appendix-C:-Git-%C6%8Fmrl%C9%99ri-Plumbing-=
%C6%8Fmrl%C9%99ri/
leads to a 404. But following it in
https://git.github.io/git-scm.com/book/az/v2/Appendix-C:-Git-%C6%8Fmrl%C9%=
99ri-Plumbing-%C6%8Fmrl%C9%99ri/
directs the browser to the correct URL:
https://git.github.io/git-scm.com/book/az/v2/GitHub-Bir-Layih%C9%99nin-Sax=
lan%C4%B1lmas%C4%B1/#_pr_refs

Another thing that is broken on https://git-scm.com/ are the footnotes in
the Czech translation of the ProGit book. These were broken in the Hugo
version, too, but now they are fixed. See e.g.
https://dscho.github.io/git-scm.com/book/cs/v2/Z%C3%A1klady-pr%C3%A1ce-se-=
syst%C3%A9mem-Git-Zobrazen%C3%AD-historie-reviz%C3%AD/#_footnotedef_7
and note that the Rails App redirects to
https://git-scm.com/book/cs/v2/Z%C3%A1klady-pr%C3%A1ce-se-syst%C3%A9mem-Gi=
t-Zobrazen%C3%AD-historie-reviz%C3%AD/ch00/_footnotedef_7
when clicking on the `[7]`, which 404s.

Could you double-check that the links in the current version?

Thank you,
Johannes

--8323328-1593516225-1700576720=:482--
