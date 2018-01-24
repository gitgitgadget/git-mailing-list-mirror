Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 163371FADF
	for <e@80x24.org>; Wed, 24 Jan 2018 21:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932659AbeAXVtF (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 16:49:05 -0500
Received: from sonic309-24.consmr.mail.gq1.yahoo.com ([98.137.65.150]:45070
        "EHLO sonic309-24.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932474AbeAXVtE (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 24 Jan 2018 16:49:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1516830544; bh=mh5io2K8ebwRO6NkKf8kFVYjOXDNZBWPgi/TnlojiDE=; h=From:To:Cc:References:In-Reply-To:Subject:Date:From:Subject; b=HisCw6ya7Bo1PRxkUSKnmG2jdGEkIilSWQi14w+x27uDDGxcR7xladNKmbxBefCa3JS2wc8gDchgSA4UJKElnc8ZkWyKFUhsN23CKxjOlSYn7Nb060RLGPlkvX3TxO77mvT+nKY0v74qTx1v9NdPKWRwMkKluu/4ZQms31npMxKxE3m1NWWRaGVZFRubs1AzZXa/QoxwxvHf2gdCx+S/pz1fbq0mhwOF/tXDNaDRJ6ZEy6eAXak5FhVp2Ar9oxoY7VnyZA3BEKHCZp7PmXe9uqKVxw1Pbij0it9PhdPEq7OiuyFWb0PtFBoErIkP9DVGSSO0pVg9OT1wAHTTT+qiTQ==
X-YMail-OSG: fbohut4VM1kP6T6TrOttgpa2UUiWVAUOCHL9sv.D5ReOTcwalre.zM4.v9yyBD0
 FKERu0kP07dFPN04fUA5jQBnnd7FCdELpTgUgjY1ids9pU.IXDSmzFAI_g8wxyXTrRnIhRXFjiVK
 UDYJPZ.DLhJWG3lwBYpXrW8wFSTkbIWjFfy7gQlAn29N8ERr62VT4GQLT2D78ET8B02wraNDG7Rz
 qvmQJGEs2NJCiSWOpz7c4P0UK.t6ClN.kWMqAPM9ianKX6.xscHqU9gxHKcVbnB4JjIe.8k38m3S
 .N5cVWJ3BMOWKGJtKezX2sXF3EfDUSJNN6N4gawYPUoN8AdUaIIBDZjZk1x6_f4eNGw7UH10dDDS
 h3SEAsrHCor7B.9ia4kv7h4ASEP.ymVju4dCR8vCSggc.DmB4DlT1bHBzaru15_nZPO3.h8sMxGx
 CZZTqyIqEdYnUCuKDA5O3bt.H69bwSB4vOF9QyOBT52fPbRUKKW8WeOuhaVjvWl4egemjjFV79Fz
 PCxc7YEpknzqOq_3PQqtd_ishWkTzPNxjHe26wwFYzDkFxtOamg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Wed, 24 Jan 2018 21:49:04 +0000
Received: from smtpgate101.mail.gq1.yahoo.com (EHLO gnash) ([10.214.169.33])
          by smtp407.mail.gq1.yahoo.com (JAMES SMTP Server ) with ESMTPA ID 8152052dc0b9d039a807bcfb8cad6b44;
          Wed, 24 Jan 2018 21:49:03 +0000 (UTC)
From:   <randall.s.becker@rogers.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>,
        "'Randall S. Becker'" <rsbecker@nexbridge.com>
References: <20180121234203.13764-1-randall.s.becker@rogers.com>        <20180121234203.13764-3-randall.s.becker@rogers.com> <xmqqvafrara6.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqvafrara6.fsf@gitster.mtv.corp.google.com>
Subject: RE: [PATCH v4 2/4] Define config options required for the HPE NonStop NSX and NSE platforms
Date:   Wed, 24 Jan 2018 16:49:00 -0500
Message-ID: <003e01d3955d$25c3ea50$714bbef0$@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQG+M0yL6q6MsDdNM8SZpgZC9eG5XQFtOM4sAr5/mpSjjPT1YA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 24, 2018 4:19 PM, Junio C Hamano wrote:
> 
> randall.s.becker@rogers.com writes:
> 
> > From: "Randall S. Becker" <rsbecker@nexbridge.com>
> >
> > Upgrade old options in config.mak.uname to currently supported NonStop
> > operating system versions (J06.21 and L17.xx).
> >
> > Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> > ---
> >  config.mak.uname | 29 +++++++++++++++++++++--------
> >  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> The "tar extraction option" thing in 1/4 is not something you use here?
Not
> complaining---I am merely trying to use this as one data point to help me
> assess/guess what 1/4 is about ;-)

The define is used only in my team's distribution engine and we are planning
to override the define as part of our Jenkins build of git. We do not expect
anyone else who clones git and builds on the platform to use this
capability. As a result, I did not want it to be defaulted as "ov", which is
our setting.

> 
> >
> > diff --git a/config.mak.uname b/config.mak.uname index
> > 685a80d13..d9f8d57e3 100644
> > --- a/config.mak.uname
> > +++ b/config.mak.uname
> > @@ -428,27 +428,37 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
> >  	# INLINE='' would just replace one set of warnings with another and
> >  	# still not compile in c89 mode, due to non-const array
initializations.
> >  	CC = cc -c99
> > +	# Build down-rev compatible objects that don't use our new
> getopt_long.
> > +	ifeq ($(uname_R).$(uname_V),J06.21)
> > +		CC += -WRVU=J06.20
> > +	endif
> > +	ifeq ($(uname_R).$(uname_V),L17.02)
> > +		CC += -WRVU=L16.05
> > +	endif
> >  	# Disable all optimization, seems to result in bad code, with -O or
-O2
> >  	# or even -O1 (default),
/usr/local/libexec/git-core/git-pack-objects
> >  	# abends on "git push". Needs more investigation.
> > -	CFLAGS = -g -O0
> > +	CFLAGS = -g -O0 -Winline
> >  	# We'd want it to be here.
> >  	prefix = /usr/local
> >  	# Our's are in ${prefix}/bin (perl might also be in /usr/bin/perl).
> > -	PERL_PATH = ${prefix}/bin/perl
> > -	PYTHON_PATH = ${prefix}/bin/python
> > -
> > +	PERL_PATH = /usr/bin/perl
> > +	PYTHON_PATH = /usr/bin/python
> > +	RM = /bin/rm -f
> >  	# As detected by './configure'.
> >  	# Missdetected, hence commented out, see below.
> >  	#NO_CURL = YesPlease
> >  	# Added manually, see above.
> >  	NEEDS_SSL_WITH_CURL = YesPlease
> > +	NEEDS_CRYPTO_WITH_SSL = YesPlease
> > +	HAVE_DEV_TTY = YesPlease
> >  	HAVE_LIBCHARSET_H = YesPlease
> >  	HAVE_STRINGS_H = YesPlease
> >  	NEEDS_LIBICONV = YesPlease
> >  	NEEDS_LIBINTL_BEFORE_LIBICONV = YesPlease
> >  	NO_SYS_SELECT_H = UnfortunatelyYes
> >  	NO_D_TYPE_IN_DIRENT = YesPlease
> > +	NO_GETTEXT = YesPlease
> >  	NO_HSTRERROR = YesPlease
> >  	NO_STRCASESTR = YesPlease
> >  	NO_MEMMEM = YesPlease
> > @@ -458,8 +468,13 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
> >  	NO_MKDTEMP = YesPlease
> >  	# Currently libiconv-1.9.1.
> >  	OLD_ICONV = UnfortunatelyYes
> > -	NO_REGEX = YesPlease
> > +	NO_REGEX=NeedsStartEnd
> >  	NO_PTHREADS = UnfortunatelyYes
> > +	ifdef NO_PTHREADS
> > +	else # WIP, use Posix User Threads
> > +		PTHREAD_CFLAGS = -D_PUT_MODEL_ -I/usr/include
> > +		PTHREAD_LIBS = -lput
> > +	endif
> >
> >  	# Not detected (nor checked for) by './configure'.
> >  	# We don't have SA_RESTART on NonStop, unfortunalety.
> > @@ -477,9 +492,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
> >  	# RFE 10-120912-4693 submitted to HP NonStop development.
> >  	NO_SETITIMER = UnfortunatelyYes
> >  	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin
> > -	SHELL_PATH = /usr/local/bin/bash
> > -	# as of H06.25/J06.14, we might better use this
> > -	#SHELL_PATH = /usr/coreutils/bin/bash
> > +	SHELL_PATH = /usr/coreutils/bin/bash
> >  endif
> >  ifneq (,$(findstring MINGW,$(uname_S)))
> >  	pathsep = ;

