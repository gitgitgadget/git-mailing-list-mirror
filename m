Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE5382095E
	for <e@80x24.org>; Sat, 25 Mar 2017 16:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751393AbdCYQ5K (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 12:57:10 -0400
Received: from mout.web.de ([212.227.15.3]:60169 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751258AbdCYQ5J (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 12:57:09 -0400
Received: from [192.168.178.36] ([79.237.59.215]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MeBVG-1cWTQ50gVq-00Prxx; Sat, 25
 Mar 2017 17:56:59 +0100
Subject: Re: [PATCH] pretty: add extra headers and MIME boundary directly
To:     Jeff King <peff@peff.net>
References: <6f3d0b54-7a9f-8088-3675-bd2980f69735@web.de>
 <20170325161705.wh4zueasik6iwktv@sigill.intra.peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c5591beb-8cb2-dc19-7820-c8b9c68aad15@web.de>
Date:   Sat, 25 Mar 2017 17:56:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170325161705.wh4zueasik6iwktv@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:4Fc6HEyG9DhSTL5rVqrdgoIIUC+nyiZFzV41xv3BDLG9Oq9TnT0
 66wtgQVxdXMxZlil93EbTyZfmIJZ+yRhpBKo+gxhxa/7wnm38PXaZFM97bsN4SgyySDSka0
 dp6qxoKEO6mSYmqnuatEK80r85ey7N1126GKb+PDXD8vx/h1HIUvwWhXmwfV1Qbo8Xqn0fe
 /Xx5ReO/uNPL6xvwVdROA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qIMPZwqrH5M=:z0o/WGh0cG6BkiMxB7B/E4
 5poSagFWoUMKxbvBC571jUKmEYOGpt/Tq4xToAj1lZ8lYEEyPY8rFZgBt/Y7RY10jyKWNq+Ip
 J5UQeYW4rE7wFLmK5Wio0VpCGtGRUzQhODeDeF3MHZVBy4aJ70YCAtO/C7WRuFWmLpFR8q4/v
 4tNa7/kaYsLhwSAKNacHIsC/QkApvZu3JFfCPc3KHQe10kfEEjqEYGFq0xUQ1QSraj31Jg60v
 Bo+kNFTf8u3h2ZGjmZLdewLEbaeKF3X361mYnJ4u5DrTHtVji9SzLngRA0lF6p3WgZ8ACqP8w
 nlMCwDmv/A8bnz5FgeNgZJ8I6GON8BLxwLTHhc/WM4aYYEhTG+GPi+MnpM3C97T7TBkZ/jm1N
 DIGJE1romugm4jy5IS+NdeETY9uRRKU4osNrRwdUbE1dC9too74Yd3+8ssBFsuRwcYnyNYVEW
 nLrMP4/AILfebT1I8CbQUY1QB41kgTaq7k9V9MDczmlb8oC58uQcPv6nMW1OWpQGWINUXAOGo
 ODAmlFSMAM26qhkJnIQjFMTZQbzTneGgGe/js5NgRFImJxgZlPYGElUwE1Pz0K6bcJVelXnB+
 ez3ks/ugdfUDZU4830Pi5FcxyU9nhQqM2iRK7kNta4UwfcRH2WXEfS68R1LiY811jtX52vtIV
 cTDbLkCAMDyRWTh0WMzRdxsOHGfpOzTR6KDN9ZxsYPzA1GHOqUpbskiP+q/o/RU/YF+Rc542z
 Xa1RpwoKF8ORuefwPhMMwhKhADAPewEvRn6DvUX8G7zdPbDAGXlDf2Dl8qjJbRT5t+mRlE406
 0zaj/Gk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.03.2017 um 17:17 schrieb Jeff King:
> On Sat, Mar 25, 2017 at 01:16:42PM +0100, René Scharfe wrote:
>> @@ -374,26 +372,9 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
>>  		graph_show_oneline(opt->graph);
>>  	}
>>  	if (opt->mime_boundary) {
>> -		static char subject_buffer[1024];
>>  		static char buffer[1024];
>
> We still have this other buffer, which ends up in stat_sep. It should
> probably get the same treatment, though I think the module boundaries
> make it a little more awkward. We look at it in diff_flush(), which
> otherwise doesn't need to know much about the pretty-printing.
>
> Perhaps stat_sep should be a callback?

Yes, it would be nice to avoid it, but I haven't found a clean way, yet. 
  In diff.c, where it's used, we don't have commit and rev_info 
available (which we'd have to pass to a callback, or consume right 
there), and that's probably how it should be.  Perhaps preparing the 
filename in advance and passing that as a string together with 
mime_boundary and no_inline might be the way to go.

>> diff --git a/pretty.c b/pretty.c
>> index d0f86f5d85..56e668781a 100644
>> --- a/pretty.c
>> +++ b/pretty.c
>> @@ -1641,6 +1641,21 @@ void pp_title_line(struct pretty_print_context *pp,
>>  	if (pp->after_subject) {
>>  		strbuf_addstr(sb, pp->after_subject);
>>  	}
>> +	if (pp->print_email_subject && pp->rev && pp->rev->mime_boundary) {
>> +		strbuf_addf(sb,
>> +			    "MIME-Version: 1.0\n"
>
> In the original, this would have been in "after_subject". Which means we
> would print it even if print_email_subject is not true. Why do we need
> to check it in the new conditional?

No, we only would have printed it if log_write_email_headers() was 
called to append it to the static buffer.  print_email_subject is only 
set when we call log_write_email_headers(), so checking it makes sure 
that we get the same behavior as before.

> Not that I expect the behavior to be wrong either way; why would we have
> a mime boundary without setting print_email_subject? But I would think
> that "do we have a mime boundary" would be the right conditional to
> trigger printing it.

FWIW, the test suite still passes with the print_email_subject check 
removed.  And currently only cmd_format_patch() sets mime_boundary, so 
we don't need the check indeed.

René
