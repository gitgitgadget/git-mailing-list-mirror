Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6923A1F437
	for <e@80x24.org>; Tue, 24 Jan 2017 20:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750792AbdAXUuu (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 15:50:50 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:8561 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbdAXUus (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 15:50:48 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id W81Gc4Vpn0KuvW81GcV52Y; Tue, 24 Jan 2017 20:48:46 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=RZjSMBlv c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=r77TgQKjGQsHNAKrUKIA:9 a=pGLkceISAAAA:8
 a=O0A442iYjKsDe7E5kM4A:9 a=QEXdDO2ut3YA:10 a=Nj4tdWK57Ui8eahcUu4A:9
 a=Ld372NDzu18A:10 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <7611CDDCF2C34AFDB7995938228298B4@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Stefan Hajnoczi" <stefanha@redhat.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     <git@vger.kernel.org>
References: <20170119150347.3484-1-stefanha@redhat.com> <20170119150347.3484-2-stefanha@redhat.com> <xmqqtw8u28u1.fsf@gitster.mtv.corp.google.com> <20170120135612.GB17499@stefanha-x1.localdomain> <xmqqlgu5y4u8.fsf@gitster.mtv.corp.google.com> <20170123131551.GL29186@stefanha-x1.localdomain> <f90eba2a-ebfa-67f0-68c4-abacb05759ba@gmail.com>
Subject: Re: [RFC 1/2] grep: only add delimiter if there isn't one already
Date:   Tue, 24 Jan 2017 20:48:47 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="----=_NextPart_000_0130_01D27683.427876B0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfAfxC4RXWEHwaxlpdVHz5e5OAk+pFhTTRdMZ+nRUmJsd0N8OlmSQWKafJbl7+Jlxb3XNR0FzoZ2gyI0yoR41MsvG5M02rDVhSn7JeiDhYzmlVI0fF9MW
 w1LkS0UatlCyXaaK2A9n71R1q44uv/dYitaN0cma1IjywS0x85dbtesQUBs3QlAfx1E0GtN7YqBs8mENL0zhx1SOZJJfmOfLIg6XwkyXcM/ce6KmzEmXYGto
 igmrBp9qaskZTMm91sb2Cg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0130_01D27683.427876B0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 8bit

From: "Jakub Narębski" <jnareb@gmail.com>
>W dniu 23.01.2017 o 14:15, Stefan Hajnoczi pisze:
>> On Fri, Jan 20, 2017 at 10:16:31AM -0800, Junio C Hamano wrote:
>
>>> My only piece of advice to folks who feel that way is to learn Git
>>> more and get comfortable.  You can do neat things like
>>>
>>>    $ git grep -e pattern rev -- t ':!t/helper/'
>>>
>>> that you cannot do with "rev:t", for example ;-)
>>
>> Neat, thanks for showing the path exclusion syntax.  I wasn't aware of
>> it.
>
> That reminds me of mu TODO item: moving extended pathspec information
> from gitglossary(7) manpage (sic!) to to-be-created gitpathspec(7).
>

Good to see someone else also had it on a ToDo list..

Attached is my collation of all the different path spec info I found from 
trawling the man & guide pages to satisfy my ignorance...
--
Philip 

------=_NextPart_000_0130_01D27683.427876B0
Content-Type: text/plain;
	format=flowed;
	name="gitpathspec.txt";
	reply-type=original
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="gitpathspec.txt"

gitpathspec(7)=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
NAME=0A=
----=0A=
gitpathspec - How to specify a path or file to git=0A=
=0A=
SYNOPSIS=0A=
--------=0A=
$HOME/.config/git/ignore, $GIT_DIR/info/exclude, .gitignore=0A=
=0A=
DESCRIPTION=0A=
-----------=0A=
=0A=
Pathspecs are used in a range of git functions.=0A=
.gitignore=0A=
.gitexclude=0A=
gitsparse=0A=
git-add -- pathspec=0A=
git-checkout -- pathspec (after the double-dash)=0A=
git grep (active/non-active wild card matching)=0A=
git log (L#:<> pathspec limiters ?? what does it mean)=0A=
=0A=
git rerere (uncontentious)=0A=
git status (uncontentious)=0A=
gitk (uncontentious, but see 'log' above)=0A=
'git' itself --=0A=
--literal-pathspecs=0A=
Treat pathspecs literally (i.e. no globbing, no pathspec magic). This is =
equivalent to setting the GIT_LITERAL_PATHSPECS environment variable to =
1.=0A=
=0A=
--glob-pathspecs=0A=
Add "glob" magic to all pathspec. This is equivalent to setting the =
GIT_GLOB_PATHSPECS environment variable to 1. Disabling globbing on =
individual pathspecs can be done using pathspec magic ":(literal)"=0A=
=0A=
--noglob-pathspecs=0A=
Add "literal" magic to all pathspec. This is equivalent to setting the =
GIT_NOGLOB_PATHSPECS environment variable to 1. Enabling globbing on =
individual pathspecs can be done using pathspec magic ":(glob)"=0A=
=0A=
--icase-pathspecs=0A=
Add "icase" magic to all pathspec. This is equivalent to setting the =
GIT_ICASE_PATHSPECS environment variable to 1.=0A=
=0A=
see glossary-content=0A=
pathspec=0A=
Pattern used to limit paths in Git commands.=0A=
=0A=
Pathspecs are used on the command line of "git ls-files", "git ls-tree", =
"git add", "git grep", "git diff", "git checkout", and many other =
commands to limit the scope of operations to some subset of the tree or =
worktree. See the documentation of each command for whether paths are =
relative to the current directory or toplevel. The pathspec syntax is as =
follows:=0A=
=0A=
any path matches itself=0A=
=0A=
the pathspec up to the last slash represents a directory prefix. The =
scope of that pathspec is limited to that subtree.=0A=
=0A=
the rest of the pathspec is a pattern for the remainder of the pathname. =
Paths relative to the directory prefix will be matched against that =
pattern using fnmatch(3); in particular, * and ? can match directory =
separators.=0A=
=0A=
For example, Documentation/*.jpg will match all .jpg files in the =
Documentation subtree, including Documentation/chapter_1/figure_1.jpg.=0A=
=0A=
A pathspec that begins with a colon : has special meaning. In the short =
form, the leading colon : is followed by zero or more "magic signature" =
letters (which optionally is terminated by another colon :), and the =
remainder is the pattern to match against the path. The "magic =
signature" consists of ASCII symbols that are neither alphanumeric, =
glob, regex special charaters nor colon. The optional colon that =
terminates the "magic signature" can be omitted if the pattern begins =
with a character that does not belong to "magic signature" symbol set =
and is not a colon.=0A=
=0A=
In the long form, the leading colon : is followed by a open parenthesis =
(, a comma-separated list of zero or more "magic words", and a close =
parentheses ), and the remainder is the pattern to match against the =
path.=0A=
=0A=
A pathspec with only a colon means "there is no pathspec". This form =
should not be combined with other pathspec.=0A=
=0A=
top=0A=
The magic word top (magic signature: /) makes the pattern match from the =
root of the working tree, even when you are running the command from =
inside a subdirectory.=0A=
=0A=
literal=0A=
Wildcards in the pattern such as * or ? are treated as literal =
characters.=0A=
=0A=
icase=0A=
Case insensitive match.=0A=
=0A=
glob=0A=
Git treats the pattern as a shell glob suitable for consumption by =
fnmatch(3) with the FNM_PATHNAME flag: wildcards in the pattern will not =
match a / in the pathname. For example, "Documentation/*.html" matches =
"Documentation/git.html" but not "Documentation/ppc/ppc.html" or =
"tools/perf/Documentation/perf.html".=0A=
=0A=
Two consecutive asterisks ("**") in patterns matched against full =
pathname may have special meaning:=0A=
=0A=
A leading "**" followed by a slash means match in all directories. For =
example, "**/foo" matches file or directory "foo" anywhere, the same as =
pattern "foo". "**/foo/bar" matches file or directory "bar" anywhere =
that is directly under directory "foo".=0A=
=0A=
A trailing "/**" matches everything inside. For example, "abc/**" =
matches all files inside directory "abc", relative to the location of =
the .gitignore file, with infinite depth.=0A=
=0A=
A slash followed by two consecutive asterisks then a slash matches zero =
or more directories. For example, "a/**/b" matches "a/b", "a/x/b", =
"a/x/y/b" and so on.=0A=
=0A=
Other consecutive asterisks are considered invalid.=0A=
=0A=
Glob magic is incompatible with literal magic.=0A=
=0A=
exclude=0A=
After a path matches any non-exclude pathspec, it will be run through =
all exclude pathspec (magic signature: !). If it matches, the path is =
ignored.=0A=
=0A=
Which characters to escape(\) *:\/ ??=0A=
=0A=
rooting (/*) of a path (a) $GIT_DIR (b) system root.=0A=
directory (/) terminator (D/F conflict)=0A=
=0A=
Compare with <path>; <paths>; and <file> =0A=
=0A=
[glob(7) patterns] (see grep)=0A=
=0A=
` file specifies intentionally untracked files that=0A=
Git should ignore.=0A=
Files already tracked by Git are not affected; see the NOTES=0A=
below for details.=0A=
=0A=
a `pathspec` is specified by a pattern.=0A=
When deciding whether a path matches a `pathspec` pattern, Git normally =
checks=0A=
with the following=0A=
order of precedence, from highest to lowest (within one level of=0A=
precedence, the last matching pattern decides the outcome):=0A=
=0A=
 * Patterns read from the command line for those commands that support=0A=
   them.=0A=
=0A=
 * Patterns read from a `.pathspec` file in the same directory=0A=
   as the path, or in any parent directory, with patterns in the=0A=
   higher level files (up to the toplevel of the work tree) being =
overridden=0A=
   by those in lower level files down to the directory containing the =
file.=0A=
   These patterns match relative to the location of the=0A=
   `.pathspec` file.  A project normally includes such=0A=
   `.pathspec` files in its repository, containing patterns for=0A=
   files generated as part of the project build.=0A=
=0A=
 * Patterns read from `$GIT_DIR/info/exclude`.=0A=
=0A=
 * Patterns read from the file specified by the configuration=0A=
   variable 'core.excludesfile'.=0A=
=0A=
Which file to place a pattern in depends on how the pattern is meant to=0A=
be used.=0A=
=0A=
 * Patterns which should be version-controlled and distributed to=0A=
   other repositories via clone (i.e., files that all developers will =
want=0A=
   to ignore) should go into a `.pathspec` file.=0A=
=0A=
 * Patterns which are=0A=
   specific to a particular repository but which do not need to be shared=0A=
   with other related repositories (e.g., auxiliary files that live =
inside=0A=
   the repository but are specific to one user's workflow) should go into=0A=
   the `$GIT_DIR/info/exclude` file.=0A=
=0A=
 * Patterns which a user wants Git to=0A=
   ignore in all situations (e.g., backup or temporary files generated by=0A=
   the user's editor of choice) generally go into a file specified by=0A=
   `core.excludesfile` in the user's `~/.gitconfig`. Its default value is=0A=
   $XDG_CONFIG_HOME/git/ignore. If $XDG_CONFIG_HOME is either not set or=0A=
   empty, $HOME/.config/git/ignore is used instead.=0A=
=0A=
The underlying Git plumbing tools, such as=0A=
'git ls-files' and 'git read-tree', read=0A=
`pathspec` patterns specified by command-line options, or from=0A=
files specified by command-line options.  Higher-level Git=0A=
tools, such as 'git status' and 'git add',=0A=
use patterns from the sources specified above.=0A=
=0A=
PATTERN FORMAT=0A=
--------------=0A=
=0A=
 - A blank line matches no files, so it can serve as a separator=0A=
   for readability.=0A=
=0A=
 - A line starting with # serves as a comment.=0A=
   Put a backslash ("`\`") in front of the first hash for patterns=0A=
   that begin with a hash.=0A=
=0A=
 - An optional prefix "`!`" which negates the pattern; any=0A=
   matching file excluded by a previous pattern will become=0A=
   included again. It is not possible to re-include a file if a parent=0A=
   directory of that file is excluded. Git doesn't list excluded=0A=
   directories for performance reasons, so any patterns on contained=0A=
   files have no effect, no matter where they are defined.=0A=
   Put a backslash ("`\`") in front of the first "`!`" for patterns=0A=
   that begin with a literal "`!`", for example, "`\!important!.txt`".=0A=
=0A=
 - If the pattern ends with a slash, it is removed for the=0A=
   purpose of the following description, but it would only find=0A=
   a match with a directory.  In other words, `foo/` will match a=0A=
   directory `foo` and paths underneath it, but will not match a=0A=
   regular file or a symbolic link `foo` (this is consistent=0A=
   with the way how pathspec works in general in Git).=0A=
=0A=
 - If the pattern does not contain a slash '/', Git treats it as=0A=
   a shell glob pattern and checks for a match against the=0A=
   pathname relative to the location of the `.pathspec` file=0A=
   (relative to the toplevel of the work tree if not from a=0A=
   `.pathspec` file).=0A=
=0A=
 - Otherwise, Git treats the pattern as a shell glob suitable=0A=
   for consumption by fnmatch(3) with the FNM_PATHNAME flag:=0A=
   wildcards in the pattern will not match a / in the pathname.=0A=
   For example, "Documentation/{asterisk}.html" matches=0A=
   "Documentation/git.html" but not "Documentation/ppc/ppc.html"=0A=
   or "tools/perf/Documentation/perf.html".=0A=
=0A=
 - A leading slash matches the beginning of the pathname.=0A=
   For example, "/{asterisk}.c" matches "cat-file.c" but not=0A=
   "mozilla-sha1/sha1.c".=0A=
=0A=
Two consecutive asterisks ("`**`") in patterns matched against=0A=
full pathname may have special meaning:=0A=
=0A=
 - A leading "`**`" followed by a slash means match in all=0A=
   directories. For example, "`**/foo`" matches file or directory=0A=
   "`foo`" anywhere, the same as pattern "`foo`". "`**/foo/bar`"=0A=
   matches file or directory "`bar`" anywhere that is directly=0A=
   under directory "`foo`".=0A=
=0A=
 - A trailing "`/**`" matches everything inside. For example,=0A=
   "`abc/**`" matches all files inside directory "`abc`", relative=0A=
   to the location of the `.pathspec` file, with infinite depth.=0A=
=0A=
 - A slash followed by two consecutive asterisks then a slash=0A=
   matches zero or more directories. For example, "`a/**/b`"=0A=
   matches "`a/b`", "`a/x/b`", "`a/x/y/b`" and so on.=0A=
=0A=
 - Other consecutive asterisks are considered invalid.=0A=
=0A=
NOTES=0A=
-----=0A=
=0A=
The purpose of pathspec files is to ensure that certain files=0A=
not tracked by Git remain untracked.=0A=
=0A=
To ignore uncommitted changes in a file that is already tracked,=0A=
use 'git update-index {litdd}assume-unchanged'.=0A=
=0A=
To stop tracking a file that is currently tracked, use=0A=
'git rm --cached'.=0A=
=0A=
EXAMPLES=0A=
--------=0A=
=0A=
--------------------------------------------------------------=0A=
    $ git status=0A=
    [...]=0A=
    # Untracked files:=0A=
    [...]=0A=
    #       Documentation/foo.html=0A=
    #       Documentation/pathspec.html=0A=
    #       file.o=0A=
    #       lib.a=0A=
    #       src/internal.o=0A=
    [...]=0A=
    $ cat .git/info/exclude=0A=
    # ignore objects and archives, anywhere in the tree.=0A=
    *.[oa]=0A=
    $ cat Documentation/.pathspec=0A=
    # ignore generated html files,=0A=
    *.html=0A=
    # except foo.html which is maintained by hand=0A=
    !foo.html=0A=
    $ git status=0A=
    [...]=0A=
    # Untracked files:=0A=
    [...]=0A=
    #       Documentation/foo.html=0A=
    [...]=0A=
--------------------------------------------------------------=0A=
=0A=
Another example:=0A=
=0A=
--------------------------------------------------------------=0A=
    $ cat .pathspec=0A=
    vmlinux*=0A=
    $ ls arch/foo/kernel/vm*=0A=
    arch/foo/kernel/vmlinux.lds.S=0A=
    $ echo '!/vmlinux*' >arch/foo/kernel/.pathspec=0A=
--------------------------------------------------------------=0A=
=0A=
The second .pathspec prevents Git from ignoring=0A=
`arch/foo/kernel/vmlinux.lds.S`.=0A=
=0A=
Example to exclude everything except a specific directory `foo/bar`=0A=
(note the `/*` - without the slash, the wildcard would also exclude=0A=
everything within `foo/bar`):=0A=
=0A=
--------------------------------------------------------------=0A=
    $ cat .pathspec=0A=
    # exclude everything except directory foo/bar=0A=
    /*=0A=
    !/foo=0A=
    /foo/*=0A=
    !/foo/bar=0A=
--------------------------------------------------------------=0A=
=0A=
SEE ALSO=0A=
--------=0A=
linkgit:git-rm[1],=0A=
linkgit:git-update-index[1],=0A=
linkgit:gitrepository-layout[5],=0A=
linkgit:git-check-ignore[1]=0A=
=0A=
GIT=0A=
---=0A=
Part of the linkgit:git[1] suite=0A=

------=_NextPart_000_0130_01D27683.427876B0--

