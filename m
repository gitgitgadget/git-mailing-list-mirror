Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C759520248
	for <e@80x24.org>; Fri, 22 Mar 2019 21:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfCVVkD (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 17:40:03 -0400
Received: from smtp-32.italiaonline.it ([213.209.10.32]:51260 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726014AbfCVVkD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 17:40:03 -0400
Received: from DESKTOP-E4U7JCE ([5.168.27.57])
        by smtp-32.iol.local with ESMTPA
        id 7RtPh6Hp56rc57RtPhykzg; Fri, 22 Mar 2019 22:39:59 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1553290799; bh=+YjYd/S/++fFJ4r0lMrlgIfXjoeks7yRZANYwd1iRzA=;
        h=Subject:From:To:Date:In-Reply-To:References;
        b=VZNRXSZa+IA3pJo/049VTJs+BusQ70PAPTT8UQOYpl522/ygCvP5gFhQNDDsZFTAK
         Uej9fywD4vUwx03lkOf60pcWS694gb8h4lTJ3yiFqUCKXHdsl5v2plQofv4+FV9L8O
         sRWd92swDMcvWkPT5AZ/ZVxzhiihIJ3Uc5BH3RNbPbXuTaJ5HNdVxJMHICFourSLLF
         yN4gEz7KS/Ovy0I7YEgrqFnHte6u9iEtQXaOnaN5tIMtA+mjLpbQEIbD7MfbAVy0SR
         VmND74GagltyF187MUayiw13w6Jv9pxHlRO65aLo66t+dL1yjNW3FGLtUvHQNLvM3g
         1Xyz7hwEScXVg==
X-CNFS-Analysis: v=2.3 cv=d7kkNirE c=1 sm=1 tr=0
 a=Docq1LM3Rd8MKGMM10gaLw==:117 a=Docq1LM3Rd8MKGMM10gaLw==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=2vAzgKwAbVjCmzCD_Z0A:9
 a=QEXdDO2ut3YA:10
Message-ID: <1553290798.1481.8.camel@libero.it>
Subject: Re: Semantic errors
From:   Fabio Aiuto <polinice83@libero.it>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
Date:   Fri, 22 Mar 2019 22:39:58 +0100
In-Reply-To: <1553289910.1481.4.camel@libero.it>
References: <1553195171.1436.1.camel@libero.it>
         <002901d4e01a$88bdd220$9a397660$@nexbridge.com>
         <1553196739.1436.3.camel@libero.it>
         <000501d4e029$93624940$ba26dbc0$@nexbridge.com>
         <1553289910.1481.4.camel@libero.it>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJAocwz+yo90asWPXyitHLUJ3kZaprsiHoXGQTMYOaBaG/OSY21FwItwN4rLZoXv1p53bqJ+4exzEp2P515rh8ft85X0Bog4kZWJC7Ny2wBov/jD1PvU
 Ezt82T7QwZWFoN6Pb2XAI6xnY95rFTayBjcYDWkYUXoLoIHF2tbQmcFoSh3OkzailXub9zHHaG+s8QszFXhCciTRN2BYdMugVg4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Il giorno ven, 22/03/2019 alle 22.25 +0100, Fabio Aiuto ha scritto:
> Il giorno gio, 21/03/2019 alle 17.03 -0400, Randall S. Becker ha
> scritto:
> > > Of On March 21, 2019 15:32, Fabio Aiuto wrote:
> > > Il giorno gio, 21/03/2019 alle 15.16 -0400, Randall S. Becker ha
> > > scritto:
> > > > On March 21, 2019 15:06, Fabio Aiuto wrote:
> > > > > I'm browsins git code with Eclipse. I'm on a local branch
> > > > > called
> > > > > "studio" based on master (last public commit e902e9b by Junio
> > > > > C
> > > > > Hamano on Monday March 11 2019). I've built everything by
> > > > > changing:
> > > > > CFLAGS = -g -Wall (removing -O2 to have smooth trace in
> > > > > debugging).
> > > > > But the environment detects the following semantic errors (I
> > > > > made no
> > > > > edits!!!):
> > > > > Description	Resource	Path	Location	
> > > > > Type
> > > > > Symbol 'GIT_HTML_PATH' could not be resolved	git.c	
> > > > > /g
> > > > > it
> > > > > line 154	Semantic Error
> > > > > Symbol 'GIT_MAN_PATH' could not be resolved	git.c	
> > > > > /gi
> > > > > t
> > > > > line 158	Semantic Error
> > > > > Symbol 'GIT_INFO_PATH' could not be resolved	git.c	
> > > > > /g
> > > > > it
> > > > > line 162	Semantic Error
> > > > > Symbol 'active_cache' could not be resolved	commit.c
> > > > > /git
> > > > > /builtin	line 899	Semantic Error
> > > > > Field 'ce_intent_to_add(active_cache[i])' could not be
> > > > > resolved
> > > > > commit.c	/git/builtin	line 899	Semantic
> > > > > Error
> > > > > Symbol 'active_nr' could not be resolved	commit.c	
> > > > > /gi
> > > > > t/bu
> > > > > iltin	line 889	Semantic Error
> > > > > Symbol 'active_nr' could not be resolved	commit.c	
> > > > > /gi
> > > > > t/bu
> > > > > iltin	line 898	Semantic Error
> > > > > Field 'oid' could not be resolved	commit.c	/git
> > > > > /b
> > > > > uilt
> > > > > in
> > > > > line 1654	Semantic Error
> > > > > Symbol 'active_nr' could not be resolved	commit.c	
> > > > > /gi
> > > > > t/bu
> > > > > iltin	line 901	Semantic Error
> > > > > Symbol 'active_cache_tree' could not be resolved	commi
> > > > > t.
> > > > > c
> > > > > /git/builtin	line 1654	Semantic Error
> > > > > Symbol 'active_cache_changed' could not be resolved	co
> > > > > mm
> > > > > it.c
> > > > > /git/builtin	line 418	Semantic Error
> > > > > Symbol 'active_cache_tree' could not be resolved	commi
> > > > > t.
> > > > > c
> > > > > /git/builtin	line 419	Semantic Error
> > > > > Symbol 'active_nr' could not be resolved	commit.c	
> > > > > /gi
> > > > > t/bu
> > > > > iltin	line 254	Semantic Error
> > > > > Symbol 'active_cache' could not be resolved	commit.c
> > > > > /git
> > > > > /builtin	line 255	Semantic Error
> > > > > 
> > > > > I can debug without problems, but what if I should trece
> > > > > through one
> > > > > of those errors?
> > > > > How can I fix them?
> > > > 
> > > > This situation occurs in many projects in ECLIPSE, not only
> > > > git.
> > > > The
> > > > errors are likely coming from one of the error parsers that you
> > > > have
> > > > enabled in your workspace. Look in the Project Properties or
> > > > Workspace
> > > > Preferences under C/C++ Build/Settings in the Error Parsers tab
> > > > for
> > > > your build configuration. You may have to turn off some of
> > > > those.
> > > > There is also the C/C++ General/Code Analysis Preferences
> > > > setting
> > > > where you might have to turn off the problematic errors. I have
> > > > found
> > > > that this is a common situation for code that is imported into
> > > > ECLIPSE
> > > > from other platforms, where the GNU error and analysis tools
> > > > are
> > > > overly aggressive by default.
> > > > 
> > > > Good luck.
> > > > Randall
> > > > 
> > > > -- Brief whoami:
> > > >  NonStop developer since approximately 211288444200000000
> > > >  UNIX developer since approximately 421664400
> > > > -- In my real life, I talk too much.
> > > > 
> > > > 
> > > > 
> > > 
> > > Thank you I tried to disable all of them, but they all remain.
> > > For
> > > example the
> > > variable 'active_nr' is actually never declared. That's so
> > > strange.
> > > Hope to
> > > solve this all soon. I'm freezed...
> > 
> > It is very likely in ECLIPSE either in workstation or project
> > settings relating to error parsers (turn everything off). It still
> > may be an error parser issue. One key thing... do not use -Wall.
> > There are also settings about what to do in some error conditions
> > configured in ECLIPSE. -Wall could be probably triggering a
> > response
> > from one of the error parsers. But the Semantic Error type is not
> > normally from the compiler; rather, it is from ECLIPSE CDT pre-
> > scanning the code. Anyway, check out other -W settings to disable
> > all
> > warnings as a start. If you are building in Cygwin or Mingw, you
> > probably can ignore the ECLIPSE errors, especially if git actually
> > built. If you are trying to mix a managed build and a non-managed
> > build in the same project, you are going to be out of luck.
> > 
> 
> If I run a make inside the git working directory, this will just
> create
> binaries in the working directory. But in my home/{myname}/bin/ I
> have
> found the following files:
> 
> git git-cvsserver gitk git-receive-pack git-shell git-upload-archive
> git-upload-pack
> 
> Maybe they are deployed by a make install I run accidentally (I think
> that's possible). How could I clean the effect of this accidental
> install? If I don't clean this install could I have problems in the
> future?
> 
> Thank you folks!!!
> 
> Fabio.
> 
> 
Sorry the latter was another thread, I sent a specific mail to the
community. Thank you Randall for your help.
Fabio.
