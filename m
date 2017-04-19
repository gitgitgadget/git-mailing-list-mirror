Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 166F5207BD
	for <e@80x24.org>; Wed, 19 Apr 2017 16:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966541AbdDSQoT (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 12:44:19 -0400
Received: from mout.web.de ([212.227.17.12]:64101 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966538AbdDSQoR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 12:44:17 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M9os0-1cuKD23r1k-00B69q; Wed, 19
 Apr 2017 18:44:01 +0200
Subject: Re: [PATCH v3 2/2] xgethostname: handle long hostnames
To:     David Turner <David.Turner@twosigma.com>,
        'Junio C Hamano' <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <20170418215743.18406-1-dturner@twosigma.com>
 <20170418215743.18406-3-dturner@twosigma.com>
 <20170419013552.GB28740@aiede.svl.corp.google.com>
 <xmqq4lxlcdpf.fsf@gitster.mtv.corp.google.com>
 <0701e70b52fe4bdd8e04e4c6918aab7a@exmbdft7.ad.twosigma.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ae1d9cb2-dd4b-4bc7-469f-1b7729811f5a@web.de>
Date:   Wed, 19 Apr 2017 18:43:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <0701e70b52fe4bdd8e04e4c6918aab7a@exmbdft7.ad.twosigma.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ZlG3ErlqHmTdXUMBy28x7n2JuwQv1qZpCduwXBVJiKi470fTb1k
 3c/76LSyUO/vpdp3bZVShB6d/6rsvh458TEuRvpArtLmBjg97wvkrdBlOHFE41UEF6WA7oY
 Sp17dEjugoIsK9yHA+0qCUfUFY3keSXGtCAfc548JjZw4YTel20xI/wwbYuziiHfHeBBCdX
 rIQFKZ+8UyRpTjq4GcHgg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qztcrw2rCaY=:vQVDO8fvyoElCK4iFFOxMz
 J80uXfLgkoxQPeT0zBoWmybsB6Q6g0SMzHR1a2Qt+9d548PpUDKO5YmMPuCKdxXvN5x0uYikP
 qOEns0MxUKNPgLXuYHJDRjCKIlIdso1XzBw+cxeZgH8XRN7pkKFATxBbqxovFZNTsHbdsIaOB
 EfM+yKWKyr2oEJl/HY+qsjwPmbFg2PU5+BzM3s1dw4OZYUFZX4H0LTXzXFmB+uuulJcE29aRl
 8RLTOuWiDy4tc3KVEaG4DaHj/9JlB+8YEbXG2dUyW1fiVgkVYzE0sgjiYm5yIqAbv4jlppSnW
 +Ez0Gm93AlK+EtegKDuHtHDOzCH0u+DuxmT0Y+89Q9q+kL5Z4Q5hyRAnMfkXdcjoENVNsOruh
 76T8COy8ddjdoqIMVB2fBhNKSYSgyD7bsEs6TZlGZvFo5lJdsD1V2bjmLNfjrOqfpFUk9MDk3
 wavVAXknPIQ/XEZOBTbc4BwM2u4K8j+vHx7lGf6949zQpeFnu06qfzYBj1CfSlb+1zkRgwcXi
 eQuiuyVuDZ/QObWkOY+slSWQxY8FgOdTyS263scGUw88jz0O98+v0/xSiYbafzN5PBMt1bjUQ
 raI0KKSrefAFh+d6M85M17eptEsiLCxdwlAJZ5lbORJxDHAJ9HAjFWXN4pUI1ryKUuY217VtO
 q173HbeT7NhK/yMhCyGAwRIA1qBKMrTu1uI3op08thpiEcYztArIQXLC2TeUg+iB7xl745z+x
 Ag7I/bHXOAh/rR5MnM0/+z2miUO/DY7pmP3+2UI0kByrmxEhzgn3ofhHHYRY29CXALy7uraMM
 OvhLtdb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.04.2017 um 17:50 schrieb David Turner:
>> -----Original Message-----
>> From: Junio C Hamano [mailto:gitster@pobox.com]
>> Sent: Tuesday, April 18, 2017 10:51 PM
>> To: Jonathan Nieder <jrnieder@gmail.com>
>> Cc: David Turner <David.Turner@twosigma.com>; git@vger.kernel.org;
>> l.s.r@web.de
>> Subject: Re: [PATCH v3 2/2] xgethostname: handle long hostnames
>>
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>
>>> Hi,
>>>
>>> David Turner wrote:
>>>
>>>> If the full hostname doesn't fit in the buffer supplied to
>>>> gethostname, POSIX does not specify whether the buffer will be
>>>> null-terminated, so to be safe, we should do it ourselves.  Introduce
>>>> new function, xgethostname, which ensures that there is always a \0
>>>> at the end of the buffer.
>>>
>>> I think we should detect the error instead of truncating the hostname.
>>> That (on top of your patch) would look like the following.
>>>
>>> Thoughts?
>>> Jonathan
>>>
>>> diff --git i/wrapper.c w/wrapper.c
>>> index d837417709..e218bd3bef 100644
>>> --- i/wrapper.c
>>> +++ w/wrapper.c
>>> @@ -660,11 +660,13 @@ int xgethostname(char *buf, size_t len)  {
>>>   	/*
>>>   	 * If the full hostname doesn't fit in buf, POSIX does not
>>> -	 * specify whether the buffer will be null-terminated, so to
>>> -	 * be safe, do it ourselves.
>>> +	 * guarantee that an error will be returned. Check for ourselves
>>> +	 * to be safe.
>>>   	 */
>>>   	int ret = gethostname(buf, len);
>>> -	if (!ret)
>>> -		buf[len - 1] = 0;
>>> +	if (!ret && !memchr(buf, 0, len)) {
>>> +		errno = ENAMETOOLONG;
>>> +		return -1;
>>> +	}
>>
>> Hmmmm.  "Does not specify if the buffer will be NUL-terminated"
>> would mean that it is OK for the platform gethostname() to stuff
>> sizeof(buf)-1 first bytes of the hostname in the buffer and then truncate by
>> placing '\0' at the end of the buf, and we would not notice truncation with the
>> above change on such a platform, no?
> 
> My read of the docs is that not only is that OK, but it is also permitted
> for the platform to put sizeof(buf) bytes into the buffer and *not*
> put \0 at the end.

That sounds crazy, but that's how I read the spec [1] as well.  And
POSIX also doesn't specify any errors for gethostname.  But that
makes kinda sense because it *does* specify HOST_NAME_MAX as maximum
size.  Things get more interesting when this spec meets systems that
don't have HOST_NAME_MAX, or error returns, or bugs.

> So in order to do a dynamic approach, we would have to allocate some
> buffer, then run gethostname, then check if the penultimate element
> of the buffer was written to, and if so, allocate a larger buffer.  Yucky,
> but possible.

That's what the gnulib version of xgethostname does [2], among
other things.

The more I read about gethostname and its weirdness, the more I
think we should import an existing, proven version of xgethostname
that returns an allocated buffer.  That way we wouldn't have to
worry about truncation or missing NULs or buffer sizes anymore.
What do you think?

I found the one from gnulib and from Neal Walfield [3] mentioned
in the Hurd docs; are there more?

René


[1] http://pubs.opengroup.org/onlinepubs/009695399/functions/gethostname.html
[2] http://git.savannah.gnu.org/gitweb/?p=gnulib.git;a=blob;f=lib/xgethostname.c;hb=0632e115747ff96e93330c88f536d7354a7ce507
[3] http://walfield.org/pub/people/neal/xgethostname/
[4] https://www.gnu.org/software/hurd/hurd/porting/guidelines.html#MAXHOSTNAMELEN_tt_
