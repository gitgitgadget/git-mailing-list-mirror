Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 166FF2047F
	for <e@80x24.org>; Thu, 28 Sep 2017 03:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbdI1DHB (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 23:07:01 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:49897 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752589AbdI1DHA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 23:07:00 -0400
Received: by mail-io0-f172.google.com with SMTP id 21so420902iof.6
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 20:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pzfIkdunkz63NYH5ZfkJdbFje0BtZ32tO88zagHtOF8=;
        b=YVbdaeG57CJd9xGu15Io4RGjLWiakYtuZ2CzwNR8uZNmrcGLO8k4jkPjHZXwVQvZng
         w8JTBlX6+w9rB4zzp0nHvTl0O67lKD9u6W3IqqU5I3b5wdHUAwG5O1dOjl6vYTWmu1tx
         NrL1U4TdQEOyOFP8qL1xFMEPMTQPr8agc+CXhtr/nhDTCkorrVwQfiAzNC01JKQQr6V3
         MccEQ3OekVkoxcS8351o5K4fZvpsUD/tOP6Yifas0VLDuXgsjM54AlRfcaJrOEjciXoP
         /L1V6tgxlPkdf79PdLxJAWBzyLBYoABcdfAUVclWnB+cKipivmXG4bXvwR4+wjW4NR8X
         z+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pzfIkdunkz63NYH5ZfkJdbFje0BtZ32tO88zagHtOF8=;
        b=DLr+oLxdW3vomid39HhQ/djNJD0Crnx4rV6x/w54hJQw2hUnReAvio57GJlG3fo+rK
         eJ+6M6neZvOlWXFKyfDCyzkwuyUgr2jh9VYH3krLGs4iTUkocr/5Tq/TcVWyn3MWLLS/
         +Whgx5AIOB+HGh69/Cgi2xr7X5zaIFO6L7IAQcMIdTI3LwsCdAQXOgxblK8FS7nHk9Tm
         Jd3ZUBPNcjWFFpeHmGgUZTXiyPrAYv+wFkE7q4+5yg/lsW4kcvWMRbuyPW7muH0Pmv8h
         DYB6g8wVfk7XMvKGHmswq9fOQGWPg7gwZhdHb1dV0sxSHhmLYc1lhmQdXty64ZUY2olF
         63ag==
X-Gm-Message-State: AMCzsaUD1wIJNo6c6u/ixOJzUAqicd1mF3YczkZr5kA+GWt8AD+WdYtq
        760K9JskujVeRkkh0930TP1o0wsRY1iO1TEdIwclcQ==
X-Google-Smtp-Source: AOwi7QCex9qI22fJdmpVhdY5TDEoQokJaoKycii4ECoSKUMqgY1fuutUGwRfjenGcoQBwo3o0I025BKmiP4OhkgAcmk=
X-Received: by 10.107.20.14 with SMTP id 14mr5120887iou.69.1506568020179; Wed,
 27 Sep 2017 20:07:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.125.142 with HTTP; Wed, 27 Sep 2017 20:06:59 -0700 (PDT)
In-Reply-To: <1506561693.24644.2.camel@gmail.com>
References: <1506561693.24644.2.camel@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 28 Sep 2017 05:06:59 +0200
Message-ID: <CAP8UFD1XXg3m_xY9RC6HBoULxiL+jK-su_LbTLN=142uEznwVA@mail.gmail.com>
Subject: Re: Help
To:     Nityananda <nityanandagohain@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Sep 28, 2017 at 3:21 AM, Nityananda <nityanandagohain@gmail.com> wrote:
> Hello,
> I am new to this community. I am facing a problem while using the
> "make" command inside the "t/" folder.
>
> The error is
>
>
> "1..31
> Makefile:49: recipe for target 't5551-http-fetch-smart.sh' failed
> make[1]: *** [t5551-http-fetch-smart.sh] Error 1
> make[1]: Leaving directory '/home/nitya/projects/git/t'
> Makefile:36: recipe for target 'test' failed
> make: *** [test] Error 2"

Could you try running "./t5551-http-fetch-smart.sh -v -i" to get more
information about the failing test?
