Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 497A0201A0
	for <e@80x24.org>; Thu, 11 May 2017 20:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932304AbdEKUnj (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 16:43:39 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35901 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932136AbdEKUni (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 16:43:38 -0400
Received: by mail-pf0-f179.google.com with SMTP id m17so19278096pfg.3
        for <git@vger.kernel.org>; Thu, 11 May 2017 13:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=h3Gu0y7udn/1I5TYg+75E/md7oHeUBwquye9BkHoFSg=;
        b=frd0Rrf84YdqhlogWOMZ5QM41Mn9miSZ0PcFiBSl4YMbIc6XZu5iLNDpHxl27WhPwd
         f9UrmNg+UTPt0Oa417sy5I6Qcal+vbx01lq7cMSN/FeZOdkl4T0NmprytTOQVFqn0MVU
         JoLO3qbf+Oc/hllLEVvb2kt6rQhyYWveuneN8j74wV0nDjp/WTlnxccZojDGFmXg9C9P
         0Rvo7Gsmk+w3wEf7fudLCZKgRTsSK8QFkNjNixbMXU/PyMLoyWJpxjkkjWbd3Grk/pvI
         nHjv9i9UDDx7JRFfUdL3QwoW1OADZxIm4wpV+umRTySSj6BKeCKeDvFU+tfY5BoPflCm
         7u5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=h3Gu0y7udn/1I5TYg+75E/md7oHeUBwquye9BkHoFSg=;
        b=DHWn7CFdVQ70pdN3vpjeJyWiwYZ0L8h4+nG2mc4u2mwz0hJzPBBhx+b7ebG5Y2mlK5
         Qq+123WvUGtXsl6+2Ky8X2tWUq37lCuiE+5br2YUoralQMYduMXJOdJRe93ALGyKnbdt
         Xbmb0j8HMw/+mQc58daEgCVw3d4R4VycCEPyp3cYNz9EJftSLNB9cx2kqTfLmdl96U+w
         cWroaK49FlmQMr5hXj1USPBIBlxwF/JxMRN4Zk4uaUKmVp5/VTp26M4Eb2hmFSeP2uzh
         L7fezxaAU0w5qQC5MXNwt2c9W2iVdFe7FzYV6sVzw1VjaRxF8fWWZp7UzJuhiR4ICj4Q
         oNAw==
X-Gm-Message-State: AODbwcAKuFwnGQLdPrzcr+a9UMGtLuiGcDZXk8ikTLMic1o2u+ryYnZ3
        QFMsUY5uhVUS+dq/
X-Received: by 10.84.236.79 with SMTP id h15mr574910pln.110.1494535417289;
        Thu, 11 May 2017 13:43:37 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:938:3d1d:44aa:d816])
        by smtp.gmail.com with ESMTPSA id 134sm1412797pgh.43.2017.05.11.13.43.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 13:43:36 -0700 (PDT)
Date:   Thu, 11 May 2017 13:43:34 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH 28/29] grep: given --threads with NO_PTHREADS=YesPlease,
 warn
Message-ID: <20170511204334.GM83655@google.com>
References: <20170511091829.5634-1-avarab@gmail.com>
 <20170511091829.5634-29-avarab@gmail.com>
 <20170511202131.GK83655@google.com>
 <CACBZZX5-oDsMh08KNiEp8mDbCH06ROozc7sekts4BRsm-dTOwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX5-oDsMh08KNiEp8mDbCH06ROozc7sekts4BRsm-dTOwg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/11, Ævar Arnfjörð Bjarmason wrote:
> On Thu, May 11, 2017 at 10:21 PM, Brandon Williams <bmwill@google.com> wrote:
> > On 05/11, Ævar Arnfjörð Bjarmason wrote:
> >> Add a warning about missing thread support when grep.threads or
> >> --threads is set to a non 0 (default) or 1 (no parallelism) value
> >> under NO_PTHREADS=YesPlease.
> >>
> >> This is for consistency with the index-pack & pack-objects commands,
> >> which also take a --threads option & are configurable via
> >> pack.threads, and have long warned about the same under
> >> NO_PTHREADS=YesPlease.
> >>
> >> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> >> ---
> >>  builtin/grep.c  | 11 +++++++++++
> >>  t/t7810-grep.sh | 18 ++++++++++++++++++
> >>  2 files changed, 29 insertions(+)
> >>
> >> diff --git a/builtin/grep.c b/builtin/grep.c
> >> index 1c0adb30f3..f4e08dd2b6 100644
> >> --- a/builtin/grep.c
> >> +++ b/builtin/grep.c
> >> @@ -289,6 +289,15 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
> >>               if (num_threads < 0)
> >>                       die(_("invalid number of threads specified (%d) for %s"),
> >>                           num_threads, var);
> >> +#ifdef NO_PTHREADS
> >> +             else if (num_threads && num_threads != 1) {
> >> +                     /* TRANSLATORS: %s is the configuration
> >> +                        variable for tweaking threads, currently
> >> +                        grep.threads */
> >
> > nit: this comment isn't formatted properly:
> >   /*
> >    * ... comment ...
> >    */
> 
> Comments for translators use a different style, see cbcfd4e3ea ("i18n:
> mention "TRANSLATORS:" marker in Documentation/CodingGuidelines",
> 2014-04-18). Otherwise the "*" gets interpolated into the string the
> translators see in their UI.
> 

Ah got it, I wasn't aware of that.

> >> +                     warning(_("no threads support, ignoring %s"), var);
> >> +                     num_threads = 0;
> >> +             }
> >> +#endif
> >>       }
> >>
> >>       return st;
> >> @@ -1233,6 +1242,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
> >>       else if (num_threads < 0)
> >>               die(_("invalid number of threads specified (%d)"), num_threads);
> >>  #else
> >> +     if (num_threads)
> >> +             warning(_("no threads support, ignoring --threads"));
> >>       num_threads = 0;
> >>  #endif
> >>
> >> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> >> index 561709ef6a..f106387820 100755
> >> --- a/t/t7810-grep.sh
> >> +++ b/t/t7810-grep.sh
> >> @@ -791,6 +791,24 @@ do
> >>       "
> >>  done
> >>
> >> +test_expect_success !PTHREADS,C_LOCALE_OUTPUT 'grep --threads=N or pack.threads=N warns when no pthreads' '
> >> +     git grep --threads=2 Hello hello_world 2>err &&
> >> +     grep ^warning: err >warnings &&
> >> +     test_line_count = 1 warnings &&
> >> +     grep -F "no threads support, ignoring --threads" err &&
> >> +     git -c grep.threads=2 grep Hello hello_world 2>err &&
> >> +     grep ^warning: err >warnings &&
> >> +     test_line_count = 1 warnings &&
> >> +     grep -F "no threads support, ignoring grep.threads" err &&
> >> +     git -c grep.threads=2 grep --threads=4 Hello hello_world 2>err &&
> >> +     grep ^warning: err >warnings &&
> >> +     test_line_count = 2 warnings &&
> >> +     grep -F "no threads support, ignoring --threads" err &&
> >> +     grep -F "no threads support, ignoring grep.threads" err &&
> >> +     git -c grep.threads=0 grep --threads=0 Hello hello_world 2>err &&
> >> +     test_line_count = 0 err
> >> +'
> >> +
> >
> > Same bit about doing the correct checks on the error strings to account
> > for translation.
> 
> Do you mean why not use test_i18ngrep? The test is guarded by
> C_LOCALE_OUTPUT which does the same thing, the whole thing is testing
> output so no point in doing just parts of it IMO, unlike some other
> tests that just end in "let's compare the output" but actually test
> other stuff.
> 
> I could e.g. test that there's something on stderr under poison, but
> no point in doing so.

Fair enough, and I didn't notice the C_LOCALE_OUTPUT.

> 
> >>  test_expect_success 'grep from a subdirectory to search wider area (1)' '
> >>       mkdir -p s &&
> >>       (
> >> --
> >> 2.11.0
> >>
> >
> > --
> > Brandon Williams

-- 
Brandon Williams
