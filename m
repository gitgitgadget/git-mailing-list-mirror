Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8915320179
	for <e@80x24.org>; Sun,  3 Jul 2016 08:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbcGCIVI (ORCPT <rfc822;e@80x24.org>);
	Sun, 3 Jul 2016 04:21:08 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38808 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbcGCIVG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2016 04:21:06 -0400
Received: by mail-wm0-f51.google.com with SMTP id r201so78612179wme.1
        for <git@vger.kernel.org>; Sun, 03 Jul 2016 01:21:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6pYLhK65qqfobhqNkKdYx4t83syS2tvlLIXbt20z4D8=;
        b=K+5U+odTqFfgvcEqv2p3J3BXgCdm8og9Usmqv6FvvpB6giud+y9mdcEcfIcw3gHTze
         OxBlGOcOyf846rbMOFXvcMlSFHNLK4XmyPrHmB+50PbkWrWPOOZO4DWhHJq2f4BAeOnu
         LphocoUudqHDOFU7S/eaJqGiqw15Mbn6KZy6t1fb8iHTC0mTbB/PBnF1dqX8MADgJUxk
         ROkBg40VOs7feZe4oDUAJ47CFs6QeYnJNLDzJdU9VDYm39R6OLDIJuNWROCyfH5EQMRd
         3y1CESXBH8UgqxdkrTylxeU/E6YklvqHjVzLndfQpEx85G7daB1vCGzdKqKu0a8ALeI/
         rmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6pYLhK65qqfobhqNkKdYx4t83syS2tvlLIXbt20z4D8=;
        b=hIxE7zJRayQIrqnZ5u+t+vdTHbbu6os1Ks+ybjK0xSHcF8wLUBoVZARgXOPCkDllsa
         yz4l6wDzSPFUsmw5tLjmeOCgT9kOAHODqqF0YqNJRlA5zbob/ECl2xCUuDwJ9xWJzqs4
         txpSzow9ki/govUeMgQREQOopkdkOw+9A45PETXCx1S+Y7s22qpQt2mcOpvCqHgyMOyX
         l9N2iogbvjMl/whIns+okcTvVcZBbeE3UfC2xQl1yXUCAQuViJcj/Kd4SYf9n1D059r0
         taAUtlt2RgBnx9LLqTzkhuGYyB7GOYJURROTO/UkMLXgN0v/XmrFUNKGAFvZBcs3q5Jv
         CCUA==
X-Gm-Message-State: ALyK8tIu0nkQ2toG0Wd8lPKC3asoGNMhdpG2QGkMmkn3KPJeWnNF7+TER8Y7hgOrPCbC+7PfnvhHwvASdmu18w==
X-Received: by 10.28.104.214 with SMTP id d205mr5922544wmc.102.1467534064627;
 Sun, 03 Jul 2016 01:21:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.82.170 with HTTP; Sun, 3 Jul 2016 01:21:03 -0700 (PDT)
In-Reply-To: <5772FF0E.6030503@micron.com>
References: <57728A17.3010207@micron.com> <vpq60stuyv5.fsf@anie.imag.fr> <5772FF0E.6030503@micron.com>
From:	David <bouncingcats@gmail.com>
Date:	Sun, 3 Jul 2016 18:21:03 +1000
Message-ID: <CAMPXz=oMhTr0r8CCS-4B0KzfTCps-bHx9CKyrGCAy2nAbUc5HA@mail.gmail.com>
Subject: Re: What's happening to the index
To:	"Andy Falanga (afalanga)" <afalanga@micron.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 29 June 2016 at 08:49, Andy Falanga (afalanga) <afalanga@micron.com> wrote:

>  Is there some sort of strange file caching that happening when
> make starts that, although the local db is updated, I don't get what I'm
> after?

I don't have time to look at your git issue, but I write this quick
note just in case it might help you to be aware that 'gnu make'
apparently does implement internal directory caching.

This is known to cause unexpected results in makefiles whose recipes
change the filesystem in ways that make does not notice.

See for example:
http://lists.gnu.org/archive/html/help-make/2015-02/msg00012.html

and related bug reports, for example:
https://savannah.gnu.org/bugs/index.php?41273

You might want to create a simple runnable example and ask on the
extremely helpful gnu-make mailing list:
https://lists.gnu.org/mailman/listinfo/help-make
