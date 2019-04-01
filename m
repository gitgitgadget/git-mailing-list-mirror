Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_HK_NAME_DR shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF5C020248
	for <e@80x24.org>; Mon,  1 Apr 2019 09:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfDAJDP convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 1 Apr 2019 05:03:15 -0400
Received: from vwp8955.webpack.hosteurope.de ([176.28.35.119]:48054 "EHLO
        vwp8955.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726425AbfDAJDP (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 1 Apr 2019 05:03:15 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]); authenticated
        by vwp8955.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1hAsqV-0003CM-6x; Mon, 01 Apr 2019 11:03:11 +0200
Received: by mail-lj1-f172.google.com with SMTP id v22so2702299lje.9
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 02:03:11 -0700 (PDT)
X-Gm-Message-State: APjAAAUtdNVC+RKG36f8XVR/sVKm1EJjRor3VOVgln/JOGi9dEcjL+uC
        J8DOb+RW+zFpOh/kR1Q2HJmDtfb8wA2Nx9OPWOM=
X-Google-Smtp-Source: APXvYqzgzpTyM9D18IdtPI8mAmX/4aS0Y28zzaB9uOcYzHDdYxxxm56IYYtMo5xkSl3uuaNZXD7VIDaW5Mh8gpcP24U=
X-Received: by 2002:a2e:9915:: with SMTP id v21mr9029319lji.154.1554109390694;
 Mon, 01 Apr 2019 02:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAKrvxcUkLcJ782xe-ETAPNWvD-zv_KXmu0VxRPvJhOGnrChVOg@mail.gmail.com>
 <CACsJy8Dz1TLpMSRNwGtvv9kBHKJsKcses+LegfOfpz2_N3eEHg@mail.gmail.com>
 <CAKrvxcWFtA7pT++pJRT1ccOwUVzqvD1o0xeXC45em__VHte6pQ@mail.gmail.com> <CACsJy8AWZLOrcDdmwKJ=x2Co56jVibVfUzaRg30gieOwwHaN_A@mail.gmail.com>
In-Reply-To: <CACsJy8AWZLOrcDdmwKJ=x2Co56jVibVfUzaRg30gieOwwHaN_A@mail.gmail.com>
From:   "Dr. Adam Nielsen" <info@drnielsen.de>
Date:   Mon, 1 Apr 2019 11:02:59 +0200
X-Gmail-Original-Message-ID: <CAKrvxcVcBEaY18pAX-eLLnh9NAgi==RZM71XufW3zyrdFmjB1A@mail.gmail.com>
Message-ID: <CAKrvxcVcBEaY18pAX-eLLnh9NAgi==RZM71XufW3zyrdFmjB1A@mail.gmail.com>
Subject: Re: Typo in the .gitignore docs?
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-bounce-key: webpack.hosteurope.de;info@drnielsen.de;1554109393;fcf47648;
X-HE-SMSGID: 1hAsqV-0003CM-6x
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Please send plain text mails. HTML mails are dropped by
> git@vger.kernel.org so other people will not see them.

Okay sorry.

>
> On Sun, Mar 31, 2019 at 6:27 PM Dr. Adam Nielsen <info@drnielsen.de> wrote:
> >
> > Thank you for your quick response.
> >
> > I will create a pull request and its probably best to continue the discussion from there:
>
> Actually if you want to reach the git development community, this is the place.

Allright.

>
> > Am So., 31. März 2019 um 11:54 Uhr schrieb Duy Nguyen <pclouds@gmail.com>:
> >>
> >> On Sun, Mar 31, 2019 at 2:53 AM Dr. Adam Nielsen <info@drnielsen.de> wrote:
> >> >
> >> > Hi everyone,
> >> >
> >> > I think there is a typo in the gitignore docs.
> >> >
> >> > Its stated on https://git-scm.com/docs/gitignore that
> >> >
> >> > >If the pattern does not contain a slash /, Git treats it as a shell
> >> > >glob pattern and checks for a match against the pathname relative to
> >> > >the location of the .gitignore file (relative to the toplevel of the
> >> > >work tree if not from a .gitignore file).
> >> >
> >> > I think that maybe two things are not 100% correct. First I think it
> >> > should be "If the pattern does contain" instead of "does not contain".
> >> > Secondly, I think it should be mentioned that this is only true for
> >> > slashes that are not a trailing slash.
> >>
> >> The trailing slash is already covered in the previous paragraph as you noticed.
> >
> >
> > If this is the purpose of the line  "it is removed for the purpose of the
> > following description" then I would highly recommend to remove that line.
> > If I am not mistaken, the line is only used for the next paragraph.
> > It also makes the paragraph where this line appears over-complicated when one reads it.
>
> I think slashes are mentioned in the next three paragraphs actually.
> Although the last one (about leading slash) is probably irrelevant,
> because a slash can't be leading and trailing at the same time (and
> the whole pattern "/" is probably seen as leading slash).

In this case I guess we may delete "it is removed for the purpose of
the following description"
so it reads like this:

>  If the pattern ends with a slash, it would only find
>  a match with a directory.

and mention the trailing slash explicitly in the two relevant paragraphs

>"If the pattern contains a slash '/' other then a trailing slash,.."

and

> "The character "`*`" matches anything except a non trailing slash "`/`". .."
>  For example, "foo/*" matches
> "foo/test.json" and "foo/bar/" but not "foo/bar/test.json".

>
> >> The "does not contain" is correct, but perhaps the wording is a bit
> >> too easy to misunderstand. If you go back to the original version of
> >> this document in cedb8d5d33 (Create a new manpage for the gitignore
> >> format, and reference it elsewhere, 2007-06-02), you can see an
> >> example of the "otherwise" part where the present of '/' will anchor
> >> the pattern to the current directory
> >>
> >> +   For example, "Documentation/\*.html" matches
> >> +   "Documentation/git.html" but not
> >> +   "Documentation/ppc/ppc.html".  A leading slash matches the
> >> +   beginning of the pathname; for example, "/*.c" matches
> >> +   "cat-file.c" but not "mozilla-sha1/sha1.c".
> >>
> >> This part was later removed by me in 2e22a85e5c (gitignore.txt:
> >> elaborate shell glob syntax, 2018-02-01). In hindsight that was a
> >> mistake since having an example seems to help clarify the description.
> >
> >
> > The latter example is still in the documentation. I think that the first
> > example is just about the paragraph for the "*". An example for the
> > paragraph about the "non-containable" slash "/" would be that
> > "Documentation/\*.html" does not match "Foo/Documentation/git.html".
> >
> >
> >>
> >>
> >> So rewording this paragraph (and keep the 'does not contain' part) to
> >> be easier to understand would be great. If you turn 'does not contain'
> >> to 'does contain' then you would need to update the 'otherwise'
> >> paragraph as well.
> >
> >
> > I do not see any change if you remove the line "Otherwise, Git
> > treats the pattern as a shell glob:". The symbols "*", "?", "[]"
> > do also work if the pattern does not contain a slash.
>
> These two paragraphs cover the "contain slash" and "not contain slash"
> cases, one for each. So if the first paragraph is updated to cover the
> 'do contain slash' then the second has to cover the other case. You
> probably see the problem here, that the current 'otherwise' paragraph
> does not really tell us more about the 'do not contain slash' case. I
> was suggesting that if we update one, we might want to clarify the
> other.
>

Oh I see. I think that this point also led to confusion. For example,
I found this quote  at
https://stackoverflow.com/a/50029706/2311074 :

>Please note that "Otherwise" starts a new bullet point hence it's not limited to the point you've quoted.
>It means "Otherwise" from all ifs from the beginning of the section "PATTERN FORMAT".

Maybe it was intended that it just belongs to the previous paragraph?

> If the pattern does not contain a slash /, Git treats it as a shell glob pattern and checks [...].
> Otherwise, Git treats the pattern as a shell glob.

Because I do not see the connection between "otherwise (contains a
slash)" and the asterix "*".

Either way, I find it difficult for the reader. I agree with you that
its good to clarify both cases.
I would then suggest to split the paragraph into two like this and
remove "Otherwise, Git treats the pattern as a shell glob" :

> If the pattern contains a slash '/' other then a trailing slash,
> it is always considered from the root. In other words, `foo/bar`
> will match `/foo/bar` but not `/bar/foo/bar`

and

> If the pattern contains no slash '/' other then a trailing slash,
> then the pattern will match in all directories. In other words,
> `foo/` will match `/bar/foo/` and `foo` will match `/bar/foo`.

> >> I think the part that trips people is the 'pathname' in 'checks for a
> >> match against the pathname relative...'. I think the key point is
> >> matching the pattern against any pathname _component_ in the path
> >> relative to the location of .gitignore. In other words '*.c' would
> >> match 'abc.c' component in 'def/abc.c'. 'def/ghi/abc.c' or 'abc.c'.
> >
> >
> > Yes, I absolutely agree, this is the key point that should be made more clear.
> >
> > I understand with "the location of the .gitignore file (relative to the
> > toplevel of the work tree if not from a .gitignore file)" the root
> > directory, or a .gitignore file that happens to be in a subdirectory.
> > So if we ignore the subdirectory case it would read to me like this :
> >
> > "If the pattern does not contain a slash , it checks for a match
> > against the pathname relative to the root". And according to this
> > I would mistakenly think that '*.c' would match '/abc.c' but not
> > '/def/abc.c'. If this is not meant, then I do not know why it is
> > mentioned in first place that it is matching the pattern "against
> > any pathname relative to...". This seems to be always the case.
>
> It's from 81c13fde37 (gitignore.5: Clarify matching rules -
> 2010-03-05). I think it's more about the 'does contain slash'. I
> dunno. Adding Jonathan maybe he remembers something.
>
> >
> >
> >>
> >>
> >> The following 'otherwise' paragraph perhaps could also elaborate a bit
> >> more, that the pattern is matched against the entire path (relative to
> >> .gitignore), not just one path component. The FNM_PATHNAME implies
> >> that (because it would not make sense otherwise) but that's just too
> >> hard to see.
> >
> >
> > That would be an option. However, since I do not the see purpose of the 'otherwise' case, I would just be clear about it in the mentioned paragraph.
> >
> >
> >>
> >>
> >> Patches are welcome.
> >
> >
> > I will create a pull request.
> >>
> >>
> >> > You find discussions about this at
> >> > https://github.com/git/git-scm.com/issues/1332 and at
> >> > https://stackoverflow.com/a/41761521/2311074
> >> >
> >> > Here is my proposal for an alternative, maybe more clear version:
> >> >
> >> > >Whenever you have a string that contains a non-trailing slash "/" , its always considered from
> >> > >the root. There is no difference between foo/bar and /foo/bar. The pattern foo/ is not
> >> > >considered from the root, because it has no non-trailing slash "/".
> >> > >One may match a path that does not start at the root by using "**" (see below).
> >> >
> >> > Also since we are on it, I would suggest to reduce
> >> >
> >> > >If the pattern ends with a slash, it is removed for the purpose of the following description, but it
> >> > >would only find a match with a directory. In other words, foo/ will match a directory foo and
> >> > >paths underneath it, but will not match a regular file or a symbolic link foo (this is consistent
> >> > >with the way how pathspec works in general in Git).
> >> >
> >> > to
> >> >
> >> > >If the pattern ends with a slash, it would only find a match with a directory. In other words, foo/
> >> > >will match a directory foo and paths underneath it, but will not match a regular file or a
> >> > >symbolic link foo.
> >> >
> >> > What do you think?
> >> >
> >> > Best regards,
> >> > Adam
> >>
> >>
> >>
> >> --
> >> Duy
> >
> >
> >> The desscription before cedb8d5d33 (in git-ls-files.txt) uses
> >> _filename_ instead of pathname, which is probably clearer:
> >>
> >> - - if it does not contain a slash '/', it is a shell glob
> >> -   pattern and used to match against the filename without
> >> -   leading directories.
> >
> >
> > Yes that seems clearer.
> >
>
>
> --
> Duy

I created a pull request at https://github.com/git/git/pull/590
where one finds the summary of the suggested changes here.

--
Adam
