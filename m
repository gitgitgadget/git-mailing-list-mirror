From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule helper: accept '.' for repositories with no submodules
Date: Tue, 22 Mar 2016 14:47:22 -0700
Message-ID: <CAGZ79kYNQ46Yett8xwtPL8Mi1TkitB1kuWbQDsR6bg-5dxckNA@mail.gmail.com>
References: <1458669579-32160-1-git-send-email-sbeller@google.com>
	<xmqqy49agx98.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaMa3CyJ-Y9Xn9QShzTUGythos+pmKZXQ7m-2c0bF0u9A@mail.gmail.com>
	<xmqqoaa6gtuu.fsf@gitster.mtv.corp.google.com>
	<CAGZ79ka=EJ-L+Zaqh0kWUdjmyUva3fEcbwJn18uxshe3R5ABBQ@mail.gmail.com>
	<xmqqtwjyfb0s.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Per Cederqvist <cederp@opera.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 22:47:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiU9A-0004jj-Te
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 22:47:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368AbcCVVrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 17:47:25 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:32921 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011AbcCVVrY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 17:47:24 -0400
Received: by mail-yw0-f172.google.com with SMTP id h65so129115186ywe.0
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 14:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=NKz5O4fUei3NEGkt4ZPN28wqHLbro2vMNTLT2gzRLtQ=;
        b=W1/JwgsLqbBJeRNa5+9zDVHKeCtn7+y0ylidEAKPp0vaZAy0s5pu0P7GxhGb5KGI8J
         zjNJWXeOp37O9R8n/X0pX9K9W57vQbd8qoc0eZDQs7kjIgtepheW+kpYbqeur5Ibw25r
         XQD7gqOFT1NtvgyGFRrXKp8fARAf6eqxGHfCUD0LvCsKzyf2TcoXZqFqSFfy2FeVzYhI
         BfXy2xyOaCcGYTAHc0ZJg2jZqHr8xYz//p3qrYWeiTCfWavoOuu5SHYXnwQ692zEM8GK
         XPM4s/nson1P/4Neg5B9PdbOYk61fIEWwyl5SjrRHhY/SErugok7+GVSpq85xweKZZkc
         KJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=NKz5O4fUei3NEGkt4ZPN28wqHLbro2vMNTLT2gzRLtQ=;
        b=IkB3sOCveVHtN7+g87Q7FiRwwy0ya9PDUHhuCxwrJICEHJ0dZHDsuK9RI44yCt1ZTt
         aVIO0hnLfPZrbv/YeF0znbeWKmaveaN8/MULex4H6HueRusd3zc7LWhMXPKdxCPSQDWg
         +AWeNw57Kr5UfXIWKNNpZZ7oD6eHH1tOelZDc6z6y3l3AlJylLBCCP5WmX6yO574pd1x
         hzRb8kwjNWSuFeIbEdt0VtTdnVJBEV4Qtv8E/9yEtx5G5WZhVZ9f1HRbCfOk3kutPAOF
         KMLEhXi9tHZqL36euGPFhdeA3ws3TS0ZNOX8t/FSVNahJ/058Du/2sUFYs6hn+RtFHNS
         DDdA==
X-Gm-Message-State: AD7BkJK9Q8njVPfaMIlpFYYQoxtQhijY97rSLYqrXOQl8JCdtAq1AVtuVE9Tk01E0B+BwJ5MHwbgWmiclLaonk1J
X-Received: by 10.129.0.65 with SMTP id 62mr17671476ywa.199.1458683243071;
 Tue, 22 Mar 2016 14:47:23 -0700 (PDT)
Received: by 10.37.51.137 with HTTP; Tue, 22 Mar 2016 14:47:22 -0700 (PDT)
In-Reply-To: <xmqqtwjyfb0s.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289572>

On Tue, Mar 22, 2016 at 2:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> I do not think that buys us much.  You have already shown how to
>>> implement "filter first and then pathspec match" if a caller
>>> wants to (which turned out to be a regression in this case, but
>>> that is besides the point).
>>
>> And by including this filtering into the pathspec machine we can pass
>> a flag DONT_BREAK_ON_NO_FILTER_RESULTS_WHEN_HAVING_OTHER_MATCHES
>> (name for illustration purpose only ;) which is how I understand this
>> regression?
>
> But you do not even need that if you fix the regression with
> something like this, no?  Do we need to add complexity to pathspec
> machinery only to make it easier to misuse it and then add another
> DONT_BREAK_... band-aid to fix a bug that can come from such a
> misuse?
>
>  builtin/submodule--helper.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index ed764c9..740b57a 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -37,10 +37,11 @@ static int module_list_compute(int argc, const char **argv,
>         for (i = 0; i < active_nr; i++) {
>                 const struct cache_entry *ce = active_cache[i];
>
> -               if (!S_ISGITLINK(ce->ce_mode) ||
> -                   !match_pathspec(pathspec, ce->name, ce_namelen(ce),
> +               if (!match_pathspec(pathspec, ce->name, ce_namelen(ce),
>                                     0, ps_matched, 1))
>                         continue;
> +               if (!S_ISGITLINK(ce->ce_mode))
> +                       continue;
>
>                 ALLOC_GROW(list->entries, list->nr + 1, list->alloc);
>                 list->entries[list->nr++] = ce;


This patch is conceptually, what you said in the first message as

> So I dunno.  This is not only "deinit", but also the post rewrite
> version catches
>
>         $ git submodule init -- 'COPYIN*'
>
> as an error, which we probably would want to keep, so I am reluctant
> to suggest swapping the order of the check to do pathspec first and
> then gitlink-ness (it has performance implications but correctness
> is a more important issue), but if we want to keep the backward
> compatibility, that would be the best bug-to-bug compatible fix in
> the shorter term.

I was under the impression that we do not want to have this bugfix
(at least long term) and then I tried to come up with an idea, which
is both:
* correct in this case
* and catches the git submodule init -- 'COPYIN*' case as failure
