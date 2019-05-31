Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70F961F462
	for <e@80x24.org>; Fri, 31 May 2019 15:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfEaPLa (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 11:11:30 -0400
Received: from mail-it1-f177.google.com ([209.85.166.177]:55719 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEaPLa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 11:11:30 -0400
Received: by mail-it1-f177.google.com with SMTP id g24so3133147iti.5
        for <git@vger.kernel.org>; Fri, 31 May 2019 08:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ClvU/fxejKsgGbYUMu9A2X2AMdpQtIqSjq+H8ZQwe+s=;
        b=Zv5qSz5PrgQbOYVRfHYT/KPKxtwGUltD+SRtYsh4d+cXUZ1pL2WX/1UgyzWgkUbjzq
         387yhgn+vhXZB/4GHn+W9fA6Qx8KBLOyIZ0VDweVOaRiPbEe64y8iNij/VjqmQNYPf+7
         yWCdrnJUazftBzxBEkodNEIWWdyOr1cZt/B8igPx4UqesU1yKNV7h0Pn71mjgAeNtz6u
         J6V9OskDR2JWp4/6KnhwjXJAObj/DzPGNvOKtpNIStEyz7hl8Ha8l6iWaWOCQir6wCRW
         tLyfbt1BKTbueJD2dvt/gDGteM1DSkquxpKdfXpPLITLfkZ8DEDWKtKrjwGRUt4QH01A
         ClPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ClvU/fxejKsgGbYUMu9A2X2AMdpQtIqSjq+H8ZQwe+s=;
        b=Ail92R1m5ms0wfoUkMNMUnYULUOg64md8U8uSWQCB/nwRx2BB7YzCQyISBsRJeA3/M
         xCTZn4f5xktha5XTRq586e28Pi6bdZYuR1WISbJC4NWSHQLiGNYOZuCNE1abH1sSr/Os
         qUPAgK6aatKaX1lnphHLi6pvNmbuovceBPRrR9Qsp3L2xo9hWJ2XnYeseF7F5x+90FFK
         Of4k4DLWvl93OklUCNlrK5/ZvQP/MmBXc1yN/270YyOlIKfMh+MumjA3OXp0KvC1jupl
         j0mR3mj703W5UzOcQXNyyfLKCEVpY1P8sPRcXt1Q45ucs/2NC4vJkELRd2auMYgRkxFB
         S0sA==
X-Gm-Message-State: APjAAAUTWa8LKhzn6cY8jmblya6OaZjWrub0I4zpnhiBjtBjm7pkTLd5
        /r2vWKeu8Epl7phFtOV4D5s=
X-Google-Smtp-Source: APXvYqwDKf3zpFcIEi/jTfaZ/0B1t7S/+MxJPTpMH3wg7DCKv4e3mT/jlyiY0XlSdNYexuOUWa/mpg==
X-Received: by 2002:a24:3014:: with SMTP id q20mr7678173itq.4.1559315489344;
        Fri, 31 May 2019 08:11:29 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-grc-01-76-68-140-144.dsl.bell.ca. [76.68.140.144])
        by smtp.gmail.com with ESMTPSA id k22sm2044848ioa.20.2019.05.31.08.11.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 08:11:28 -0700 (PDT)
Date:   Fri, 31 May 2019 11:11:26 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Cliff Schomburg <clisc@microsoft.com>
Cc:     Patryk Obara <dreamer.tan@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Simple shortcut for "git push --set-upstream origin
 newBranchName"
Message-ID: <20190531151126.GA3465@archbookpro.localdomain>
References: <BN8PR21MB1156ED141AE2662BC5328A22B7180@BN8PR21MB1156.namprd21.prod.outlook.com>
 <BN8PR21MB1156F593DAEBD7194DA7041EB7180@BN8PR21MB1156.namprd21.prod.outlook.com>
 <BN8PR21MB1156DA1893F64814F1BE8709B7180@BN8PR21MB1156.namprd21.prod.outlook.com>
 <BN8PR21MB1156F7F3E7EFF9C8A60F33D0B7190@BN8PR21MB1156.namprd21.prod.outlook.com>
 <ac62f96f-0ebc-2dff-3365-781e6b9142a3@gmail.com>
 <BN8PR21MB115693C381F65E97AB65FA18B7190@BN8PR21MB1156.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR21MB115693C381F65E97AB65FA18B7190@BN8PR21MB1156.namprd21.prod.outlook.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 31, 2019 at 02:56:12PM +0000, Cliff Schomburg wrote:
> Wow, I did not see that in the man pages... but I see it now.  Thanks!
> 
> So I guess I would change my ask to this:
> 
> "git push -u"
> 
> Should default to "origin branch" if no parameters are provided.  Thoughts?

I'll do you one better. You can run

	$ git push -u origin HEAD

and HEAD will mean the current branch, so you'll only need to specify
the remote (in our case, origin).

Perhaps you could alias that to something like `git push-up`.

> 
> Thanks,
> Cliff
> 
> -----Original Message-----
> From: Patryk Obara <dreamer.tan@gmail.com> 
> Sent: Friday, May 31, 2019 10:51 AM
> To: Cliff Schomburg <clisc@microsoft.com>; git@vger.kernel.org
> Subject: Re: Simple shortcut for "git push --set-upstream origin newBranchName"
> 
> On 31/05/2019 16:45, Cliff Schomburg wrote:
> > I'm proposing a shortcut for this command.
> 
> What's wrong with "$ git push -u origin branch"?
> 
> --
> Patryk Obara
