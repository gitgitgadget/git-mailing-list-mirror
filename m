From: Stefan Beller <sbeller@google.com>
Subject: Re: Issue with git submodule update --init --depth=1 submodA
Date: Thu, 24 Mar 2016 10:43:23 -0700
Message-ID: <CAGZ79kbu=3Chh96JAgHDESjBr=B3td=7e9Q_uwsyGWgx=WGk5A@mail.gmail.com>
References: <CAECUmHo8Q=N_rTP7NnYaQJ24g9SVrgCmpq1NHVXe1icD6xn7vw@mail.gmail.com>
	<CAGZ79kaTACBvBNwAumK035fWG8qooh31JpoooyUmGZEL+4mpOg@mail.gmail.com>
	<CAECUmHq-NVZ5NVuMaTm_1mLjbE4wAMCDnFHrcGHdKoCGDL1E2g@mail.gmail.com>
	<CAECUmHpE1KJYK5758+VeiXa3nZa-_rOyJD3RwsD9pJ9uQS9_0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jared Davison <jared@medical-objects.com.au>
X-From: git-owner@vger.kernel.org Thu Mar 24 18:43:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj9I9-0000Sg-5E
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 18:43:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbcCXRn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 13:43:26 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:36165 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbcCXRnY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 13:43:24 -0400
Received: by mail-yw0-f180.google.com with SMTP id g3so68661472ywa.3
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 10:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=2GCg8OMdAUXqpFP60cqgZJC8TZW/UiPbDReQydZiy3w=;
        b=kFWd/gYdfcN1XHn8ytjMrVKFWo0g/pzbUdvp0c+Y7hdkQRwDZMOeJ9bo/tw/fiodFa
         GbnIMgER5asq81k7eEPS8ZMMqEOEq9vhUvEwQwY0e8BcSKuSJkxdOaOQnTNV4ieNFWEN
         w/oy1h3eb5vLTUzGaTQYEwA6zJ9LusPa4JGfZL0CTu4GABk3wLMsrLPMJgxfSXv+HRSl
         IA8hfm2YG7Y1bO2fuPBi70Tu1P4andBjvka4XU4mjT2oX/eIWxyxXYTN93xQc6gCvdG4
         ekT62N3a4LRiclO2gqp2bJUPIstcrXD5k0SFnq8HpvoPbiwgGE424dXKDAOqjSyRByAg
         rZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=2GCg8OMdAUXqpFP60cqgZJC8TZW/UiPbDReQydZiy3w=;
        b=InZQdGbB/B8AJzgiQngFwZ5rOEdkV6jVQLsGZBgfq8xhxp1UGq3pXt1huXYRvNVn0t
         tWrsvvKV5GEIBo2twJ6mHycwGN72mzAocWLipFUPO6SZyePXqEa1lRdk6rc5uogZ67CD
         97JwGc/wywiX9W+FGc2KNPDVT+2z0DTra9NtsXLeyfnBd1KtjH/r+swgZ3ZreCvz/ua6
         4CbUxF+dKtgmt5cH3RfpiYuXd9FJ6VtCQM7Eqds6Rkt5dUYNFPA1XYVQJ+n8gBc7fLg4
         AJSG0/UG4pbr4VPoecqJaPoeeMVKzI7UfqoyHnrGtUR4AZeuwNsemVUeFZG/YRdOX0Yg
         Ed+A==
X-Gm-Message-State: AD7BkJJKDu2vkAoP2Cz6mSjk9lGg0WIyKLeRaH26hCtuFdeaN0nc1J2cUfKOGw44ooUQb6be1NUkq+67PiN4Jq7k
X-Received: by 10.129.49.200 with SMTP id x191mr4917945ywx.176.1458841403533;
 Thu, 24 Mar 2016 10:43:23 -0700 (PDT)
Received: by 10.37.51.137 with HTTP; Thu, 24 Mar 2016 10:43:23 -0700 (PDT)
In-Reply-To: <CAECUmHpE1KJYK5758+VeiXa3nZa-_rOyJD3RwsD9pJ9uQS9_0A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289770>

On Wed, Mar 23, 2016 at 11:21 PM, Jared Davison
<jared@medical-objects.com.au> wrote:
>
>
> I've had a go at patching the git-submodule.sh code further to achieve
> the result I'm seeking and it seems to work for me. Can you see a
> problem with this?

Welcome to Git development :)

I think the code looks fine, as it solves your problem.

A few thoughts:
Currently the depth argument is only passed on if we're
cloning from scratch, the depth argument is not passed on
when fetching. I think this is because the depth argument in
fetch allows to deepen or shorten the history.

Shortening the history throws away data, so it's worth a second
thought if the user really means that and is aware of it. So for now
"git submodule update --depth 1" would mean: "keep all data I have
and clone additional submodules with depth 1".

With this patch it would mean: "If a submodule is missing, fetch it;
make sure all submodules are shortened to depth 1".

A few lines before (in 744 when using origin/master version),
we still have "(clear_local_git_env; cd "$sm_path" && git-fetch) ||"
which would also want to learn about the depth argument, such that
all fetches are affected by the depth argument. (We can replace that line
by a call to fetch_in_submodule; it should have been part of
fb43e31f2b4, 2016-02-23, submodule: try harder to fetch needed sha1
by direct fetching sha1)

Some thoughts unrelated to the code:
Please read/skim over Documentation/SubmittingPatches,
specially (5)

(0) Decide what to base your work on.
  As this patch is based on fb43e31f2b4, we'd aim for master
(1) Make separate commits for logically separate changes.
  This is all one logical step, so it will be one patch.
(2) Describe your changes well.
  How about:
  When passing the depth argument to "git submodule update", the user
  is aware of shallow clones and asks Git deliberately to reduce size of the
  submodules; Make sure the existing submodules are also fetched with the
  depth parameter, such that all shallow submodules are shortened to the
  relevant part.
(3) Generate your patch using Git tools out of your commits.
(4) Sending your patches.
  This is only necessary if you plan on sending the patch via email,
  (which is most conveniant when sending lots of patches; for a one off
  you may want to try https://submitgit.herokuapp.com/ as it saves you
  the hassle of setting up getting your mailclient to do what you need,
  e.g. sending patches without white space breakage)
(5) Sign your work
  Legal reasons. We want to use your code, but can only do so, if
  we can trust you are legally allowed to send that patch. By signing
  off your patch we trust you know what you are doing. ;)

Thanks,
Stefan

>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index cd749f4..2e5c918 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -610,12 +610,13 @@ is_tip_reachable () (
>
>  fetch_in_submodule () (
>   sanitize_submodule_env &&
> + depth=$3
>   cd "$1" &&
>   case "$2" in
>   '')
> - git fetch ;;
> + git fetch $depth ;;
>   *)
> - git fetch $(get_default_remote) "$2" ;;
> + git fetch $depth $(get_default_remote) "$2" ;;
>   esac
>  )
>
> @@ -769,13 +770,13 @@ cmd_update()
>   # Run fetch only if $sha1 isn't present or it
>   # is not reachable from a ref.
>   is_tip_reachable "$sm_path" "$sha1" ||
> - fetch_in_submodule "$sm_path" ||
> + fetch_in_submodule "$sm_path" "" "$depth" ||
>   die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
>
>   # Now we tried the usual fetch, but $sha1 may
>   # not be reachable from any of the refs
>   is_tip_reachable "$sm_path" "$sha1" ||
> - fetch_in_submodule "$sm_path" "$sha1" ||
> + fetch_in_submodule "$sm_path" "$sha1" "$depth" ||
>   die "$(eval_gettext "Fetched in submodule path '\$displaypath', but
> it did not contain $sha1. Direct fetching of that commit failed.")"
>   fi
>
