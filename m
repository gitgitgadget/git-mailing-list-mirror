Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D32AF1F609
	for <e@80x24.org>; Wed, 28 Nov 2018 09:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeK1Unu (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 15:43:50 -0500
Received: from mout.gmx.net ([212.227.15.15]:47393 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727541AbeK1Unt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 15:43:49 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MgszY-1g5tGm2ETY-00M6A0; Wed, 28
 Nov 2018 10:42:44 +0100
Date:   Wed, 28 Nov 2018 10:42:45 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "H.Merijn Brand" <h.m.brand@xs4all.nl>
cc:     git@vger.kernel.org
Subject: Re: in 2.19.2 t0061-run-command FAILs if . is in $PATH
In-Reply-To: <20181128100517.28d44804@pc09.procura.nl>
Message-ID: <nycvar.QRO.7.76.6.1811281041400.41@tvgsbejvaqbjf.bet>
References: <20181128100517.28d44804@pc09.procura.nl>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wFN20SMH/RAkznA8j5bzUJ9rigqZBs+gnqI/IjbA01+oiARQVay
 7jBLjij9Aiwd5zkI66V7vG1o8B+KccPIAOFaL3wimQYji4TMYfQjUZfKiTcc1nfJNhFZZoy
 6oxgERYuo6xrwnAmYHDHToeZw2l8Uq3X0bE8fX/5tMQyN0mRt+2pwK5qxzzxEebx3lzw5Y1
 yJcuRw+3JQKHL4oNGYq7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Exa24I5TykQ=:e5Tc6ZfOX3bS9kDuB+g4oe
 Av62H8xdGpY85E3jL5q/HAa74SU4rj1bT2vYW6wHNHUjAs3xhqylWgsaf7MXfwyJMGq9bzGND
 tDB6hRoBA4QXD/2VX2eNP2SS2z1W1KfbaEzAAEgELdkIrlRI4nQ5VBFu0RjrRdgUE/3IwEwcV
 xuNgvV4Kka8qSX8EJRbVcWPWYZ+F1ydptt+NqmmYJDszc2gV6/LQM5oZm6bdwYa/f2YK0DxlA
 Hg6Mm7Mu/z8LbUjZYNjZnQFcZVCigEqtEc1VDzNR1LxiBnLxl8kwXcaBV5JV7ZnnRl0CIb7pv
 sOPrAh7yQG+e6AFUSz52KO1U7VPwWgI8qQLlY+Q6i4NV077ST4OCikoOcvwEHZe49wK8W6WE7
 i7qo2GsFpW+543HsrkaCbMKI4AH3eKJai4yMSGuq3wf7pMHn8aw50Vd8j/VutQr3pJKVI2meS
 q7ACKAnC5OPTD05uZjeq9vuafN4eXzWdJc+5NiHYZcDB3Wf3nHLHt9tq9C3ODDe6hWtwWy8uR
 DTWN/HbWxTmyuH551aTDpsnqw+5MBOctOYdb689HHnHPooc5GxCCbVtyqVaWvU7I/q/xVLPzi
 Xdikjz0Gj2Ulkii2MFSVfq1Wp1hC5awTfLBbDqpMsMwRDchG/ea89C44NNTW1fqVCVg8aB1yP
 J9/Ld1Q8dDHwDUENyH06neBXwZzQpiBkt8wvWdBGDeI1fSKV9mXzWS1f5KhmauasU7G4VeQjC
 6TYGXhN56DC3ITRAKldIxUDEK4kaxN54M3nQ1Y7r9ei/kOKSl+9sUXgVRCYwbg3yXdOhcSnTg
 pbPPx67rlu0VB6O6eD8fMduX7ay55NmQbfXX8RenaENLn8Uunr3+7dJySLiXA5COILPlbQopX
 xk8LOxe81QvmNdnnm4RWff0aGIgIZrs8SORdVc0SKnzTGhvd61VldaSTLAfng+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 28 Nov 2018, H.Merijn Brand wrote:

> the test is explicitely checking that it should not find runnable
> scripts outside $PATH, *assuming* $PATH does not have . in it

Does this fix it for you?

-- snip --
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index f3f308920f04..4949fdfde88b 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -33,7 +33,14 @@ test_expect_success 'run_command can run a command' '
 	test_must_be_empty err
 '
 
-test_expect_success 'run_command is restricted to PATH' '
+test_lazy_prereq DOT_IN_PATH '
+	case ":$PATH:" in
+	*:.:*) true;;
+	*) false;;
+	esac
+'
+
+test_expect_success !DOT_IN_PATH 'run_command is restricted to PATH' '
 	write_script should-not-run <<-\EOF &&
 	echo yikes
 	EOF
-- snap --

If so, can you please provide a commit message for it (you can add my
Signed-off-by: line and your Tested-by: line).

Thanks,
Johannes


> 
> Having '.' in $PATH can be seen as a bad idea (and it most likely is),
> but the tests should either remove '.' from $PATH before testing or
> ignore that fail if $PATH does have '.', as it is not illegal
> 
> $ git-2.19.2/t 504 > prove -v t0061-run-command.sh
> t0061-run-command.sh ..
> ok 1 - start_command reports ENOENT (slash)
> ok 2 - start_command reports ENOENT (no slash)
> ok 3 - run_command can run a command
> ok 4 - run_command is restricted to PATH
> ok 5 - run_command can run a script without a #! line
> ok 6 - run_command does not try to execute a directory
> ok 7 - run_command passes over non-executable file
> ok 8 - run_command reports EACCES
> ok 9 - unreadable directory in PATH
> ok 10 - run_command runs in parallel with more jobs available than tasks
> ok 11 - run_command runs in parallel with as many jobs as tasks
> ok 12 - run_command runs in parallel with more tasks than jobs available
> ok 13 - run_command is asked to abort gracefully
> ok 14 - run_command outputs
> ok 15 - GIT_TRACE with environment variables
> # passed all 15 test(s)
> 1..15
> ok
> All tests successful.
> Files=1, Tests=15,  1 wallclock secs ( 0.04 usr  0.01 sys +  0.26 cusr  0.07 csys =  0.38 CPU)
> Result: PASS
> 
> $ env PATH="$PATH"":." prove -v t0061-run-command.sh
> t0061-run-command.sh ..
> ok 1 - start_command reports ENOENT (slash)
> ok 2 - start_command reports ENOENT (no slash)
> ok 3 - run_command can run a command
> not ok 4 - run_command is restricted to PATH
> #
> #               write_script should-not-run <<-\EOF &&
> #               echo yikes
> #               EOF
> #               test_must_fail test-tool run-command run-command should-not-run
> #
> ok 5 - run_command can run a script without a #! line
> ok 6 - run_command does not try to execute a directory
> ok 7 - run_command passes over non-executable file
> ok 8 - run_command reports EACCES
> ok 9 - unreadable directory in PATH
> ok 10 - run_command runs in parallel with more jobs available than tasks
> ok 11 - run_command runs in parallel with as many jobs as tasks
> ok 12 - run_command runs in parallel with more tasks than jobs available
> ok 13 - run_command is asked to abort gracefully
> ok 14 - run_command outputs
> ok 15 - GIT_TRACE with environment variables
> # failed 1 among 15 test(s)
> 1..15
> Dubious, test returned 1 (wstat 256, 0x100)
> Failed 1/15 subtests
> 
> Test Summary Report
> -------------------
> t0061-run-command.sh (Wstat: 256 Tests: 15 Failed: 1)
>   Failed test:  4
>   Non-zero exit status: 1
> Files=1, Tests=15,  1 wallclock secs ( 0.03 usr  0.00 sys +  0.24 cusr  0.07 csys =  0.34 CPU)
> Result: FAIL
> 
> -- 
> H.Merijn Brand  http://tux.nl   Perl Monger  http://amsterdam.pm.org/
> using perl5.00307 .. 5.29   porting perl5 on HP-UX, AIX, and openSUSE
> http://mirrors.develooper.com/hpux/        http://www.test-smoke.org/
> http://qa.perl.org   http://www.goldmark.org/jeff/stupid-disclaimers/
> 
