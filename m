Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48790207B3
	for <e@80x24.org>; Thu,  4 May 2017 09:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751822AbdEDJr3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 05:47:29 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:36740 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbdEDJr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 05:47:27 -0400
Received: by mail-wr0-f178.google.com with SMTP id l50so4674610wrc.3
        for <git@vger.kernel.org>; Thu, 04 May 2017 02:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cz4K7OrVTOxzvpf7Km6hfHOQ0C+HmGsl0z4bqhof/Do=;
        b=xcLk+tE+wgfwBTQdJ+vLkhi6eCbU2OvpeeOXQzFpdEJw10hlXsFGV8iciLO/gmM7la
         XdkZi82dGstUQ21+CVIuNzJ0CideAH30Q9/fP9mf4HhlXQf7ujI6+z4UzEv2Tu404jvu
         aCo0eF6FNzo+A+7zvI1K7OyBw4nfij5pjKic0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cz4K7OrVTOxzvpf7Km6hfHOQ0C+HmGsl0z4bqhof/Do=;
        b=ZmcIV7fC4fQVRjrjoBqBFdaxEy5EOkjXx736ogGj2tOcpxzPYb9NBryqKYNvU9+rrp
         82nuge5JzJkXU6CkQ3LueCZnTfxjEz09yhiFgA1Obzgc9PefvW9sHt+akNRTy5cgZieA
         HpboYgQiNaoLWhNQOv7fnVuQa+nu+4y6sr6NCCkwVccwNq8bjw1wwWyLY9aqgScQYIo+
         uY+biRLacPokBH/56q3EseyZTN6CjA6KQJx+bRoOPHIvB5Z51Q9A3VCfr6lIhBlr/cNi
         hFmK/Zf6d9eSMGt62Pbjqyf9dW1vcTFZL2MSqwwEmgTYscX97whDwk37WMfqXRZJbcOR
         A4qg==
X-Gm-Message-State: AN3rC/6q8h6j/9yQ9MCfO8f7HAqlD+JafuU7JOAno8whfaAxd5jkZoDr
        XTzbg5b7rVU4LDwXW44=
X-Received: by 10.223.173.74 with SMTP id p68mr26222692wrc.163.1493891246393;
        Thu, 04 May 2017 02:47:26 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id o97sm928868wrc.48.2017.05.04.02.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 May 2017 02:47:25 -0700 (PDT)
Date:   Thu, 4 May 2017 10:47:19 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        ankostis <ankostis@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: CYGWIN git cannot install python packages with pip
Message-ID: <20170504094719.GA3238@dinwoodie.org>
References: <CA+dhYEX+GgEHnVBnLQqnNW99xpf9kWcataTTt3Ya6ivGFgscMw@mail.gmail.com>
 <alpine.DEB.2.20.1705031147040.3480@virtualbox>
 <CA+dhYEUCJghqDQyBrL71Q=JKokcH-nhQ9WZzBb19-gonxi7o=Q@mail.gmail.com>
 <alpine.DEB.2.20.1705031630540.3480@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1705031630540.3480@virtualbox>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 03, 2017 at 04:32:15PM +0200, Johannes Schindelin wrote:
> On Wed, 3 May 2017, ankostis wrote:
> 
> > On 3 May 2017 11:47, Johannes Schindelin wrote:
> > > On Tue, 2 May 2017, ankostis wrote:
> > >
> > >> On Windows, with Cygwin-git 02.12.2-1 the python command:
> > >> [...]
> > >
> > > You forgot to mention what python/pip you use (is it the Cygwin one,
> > > or a standalone one?). Intentional?
> > 
> > I have tested it on using WinPython[1] 3.6.1 & 3.5.3.
> > WinPython is built out of the "standard" python on Windows.
> 
> I am afraid that you run into path conversion problems here. /cygdrive/d/
> is something Cygwin understands, but not WinPython nor Git for Windows.
> 
> It appears to be difficult to impossible to mix Cygwin with non-Cygwin
> executables...

Confirmed: the Cygwin project as a general rule doesn't support this
sort of mixing of Windows and Cygwin tools.  Either use Python and Git
packages both provided by Cygwin, or both provided by Windows.

Mixing and matching does work sometimes -- as was apparently the case
with Cygwin Git v2.8.3-1 -- but it requires care and you're generally on
your own with it.

Adam
