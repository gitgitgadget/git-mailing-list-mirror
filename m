Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 479F220899
	for <e@80x24.org>; Sat, 19 Aug 2017 10:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751546AbdHSKOm (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 06:14:42 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:37398 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750854AbdHSKOl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 06:14:41 -0400
Received: by mail-wr0-f179.google.com with SMTP id z91so69200926wrc.4
        for <git@vger.kernel.org>; Sat, 19 Aug 2017 03:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=y+/+0KIVifFOJOVaGY8ZGwXf7a++nw1OMaWJNSSOIww=;
        b=BgVXuCWc7LaVsohgos/DugqLIFwBHXRQPuNJY3+V2SfA5fROaMBwSbpoyHiWevH3to
         KOK9vCikki4ok9YdS9KMXReGhSZJQK3XYlbOLaL6SIlNjPi4+GWrrVoF/xqY57q4cjX8
         6trrUxvWNKSVLJmMIFGwEPRU4CopnxsbIbM2liHhrYCrD9hiTqzi/rstn7yeYiK4kaTx
         zZVPzOBRLhnFViIA2wG6g6/JYyv5HJge6WgrNIBvt3uTregCTv6SbQ+CUqZRj37sAOW2
         MyEoS+2vUhGxeNy3xva/5Mg+yKWPrKrnTfX7sCJM2XePPNWU7tWcol1fgsLjXHst20/X
         49Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y+/+0KIVifFOJOVaGY8ZGwXf7a++nw1OMaWJNSSOIww=;
        b=JHtPInn/lxqqwBbFT+/HAo/P36P51B625zwIASIhjb6ATdE6FTPhIdWB95blDRVbvV
         6+W5iPvZovAXOv5P30RpPy0Cv+dK+8sJFrQ+i/TbS7EEbfWnA+9BgkzwqUGHIZtbIxws
         PE6tC1aqKK3OJZOrRPhM/7EVHAdlhaSwToC3H2Xfwc0infkxQcYh55tEG+k/5i3GUzW2
         Ae5LAb0CSMBv1+TvqzY8RFCmLBZyK6pVSMA8Ja8BOyyUdcvfmMV13InhCt+J9DC7uRKe
         gFsL36EqbKXNp5RJdrgm76fGNu9CnXXMBpbbFRpHfXz8SUVjO4hhQ9HZHP/KaQ/lYwnH
         grcA==
X-Gm-Message-State: AHYfb5iR8nxeNozU6IVkvkbCFRwJQx0x7hKclGqKzuvvokzQH77fYURd
        oiBtAJGoHLL436WB
X-Received: by 10.223.162.139 with SMTP id s11mr5930677wra.25.1503137679663;
        Sat, 19 Aug 2017 03:14:39 -0700 (PDT)
Received: from ?IPv6:2001:a61:340e:100:2ca5:215f:d828:4970? ([2001:a61:340e:100:2ca5:215f:d828:4970])
        by smtp.googlemail.com with ESMTPSA id q16sm7326765wrg.44.2017.08.19.03.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Aug 2017 03:14:38 -0700 (PDT)
Subject: Re: git svn show-externals output format
To:     =?UTF-8?Q?Alexander_Gro=c3=9f?= <agross@therightstuff.de>,
        git@vger.kernel.org
References: <CACcHa=NYgir8HDeR1ES9mKsqTQYk=90Z38csTgK-vfD=fQmHLg@mail.gmail.com>
From:   Andreas Heiduk <asheiduk@gmail.com>
Message-ID: <165f5000-df53-0b62-6b06-d628a09d3076@gmail.com>
Date:   Sat, 19 Aug 2017 12:14:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CACcHa=NYgir8HDeR1ES9mKsqTQYk=90Z38csTgK-vfD=fQmHLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-BE
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.08.2017 um 10:24 schrieb Alexander Groß:

> $ git svn show-externals
> 
> # /trunk/
> /trunk/https://svn.code.sf.net/p/gc-webdav/svn webdav
> /trunk/https://svn.code.sf.net/p/gc-webdav/svn@1 webdav-at-revision

This is the (bugged) output of `git svn show-externals` for "new
style" svn:externals.

> 
> # /trunk/sub directory/
> /trunk/sub directory/https://svn.code.sf.net/p/gc-webdav/svn 'webdav in subdir'
> 
> An earlier version contains just one external:
> 
> $ git svn show-externals --revision 8
> 
> # /trunk/
> /trunk/webdav https://svn.code.sf.net/p/gc-webdav/svn/

And that the proper output for "old style" svn:externals.

> It seems like the output is inconsistent. [...]

SVN changed/extended the svn:externals format in version 1.5.
(See [1] for details). One thing is - they switched the
order of the arguments. `git svn` dit not pick up these changes
and hence interprets the new format incorrectly. See [2] for 
a similar discussion - it is from 2012!

> This makes consuming the output of git svn show-externals in HEAD
> difficult because the parts are not clearly separated by space and
> sometimes the path is the first element, sometimes it's a combination
> of first and last elements.

My practical solution was to skip the man in the middle and ask the SVN
server directly for the property values with something like that:

    svn propget svn:externals -r 42 http://my-repo-url/path/to/ext/dir

I used the output to hardcode the values during the conversion.



[1] http://svnbook.red-bean.com/en/1.8/svn.advanced.externals.html
[2] https://public-inbox.org/git/E59CCE45-6F92-4748-9B6E-2A562647904B@nikolaus-demmel.de/
