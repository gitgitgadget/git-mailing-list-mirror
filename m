Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E996320248
	for <e@80x24.org>; Thu, 21 Mar 2019 19:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfCUTcX (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 15:32:23 -0400
Received: from smtp-32.italiaonline.it ([213.209.10.32]:41000 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727909AbfCUTcX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 15:32:23 -0400
Received: from DESKTOP-E4U7JCE ([158.148.82.31])
        by smtp-32.iol.local with ESMTPA
        id 73QKhvVPC6rc573QKhsBRX; Thu, 21 Mar 2019 20:32:20 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1553196740; bh=rZQyf59oz2KTnhJnx/O7j9q2jYr8ywn+lI8lfpm22Ys=;
        h=Subject:From:To:Date:In-Reply-To:References;
        b=lwp0QdVt3qPH0brJSRQjgPeQLO5sMNRJk/z/SxhfGAUDkjIREc/TfCSPRPpRNXK0h
         NY3FWB9Z9nzCLSMqMGFBDDnN6ys8OJx+Jqmsv5tc2/FNKGzdzvp4FdTAEV45Eea4FJ
         dYCI9jhHJira/VeaZ8PZOaSL8oP9lT9AJnrGKELrUO8JDbMeRKq1bSW/f+kCOkJvmY
         uSLvcBqLkPgmymv1UtXxHfL8C0usfPkRwhcBT8P40Ae+rX1luHLd5BRowmBadRW9jb
         LNGa7lAsh05yF2lKxD7LM7ladfx10ezVHjC0lLbe8EALyu+QZlaiB0fCxrbIocRwDd
         4IHq45B4l3vcw==
X-CNFS-Analysis: v=2.3 cv=d7kkNirE c=1 sm=1 tr=0
 a=Yl0R8IIxZDOUFwKtadnq+A==:117 a=Yl0R8IIxZDOUFwKtadnq+A==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=oSobMYlXyIZOgQwDuXAA:9
 a=QEXdDO2ut3YA:10
Message-ID: <1553196739.1436.3.camel@libero.it>
Subject: Re: Semantic errors
From:   Fabio Aiuto <polinice83@libero.it>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
Date:   Thu, 21 Mar 2019 20:32:19 +0100
In-Reply-To: <002901d4e01a$88bdd220$9a397660$@nexbridge.com>
References: <1553195171.1436.1.camel@libero.it>
         <002901d4e01a$88bdd220$9a397660$@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJExRJzNpHfNsG6qle58W+UOWQK8Dkt1jVC7Pk3uHvoWMWguFL+ybwnh7ZcGJZLpBxzyIeSj41LxS/OCtke1wUKfApD1r63fF1q3qEfIZudneB5yu0ju
 Y1N58UFrxT4xNhxECL5LibD924ZKNHut7POgDqSe5e9y+WvM7d14qsvm5jUxeVeyK4qZa90JDoxRa0rhxDYgIF3pdzYuvVIHU60=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Il giorno gio, 21/03/2019 alle 15.16 -0400, Randall S. Becker ha
scritto:
> On March 21, 2019 15:06, Fabio Aiuto wrote:
> > I'm browsins git code with Eclipse. I'm on a local branch called
> > "studio" based
> > on master (last public commit e902e9b by Junio C Hamano on Monday
> > March 11 2019). I've built everything by changing:
> > CFLAGS = -g -Wall (removing -O2 to have smooth trace in debugging).
> > But the environment detects the following semantic errors (I made
> > no
> > edits!!!):
> > Description	Resource	Path	Location	Type
> > Symbol 'GIT_HTML_PATH' could not be resolved	git.c	/g
> > it
> > line 154	Semantic Error
> > Symbol 'GIT_MAN_PATH' could not be resolved	git.c	/gi
> > t
> > line 158	Semantic Error
> > Symbol 'GIT_INFO_PATH' could not be resolved	git.c	/g
> > it
> > line 162	Semantic Error
> > Symbol 'active_cache' could not be resolved	commit.c	
> > /git
> > /builtin	line 899	Semantic Error
> > Field 'ce_intent_to_add(active_cache[i])' could not be resolved
> > commit.c	/git/builtin	line 899	Semantic Error
> > Symbol 'active_nr' could not be resolved	commit.c	/gi
> > t/bu
> > iltin	line 889	Semantic Error
> > Symbol 'active_nr' could not be resolved	commit.c	/gi
> > t/bu
> > iltin	line 898	Semantic Error
> > Field 'oid' could not be resolved	commit.c	/git/built
> > in
> > line 1654	Semantic Error
> > Symbol 'active_nr' could not be resolved	commit.c	/gi
> > t/bu
> > iltin	line 901	Semantic Error
> > Symbol 'active_cache_tree' could not be resolved	commit.c
> > /git/builtin	line 1654	Semantic Error
> > Symbol 'active_cache_changed' could not be resolved	commit.c
> > /git/builtin	line 418	Semantic Error
> > Symbol 'active_cache_tree' could not be resolved	commit.c
> > /git/builtin	line 419	Semantic Error
> > Symbol 'active_nr' could not be resolved	commit.c	/gi
> > t/bu
> > iltin	line 254	Semantic Error
> > Symbol 'active_cache' could not be resolved	commit.c	
> > /git
> > /builtin	line 255	Semantic Error
> > 
> > I can debug without problems, but what if I should trece through
> > one of
> > those errors?
> > How can I fix them?
> 
> This situation occurs in many projects in ECLIPSE, not only git. The
> errors are likely coming from one of the error parsers that you have
> enabled in your workspace. Look in the Project Properties or
> Workspace Preferences under C/C++ Build/Settings in the Error Parsers
> tab for your build configuration. You may have to turn off some of
> those. There is also the C/C++ General/Code Analysis Preferences
> setting where you might have to turn off the problematic errors. I
> have found that this is a common situation for code that is imported
> into ECLIPSE from other platforms, where the GNU error and analysis
> tools are overly aggressive by default.
> 
> Good luck.
> Randall
> 
> -- Brief whoami:
>  NonStop developer since approximately 211288444200000000
>  UNIX developer since approximately 421664400
> -- In my real life, I talk too much.
> 
> 
> 
Thank you I tried to disable all of them, but they all remain. For
example the variable 'active_nr' is actually never declared. That's so
strange. Hope to solve this all soon. I'm freezed...
 
