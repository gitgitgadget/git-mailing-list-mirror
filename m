Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A92C3208CD
	for <e@80x24.org>; Wed, 23 Aug 2017 10:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753819AbdHWK5c (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 06:57:32 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35026 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753635AbdHWK5b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 06:57:31 -0400
Received: by mail-wm0-f49.google.com with SMTP id r187so12836040wma.0
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 03:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ddGBeP0uDtqMg8iBNMHqJOa0yyENHSvaQgHq5kbN3cY=;
        b=m9X4uwsyX9dZxrzSakA9yIWDXTn6NX+tFcwixvAIwWOT/AkQjYCWgHWZhPbOA81oy0
         UKX4iFAGZN/hSaDQyuQtT128JilfN5/DrJhCCWdmI/kPh3LXrFHzdvY7kjxsy1X8p+pf
         GihUh7rLCx1+biuqLHO5JPSG0xrw+OKNd/dsbt+TeDLZhGYxUApOSLPGmX3VzWMIVuGe
         KvKY2pS5m7AKPop+Nl6BGdZWj1vvQARqecTprOhSC9ttWkrPNLC2cziB19y2+y8I1U1J
         EnhA4tWiRS4h0bKHUibSDm7jrhEMsxx+0aJtn5Yg/5KvyhU00gLXS7biQY64WacBrPtq
         sqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ddGBeP0uDtqMg8iBNMHqJOa0yyENHSvaQgHq5kbN3cY=;
        b=WRuZcshNxvv0DqDgMKbe+xYC+aclpg3cWGJMiWI30+zNfx8Zo0iKHDhot+8oy6ClKb
         wtrBUWWQWiyf/CatxbIHDjF4mtm18cgkGqofZlO/4fFYWr6bOljIYirXhdL07MHAHp/2
         ZJ+485yIDqijl/vphtP8aRS0d730v9AMj6/EFgxqNIkmCcXMf4s2YA0JPT9dUeYXgDvX
         yv3o0mNd+yEIa4kJ3wviR0kSM/lEbJ+VCcGm5XWojZXYPRpPAfpSX/j33x+gz5urZtJ7
         hEKm3MzVp4UgkGcaYsvdW/xluOBQ38BvY/ozxrrh8KmblLydPEoUx4KJ6JgiRbayG89w
         sKGw==
X-Gm-Message-State: AHYfb5iMo3kZAViazAUrTh5jqEs6DM5CaXe6GpUhf2TSrq7IXCDrdsTV
        ourAnX6ynG1wlLTkZf4=
X-Received: by 10.28.9.13 with SMTP id 13mr1441582wmj.78.1503485849678;
        Wed, 23 Aug 2017 03:57:29 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id i80sm1986410wmh.40.2017.08.23.03.57.28
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Aug 2017 03:57:28 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH/RFC] push: anonymize URL in error output
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170823094929.13541-1-sainaen@gmail.com>
Date:   Wed, 23 Aug 2017 12:57:27 +0200
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <698B5636-BE6B-47EF-BE4B-1DB590E0028F@gmail.com>
References: <20170823094929.13541-1-sainaen@gmail.com>
To:     Ivan Vyshnevskyi <sainaen@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 23 Aug 2017, at 11:49, Ivan Vyshnevskyi <sainaen@gmail.com> wrote:
>=20
> Commits 47abd85 (fetch: Strip usernames from url's before storing =
them,
> 2009-04-17) and later 882d49c (push: anonymize URL in status output,
> 2016-07-14) made fetch and push strip the authentication part of the
> remote URLs when used in the merge-commit messages or status outputs.
> The URLs that are part of the error messages were not anonymized.
>=20
> A commonly used pattern for storing artifacts from a build server in a
> remote repository utilizes a "secure" environment variable with
> credentials to embed them in the URL and execute a push. Given enough
> runs, an intermittent network failure will cause a push to fail, =
leaving
> a non-anonymized URL in the build log.
>=20
> To prevent that, reuse the same anonymizing function to scrub
> credentials from URL in the push error output.
>=20
> Signed-off-by: Ivan Vyshnevskyi <sainaen@gmail.com>
> ---
>=20
> This is my first attempt to propose a patch, sorry if I did something =
wrong!
>=20
> I've tested my changes on Travis CI, and the build is green [1].
>=20
> Not sure how much of the background should be included in the commit =
message.
> The "commonly used pattern" I mention could be found in the myriad of
> online tutorials and looks something like this:
>=20
>    git push -fq https://$GIT_CREDS@github.com/$REPO_SLUG
>=20
> Note, that a lot of developers mistakenly assume that '--quiet' ('-q') =
will
> suppress all output. Sometimes, they would redirect standard output to
> /dev/null, without realizing that errors are printed out to stderr.
>=20
> I didn't mention this in the commit, but another typical offender is a =
tool that
> calls 'git push' as part of its execution. This is a spectrum that =
starts with
> shell scripts, includes simple one-task apps in Python or Ruby, and =
ends with
> the plugins for JavaScript, Java, Groovy, and Scala build tools. (I'd =
like to
> avoid shaming their authors publicly, but could send you a few =
examples
> privately.)
>=20
> I gathered the data by going through build logs of popular open source =
projects
> (and projects of their contributors) hosted on GitHub and built by =
Travis CI.
> I found about 2.3k unique credentials (but only about nine hundred =
were active
> at the time), and more than a half of those were exposed by a failed =
push. See
> the advisory from Travis CI [2] for results of their own scan.
>=20
> While the issue is public for several months now and addressed on =
Travis CI,
> I keep finding build logs with credentials on the internet. So I think =
it's
> worth fixing in the git itself.
>=20
> [1]: https://travis-ci.org/sainaen/git/builds/267180560
> [2]: https://blog.travis-ci.com/2017-05-08-security-advisory
>=20

This sounds very reasonable to me! Thanks for the contribution!

I wonder if we should even extend this. Consider this case:

  $ git push https://lars:secret@server/org/repo1
  remote: Invalid username or password.
  fatal: Authentication failed for =
'https://lars:secret@server/org/repo1/'

I might not have valid credentials for repo1 but my credentials could
very well be valid for repo2.

- Lars


> builtin/push.c             |  2 +-
> t/t5541-http-push-smart.sh | 18 ++++++++++++++++++
> 2 files changed, 19 insertions(+), 1 deletion(-)
>=20
> diff --git a/builtin/push.c b/builtin/push.c
> index 03846e837..59f3bc975 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -336,7 +336,7 @@ static int push_with_options(struct transport =
*transport, int flags)
> 	err =3D transport_push(transport, refspec_nr, refspec, flags,
> 			     &reject_reasons);
> 	if (err !=3D 0)
> -		error(_("failed to push some refs to '%s'"), =
transport->url);
> +		error(_("failed to push some refs to '%s'"), =
transport_anonymize_url(transport->url));
>=20
> 	err |=3D transport_disconnect(transport);
> 	if (!err)
> diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
> index d38bf3247..0b6fb6252 100755
> --- a/t/t5541-http-push-smart.sh
> +++ b/t/t5541-http-push-smart.sh
> @@ -377,5 +377,23 @@ test_expect_success 'push status output scrubs =
password' '
> 	grep "^To $HTTPD_URL/smart/test_repo.git" status
> '
>=20
> +cat >"$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update" <<EOF
> +#!/bin/sh
> +exit 1
> +EOF
> +chmod a+x "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update"
> +
> +cat >exp <<EOF
> +error: failed to push some refs to '$HTTPD_URL/smart/test_repo.git'
> +EOF
> +
> +test_expect_success 'failed push status output scrubs password' '
> +	cd "$ROOT_PATH"/test_repo_clone &&
> +	test_must_fail git push =
"$HTTPD_URL_USER_PASS/smart/test_repo.git" +HEAD:scrub_err 2>stderr &&
> +	grep "^error: failed to push some refs" stderr >act &&
> +	test_i18ncmp exp act
> +'
> +rm -f "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update"
> +
> stop_httpd
> test_done
> --=20
> 2.14.1
>=20

