Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE7BB20229
	for <e@80x24.org>; Fri, 21 Oct 2016 13:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932934AbcJUNLX (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 09:11:23 -0400
Received: from mail-vk0-f52.google.com ([209.85.213.52]:34733 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932905AbcJUNLW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 09:11:22 -0400
Received: by mail-vk0-f52.google.com with SMTP id b186so116470346vkb.1
        for <git@vger.kernel.org>; Fri, 21 Oct 2016 06:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1yoeYzez+QctSGARrWWXXvVJ/dnViwRm4DGHGjk3SY8=;
        b=ZqWySaPWfivUa0U7ixOQ35gIemFB0/BFFU+SasuRdFCHMPlPHfVuJB450Udos4VyNA
         M4en96o601RV0wh8PzydwsjfW50Z6iLu6uTFZWWBXIxO5htT2yzS+t3wljCfgeQmhIfV
         nqeMU/04uwXOVS3YpkJzKWChGof/3+ZOZ6xELY2JLaB0u2yDTmNIIhKl40Vmqwbg0iPt
         Z5RJOCAiBh6qpeCqID+eMhglz2eofUjpyE5gHhiZMpxYC7F1g63IChDsD29N2rspfe5M
         aJa+MnRc1ThOh6D/9s5lgsubbbx577UI47kT2S8VkMy7YF5kaCj3lw2+XJsrt8Iu/eJK
         Ej/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1yoeYzez+QctSGARrWWXXvVJ/dnViwRm4DGHGjk3SY8=;
        b=RmdXo6fZaZUrGfCDiLNezq3rXs3YGWjfQ7Zca3sYOcZpFfInpbGuQcxdLUVMR/3btN
         2uiBgIi1R6Y2YiwjRUh7z0RIuUBwy99jICH7j8UrWo+ExS7BEJpCbhKwCxYWR5+BgCZS
         gTHTUmOWJkAW3ZMpe2SCanDIUtR1Q/kNtTSZfdNvXJ9th2Rm1Oll3VRMU6jAJAZy5k1f
         qV9neN5Wobhyttu1gX5NQsMA0fqV2T5puijEcHZwqcan/k2X92Z6ioOz07w50foUQ0Pi
         vGKSdUP6tu4clCc59vRIs72+e09zORzfWYp8UbXqOgjWkhwuOrHNqbczafDo1oWW82yc
         +K7w==
X-Gm-Message-State: ABUngvd8HaqWorlWcltxmfdZHEHMAVqSzEtQxMLZvRL8FHnntEk9VsZPDDDt6WQ4sEKh1rIAcs9/h3PjXJXSXw==
X-Received: by 10.31.85.4 with SMTP id j4mr781444vkb.8.1477055481554; Fri, 21
 Oct 2016 06:11:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.47.133 with HTTP; Fri, 21 Oct 2016 06:11:00 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1610211437510.3264@virtualbox>
References: <CAJtFkWur0NfvvV-QT2XmEW=MSJ7Ye=hX7HujEQhTFGiah2_yBQ@mail.gmail.com>
 <alpine.DEB.2.20.1610211437510.3264@virtualbox>
From:   Stefan Monov <logixoul@gmail.com>
Date:   Fri, 21 Oct 2016 16:11:00 +0300
Message-ID: <CAJtFkWvXbKmWB=Aj4VEvPtWnTKj=zObxe6ow9Jn7DizcLoHT7Q@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Git_context_menu_in_Windows_Exporer_has_a_=E2=80=9Cgit?=
        =?UTF-8?Q?_bash=E2=80=9D_option_but_it_doesn=27t_work?=
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2016 at 3:40 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Are you referring to Git for Windows?
> Which version? From where did you obtain it?
I'm not sure about the answer to these questions, so to clear things
up, I'm downloading it anew now. Getting it from
https://git-scm.com/download/win .
I downloaded and installed Git for Windows, version 2.10.1, 32-bit.

Indeed the context menu option is now called "Git Bash Here". I don't
know what it was called before I installed this new version of git,
but now it works fine. I.e. no more auto-closing bash window.

Thanks for (indirectly) helping me resolve the issue. :)

On Fri, Oct 21, 2016 at 3:40 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Stefan,
>
> On Fri, 21 Oct 2016, Stefan Monov wrote:
>
>> The default git distribution for windows
>
> Are you referring to Git for Windows? Which version? From where did you
> obtain it?
>
>> contains, besides the CLI tools, a shell integration, i.e. a context
>> menu for Windows Explorer.  This context menu has a "Git bash" option
>> which I suppose should open a Git bash prompt cd'd to the current
>> directory.
>
> I guess you mean either "Git Bash Here" or "Git Bash" (not "Git bash")?
>
>> But instead, the git bash window opens and immediately closes, giving me
>> no chance to even see what it says inside it. Any fix?
>
> Sorry, there is not enough information to go on here. In Git for Windows'
> bug tracker, we were careful to provide you with a template that helps
> with providing relevant information:
> https://github.com/git-for-windows/git/issues/new
>
>> Note: Opening Git Bash from the Windows Start Menu works fine, but if
>> I open it that way, then I need to manually cd to the needed dir.
>
> For me, both work fine. For the record, I use Git for Windows (64-bit)
> v2.10.1, as downloaded from https://git-for-windows.github.io/:
>
>         $ git version
>         git version 2.10.1.windows.1
>
> Ciao,
> Johannes
>
