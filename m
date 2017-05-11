Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A32681FF34
	for <e@80x24.org>; Thu, 11 May 2017 07:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755317AbdEKH7h (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 03:59:37 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:36825 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755279AbdEKH7g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 03:59:36 -0400
Received: by mail-pg0-f45.google.com with SMTP id 64so10701073pgb.3
        for <git@vger.kernel.org>; Thu, 11 May 2017 00:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Em0Rqjat2zN7b/NGllohPulohMZudxdRJl6Eq0qWpWI=;
        b=hLuoHAnDeMuAt2+RHFEMz6zy3OlM0t3FiCKd8erqwLQJtN5kazjdJR7eg8vncSeQ3T
         sYJxDKToV37Q0ljX1LNLpwDz+FhL0a1kKlse/1iiXSd+ISzRchbO2K7BzrUtrApjTOzW
         K0dHYR1AwcvlT7qRIT4lZBGW0GyWvDyMMG6pmUw/yAAxwBxE2wI+6USBV4b0tcVnOQRz
         j650aX6bAt2YaAHDr4T6AzFBgjvp4QBWkJ3aT+bn7Nbc/4pUlrfnzL0E7oIgsqABsSXD
         BwW8XEk8hoQWvivUJ77MZgSunW+IWjV7MFvH7pXWd2ztkO9V7Zv7ZG85wJ4hn4cskDLL
         7Fgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Em0Rqjat2zN7b/NGllohPulohMZudxdRJl6Eq0qWpWI=;
        b=ol2gIxlZQtOrJLe8BCn6/p3nCOUr9NY3t2Qk30qgw50AtCLzk7eaDcmKArBmpPD54c
         NM0gJQ+Tl6Bt9GAKIgUciY25EVKzqsmXK5mb+JYOxLm07Nv6+o8NG9XnOBG8LSUpOLRx
         aIg3u4aerOK9oJJbAEg05YZUmV3JKIC/YL60fS6UghcgD5CnBDQ+WecwD3A9RX/7rERO
         BT+8PwHryFSQnfJ03pk2AQRycG82R0VdDkuwngYQcOL9uVI1mKKQWzCLQRWGP0hOudql
         dS0iczwBathKh91MIq9CYUoa71+XXDJoUCSezIG3i9bPVmPYsfm2ZL0cgi1gjzDZakgC
         Yvow==
X-Gm-Message-State: AODbwcA1Nco7d+cs7Oywgb6dbgTl0XXjTF50lmHZ0ESLVnz78GogIZ0D
        Y1g3Hnkljn4bVl1lESJmGCTgOtCCSw==
X-Received: by 10.99.250.69 with SMTP id g5mr8869235pgk.11.1494489575449; Thu,
 11 May 2017 00:59:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.141.87 with HTTP; Thu, 11 May 2017 00:59:34 -0700 (PDT)
In-Reply-To: <xmqqk25nc2s9.fsf@gitster.mtv.corp.google.com>
References: <CAEY4ZpMJbS+-xDKcwbOHCWxAdjOVuTN9DFJNHVqHw0r06CwKJg@mail.gmail.com>
 <xmqqk25nc2s9.fsf@gitster.mtv.corp.google.com>
From:   Nazri Ramliy <ayiehere@gmail.com>
Date:   Thu, 11 May 2017 15:59:34 +0800
Message-ID: <CAEY4ZpO108t=2TxmzeFrzHxeXzJ3V_MGv+fy2gH-ZtOXfP8zUw@mail.gmail.com>
Subject: Re: Should "git submodule update" accepts --init?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 2:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I am not a heavy submodule user so what I think may not count, but I
> think the "upstream" changing the URL of the submodule should be a
> rare and notable event.  Making it easy to automatically run "sync"
> without thinking would be a huge mistake---it will make it likely
> for users to blindly follow what the upstream has in .gitmodules
> without checking if the new URL is sensible.

Yes that would be a mistake for the case when we don't trust upstream.
But for the case that we do trust upstream, I would argue that we should
always follow what upstream told us to use when it comes to getting the
content of the submodule.

> Also doesn't "submodule sync" blindly overwrite URL, even the ones
> that you tweaked in your configuration to override to point at a
> mirror that is closer to you than the one suggested in .gitmodules?
> If that is the case, sucn a change to make it easier to run "sync"
> without thinking is doubly bad, I would think.

For such use cases I would suggest using url.<pattern>.insteadOf, instead
of changing what submodule.<name>.url.

My recent use case that prompted this question (I just realized that I typo'ed
the mail subject s/--init/--sync/) is this:

We are using git submodule for vendoring our Go dependencies. We've been using
it since 2015 and it has been great for this role. There comes a time when we
have to patch the vendored version so we do what is normally done - we fork the
code at github and made a pull request. This pull request may get rejected, or
accepted. For the latter case it may take some time for the acceptance to
happen - upstream owner may be away, or there are some cosmetic changes needed
etc, while on our side we need the changes in place for our build (and on
developer machines) to succeed so that it can be used in production (after
testing it in our staging). It is during this time that we want to switch the
submodule url (upstream github repo) to point to another submodule url (our
github repo)

Hmm after writing all of the above I wonder if we can't just use
url.<pattern>.insteadOf
to achieve this. But then url.<pattern>.insteadOf feels less official than
submodule.name.<url> so that's another point to think about.

nazri
