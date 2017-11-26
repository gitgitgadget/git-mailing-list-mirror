Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CFB22036D
	for <e@80x24.org>; Sun, 26 Nov 2017 08:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbdKZIin (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 03:38:43 -0500
Received: from mail-oi0-f44.google.com ([209.85.218.44]:42083 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752053AbdKZIim (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 03:38:42 -0500
Received: by mail-oi0-f44.google.com with SMTP id p23so14392360oie.9
        for <git@vger.kernel.org>; Sun, 26 Nov 2017 00:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=assw28+8Vtjus8c5dnSi10L5QgwBc+QMdQq1Wxn/abA=;
        b=R+P/znFr/B3OZa9od3F56+ZPzekyuc/plzDaqPc8uTv8nEMDD4RXA0+dPvOWBM50NT
         RIBYyCil8MHhmCfDFHsp9NSOqBXOAvRCihB6Mh3ed7pwa+DAzXUFmh/0UVxJ9tU/vzNS
         E/T0uV6dQ7GSfjIAJDa0SQTDtUtq9hNSQcwrknjV7uHTnvqz16fR7e0jV+QutvqhxFhL
         qhU1fv7/htQhJoBPGtPmukJhefA5QBFX72bmXFUdnk1UtNBMNyLoj6Xbl/7mKuapaR6m
         W1raiKZB/Q03lTL7kVaAI/BCm3ES/mRSsTn8eVOVIst4ISKyvNNbNPaBRi0JUVpF4Ycg
         RbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=assw28+8Vtjus8c5dnSi10L5QgwBc+QMdQq1Wxn/abA=;
        b=BlGntZuv1oFHICGnCWdV7rZSfknQPGwMEc7VylrZD9n2KaqvNvLZyqTDAOEgjQiH+/
         gBeW+YtBw/deZS8nRqmC1led0xhKb2reW0fE4a8hISR0W7ba6hNyXS8WJjGelvzfiqma
         2VT4UTW8spVwLFv8PhBurM3aLw2dP0TMAYQ4aF3ydIneAmCmz1ZkvPhwr24frDJZrGIG
         x4Gh0Kom+1k/y3BZ+/G9veC4MvwxObLK5TX58g9sqz13BxFH/eD6CObRaNfKzR4+56cB
         Eq2R8acdhtDRBNuxFv+09bjjgfJVVAsRZaT54h4y8zABAH52BLOVjPWKS1vSVS80QT5v
         i95Q==
X-Gm-Message-State: AJaThX6TS5jdbocrIPw0TzFRpMmvZe10a48TCapybyAdyPkFUB/xcs0b
        RC9bLX7AsezrWTEH7+JAkMqEb8PA4EmsxET7Hto=
X-Google-Smtp-Source: AGs4zMbLe0jgjZKqIwhfp/bCpyo4+it56FHIWEeJr18Id4Yex656pDIYFzUrDCmpg+5vs8J4VJw2F9+zt/mJ9EnqKXk=
X-Received: by 10.202.184.69 with SMTP id i66mr13187271oif.261.1511685521842;
 Sun, 26 Nov 2017 00:38:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.108.78 with HTTP; Sun, 26 Nov 2017 00:38:41 -0800 (PST)
In-Reply-To: <alpine.DEB.2.21.1.1711252338050.6482@virtualbox>
References: <CAOeKBwpUDD_C5mQ54Aa2pj72aVkp9F2rkmGrSVMC81d6gJQRew@mail.gmail.com>
 <alpine.DEB.2.21.1.1711252338050.6482@virtualbox>
From:   Roberto Garcia <eltitorober1985@gmail.com>
Date:   Sun, 26 Nov 2017 09:38:41 +0100
Message-ID: <CAOeKBwprpzGYDjjgcaZwmuG4DXiWB-kHn+BekDTD18qSgXWpUg@mail.gmail.com>
Subject: Re: Clone repository computer A to remote B doenst work
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks you very much:
I have QNAP NAS,
Finally I have installed QGit (from forum QNAP because you can't find
in app center) from here:
https://forum.qnap.com/viewtopic.php?f=320&t=109649
I used SSH for create a bare repository in the server side.
Once it was created i went to the local machine and i wrote:
git clone user@ip:/my/path/in/the/server/git
I put my files, add and commit to the new git repository created by git clone.
Now i can use git push to commit the changes into the server

Thanks you very much!!!!!!!!!!!
Regards,
Roberto


2017-11-25 23:38 GMT+01:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi Roberto,
>
> On Sat, 25 Nov 2017, Roberto Garcia wrote:
>
>> I'm trying clone in windows a git repository to other remote machine
>> (NAS Linux based).
>> I have installed git for windows but i didn't installed nothing in the
>> other remote machine (NAS Linux based).
>
> You need a Git on the remote side. Otherwise Git will not be able to clone
> from there.
>
> Ciao,
> Johannes
