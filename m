From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] rebase -i: Remember merge options beyond continue actions
Date: Wed, 11 Jun 2014 23:13:42 +0200
Message-ID: <5398C686.8050400@alum.mit.edu>
References: <CAPig+cSHFFPUEQz8==HLQr0My2Bfsth_F16wVf9giytqGwzZww@mail.gmail.com> <53965334.3030206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Diogo de Campos <campos@esss.com.br>
To: Fabian Ruch <bafain@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 23:13:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WupqD-0007XO-SY
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 23:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199AbaFKVNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 17:13:48 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:65421 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751236AbaFKVNr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jun 2014 17:13:47 -0400
X-AuditID: 1207440c-f79656d000000c83-cf-5398c68a4ecf
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 3D.8F.03203.A86C8935; Wed, 11 Jun 2014 17:13:46 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96325.dip0.t-ipconnect.de [79.201.99.37])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s5BLDhmP004411
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 11 Jun 2014 17:13:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <53965334.3030206@gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsUixO6iqNt1bEawwZopQhaH5t5jt7i+6w+r
	RdeVbiaLM28aGR1YPPpmzGb12DnrLrvH4gdeHp83yQWwRHHbJCWWlAVnpufp2yVwZ6y80sNU
	0Kxe0XHuN2MD4375LkZODgkBE4mZtw6zQNhiEhfurWcDsYUELjNKnGst6mLkArLPMUncn/2Q
	GSTBK6AtceFwEyuIzSKgKjHj4HQmEJtNQFdiUU8zmC0qECQx+/M8doh6QYmTM5+ALRAR8JaY
	sXM3mM0sYCux/fhCsDnCAn4SOy4tY4RYnCtx5/kPsDmcApoSZ6feB5rDAXScuERPYxBEq47E
	u74HzBC2vMT2t3OYJzAKzkKybRaSsllIyhYwMq9ilEvMKc3VzU3MzClOTdYtTk7My0st0jXU
	y80s0UtNKd3ECAlynh2M39bJHGIU4GBU4uFlqJ0RLMSaWFZcmXuIUZKDSUmUV/AwUIgvKT+l
	MiOxOCO+qDQntfgQowQHs5II79p1QDnelMTKqtSifJiUNAeLkjiv6hJ1PyGB9MSS1OzU1ILU
	IpisDAeHkgTv2SNAjYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGg+I0vBkYwSIoH
	aO8JkHbe4oLEXKAoROspRl2OU3eOtTEJseTl56VKifPuAzlcAKQoozQPbgUspb1iFAf6WJh3
	P8goHmA6hJv0CmgJE9CS157TQZaUJCKkpBoY7STuLQ3hFZXOkVo7VZ/78E/peTV/N/M2nxfx
	62eMe6SfZlsiLfxvVuTuD0yrjm431f9TtYEja8G/bcKq25dP1OLdwXv4CeuDjmC3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251386>

The fix seems reasonable to me.  See below for a couple of suggestions
regarding the commit message.

On 06/10/2014 02:37 AM, Fabian Ruch wrote:
> [...]
> -- >8 --
> Subject: rebase -i: Remember merge options beyond continue actions
> 
> If the user explicitly specified a merge strategy or strategy options,
> "rebase --interactive" started using the default merge strategy again
> after "rebase --continue".
> 
> This problem gets fixed by this commit. Add test.

Please phrase commit messages in the imperative voice, as if commanding
git to fix itself.  Maybe

    If the user explicitly specified a merge strategy or strategy
    options, continue to use that strategy/option after
    "rebase --continue".  Add a test of the corrected behavior.

> Since the "rebase" options "-s" and "-X" imply "--merge", we can simply
> remove the "do_merge" guard in the interactive mode and always compile
> the "cherry-pick" arguments from the "rebase" state variables "strategy"
> and "strategy_opts".
> 
> Reported-by: Diogo de Campos <campos@esss.com.br>
> Signed-off-by: Fabian Ruch <bafain@gmail.com>

I expect it took you a while to figure out how the strategy-related
options are handled and propagated from one step of an interactive
rebase to the next and why your fix is correct.  It certainly took *me*
a while even though I had your patch in front of me :-)

It is helpful if you give reviewers and future readers the benefit of
your hard work by spoon-feeding them more of the backstory.  I suggest
expanding your justification to something like this (correct me if I've
misunderstood something!):

    If --merge is specified or implied by -s or -X, then "strategy" and
    "strategy_opts" are set to values from which "strategy_args" can be
    derived; otherwise they are set to empty strings.  Either way,
    their values are propagated from one step of an interactive rebase
    to the next via state files.

    "do_merge", on the other hand, is *not* propagated to later steps of
    an interactive rebase.  Therefore, making the initialization of
    "strategy_args" conditional on "do_merge" being set prevents later
    steps of an interactive rebase from setting it correctly.

    Luckily, we don't need the "do_merge" guard at all.  If the rebase
    was started without --merge, then "strategy" and "strategy_opts"
    are both the empty string, which results in "strategy_args" also
    being set to the empty string, which is just what we want in that
    situation.  So remove the "do_merge" guard and derive
    "strategy_args" from "strategy" and "strategy_opts" every time.

Michael

> ---
>  git-rebase--interactive.sh    | 18 +++++++-----------
>  t/t3404-rebase-interactive.sh | 16 ++++++++++++++++
>  2 files changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 6ec9d3c..817c933 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -77,17 +77,13 @@ amend="$state_dir"/amend
>  rewritten_list="$state_dir"/rewritten-list
>  rewritten_pending="$state_dir"/rewritten-pending
>  
> -strategy_args=
> -if test -n "$do_merge"
> -then
> -	strategy_args=${strategy:+--strategy=$strategy}
> -	eval '
> -		for strategy_opt in '"$strategy_opts"'
> -		do
> -			strategy_args="$strategy_args -X$(git rev-parse --sq-quote "${strategy_opt#--}")"
> -		done
> -	'
> -fi
> +strategy_args=${strategy:+--strategy=$strategy}
> +eval '
> +	for strategy_opt in '"$strategy_opts"'
> +	do
> +		strategy_args="$strategy_args -X$(git rev-parse --sq-quote "${strategy_opt#--}")"
> +	done
> +'
>  
>  GIT_CHERRY_PICK_HELP="$resolvemsg"
>  export GIT_CHERRY_PICK_HELP
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index c0023a5..73849f1 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -998,6 +998,22 @@ test_expect_success 'rebase -i with --strategy and -X' '
>  	test $(cat file1) = Z
>  '
>  
> +test_expect_success 'interrupted rebase -i with --strategy and -X' '
> +	git checkout -b conflict-merge-use-theirs-interrupted conflict-branch &&
> +	git reset --hard HEAD^ &&
> +	>breakpoint &&
> +	git add breakpoint &&
> +	git commit -m "breakpoint for interactive mode" &&
> +	echo five >conflict &&
> +	echo Z >file1 &&
> +	git commit -a -m "one file conflict" &&
> +	set_fake_editor &&
> +	FAKE_LINES="edit 1 2" git rebase -i --strategy=recursive -Xours conflict-branch &&
> +	git rebase --continue &&
> +	test $(git show conflict-branch:conflict) = $(cat conflict) &&
> +	test $(cat file1) = Z
> +'
> +
>  test_expect_success 'rebase -i error on commits with \ in message' '
>  	current_head=$(git rev-parse HEAD)
>  	test_when_finished "git rebase --abort; git reset --hard $current_head; rm -f error" &&
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
