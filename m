Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EC411F597
	for <e@80x24.org>; Thu, 26 Jul 2018 12:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbeGZNXy (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 09:23:54 -0400
Received: from mout.gmx.net ([212.227.15.18]:33671 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729531AbeGZNXy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 09:23:54 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MSuMn-1faivy0YvF-00RmYv; Thu, 26
 Jul 2018 14:07:11 +0200
Date:   Thu, 26 Jul 2018 14:07:07 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     knu@idaemons.org, Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] sequencer.c: terminate the last line of author-script
 properly
In-Reply-To: <xmqqpnzlla1p.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807261347040.71@tvgsbejvaqbjf.bet>
References: <86a7qwpt9g.knu@iDaemons.org>        <xmqqa7qww6uk.fsf@gitster-ct.c.googlers.com>        <CAPig+cQWA+sE3iH89kQGWgS+0HQDK-V5++S0+F6_dpfOCfXxDg@mail.gmail.com> <xmqqpnzlla1p.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SX/5gvkgWOr1SeufELYTd+WQAAoaDWl1ioX6zY92QWyfPbjySsS
 RW0KydhOovuK+A3Fcmi79dfHbPQv/othfZZBV8zVRfdZ8xrLpZMU3z0UZYh3uVZrQVuVSbi
 DgF/8gVM8M3SqtReQeOs1VKgiQYsP4ZE9owOpdQntuMS1a+cARqZwDBLHoNWxfHA6E1UufV
 oPnzboCQ0GGeYGgnTpBCA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LspROmp54QE=:hzLvbAWzvJcywFQjdGXZfx
 2+oTT7+wglbpyqtD9V/KHhiISqRX5r6Qm0kSl75Kq2KdplYrTBgnYCIcQlokXrHWQkew3klHC
 E5wf1ynRD3FQphnGpH0NM4eY4RSp/Rvg3SCLsPSx7r1PcW1recdj1zTv5mOFwD1a1pza9sFD2
 3dzqQUtNn+FtpaWk7edV71L42o1H7vSzhjT2EZmp0JhliPHiM+9gOYoXksCw3EDo+79DOM2cK
 99PgX9reJePffDXhATyjWDdB5vMSHo0Zqk0dU0UlSG+dF326VXKYXR+HBquCuUK/+60GuPyrM
 d22az8W2fUXMtcjOd2PgP1L2Js/JvAhzAMmrqT/tJ8isZYeDVlI9FsNR0c3gSmHRTbihfHM9b
 yhAfoMk9ajGYcDcyTffzCRKdnKbBdVGlS1VWt5FHgFVO3piomDNw18upE0KcJOUQlIbqR5Wwx
 w++I+VrKFislPd+u6lBJ/81OVq/+jFut4JXsQuf91fVY3mUWiZZdfKV0W7KAgfpDpu+LJQcyP
 UFwKisyB5fgCqDwLTZrWu/495Sh6JELHNkjqxVYesZ88ak+a4odkimsRP3ur3iNDjgi+HRxH2
 RsVDLWv7cLCiw4GqzzESi3+e+pRQ0pvjLhNW+0BxvWkxz1xca9QrEAZOAa9YF/uZC4ezpnj/2
 blH+tMl71oLmjZnrpdB4RgwfyHP+EQzsdDhBvBucsNcLdm9X2NgDoYPNy0WbpSl+KO9AmTfsG
 enok5D4KkDo1XHVO5gl8Lh4r91lUjXqadJjEkkKs+Z6mWHFMCKrBWesfXt0HDYeaBfi3GkPBM
 mOCjvuw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 17 Jul 2018, Junio C Hamano wrote:

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 2d189da2f1..b0cef509ab 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -81,11 +81,13 @@ test_expect_success 'rebase -i writes out .git/rebase-merge/author-script in "ed

You missed a very long line here.

>  	set_fake_editor &&
>  	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
>  	test -f .git/rebase-merge/author-script &&

Why do we need this, if we already have an `eval` later on?

> -	unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
> -	eval "$(cat .git/rebase-merge/author-script)" &&
> -	test "$(git show --quiet --pretty=format:%an)" = "$GIT_AUTHOR_NAME" &&
> -	test "$(git show --quiet --pretty=format:%ae)" = "$GIT_AUTHOR_EMAIL" &&
> -	test "$(git show --quiet --date=raw --pretty=format:@%ad)" = "$GIT_AUTHOR_DATE"
> +	(
> +		sane_unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
> +		eval "$(cat .git/rebase-merge/author-script)" &&

Why not

	. .git/rebase-merge/author-script

instead? Less roundabout, easier to read, I think.

> +		test "$(git show --quiet --pretty=format:%an)" = "$GIT_AUTHOR_NAME" &&

How is this even working without `-s`?

*clicketyclick*

Ah, --quiet does this. Wait. `git show --quiet` is not even documented.

All of those lines are too long, though. I am surprised you did not catch
that.

Besides, this would be more compact, less repetitive, *and* more readable
as

	test "$(git show -s --date=raw --format=%an,%ae,@%ad)" = \
		"$GIT_AUTHOR_NAME,$GIT_AUTHOR_EMAIL,$GIT_AUTHOR_DATE"

t3404-rebase-interactive.sh already takes 8 minutes (last I checked,
anyway) to run on a *fast* machine. There is absolutely no need to
introduce even more spawning, not when it is so easily avoided.

> +		test "$(git show --quiet --pretty=format:%ae)" = "$GIT_AUTHOR_EMAIL" &&
> +		test "$(git show --quiet --date=raw --pretty=format:@%ad)" = "$GIT_AUTHOR_DATE"

It is a shame that we cannot use %at directly here.

> +	)
>  '
>  
>  test_expect_success 'rebase -i with the exec command' '

Note: this is not a criticism of the original patch. It is a criticism of
the review which could really have been better.

I also saw that the test_when_finished uses a shell construct that shell
script aficionados might like, but these days it is a lot better to use
`test_might_fail` instead. Let's do this, then.

So here goes, the clean-up patch on top of your 843654e435e (why does it
have to be so darned tedious to get from a mail to the corresponding
commit in `pu`), in all its glory:

-- snipsnap --
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index b0cef509ab7..97f0b4bf881 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -75,18 +75,16 @@ test_expect_success 'rebase --keep-empty' '
 	test_line_count = 6 actual
 '
 
-test_expect_success 'rebase -i writes out .git/rebase-merge/author-script in "edit" that sh(1) can parse' '
-	test_when_finished "git rebase --abort ||:" &&
+test_expect_success 'rebase -i writes correct author-script' '
+	test_when_finished "test_might_fail git rebase --abort" &&
 	git checkout master &&
 	set_fake_editor &&
 	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
-	test -f .git/rebase-merge/author-script &&
 	(
 		sane_unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
-		eval "$(cat .git/rebase-merge/author-script)" &&
-		test "$(git show --quiet --pretty=format:%an)" = "$GIT_AUTHOR_NAME" &&
-		test "$(git show --quiet --pretty=format:%ae)" = "$GIT_AUTHOR_EMAIL" &&
-		test "$(git show --quiet --date=raw --pretty=format:@%ad)" = "$GIT_AUTHOR_DATE"
+		. .git/rebase-merge/author-script &&
+		test "$(git show -s --date=raw --format=%an,%ae,@%ad)" = \
+			"$GIT_AUTHOR_NAME,$GIT_AUTHOR_EMAIL,$GIT_AUTHOR_DATE"
 	)
 '
 
