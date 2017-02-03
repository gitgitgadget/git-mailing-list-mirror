Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88DEE1F6BD
	for <e@80x24.org>; Fri,  3 Feb 2017 20:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752463AbdBCU5m (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Feb 2017 15:57:42 -0500
Received: from mail-vk0-f48.google.com ([209.85.213.48]:34130 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752452AbdBCU5l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 15:57:41 -0500
Received: by mail-vk0-f48.google.com with SMTP id r136so21262435vke.1
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 12:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KO/ZosMLUO7eWkzA2NCMiZeVKRocj/RK8WQMyOCPY2w=;
        b=qfgto17Gj4P3zqfPeKiAUdv7VmeecV2R62A1eVj69wS8+bKIp1N+H0nJ9ekzS8KQd8
         v5/8N92CJe8S8LXQYi9rqr5qHbEYbvL08PxNbHJSLDOWea5Oe/Kr1/srnWNukQ6BUDUt
         I36xSJcUMkxnVmamkBkeTcvI6Di/7GEfpcXejb68kXq+Veb1r/PCdzA/VLJ4nrnEuRc1
         Jr7BX8NOZjIDqZ+o/UXRKE5DIuKnvbagUcgJHAzALpChoEBzCVnspWN7UpX5Sq+uGc+W
         0PdSKoFEJ7UuUwLZjr3bhwox4Y5EJEvMaiWtLIkNGu++VEqtiVMKOBGzKRstgESkxYdm
         3tQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KO/ZosMLUO7eWkzA2NCMiZeVKRocj/RK8WQMyOCPY2w=;
        b=FNTRWeRMlsMDOLiUhHU8SJ336Raue0847G/4BH16TcnhMbch608dMSmC4+Ya+O3YV7
         xPvC7ANBs3E9+VwZ25grkq6pP2uph/mLJ2WEijVCnFC5WzdLlNxSl4pZ1sc/AGuv/EIZ
         lcWkNZzkZB3GrcCbITUA+JWZznSLUTC2wsp5qYUrFs1PvI2WoFqp+2v9PtpE6j5kfp2h
         2ZsI+aoL/UeE5BD1rm6aKQa6tSHTTDhAxvyU+/rdJ/SK3xwUsJlF72RFi+gHEiv7spbe
         8/HIUkaHh4iOrtSM8fNPX0/TLgM9F5c0z9mLyLgGK+Z98vhbszeQKcNwcsMkH1had384
         Jgrg==
X-Gm-Message-State: AIkVDXJzkdmI/qzSo7v/PWKrlGGJ2n28tp1ARhL19TRng8BpCVWB9FP+2eipk8+xOaTJ3yPtAgvQb/n0QFojcw==
X-Received: by 10.31.115.142 with SMTP id o136mr7542193vkc.139.1486155460324;
 Fri, 03 Feb 2017 12:57:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.34.48 with HTTP; Fri, 3 Feb 2017 12:56:59 -0800 (PST)
In-Reply-To: <20170203115814.vxn33ivuhrnxmkzf@sigill.intra.peff.net>
References: <20170202023349.7fopb3a6pc6dkcmd@sigill.intra.peff.net>
 <20170202043610.GA12738@starla> <CAJZjrdUGsp5-HsA0Hxk4Qo+2s6crLbu-LuX=ECuC2QpM6HCWgg@mail.gmail.com>
 <20170203115814.vxn33ivuhrnxmkzf@sigill.intra.peff.net>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Fri, 3 Feb 2017 14:56:59 -0600
Message-ID: <CAJZjrdVOZrCAa9s72zYrQv8wY+DezrENzA0AgT_Bgr-oMgsFTA@mail.gmail.com>
Subject: Re: git-scm.com status report
To:     Jeff King <peff@peff.net>
Cc:     Eric Wong <e@80x24.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 3, 2017 at 5:58 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 02, 2017 at 12:54:53AM -0600, Samuel Lijin wrote:
>
>> In theory, you could also dump the build artifacts to a GH Pages repo
>> and host it from there, although I don't know if you would run up
>> against any of the usage limits[0]. The immediate problem I see with
>> that approach, though, is that I have no idea how any of the dynamic
>> stuff (e.g. search) would be replaced.
>
> I've talked with Pages people and they say it shouldn't be a big deal to
> host. The main issue is that it's not _just_ a static site. It's a site
> that's static once built, but a lot of the content is auto-generated
> from other sources (git manpages, Pro Git and its translations, etc).
>
> So there's work involved in moving that generation step to whatever the
> new process is (it's fine if it's running "make" locally after a Git
> release and pushing up the result).

Yep, noticed that when I cloned the repo the other day. Still
wrangling with my own setup so that I can build everything locally. I
imagine it would also be possible to set up some sort of CI/CD
pipeline to handle generating build artifacts automatically; so to be
honest, I don't think any of the static assets would pose a
significant problem.

The bigger issue, in my opinion, is that there seems to be a fair
amount of non-trivial back-end stuff
(https://github.com/git/git-scm.com/blob/master/spec/controllers/site_controller_spec.rb,
https://github.com/git/git-scm.com/blob/master/app/controllers/site_controller.rb)
including an Elasticsearch layer. (The redirects would be mildly
inconvenient to handle with Pages, but like the static asset
generation, should be more than doable.)

>> A question: there's a DB schema in there. Does the site still use a DB?
>
> It does use the database to hold all of the bits that aren't checked
> into Git. So renderings of the manpages, the latest release git version,
> etc. AFAIK, it's all things that I would be comfortable committing into
> a git repository.
>
> -Peff

In the meantime, I've also pinged a friend at Digital Ocean about
their hosting options and they've expressed interest. At the very
least, they seem to offer a lot more than Heroku for 230$/mo[0], and I
imagine it wouldn't be impossible to reduce the hosting costs by an
order of magnitude. Think it's worth looking into?

[0] https://www.digitalocean.com/pricing/#droplet
