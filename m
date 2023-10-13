Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC10E250E5
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 20:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6e1Vmwp"
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DD583
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 13:49:11 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-79faba5fe12so92595239f.3
        for <git@vger.kernel.org>; Fri, 13 Oct 2023 13:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697230151; x=1697834951; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kuWn3RD04pJLoURjRWqGqHUBjd4/F8MRtSRKPbS7Yno=;
        b=M6e1VmwpEIULrvNvw26pucKCjtnj1N6TpPOQt7nk0+7p2y9s2VbKZvO4bDwtClZX9k
         PM1v+Yod5p7bHlzwn9LY8G6AM4sU1lVZRAfIpw2T05XltQKe7sFlIDUSuLxbu6uSti6z
         jHCaYyf6B5akZjGhR95hGxXk5ktbT7OOQI4FwMJYyvIqfmYJZoouSE+jZ+qtEK+ZxJfG
         HX3Xxa7aA3q1qfiIBAb7u+QTobIsRXzKA11EpvNyKkrOK3AD7q0LtHJLui7p0oHs+LSc
         sXGVh4Xh4RGhMCCPXKsTFOFJafNoyNin4DetmaqaQaoiU2BFu6UuNUDRtD0wqlHUNlWe
         IG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697230151; x=1697834951;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kuWn3RD04pJLoURjRWqGqHUBjd4/F8MRtSRKPbS7Yno=;
        b=NQHp1p7stqrUoKPUpcsqKwXinm3/U58LRmuWqYjaBDN4orN+GpMbDg9wTroIXjDEzS
         tgawNdTbPxR/zQTnf98x03kLEcTdad/GyS/hFcVFlwkuN+v4/o3m1ghh8/uFQauyC2tY
         X4H4nY/JIe76ljUI3yTdwT9AdLk/bseZX0E7M631vqukcx7CEEjflAEGzMzd2Cqblsrg
         ZAtgqw49zUuyssVBJzQ7VsjJUgm6PrZ5NaqAecjppLUfcBW4ElPJVAxCUdUhqwesoCRF
         8Wd87nR42wR2yMYK9EPuPXDMOK5MxFXyLbInMq6XgIvt0gSF6oROI4o4ny0VrEYofbax
         8Zyw==
X-Gm-Message-State: AOJu0Yy8OfFKEjegrs0OyR3PozhI0Ln96NJaB8AnH+XpUHJJIOW9IZSk
	+YM5V0izeCgeHckDK36Z7ul0mwdXm4Eud556eWC1MCV1gU4=
X-Google-Smtp-Source: AGHT+IFMCfTog4QhiNQIjTAeOii7+GVKKimj07yR6O4iF09Dnz8YdJmAXcltFe6dN425n+Zb3n3SHMiVy5jPajEdZuM=
X-Received: by 2002:a92:c262:0:b0:349:927a:5d85 with SMTP id
 h2-20020a92c262000000b00349927a5d85mr36854875ild.22.1697230151051; Fri, 13
 Oct 2023 13:49:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: David Rogers <predictivestatmech@gmail.com>
Date: Fri, 13 Oct 2023 16:49:00 -0400
Message-ID: <CAEAhKry640n-mR7f_6g8TPtEt++ExMTA1K1n6x9XLFMHjCGURA@mail.gmail.com>
Subject: Re: Regarding the depreciation of ssh+git/git+ssh protocols
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Git repositories have become indispensable resources for citing parts
of a development history with links.  However, the format of git
remote entries is not always distinguishable from other types of
citation -- for example a git reference vs. a plain URL.

Rather than rely on context to tell me that `https://github.com/git/git`
refers to a git repository which I could clone with git over https, it
would be nice to use a url like `git+https://github.com/git/git`
or even
`git+https://github.com/git/git?commit=d0e8084c65cbf949038ae4cc344ac2c2efd77415`
to unambiguously specify that the type of data and its method of
access are native to git.

This issue is extremely important for version control systems which
build dependency lists from git, e.g.
https://pip.pypa.io/en/stable/topics/vcs-support/

That project lists several invented URL schemes (all beginning with
git+) and assigning special reserved characters
(https://datatracker.ietf.org/doc/html/rfc3986#section-2.2)
git+https://git.example.com/MyProject.git@master
git+https://git.example.com/MyProject.git@v1.0
git+https://git.example.com/MyProject.git@da39a3ee5e6b4b0d3255bfef95601890afd80709
git+https://git.example.com/MyProject.git@refs/pull/123/head

It would be helpful for the git project itself to define its own URL
scheme to codify these use cases and, possibly in addition, provide a
standard way to reference within git repositories.

For reference, some of the ways URLs are already used/defined within
git are documented here:
- https://github.com/git/git/blob/d0e8084c65cbf949038ae4cc344ac2c2efd77415/connect.c#L107
  (alternately, using gitweb syntax not actually available on github,
https://github.com/git/git.git/blob/d0e8084c65cbf949038ae4cc344ac2c2efd77415:/git/connect.c)
- https://mirrors.edge.kernel.org/pub/software/scm/git/docs/gitremote-helpers.html
- https://git-scm.com/docs/git-http-backend
- https://git-scm.com/docs/gitweb

Currently, a comment in connect.c notes "git+" schemes were
deprecated.  However, I would argue that at a minimum, these "git+"
schemes should be a supported and documented feature of git.  Also,
something has to be fixed (or better communicated) about URLs of the
form "git@github.com:user/project.git"  These are implicitly treated
as "git+ssh://git@github.com/user/project.git", but the use of ":" is
confusing from the perspective of translating between these two forms.

In addition, the use of paths, queries, and fragments should be
considered to allow (IMHO) at least 3 distinct uses:
1. naming commit-ish objects (and potentially metadata like author and
parents within the commit)
2. naming tree-ish objects and paths within them
3. naming blobs (and potentially fragment identifiers like lines or
HTML tags within those blobs)

These further refinements don't have to be supported by any special
functions within git.  However, their existence may influence git data
structures and api-s in the future.

The last discussion I can find of this issue on the git mailing list
(https://lore.kernel.org/git/C9Y2DPYH4XO1.3KFD8LT770P2@taiga)
indicates that defining conventions like these within git's
documentation would be a good place to start.  On a separate thread, I
will send a draft "git+" URI naming scheme for discussion and eventual
submission to IANA
(https://www.iana.org/assignments/uri-schemes/uri-schemes.xhtml).

~ David M. Rogers
