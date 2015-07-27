From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/6] Documentation/config: mention "now" and "never" for
 'expire' settings
Date: Sun, 26 Jul 2015 18:41:15 -0700
Message-ID: <55B58C3B.7040200@alum.mit.edu>
References: <1437710457-38592-1-git-send-email-sunshine@sunshineco.com> <1437710457-38592-3-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 27 03:41:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJXQ7-0007mT-Lr
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 03:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755034AbbG0Blb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2015 21:41:31 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:42475 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753338AbbG0Bla (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jul 2015 21:41:30 -0400
X-AuditID: 12074414-f794f6d000007852-9b-55b58c3ea37a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id A4.D8.30802.E3C85B55; Sun, 26 Jul 2015 21:41:18 -0400 (EDT)
Received: from [192.168.69.130] (p4FC9657F.dip0.t-ipconnect.de [79.201.101.127])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t6R1fFWL012302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 26 Jul 2015 21:41:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1437710457-38592-3-git-send-email-sunshine@sunshineco.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqGvXszXUYNVFbYuuK91MFg29V5gt
	zrxpZHRg9rh4Sdlj8QMvj8+b5AKYo7htkhJLyoIz0/P07RK4M1o29LAVLJWq2LhjCksD4w2R
	LkZODgkBE4nGu0eYIWwxiQv31rN1MXJxCAlcZpTYuPMaM4RzgUmi8fAHJpAqXgFtiVsz57KB
	2CwCqhKTb+xhBLHZBHQlFvU0A9VwcIgKBEm8fpkLUS4ocXLmExYQW0TAQWLtkZ1grcwCahKH
	ljwCaxUWSJBY3NgKtbiZUeLLypVgDZwCHhLTl+6DatCT2HH9FyuELS/RvHU28wRGgVlIdsxC
	UjYLSdkCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRboWermZJXqpKaWbGCGhK7KD8chJuUOM
	AhyMSjy8F1S2hgqxJpYVV+YeYpTkYFIS5f0iuTlUiC8pP6UyI7E4I76oNCe1+BCjBAezkgjv
	4yigct6UxMqq1KJ8mJQ0B4uSOO+3xep+QgLpiSWp2ampBalFMFkZDg4lCd7ZXUCNgkWp6akV
	aZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aBYjS8GRitIigdo7xaQdt7igsRcoChE6ylGRSlx
	3l0gCQGQREZpHtxYWEJ6xSgO9KUwL2s3UBUPMJnBdb8CGswENNizZwvI4JJEhJRUA2PDg9Kz
	ynXRB4wZPjoZ8tm8vLzdhPNR78QL3Hqfp37dsn3WwbPJr6ON3EsD9NMF/ov5xAS+MzmbcLmv
	7NsK7QOnLc+e6tc94+EkWDibz7dnr6JNwaZiRuvtF30N2R7MO+Hv/+9O2sVpHYnl 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274647>

On 07/23/2015 09:00 PM, Eric Sunshine wrote:
> In addition to approxidate-style values ("2.months.ago", "yesterday"),
> consumers of 'gc.*expire*' configuration variables also accept and
> respect 'now'/'all' ("do it immediately") and 'never'/'false' ("suppress
> entirely").
> 
> Suggested-by: Michael Haggerty <mhagger@alum.mit.edu>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
> 
> Reference: http://article.gmane.org/gmane.comp.version-control.git/274325
> 
> I sneaked in a minor whitespace fix.
> 
>  Documentation/config.txt | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1a8a399..cc920c0 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1307,20 +1307,22 @@ gc.packRefs::
>  gc.pruneExpire::
>  	When 'git gc' is run, it will call 'prune --expire 2.weeks.ago'.
>  	Override the grace period with this config variable.  The value
> -	"now" may be used to disable this  grace period and always prune
> -	unreachable objects immediately.
> +	"now" may be used to disable this grace period and always prune
> +	unreachable objects immediately; or "never" to suppress pruning.

A semicolon should be used without a conjunction, and the parts of a
sentence joined by a semicolon should be independent clauses. So this
should probably be

                                                     [...] The value
    "now" may be used to disable this grace period and always prune
    unreachable objects immediately, or "never" may be used to
    suppress pruning.

>  gc.worktreePruneExpire::
>  	When 'git gc' is run, it calls
>  	'git worktree prune --expire 3.months.ago'.
>  	This config variable can be used to set a different grace
>  	period. The value "now" may be used to disable the grace
> -	period and prune $GIT_DIR/worktrees immediately.
> +	period and prune $GIT_DIR/worktrees immediately; or "never" to
> +	suppress pruning.

The same here.

>  gc.reflogExpire::
>  gc.<pattern>.reflogExpire::
>  	'git reflog expire' removes reflog entries older than
> -	this time; defaults to 90 days.  With "<pattern>" (e.g.
> +	this time; defaults to 90 days. The value "all" expires all
> +	entries; and "false" disables expiration. With "<pattern>" (e.g.
>  	"refs/stash") in the middle the setting applies only to
>  	the refs that match the <pattern>.

Similarly, this could be fixed to

                               [...] The value "all" expires all
    entries; "false" disables expiration. [...]


> @@ -1328,7 +1330,8 @@ gc.reflogExpireUnreachable::
>  gc.<ref>.reflogExpireUnreachable::
>  	'git reflog expire' removes reflog entries older than
>  	this time and are not reachable from the current tip;
> -	defaults to 30 days.  With "<pattern>" (e.g. "refs/stash")
> +	defaults to 30 days. The value "all" expires all entries; and
> +	"false" disables expiration. With "<pattern>" (e.g. "refs/stash")
>  	in the middle, the setting applies only to the refs that
>  	match the <pattern>.

The same here.

Also, I wonder why you suggest "now"/"never" for the first two settings,
but "all"/"false" for the second two. Wouldn't it be less confusing to
be consistent?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
