Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB7B8202BB
	for <e@80x24.org>; Sat, 23 Mar 2019 13:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfCWNAH (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Mar 2019 09:00:07 -0400
Received: from smtp-32.italiaonline.it ([213.209.10.32]:60251 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726909AbfCWNAH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Mar 2019 09:00:07 -0400
Received: from DESKTOP-E4U7JCE ([5.168.27.57])
        by smtp-32.iol.local with ESMTPA
        id 7gFohApdS6rc57gFoh1OPP; Sat, 23 Mar 2019 14:00:04 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1553346005; bh=Jz7apk0M9LwjuAh5DdC5Yk2WdpQRjzwzT47SBg/o/g0=;
        h=Subject:From:To:Date:In-Reply-To:References;
        b=OOQLH2NhQJws9jygnY5Tl125dKSccipdWyNlKV754jK21OL3NP/wL/9A0Ay3pqVus
         rFDpXSq8drsPj78iyYM2sZqG/csZ48l67O1KOOEwwrl6/iArjkYk9Ss67xTX4Q5TL4
         iKI6GIC+kHuyNgFsvOiSevB9W2vB2XaJgJBh5/kVTk/gvSNC39K8INA72eJG5BM0Hm
         wm5oFQ7WHgzw/TfgwuegDd8lGuxDC056e3RHawCzeaFbdlYoOLI6VwAZyPu1wHKVxj
         vUHT8ngv4JqS8ZwonOuU3ndzmYil6XULK2a4aN3eAmN33lZil96zTUELaubUQ84GOK
         mXkwBGhSjl1iw==
X-CNFS-Analysis: v=2.3 cv=d7kkNirE c=1 sm=1 tr=0
 a=Docq1LM3Rd8MKGMM10gaLw==:117 a=Docq1LM3Rd8MKGMM10gaLw==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=Dx4yW56zAAAA:8
 a=VwQbUJbxAAAA:8 a=Md6HsupoLesJ3362ms4A:9 a=QEXdDO2ut3YA:10
 a=X_u8qhY6y2Nm79co_leF:22 a=AjGcO6oz07-iQ99wixmX:22
Message-ID: <1553346004.1639.3.camel@libero.it>
Subject: Re: Semantic errors
From:   Fabio Aiuto <polinice83@libero.it>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
Date:   Sat, 23 Mar 2019 14:00:04 +0100
In-Reply-To: <001c01d4e100$a5feb610$f1fc2230$@nexbridge.com>
References: <1553195171.1436.1.camel@libero.it>
         <002901d4e01a$88bdd220$9a397660$@nexbridge.com>
         <1553196739.1436.3.camel@libero.it>
         <000501d4e029$93624940$ba26dbc0$@nexbridge.com>
         <1553289910.1481.4.camel@libero.it>
         <001301d4e0f7$c061b600$41252200$@nexbridge.com>
         <1553290862.1481.9.camel@libero.it>
         <001c01d4e100$a5feb610$f1fc2230$@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJVi7+GzdbN9A63mj5OWs8MI0y7GMrIK9LRQ+r7IaDMl8EOJM3P3CdvUsNq0Gauc1ioACWRCFyRDxwOMgqRLOlmp3pre0rYBAxpgmoYZVxQnaC1Nulce
 RMNjqTXqBxfqlg2nfVKP0Q8JdX7n1/FXVOY5P1UOwtq7BmQ58tIzJaTT5ttLcZKLP8KkK7UP86XvJ7sXM5K2V4wQSZ7jZYZhDxs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Il giorno ven, 22/03/2019 alle 18.43 -0400, Randall S. Becker ha
scritto:
> > -----Original Message-----
> > From: Fabio Aiuto <polinice83@libero.it>
> > Sent: March 22, 2019 17:41
> > To: Randall S. Becker <rsbecker@nexbridge.com>; git@vger.kernel.org
> > Subject: Re: Semantic errors
> > 
> > Il giorno ven, 22/03/2019 alle 17.39 -0400, Randall S. Becker ha
> > scritto:
> > > On March 22, 2019 17:25, Fabio Aiuto
> > > > Il giorno gio, 21/03/2019 alle 17.03 -0400, Randall S. Becker
> > > > ha
> > > > scritto:
> > > > > > Of On March 21, 2019 15:32, Fabio Aiuto wrote:
> > > > > > Il giorno gio, 21/03/2019 alle 15.16 -0400, Randall S.
> > > > > > Becker ha
> > > > > > scritto:
> > > > > > > On March 21, 2019 15:06, Fabio Aiuto wrote:
> > > > > > > > I'm browsins git code with Eclipse. I'm on a local
> > > > > > > > branch
> > > > > > > > called "studio" based on master (last public commit
> > > > > > > > e902e9b
> > > > > > > > by Junio C Hamano on Monday March 11 2019). I've built
> > > > > > > > everything by
> > > > > > > > changing:
> > > > > > > > CFLAGS = -g -Wall (removing -O2 to have smooth trace in
> > > > > > > > debugging).
> > > > > > > > But the environment detects the following semantic
> > > > > > > > errors (I
> > > > > > > > made no
> > > > > > > > edits!!!):
> > > > > > > > Description	Resource	Path	Location
> > > > > > > > Type
> > > > > > > > Symbol 'GIT_HTML_PATH' could not be resolved	git
> > > > > > > > .c
> > > > > > > > /g
> > > > > > > > it
> > > > > > > > line 154	Semantic Error
> > > > > > > > Symbol 'GIT_MAN_PATH' could not be resolved	git.
> > > > > > > > c
> > > > > > > > /gi
> > > > > > > > t
> > > > > > > > line 158	Semantic Error
> > > > > > > > Symbol 'GIT_INFO_PATH' could not be resolved	git
> > > > > > > > .c
> > > > > > > > /g
> > > > > > > > it
> > > > > > > > line 162	Semantic Error
> > > > > > > > Symbol 'active_cache' could not be resolved	comm
> > > > > > > > it.c
> > > > > > > > /git
> > > > > > > > /builtin	line 899	Semantic Error
> > > > > > > > Field 'ce_intent_to_add(active_cache[i])' could not be
> > > > > > > > resolved
> > > > > > > > commit.c	/git/builtin	line 899	Sem
> > > > > > > > anti
> > > > > > > > c
> > > > > > > > Error
> > > > > > > > Symbol 'active_nr' could not be resolved	commit.
> > > > > > > > c
> > > > > > > > /gi
> > > > > > > > t/bu
> > > > > > > > iltin	line 889	Semantic Error
> > > > > > > > Symbol 'active_nr' could not be resolved	commit.
> > > > > > > > c
> > > > > > > > /gi
> > > > > > > > t/bu
> > > > > > > > iltin	line 898	Semantic Error
> > > > > > > > Field 'oid' could not be resolved	commit.c	
> > > > > > > > /g
> > > > > > > > it/b
> > > > > > > > uilt
> > > > > > > > in
> > > > > > > > line 1654	Semantic Error
> > > > > > > > Symbol 'active_nr' could not be resolved	commit.
> > > > > > > > c
> > > > > > > > /gi
> > > > > > > > t/bu
> > > > > > > > iltin	line 901	Semantic Error
> > > > > > > > Symbol 'active_cache_tree' could not be resolved	
> > > > > > > > com
> > > > > > > > mit.
> > > > > > > > c
> > > > > > > > /git/builtin	line 1654	Semantic Error
> > > > > > > > Symbol 'active_cache_changed' could not be resolved
> > > > > > > > comm
> > > > > > > > it.c
> > > > > > > > /git/builtin	line 418	Semantic Error
> > > > > > > > Symbol 'active_cache_tree' could not be resolved	
> > > > > > > > com
> > > > > > > > mit.
> > > > > > > > c
> > > > > > > > /git/builtin	line 419	Semantic Error
> > > > > > > > Symbol 'active_nr' could not be resolved	commit.
> > > > > > > > c
> > > > > > > > /gi
> > > > > > > > t/bu
> > > > > > > > iltin	line 254	Semantic Error
> > > > > > > > Symbol 'active_cache' could not be resolved	comm
> > > > > > > > it.c
> > > > > > > > /git
> > > > > > > > /builtin	line 255	Semantic Error
> > > > > > > > 
> > > > > > > > I can debug without problems, but what if I should
> > > > > > > > trece
> > > > > > > > through one of those errors?
> > > > > > > > How can I fix them?
> > > > > > > 
> > > > > > > This situation occurs in many projects in ECLIPSE, not
> > > > > > > only
> > > > > > > git.
> > > > > > > The
> > > > > > > errors are likely coming from one of the error parsers
> > > > > > > that
> > > > > > > you have enabled in your workspace. Look in the Project
> > > > > > > Properties or Workspace Preferences under C/C++
> > > > > > > Build/Settings
> > > > > > > in the Error Parsers tab for your build configuration.
> > > > > > > You may
> > > > > > > have to turn off some of those.
> > > > > > > There is also the C/C++ General/Code Analysis Preferences
> > > > > > > setting where you might have to turn off the problematic
> > > > > > > errors. I have found that this is a common situation for
> > > > > > > code
> > > > > > > that is imported into ECLIPSE from other platforms, where
> > > > > > > the
> > > > > > > GNU error and analysis tools are overly aggressive by
> > > > > > > default.
> > > > > > > 
> > > > > > > Good luck.
> > > > > > > Randall
> > > > > > > 
> > > > > > > -- Brief whoami:
> > > > > > >  NonStop developer since approximately 211288444200000000
> > > > > > >  UNIX developer since approximately 421664400
> > > > > > > -- In my real life, I talk too much.
> > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > 
> > > > > > Thank you I tried to disable all of them, but they all
> > > > > > remain.
> > > > > > For
> > > > > > example the variable 'active_nr' is actually never
> > > > > > declared.
> > > > > > That's
> > > > > > so strange.
> > > > > > Hope to
> > > > > > solve this all soon. I'm freezed...
> > > > > 
> > > > > It is very likely in ECLIPSE either in workstation or project
> > > > > settings relating to error parsers (turn everything off). It
> > > > > still
> > > > > may be an error parser issue. One key thing... do not use
> > > > > -Wall.
> > > > > There are also settings about what to do in some error
> > > > > conditions
> > > > > configured in ECLIPSE. -Wall could be probably triggering a
> > > > > response from one of the error parsers. But the Semantic
> > > > > Error
> > > > > type is not normally from the compiler; rather, it is from
> > > > > ECLIPSE
> > > > > CDT pre- scanning the code. Anyway, check out other -W
> > > > > settings to
> > > > > disable all warnings as a start. If you are building in
> > > > > Cygwin or
> > > > > Mingw, you probably can ignore the ECLIPSE errors, especially
> > > > > if
> > > > > git actually built. If you are trying to mix a managed build
> > > > > and a
> > > > > non-managed build in the same project, you are going to be
> > > > > out of
> > > > > luck.
> > > > > 
> > > > 
> > > > If I run a make inside the git working directory, this will
> > > > just
> > > > create binaries in the working directory. But in my
> > > > home/{myname}/bin/ I have found the following files:
> > > > 
> > > > git git-cvsserver gitk git-receive-pack git-shell git-upload-
> > > > archive git-upload- pack
> > > > 
> > > > Maybe they are deployed by a make install I run accidentally (I
> > > > think that's possible). How could I clean the effect of this
> > > > accidental install?
> > > > If I don't
> > > > clean this install could I have problems in the future?
> > > 
> > > I haven't done a Windows build so I really can't help here.
> > > Anyone
> > > else able to chime in?
> > > 
> > 
> > I'm on debian stretch.
> 
> Unless /home/{yourname}/bin is on your PATH, the make install should
> not cause a problem and cleaning up from it probably is fine. I'm
> surprised there is no /home/{yourname}/share also because make
> install will move man pages into it - although you might not have all
> of the man pages installed (that is another topic and make target -
> my platform does not have a port of the Asciidoctor tool, so I can't
> build git man pages, so I use quick-install-man, which depends on
> having a clone of the man page repository that the really awesome git
> team creates). It might be helpful to specify some of the option
> defines described in the Makefile so that the install goes to the
> proper place (like /usr/local). Run 'uname -s' to figure out which
> system type config.mak.uname is going to use, and go from there.
> 
> Good luck.
> 
> Randall
> 
> -- Brief whoami:
>  NonStop developer since approximately 211288444200000000
>  UNIX developer since approximately 421664400
> -- In my real life, I talk too much.
> 
> 
> 
I found in the Makefile:

...

prefix = $(HOME)
bindir = $(prefix)/bin <--- delete the whole home/fabio/bin
mandir = $(prefix)/share/man  <--- delete 
infodir = $(prefix)/share/info <--- delete
gitexecdir = libexec/git-core <---- delete
mergetoolsdir = $(gitexecdir)/mergetools <---not present
sharedir = $(prefix)/share <--- delete
gitwebdir = $(sharedir)/gitweb <--- delete
perllibdir = $(sharedir)/perl5 <--- delete
localedir = $(sharedir)/locale <--- delete
template_dir = share/git-core/templates <--- delete
htmldir = $(prefix)/share/doc/git-doc <--- not present
ETC_GITCONFIG = $(sysconfdir)/gitconfig   <--- in my /etc there's no
gitconfig
ETC_GITATTRIBUTES = $(sysconfdir)/gitattributes <--- in my /etc there's
no gitattributes
lib = lib
# DESTDIR =
pathsep = :

bindir_relative = $(patsubst $(prefix)/%,%,$(bindir))
mandir_relative = $(patsubst $(prefix)/%,%,$(mandir))
infodir_relative = $(patsubst $(prefix)/%,%,$(infodir))
gitexecdir_relative = $(patsubst $(prefix)/%,%,$(gitexecdir))
localedir_relative = $(patsubst $(prefix)/%,%,$(localedir))
htmldir_relative = $(patsubst $(prefix)/%,%,$(htmldir))
perllibdir_relative = $(patsubst $(prefix)/%,%,$(perllibdir))

...

so by deleting all this stuff should be everything good, shouldn't it?
Please let me know if there should be anything else to know.

Thanks.

Fabio.


