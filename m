Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA193200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 18:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755534AbcL0SWu (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 13:22:50 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:42067 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755467AbcL0SWt (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 27 Dec 2016 13:22:49 -0500
X-AuditID: 1207440c-e3bff700000009a1-62-5862b1774934
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 83.4A.02465.771B2685; Tue, 27 Dec 2016 13:22:47 -0500 (EST)
Received: from [192.168.69.190] (p5B10401B.dip0.t-ipconnect.de [91.16.64.27])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBRIMjC1017980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 27 Dec 2016 13:22:47 -0500
Subject: Re: What's cooking in git.git (Dec 2016, #05; Mon, 19)
To:     Junio C Hamano <gitster@pobox.com>
References: <xmqq37hjmow0.fsf@gitster.mtv.corp.google.com>
 <afd95065-d076-b962-8337-b87008b9f894@alum.mit.edu>
 <xmqqd1gdcmwn.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <b715d8af-850a-ef32-921d-f52a89d8466c@alum.mit.edu>
Date:   Tue, 27 Dec 2016 19:22:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <xmqqd1gdcmwn.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsUixO6iqFuxMSnCYMtFRouuK91MFg29V5gd
        mDwuXlL2+LxJLoApissmJTUnsyy1SN8ugSvj/fGL7AVveCpat/1la2Ds4epi5OCQEDCR6Pxg
        1sXIxSEkcJlRYub2vSwQzlkmic9vF7OBFAkL2Evc3ufRxcjJISKgJjGx7RBUzUJGidZv01hA
        EswC4hLr5p5nB7HZBHQlFvU0M4HYvEC9l/dNB4uzCKhKHO88xgpiiwqESFyec5QNokZQ4uTM
        J2BzOAWsJf6e/cQEMVNPYsf1X6wQtrzE9rdzmCcw8s9C0jILSdksJGULGJlXMcol5pTm6uYm
        ZuYUpybrFicn5uWlFuka6uVmluilppRuYoQEI88Oxm/rZA4xCnAwKvHw/lieGCHEmlhWXJl7
        iFGSg0lJlLdlUlKEEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHereuBcrwpiZVVqUX5MClpDhYl
        cV7VJep+QgLpiSWp2ampBalFMFkZDg4lCd6dG4AaBYtS01Mr0jJzShDSTBycIMN5gIa3gtTw
        Fhck5hZnpkPkTzHqctw6vuQpkxBLXn5eqpQ4rw9IkQBIUUZpHtwcWBJ5xSgO9JYwbyJIFQ8w
        AcFNegW0hAloiX59PMiSkkSElFQDo+e+R+bFX7wDGRlivMSX/hQ+ZpLH5PbyX1bM7oXLtZWY
        b05z/PrKwHgxZ4iES+7Jw5VT/ZfNUvvr3nciYhnj6oTEhfFBCs5GL9oqt35gcXbxPN43xTmu
        MVzNLkOco3CVpN1ODfsdz5K1ZOoKlwtHPj3JN3mm0eO7QS8svl/eGLPpG6Pz7wQNJZbijERD
        Leai4kQAm5gIF/0CAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/27/2016 06:16 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Sorry I didn't notice this earlier, but the `LOCK_REPORT_ON_ERROR`
>> constant introduced by
>>
>>     3f061bf "lockfile: LOCK_REPORT_ON_ERROR", 2016-12-07
>>
>> sets that constant to the value 2,...
> 
> Sorry I didn't notice this earlier, either.  Thanks for spotting.
> 
> -- >8 --
> From: Junio C Hamano <gitster@pobox.com>
> Date: Tue, 27 Dec 2016 09:12:09 -0800
> Subject: [PATCH] lockfile: move REPORT_ON_ERROR bit elsewhere
> 
> There was LOCK_NO_DEREF defined as 2 = 1<<1 with the same value,
> which was missed due to a huge comment block.  Deconflict by moving
> the new one to 4 = 1<<2 for now.

The fix is obviously correct. I'm not sure I like it that comments are
being blamed for mistakes :-P

Perhaps defining these constants within an `enum` would make it clearer
that they are a group and help prevent problems like this in the future
(though that could be done later rather than as part of this hot fix).

Michael

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  lockfile.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lockfile.h b/lockfile.h
> index 16775a7d79..7b715f9e77 100644
> --- a/lockfile.h
> +++ b/lockfile.h
> @@ -137,7 +137,7 @@ struct lock_file {
>   * ... this flag can be passed instead to return -1 and give the usual
>   * error message upon an error.
>   */
> -#define LOCK_REPORT_ON_ERROR 2
> +#define LOCK_REPORT_ON_ERROR 4
>  
>  /*
>   * Usually symbolic links in the destination path are resolved. This
> 

