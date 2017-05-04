Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04CC0207D6
	for <e@80x24.org>; Thu,  4 May 2017 14:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754427AbdEDO1L (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 10:27:11 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34038 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbdEDO0u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 10:26:50 -0400
Received: by mail-wr0-f193.google.com with SMTP id 6so1619788wrb.1
        for <git@vger.kernel.org>; Thu, 04 May 2017 07:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QRS8FnWq+SvP2kvqF6TQ/lpB7Ufd6g7ziYmH9m0oHHg=;
        b=S8RqA7lCQIF8dTCeaB2lQIfoOtiRxbmNCc3Ul2obbC4j6BbCutM9WRHGDWP7bYxIuU
         zpwviWc5olAsrGz1DHKepRSCtthjYlJKdEbJwfW6MSRygMpn3XHDah4Ssu8mNMHP7QrI
         kq9kKlIM/6jRS3I7iTwvdNit41BAqKC8ymu50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QRS8FnWq+SvP2kvqF6TQ/lpB7Ufd6g7ziYmH9m0oHHg=;
        b=jYMdPgj2npE2GbYI6Vi5uJDnAYRob5xX1Ng+fHE6ArPiubhr0Kfop7ruCycJyQcR0n
         +MH+H6y9KISinHXKcpD4aKBvy3G+djdwXprywAgPt/9OAXAfpMj1HDtpIqo5HNNoMRnu
         RMk4zq+L0K+y1w6OIzOpFfsMN+P4OS29VxzKcOnEMEsv0BGyP29sdS2kmtQ2woHcUsDb
         1sxECl0wOtRccrph3cLdDxQXo4hR1BOYJWO+Ww2cScgnPF3HZq5p+KL3J9LhNdNGMJwd
         cQPM1T5gn5jMi4y6oymu3gditlxBAThXcg/lQ6TSZCtTXYYC9N02W825SamxUaj8JkrB
         oFzQ==
X-Gm-Message-State: AN3rC/7t6s+62PIAbK6oVIqfr2fFZstDUXafTZSpJhWmRm7AfQDOZQLs
        wX64S3tl6QZnV7oN/hY=
X-Received: by 10.223.163.222 with SMTP id m30mr31581948wrb.24.1493908008485;
        Thu, 04 May 2017 07:26:48 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id a197sm1589266wma.1.2017.05.04.07.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 May 2017 07:26:47 -0700 (PDT)
Date:   Thu, 4 May 2017 15:26:45 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Devin Lehmacher <lehmacdj@gmail.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git v2.13.0-rc0 test failures on cygwin
Message-ID: <20170504142645.GC3238@dinwoodie.org>
References: <bf7db655-d90f-e711-afc8-6565b71373d2@ramsayjones.plus.com>
 <CA+kUOanMdez0Gu1z=bULMm0vMnFx8p12nt-e7v5LvyAiLu_45Q@mail.gmail.com>
 <20170428192020.GA17052@mango1>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20170428192020.GA17052@mango1>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 28, 2017 at 03:20:21PM -0400, Devin Lehmacher wrote:
> > > Test Summary Report
> > > -------------------
> > > t0301-credential-cache.sh                        (Wstat: 256 Tests: 29 Failed: 6)
> > >   Failed tests:  12, 24-28
> > >   Non-zero exit status: 1
> >
> > Confirmed I'm seeing this on v2.13.0-rc1, and this passed in v2.12.2.
> > `git bisect` tells me this failure was introduced by commit
> > v2.12.0-267-g612c49e94, added by Devin Lehmacher (added to the CC
> > list).
> 
> Can someone with cygwin check that `test -S` works on cygwin?

Seems to work for me, using both Bash's built-in `test` and `/bin/test`:

    $ socat UNIX-LISTEN:socket-file LISTEN:socket-file &
    [1] 2976

    $ ls -l socket-file
    srw-r--r-- 1 add Domain Users 0 May  4 15:08 socket-file

    $ type test
    test is a shell builtin

    $ test -S socket-file && echo success
    success

    $ /bin/test -S socket-file && echo success
    success

    $ touch regular-file

    $ test -S regular-file && echo success

    $ /bin/test -S regular-file && echo success

    $ test -S non-existant-file && echo success

    $ /bin/test -S non-existant-file && echo success

> I'll also take a look at verbose test output (maybe with a trace too)
> for t0301 if someone sends me that.

The verbose t0301.12 output is below; the verbose test output from the other
failing tests is more-or-less identical.  I've attached the full trace
output, too: it looks like the fatal error below is on the `git
credential-cache exit` commands.

    fatal: read error from cache daemon: Connection reset by peer
    not ok 12 - socket defaults to ~/.cache/git/credential/socket
    #
    #               test_when_finished "
    #                       git credential-cache exit &&
    #                       rmdir -p .cache/git/credential/
    #               " &&
    #               test_path_is_missing "$HOME/.git-credential-cache" &&
    #               test -S "$HOME/.cache/git/credential/socket"
    #

This specific output came from v2.13.0-rc1 on an up-to-date 64-bit
Cygwin installation.  I'm happy to experiment with other build options /
patches / environments / &c. if that would be useful.

Adam

--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="t0301-trace-output.log"

Initialized empty Git repository in /home/add/vcs/cygwin/git/git-2.13.0-rc1-1.x86_64/build/t/trash directory.t0301-credential-cache/.git/
expecting success: 
		check fill $HELPER <<-\EOF
		protocol=https
		host=example.com
		--
		protocol=https
		host=example.com
		username=askpass-username
		password=askpass-password
		--
		askpass: Username for 'https://example.com':
		askpass: Password for 'https://askpass-username@example.com':
		EOF
	
++ check fill cache
++ credential_opts=
++ credential_cmd=fill
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=askpass-username
++ read line
++ case "$line" in
++ echo password=askpass-password
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo 'askpass: Username for '\''https://example.com'\'':'
++ read line
++ case "$line" in
++ echo 'askpass: Password for '\''https://askpass-username@example.com'\'':'
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential fill <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential fill
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 1 - helper (cache) has no existing data

expecting success: 
		check approve $HELPER <<-\EOF
		protocol=https
		host=example.com
		username=store-user
		password=store-pass
		EOF
	
++ check approve cache
++ credential_opts=
++ credential_cmd=approve
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=store-user
++ read line
++ case "$line" in
++ echo password=store-pass
++ read line
++ read_chunk
++ read line
++ read_chunk
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential approve <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential approve
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 2 - helper (cache) stores password

expecting success: 
		check fill $HELPER <<-\EOF
		protocol=https
		host=example.com
		--
		protocol=https
		host=example.com
		username=store-user
		password=store-pass
		--
		EOF
	
++ check fill cache
++ credential_opts=
++ credential_cmd=fill
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=store-user
++ read line
++ case "$line" in
++ echo password=store-pass
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential fill <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential fill
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 3 - helper (cache) can retrieve password

expecting success: 
		check fill $HELPER <<-\EOF
		protocol=http
		host=example.com
		--
		protocol=http
		host=example.com
		username=askpass-username
		password=askpass-password
		--
		askpass: Username for 'http://example.com':
		askpass: Password for 'http://askpass-username@example.com':
		EOF
	
++ check fill cache
++ credential_opts=
++ credential_cmd=fill
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=http
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=http
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=askpass-username
++ read line
++ case "$line" in
++ echo password=askpass-password
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo 'askpass: Username for '\''http://example.com'\'':'
++ read line
++ case "$line" in
++ echo 'askpass: Password for '\''http://askpass-username@example.com'\'':'
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential fill <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential fill
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 4 - helper (cache) requires matching protocol

expecting success: 
		check fill $HELPER <<-\EOF
		protocol=https
		host=other.tld
		--
		protocol=https
		host=other.tld
		username=askpass-username
		password=askpass-password
		--
		askpass: Username for 'https://other.tld':
		askpass: Password for 'https://askpass-username@other.tld':
		EOF
	
++ check fill cache
++ credential_opts=
++ credential_cmd=fill
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=other.tld
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=other.tld
++ read line
++ case "$line" in
++ echo username=askpass-username
++ read line
++ case "$line" in
++ echo password=askpass-password
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo 'askpass: Username for '\''https://other.tld'\'':'
++ read line
++ case "$line" in
++ echo 'askpass: Password for '\''https://askpass-username@other.tld'\'':'
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential fill <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential fill
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 5 - helper (cache) requires matching host

expecting success: 
		check fill $HELPER <<-\EOF
		protocol=https
		host=example.com
		username=other
		--
		protocol=https
		host=example.com
		username=other
		password=askpass-password
		--
		askpass: Password for 'https://other@example.com':
		EOF
	
++ check fill cache
++ credential_opts=
++ credential_cmd=fill
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=other
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=other
++ read line
++ case "$line" in
++ echo password=askpass-password
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo 'askpass: Password for '\''https://other@example.com'\'':'
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential fill <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential fill
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 6 - helper (cache) requires matching username

expecting success: 
		test_config credential.usehttppath true &&
		check approve $HELPER <<-\EOF &&
		protocol=http
		host=path.tld
		path=foo.git
		username=user
		password=pass
		EOF
		check fill $HELPER <<-\EOF
		protocol=http
		host=path.tld
		path=bar.git
		--
		protocol=http
		host=path.tld
		path=bar.git
		username=askpass-username
		password=askpass-password
		--
		askpass: Username for 'http://path.tld/bar.git':
		askpass: Password for 'http://askpass-username@path.tld/bar.git':
		EOF
	
++ test_config credential.usehttppath true
++ config_dir=
++ test credential.usehttppath = -C
++ test_when_finished 'test_unconfig  '\''credential.usehttppath'\'''
++ test 0 = 0
++ test_cleanup='{ test_unconfig  '\''credential.usehttppath'\''
		} && (exit "$eval_ret"); eval_ret=$?; :'
++ git config credential.usehttppath true
++ check approve cache
++ credential_opts=
++ credential_cmd=approve
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=http
++ read line
++ case "$line" in
++ echo host=path.tld
++ read line
++ case "$line" in
++ echo path=foo.git
++ read line
++ case "$line" in
++ echo username=user
++ read line
++ case "$line" in
++ echo password=pass
++ read line
++ read_chunk
++ read line
++ read_chunk
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential approve <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential approve
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
++ check fill cache
++ credential_opts=
++ credential_cmd=fill
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=http
++ read line
++ case "$line" in
++ echo host=path.tld
++ read line
++ case "$line" in
++ echo path=bar.git
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=http
++ read line
++ case "$line" in
++ echo host=path.tld
++ read line
++ case "$line" in
++ echo path=bar.git
++ read line
++ case "$line" in
++ echo username=askpass-username
++ read line
++ case "$line" in
++ echo password=askpass-password
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo 'askpass: Username for '\''http://path.tld/bar.git'\'':'
++ read line
++ case "$line" in
++ echo 'askpass: Password for '\''http://askpass-username@path.tld/bar.git'\'':'
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential fill <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential fill
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
++ test_unconfig credential.usehttppath
++ config_dir=
++ test credential.usehttppath = -C
++ git config --unset-all credential.usehttppath
++ config_status=0
++ case "$config_status" in
++ return 0
++ exit 0
++ eval_ret=0
++ :
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 7 - helper (cache) requires matching path

expecting success: 
		check reject $HELPER <<-\EOF &&
		protocol=https
		host=example.com
		EOF
		check fill $HELPER <<-\EOF
		protocol=https
		host=example.com
		--
		protocol=https
		host=example.com
		username=askpass-username
		password=askpass-password
		--
		askpass: Username for 'https://example.com':
		askpass: Password for 'https://askpass-username@example.com':
		EOF
	
++ check reject cache
++ credential_opts=
++ credential_cmd=reject
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ read_chunk
++ read line
++ read_chunk
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential reject <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential reject
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
++ check fill cache
++ credential_opts=
++ credential_cmd=fill
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=askpass-username
++ read line
++ case "$line" in
++ echo password=askpass-password
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo 'askpass: Username for '\''https://example.com'\'':'
++ read line
++ case "$line" in
++ echo 'askpass: Password for '\''https://askpass-username@example.com'\'':'
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential fill <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential fill
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 8 - helper (cache) can forget host

expecting success: 
		check approve $HELPER <<-\EOF &&
		protocol=https
		host=example.com
		username=user1
		password=pass1
		EOF
		check approve $HELPER <<-\EOF &&
		protocol=https
		host=example.com
		username=user2
		password=pass2
		EOF
		check fill $HELPER <<-\EOF &&
		protocol=https
		host=example.com
		username=user1
		--
		protocol=https
		host=example.com
		username=user1
		password=pass1
		EOF
		check fill $HELPER <<-\EOF
		protocol=https
		host=example.com
		username=user2
		--
		protocol=https
		host=example.com
		username=user2
		password=pass2
		EOF
	
++ check approve cache
++ credential_opts=
++ credential_cmd=approve
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=user1
++ read line
++ case "$line" in
++ echo password=pass1
++ read line
++ read_chunk
++ read line
++ read_chunk
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential approve <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential approve
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
++ check approve cache
++ credential_opts=
++ credential_cmd=approve
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=user2
++ read line
++ case "$line" in
++ echo password=pass2
++ read line
++ read_chunk
++ read line
++ read_chunk
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential approve <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential approve
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
++ check fill cache
++ credential_opts=
++ credential_cmd=fill
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=user1
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=user1
++ read line
++ case "$line" in
++ echo password=pass1
++ read line
++ read_chunk
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential fill <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential fill
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
++ check fill cache
++ credential_opts=
++ credential_cmd=fill
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=user2
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=user2
++ read line
++ case "$line" in
++ echo password=pass2
++ read line
++ read_chunk
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential fill <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential fill
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 9 - helper (cache) can store multiple users

expecting success: 
		check reject $HELPER <<-\EOF &&
		protocol=https
		host=example.com
		username=user1
		EOF
		check fill $HELPER <<-\EOF
		protocol=https
		host=example.com
		username=user1
		--
		protocol=https
		host=example.com
		username=user1
		password=askpass-password
		--
		askpass: Password for 'https://user1@example.com':
		EOF
	
++ check reject cache
++ credential_opts=
++ credential_cmd=reject
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=user1
++ read line
++ read_chunk
++ read line
++ read_chunk
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential reject <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential reject
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
++ check fill cache
++ credential_opts=
++ credential_cmd=fill
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=user1
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=user1
++ read line
++ case "$line" in
++ echo password=askpass-password
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo 'askpass: Password for '\''https://user1@example.com'\'':'
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential fill <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential fill
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 10 - helper (cache) can forget user

expecting success: 
		check fill $HELPER <<-\EOF
		protocol=https
		host=example.com
		username=user2
		--
		protocol=https
		host=example.com
		username=user2
		password=pass2
		EOF
	
++ check fill cache
++ credential_opts=
++ credential_cmd=fill
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=user2
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=user2
++ read line
++ case "$line" in
++ echo password=pass2
++ read line
++ read_chunk
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential fill <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential fill
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 11 - helper (cache) remembers other user

expecting success: 
	test_when_finished "
		git credential-cache exit &&
		rmdir -p .cache/git/credential/
	" &&
	test_path_is_missing "$HOME/.git-credential-cache" &&
	test -S "$HOME/.cache/git/credential/socket"

++ test_when_finished '
		git credential-cache exit &&
		rmdir -p .cache/git/credential/
	'
++ test 0 = 0
++ test_cleanup='{ 
		git credential-cache exit &&
		rmdir -p .cache/git/credential/
	
		} && (exit "$eval_ret"); eval_ret=$?; :'
++ test_path_is_missing '/home/add/vcs/cygwin/git/git-2.13.0-rc1-1.x86_64/build/t/trash directory.t0301-credential-cache/.git-credential-cache'
++ test -e '/home/add/vcs/cygwin/git/git-2.13.0-rc1-1.x86_64/build/t/trash directory.t0301-credential-cache/.git-credential-cache'
++ test -S '/home/add/vcs/cygwin/git/git-2.13.0-rc1-1.x86_64/build/t/trash directory.t0301-credential-cache/.cache/git/credential/socket'
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
++ git credential-cache exit
fatal: read error from cache daemon: Connection reset by peer
++ eval_ret=128
++ :
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
not ok 12 - socket defaults to ~/.cache/git/credential/socket
#	
#		test_when_finished "
#			git credential-cache exit &&
#			rmdir -p .cache/git/credential/
#		" &&
#		test_path_is_missing "$HOME/.git-credential-cache" &&
#		test -S "$HOME/.cache/git/credential/socket"
#	

expecting success: 
		check fill $HELPER <<-\EOF
		protocol=https
		host=example.com
		--
		protocol=https
		host=example.com
		username=askpass-username
		password=askpass-password
		--
		askpass: Username for 'https://example.com':
		askpass: Password for 'https://askpass-username@example.com':
		EOF
	
++ check fill cache
++ credential_opts=
++ credential_cmd=fill
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=askpass-username
++ read line
++ case "$line" in
++ echo password=askpass-password
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo 'askpass: Username for '\''https://example.com'\'':'
++ read line
++ case "$line" in
++ echo 'askpass: Password for '\''https://askpass-username@example.com'\'':'
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential fill <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential fill
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 13 - helper (cache) has no existing data

expecting success: 
		check approve $HELPER <<-\EOF
		protocol=https
		host=example.com
		username=store-user
		password=store-pass
		EOF
	
++ check approve cache
++ credential_opts=
++ credential_cmd=approve
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=store-user
++ read line
++ case "$line" in
++ echo password=store-pass
++ read line
++ read_chunk
++ read line
++ read_chunk
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential approve <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential approve
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 14 - helper (cache) stores password

expecting success: 
		check fill $HELPER <<-\EOF
		protocol=https
		host=example.com
		--
		protocol=https
		host=example.com
		username=store-user
		password=store-pass
		--
		EOF
	
++ check fill cache
++ credential_opts=
++ credential_cmd=fill
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=store-user
++ read line
++ case "$line" in
++ echo password=store-pass
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential fill <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential fill
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 15 - helper (cache) can retrieve password

expecting success: 
		check fill $HELPER <<-\EOF
		protocol=http
		host=example.com
		--
		protocol=http
		host=example.com
		username=askpass-username
		password=askpass-password
		--
		askpass: Username for 'http://example.com':
		askpass: Password for 'http://askpass-username@example.com':
		EOF
	
++ check fill cache
++ credential_opts=
++ credential_cmd=fill
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=http
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=http
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=askpass-username
++ read line
++ case "$line" in
++ echo password=askpass-password
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo 'askpass: Username for '\''http://example.com'\'':'
++ read line
++ case "$line" in
++ echo 'askpass: Password for '\''http://askpass-username@example.com'\'':'
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential fill <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential fill
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 16 - helper (cache) requires matching protocol

expecting success: 
		check fill $HELPER <<-\EOF
		protocol=https
		host=other.tld
		--
		protocol=https
		host=other.tld
		username=askpass-username
		password=askpass-password
		--
		askpass: Username for 'https://other.tld':
		askpass: Password for 'https://askpass-username@other.tld':
		EOF
	
++ check fill cache
++ credential_opts=
++ credential_cmd=fill
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=other.tld
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=other.tld
++ read line
++ case "$line" in
++ echo username=askpass-username
++ read line
++ case "$line" in
++ echo password=askpass-password
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo 'askpass: Username for '\''https://other.tld'\'':'
++ read line
++ case "$line" in
++ echo 'askpass: Password for '\''https://askpass-username@other.tld'\'':'
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential fill <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential fill
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 17 - helper (cache) requires matching host

expecting success: 
		check fill $HELPER <<-\EOF
		protocol=https
		host=example.com
		username=other
		--
		protocol=https
		host=example.com
		username=other
		password=askpass-password
		--
		askpass: Password for 'https://other@example.com':
		EOF
	
++ check fill cache
++ credential_opts=
++ credential_cmd=fill
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=other
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=other
++ read line
++ case "$line" in
++ echo password=askpass-password
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo 'askpass: Password for '\''https://other@example.com'\'':'
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential fill <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential fill
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 18 - helper (cache) requires matching username

expecting success: 
		test_config credential.usehttppath true &&
		check approve $HELPER <<-\EOF &&
		protocol=http
		host=path.tld
		path=foo.git
		username=user
		password=pass
		EOF
		check fill $HELPER <<-\EOF
		protocol=http
		host=path.tld
		path=bar.git
		--
		protocol=http
		host=path.tld
		path=bar.git
		username=askpass-username
		password=askpass-password
		--
		askpass: Username for 'http://path.tld/bar.git':
		askpass: Password for 'http://askpass-username@path.tld/bar.git':
		EOF
	
++ test_config credential.usehttppath true
++ config_dir=
++ test credential.usehttppath = -C
++ test_when_finished 'test_unconfig  '\''credential.usehttppath'\'''
++ test 0 = 0
++ test_cleanup='{ test_unconfig  '\''credential.usehttppath'\''
		} && (exit "$eval_ret"); eval_ret=$?; :'
++ git config credential.usehttppath true
++ check approve cache
++ credential_opts=
++ credential_cmd=approve
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=http
++ read line
++ case "$line" in
++ echo host=path.tld
++ read line
++ case "$line" in
++ echo path=foo.git
++ read line
++ case "$line" in
++ echo username=user
++ read line
++ case "$line" in
++ echo password=pass
++ read line
++ read_chunk
++ read line
++ read_chunk
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential approve <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential approve
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
++ check fill cache
++ credential_opts=
++ credential_cmd=fill
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=http
++ read line
++ case "$line" in
++ echo host=path.tld
++ read line
++ case "$line" in
++ echo path=bar.git
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=http
++ read line
++ case "$line" in
++ echo host=path.tld
++ read line
++ case "$line" in
++ echo path=bar.git
++ read line
++ case "$line" in
++ echo username=askpass-username
++ read line
++ case "$line" in
++ echo password=askpass-password
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo 'askpass: Username for '\''http://path.tld/bar.git'\'':'
++ read line
++ case "$line" in
++ echo 'askpass: Password for '\''http://askpass-username@path.tld/bar.git'\'':'
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential fill <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential fill
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
++ test_unconfig credential.usehttppath
++ config_dir=
++ test credential.usehttppath = -C
++ git config --unset-all credential.usehttppath
++ config_status=0
++ case "$config_status" in
++ return 0
++ exit 0
++ eval_ret=0
++ :
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 19 - helper (cache) requires matching path

expecting success: 
		check reject $HELPER <<-\EOF &&
		protocol=https
		host=example.com
		EOF
		check fill $HELPER <<-\EOF
		protocol=https
		host=example.com
		--
		protocol=https
		host=example.com
		username=askpass-username
		password=askpass-password
		--
		askpass: Username for 'https://example.com':
		askpass: Password for 'https://askpass-username@example.com':
		EOF
	
++ check reject cache
++ credential_opts=
++ credential_cmd=reject
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ read_chunk
++ read line
++ read_chunk
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential reject <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential reject
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
++ check fill cache
++ credential_opts=
++ credential_cmd=fill
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=askpass-username
++ read line
++ case "$line" in
++ echo password=askpass-password
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo 'askpass: Username for '\''https://example.com'\'':'
++ read line
++ case "$line" in
++ echo 'askpass: Password for '\''https://askpass-username@example.com'\'':'
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential fill <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential fill
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 20 - helper (cache) can forget host

expecting success: 
		check approve $HELPER <<-\EOF &&
		protocol=https
		host=example.com
		username=user1
		password=pass1
		EOF
		check approve $HELPER <<-\EOF &&
		protocol=https
		host=example.com
		username=user2
		password=pass2
		EOF
		check fill $HELPER <<-\EOF &&
		protocol=https
		host=example.com
		username=user1
		--
		protocol=https
		host=example.com
		username=user1
		password=pass1
		EOF
		check fill $HELPER <<-\EOF
		protocol=https
		host=example.com
		username=user2
		--
		protocol=https
		host=example.com
		username=user2
		password=pass2
		EOF
	
++ check approve cache
++ credential_opts=
++ credential_cmd=approve
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=user1
++ read line
++ case "$line" in
++ echo password=pass1
++ read line
++ read_chunk
++ read line
++ read_chunk
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential approve <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential approve
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
++ check approve cache
++ credential_opts=
++ credential_cmd=approve
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=user2
++ read line
++ case "$line" in
++ echo password=pass2
++ read line
++ read_chunk
++ read line
++ read_chunk
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential approve <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential approve
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
++ check fill cache
++ credential_opts=
++ credential_cmd=fill
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=user1
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=user1
++ read line
++ case "$line" in
++ echo password=pass1
++ read line
++ read_chunk
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential fill <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential fill
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
++ check fill cache
++ credential_opts=
++ credential_cmd=fill
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=user2
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=user2
++ read line
++ case "$line" in
++ echo password=pass2
++ read line
++ read_chunk
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential fill <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential fill
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 21 - helper (cache) can store multiple users

expecting success: 
		check reject $HELPER <<-\EOF &&
		protocol=https
		host=example.com
		username=user1
		EOF
		check fill $HELPER <<-\EOF
		protocol=https
		host=example.com
		username=user1
		--
		protocol=https
		host=example.com
		username=user1
		password=askpass-password
		--
		askpass: Password for 'https://user1@example.com':
		EOF
	
++ check reject cache
++ credential_opts=
++ credential_cmd=reject
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=user1
++ read line
++ read_chunk
++ read line
++ read_chunk
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential reject <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential reject
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
++ check fill cache
++ credential_opts=
++ credential_cmd=fill
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=user1
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=user1
++ read line
++ case "$line" in
++ echo password=askpass-password
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo 'askpass: Password for '\''https://user1@example.com'\'':'
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential fill <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential fill
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 22 - helper (cache) can forget user

expecting success: 
		check fill $HELPER <<-\EOF
		protocol=https
		host=example.com
		username=user2
		--
		protocol=https
		host=example.com
		username=user2
		password=pass2
		EOF
	
++ check fill cache
++ credential_opts=
++ credential_cmd=fill
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=user2
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=user2
++ read line
++ case "$line" in
++ echo password=pass2
++ read line
++ read_chunk
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential fill <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential fill
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 23 - helper (cache) remembers other user

expecting success: 
	test_when_finished "git credential-cache exit" &&
	test -S "$XDG_CACHE_HOME/git/credential/socket" &&
	test_path_is_missing "$HOME/.git-credential-cache/socket" &&
	test_path_is_missing "$HOME/.cache/git/credential/socket"

++ test_when_finished 'git credential-cache exit'
++ test 0 = 0
++ test_cleanup='{ git credential-cache exit
		} && (exit "$eval_ret"); eval_ret=$?; :'
++ test -S '/home/add/vcs/cygwin/git/git-2.13.0-rc1-1.x86_64/build/t/trash directory.t0301-credential-cache/xdg/git/credential/socket'
++ test_path_is_missing '/home/add/vcs/cygwin/git/git-2.13.0-rc1-1.x86_64/build/t/trash directory.t0301-credential-cache/.git-credential-cache/socket'
++ test -e '/home/add/vcs/cygwin/git/git-2.13.0-rc1-1.x86_64/build/t/trash directory.t0301-credential-cache/.git-credential-cache/socket'
++ test_path_is_missing '/home/add/vcs/cygwin/git/git-2.13.0-rc1-1.x86_64/build/t/trash directory.t0301-credential-cache/.cache/git/credential/socket'
++ test -e '/home/add/vcs/cygwin/git/git-2.13.0-rc1-1.x86_64/build/t/trash directory.t0301-credential-cache/.cache/git/credential/socket'
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
++ git credential-cache exit
fatal: read error from cache daemon: Connection reset by peer
++ eval_ret=128
++ :
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
not ok 24 - use custom XDG_CACHE_HOME if set and default sockets are not created
#	
#		test_when_finished "git credential-cache exit" &&
#		test -S "$XDG_CACHE_HOME/git/credential/socket" &&
#		test_path_is_missing "$HOME/.git-credential-cache/socket" &&
#		test_path_is_missing "$HOME/.cache/git/credential/socket"
#	

expecting success: 
	test_when_finished "
		git credential-cache exit --socket \"\$HOME/dir/socket\" &&
		rmdir \"\$HOME/dir\"
	" &&
	check approve "cache --socket \"\$HOME/dir/socket\"" <<-\EOF &&
	protocol=https
	host=example.com
	username=store-user
	password=store-pass
	EOF
	test -S "$HOME/dir/socket"

++ test_when_finished '
		git credential-cache exit --socket "$HOME/dir/socket" &&
		rmdir "$HOME/dir"
	'
++ test 0 = 0
++ test_cleanup='{ 
		git credential-cache exit --socket "$HOME/dir/socket" &&
		rmdir "$HOME/dir"
	
		} && (exit "$eval_ret"); eval_ret=$?; :'
++ check approve 'cache --socket "$HOME/dir/socket"'
++ credential_opts=
++ credential_cmd=approve
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache --socket "$HOME/dir/socket"'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=store-user
++ read line
++ case "$line" in
++ echo password=store-pass
++ read line
++ read_chunk
++ read line
++ read_chunk
++ read line
++ eval 'git  -c credential.helper='\''cache --socket "$HOME/dir/socket"'\'' credential approve <stdin >stdout 2>stderr'
+++ git -c 'credential.helper=cache --socket "$HOME/dir/socket"' credential approve
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
++ test -S '/home/add/vcs/cygwin/git/git-2.13.0-rc1-1.x86_64/build/t/trash directory.t0301-credential-cache/dir/socket'
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
++ git credential-cache exit --socket '/home/add/vcs/cygwin/git/git-2.13.0-rc1-1.x86_64/build/t/trash directory.t0301-credential-cache/dir/socket'
fatal: read error from cache daemon: Connection reset by peer
++ eval_ret=128
++ :
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
not ok 25 - credential-cache --socket option overrides default location
#	
#		test_when_finished "
#			git credential-cache exit --socket \"\$HOME/dir/socket\" &&
#			rmdir \"\$HOME/dir\"
#		" &&
#		check approve "cache --socket \"\$HOME/dir/socket\"" <<-\EOF &&
#		protocol=https
#		host=example.com
#		username=store-user
#		password=store-pass
#		EOF
#		test -S "$HOME/dir/socket"
#	

expecting success: 
	test_when_finished "
		git credential-cache exit &&
		sane_unset XDG_CACHE_HOME
	" &&
	check approve cache <<-\EOF &&
	protocol=https
	host=example.com
	username=store-user
	password=store-pass
	EOF
	test -S "$HOME/.cache/git/credential/socket" &&
	XDG_CACHE_HOME="$HOME/xdg" &&
	export XDG_CACHE_HOME &&
	check approve cache <<-\EOF &&
	protocol=https
	host=example.com
	username=store-user
	password=store-pass
	EOF
	test -S "$XDG_CACHE_HOME/git/credential/socket"

++ test_when_finished '
		git credential-cache exit &&
		sane_unset XDG_CACHE_HOME
	'
++ test 0 = 0
++ test_cleanup='{ 
		git credential-cache exit &&
		sane_unset XDG_CACHE_HOME
	
		} && (exit "$eval_ret"); eval_ret=$?; :'
++ check approve cache
++ credential_opts=
++ credential_cmd=approve
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=store-user
++ read line
++ case "$line" in
++ echo password=store-pass
++ read line
++ read_chunk
++ read line
++ read_chunk
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential approve <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential approve
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
++ test -S '/home/add/vcs/cygwin/git/git-2.13.0-rc1-1.x86_64/build/t/trash directory.t0301-credential-cache/.cache/git/credential/socket'
++ XDG_CACHE_HOME='/home/add/vcs/cygwin/git/git-2.13.0-rc1-1.x86_64/build/t/trash directory.t0301-credential-cache/xdg'
++ export XDG_CACHE_HOME
++ check approve cache
++ credential_opts=
++ credential_cmd=approve
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=store-user
++ read line
++ case "$line" in
++ echo password=store-pass
++ read line
++ read_chunk
++ read line
++ read_chunk
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential approve <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential approve
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
++ test -S '/home/add/vcs/cygwin/git/git-2.13.0-rc1-1.x86_64/build/t/trash directory.t0301-credential-cache/xdg/git/credential/socket'
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
++ git credential-cache exit
fatal: read error from cache daemon: Connection reset by peer
++ eval_ret=128
++ :
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
not ok 26 - use custom XDG_CACHE_HOME even if xdg socket exists
#	
#		test_when_finished "
#			git credential-cache exit &&
#			sane_unset XDG_CACHE_HOME
#		" &&
#		check approve cache <<-\EOF &&
#		protocol=https
#		host=example.com
#		username=store-user
#		password=store-pass
#		EOF
#		test -S "$HOME/.cache/git/credential/socket" &&
#		XDG_CACHE_HOME="$HOME/xdg" &&
#		export XDG_CACHE_HOME &&
#		check approve cache <<-\EOF &&
#		protocol=https
#		host=example.com
#		username=store-user
#		password=store-pass
#		EOF
#		test -S "$XDG_CACHE_HOME/git/credential/socket"
#	

expecting success: 
	test_when_finished "
		git credential-cache exit &&
		rmdir \"\$HOME/.git-credential-cache/\"
	" &&
	mkdir -p -m 700 "$HOME/.git-credential-cache/" &&
	check approve cache <<-\EOF &&
	protocol=https
	host=example.com
	username=store-user
	password=store-pass
	EOF
	test -S "$HOME/.git-credential-cache/socket"

++ test_when_finished '
		git credential-cache exit &&
		rmdir "$HOME/.git-credential-cache/"
	'
++ test 0 = 0
++ test_cleanup='{ 
		git credential-cache exit &&
		rmdir "$HOME/.git-credential-cache/"
	
		} && (exit "$eval_ret"); eval_ret=$?; :'
++ mkdir -p -m 700 '/home/add/vcs/cygwin/git/git-2.13.0-rc1-1.x86_64/build/t/trash directory.t0301-credential-cache/.git-credential-cache/'
++ check approve cache
++ credential_opts=
++ credential_cmd=approve
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=store-user
++ read line
++ case "$line" in
++ echo password=store-pass
++ read line
++ read_chunk
++ read line
++ read_chunk
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential approve <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential approve
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
++ test -S '/home/add/vcs/cygwin/git/git-2.13.0-rc1-1.x86_64/build/t/trash directory.t0301-credential-cache/.git-credential-cache/socket'
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
++ git credential-cache exit
fatal: read error from cache daemon: Connection reset by peer
++ eval_ret=128
++ :
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
not ok 27 - use user socket if user directory exists
#	
#		test_when_finished "
#			git credential-cache exit &&
#			rmdir \"\$HOME/.git-credential-cache/\"
#		" &&
#		mkdir -p -m 700 "$HOME/.git-credential-cache/" &&
#		check approve cache <<-\EOF &&
#		protocol=https
#		host=example.com
#		username=store-user
#		password=store-pass
#		EOF
#		test -S "$HOME/.git-credential-cache/socket"
#	

checking prerequisite: SYMLINKS

mkdir -p "$TRASH_DIRECTORY/prereq-test-dir" &&
(
	cd "$TRASH_DIRECTORY/prereq-test-dir" &&
	# test whether the filesystem supports symbolic links
	ln -s x y && test -h y

)
++ mkdir -p '/home/add/vcs/cygwin/git/git-2.13.0-rc1-1.x86_64/build/t/trash directory.t0301-credential-cache/prereq-test-dir'
++ cd '/home/add/vcs/cygwin/git/git-2.13.0-rc1-1.x86_64/build/t/trash directory.t0301-credential-cache/prereq-test-dir'
++ ln -s x y
++ test -h y
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
prerequisite SYMLINKS ok
expecting success: 
	test_when_finished "
		git credential-cache exit &&
		rmdir \"\$HOME/dir/\" &&
		rm \"\$HOME/.git-credential-cache\"
	" &&
	mkdir -p -m 700 "$HOME/dir/" &&
	ln -s "$HOME/dir" "$HOME/.git-credential-cache" &&
	check approve cache <<-\EOF &&
	protocol=https
	host=example.com
	username=store-user
	password=store-pass
	EOF
	test -S "$HOME/.git-credential-cache/socket"

++ test_when_finished '
		git credential-cache exit &&
		rmdir "$HOME/dir/" &&
		rm "$HOME/.git-credential-cache"
	'
++ test 0 = 0
++ test_cleanup='{ 
		git credential-cache exit &&
		rmdir "$HOME/dir/" &&
		rm "$HOME/.git-credential-cache"
	
		} && (exit "$eval_ret"); eval_ret=$?; :'
++ mkdir -p -m 700 '/home/add/vcs/cygwin/git/git-2.13.0-rc1-1.x86_64/build/t/trash directory.t0301-credential-cache/dir/'
++ ln -s '/home/add/vcs/cygwin/git/git-2.13.0-rc1-1.x86_64/build/t/trash directory.t0301-credential-cache/dir' '/home/add/vcs/cygwin/git/git-2.13.0-rc1-1.x86_64/build/t/trash directory.t0301-credential-cache/.git-credential-cache'
++ check approve cache
++ credential_opts=
++ credential_cmd=approve
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=example.com
++ read line
++ case "$line" in
++ echo username=store-user
++ read line
++ case "$line" in
++ echo password=store-pass
++ read line
++ read_chunk
++ read line
++ read_chunk
++ read line
++ eval 'git  -c credential.helper='\''cache'\'' credential approve <stdin >stdout 2>stderr'
+++ git -c credential.helper=cache credential approve
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
++ test -S '/home/add/vcs/cygwin/git/git-2.13.0-rc1-1.x86_64/build/t/trash directory.t0301-credential-cache/.git-credential-cache/socket'
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
++ git credential-cache exit
fatal: read error from cache daemon: Connection reset by peer
++ eval_ret=128
++ :
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
not ok 28 - use user socket if user directory is a symlink to a directory
#	
#		test_when_finished "
#			git credential-cache exit &&
#			rmdir \"\$HOME/dir/\" &&
#			rm \"\$HOME/.git-credential-cache\"
#		" &&
#		mkdir -p -m 700 "$HOME/dir/" &&
#		ln -s "$HOME/dir" "$HOME/.git-credential-cache" &&
#		check approve cache <<-\EOF &&
#		protocol=https
#		host=example.com
#		username=store-user
#		password=store-pass
#		EOF
#		test -S "$HOME/.git-credential-cache/socket"
#	

expecting success: 
		check approve "$HELPER" <<-\EOF &&
		protocol=https
		host=timeout.tld
		username=user
		password=pass
		EOF
		sleep 2 &&
		check fill "$HELPER" <<-\EOF
		protocol=https
		host=timeout.tld
		--
		protocol=https
		host=timeout.tld
		username=askpass-username
		password=askpass-password
		--
		askpass: Username for 'https://timeout.tld':
		askpass: Password for 'https://askpass-username@timeout.tld':
		EOF
	
++ check approve 'cache --timeout=1'
++ credential_opts=
++ credential_cmd=approve
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache --timeout=1'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=timeout.tld
++ read line
++ case "$line" in
++ echo username=user
++ read line
++ case "$line" in
++ echo password=pass
++ read line
++ read_chunk
++ read line
++ read_chunk
++ read line
++ eval 'git  -c credential.helper='\''cache --timeout=1'\'' credential approve <stdin >stdout 2>stderr'
+++ git -c 'credential.helper=cache --timeout=1' credential approve
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
++ sleep 2
++ check fill 'cache --timeout=1'
++ credential_opts=
++ credential_cmd=fill
++ shift
++ for arg in "$@"
++ credential_opts=' -c credential.helper='\''cache --timeout=1'\'''
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=timeout.tld
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo protocol=https
++ read line
++ case "$line" in
++ echo host=timeout.tld
++ read line
++ case "$line" in
++ echo username=askpass-username
++ read line
++ case "$line" in
++ echo password=askpass-password
++ read line
++ case "$line" in
++ break
++ read_chunk
++ read line
++ case "$line" in
++ echo 'askpass: Username for '\''https://timeout.tld'\'':'
++ read line
++ case "$line" in
++ echo 'askpass: Password for '\''https://askpass-username@timeout.tld'\'':'
++ read line
++ eval 'git  -c credential.helper='\''cache --timeout=1'\'' credential fill <stdin >stdout 2>stderr'
+++ git -c 'credential.helper=cache --timeout=1' credential fill
++ test_cmp expect-stdout stdout
++ diff -u expect-stdout stdout
++ test_cmp expect-stderr stderr
++ diff -u expect-stderr stderr
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 29 - helper (cache --timeout=1) times out

fatal: read error from cache daemon: Connection reset by peer
# failed 6 among 29 test(s)
1..29

--UugvWAfsgieZRqgk--
