Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D00BA1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 21:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933035AbeFZVfT (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 17:35:19 -0400
Received: from mout.gmx.net ([212.227.17.20]:34603 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753059AbeFZVfS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 17:35:18 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M5IdH-1gNHHY0trj-00za4r; Tue, 26
 Jun 2018 23:35:15 +0200
Date:   Tue, 26 Jun 2018 23:35:13 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     dana <dana@dana.is>
cc:     git@vger.kernel.org, Wink Saville <wink@saville.com>
Subject: Re: [PATCH] rebase -i: Fix white space in comments
In-Reply-To: <nycvar.QRO.7.76.6.1806262329390.21419@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1806262331340.21419@tvgsbejvaqbjf.bet>
References: <614F0C12-7173-48BD-9212-71AD6FBBDAA7@dana.is> <nycvar.QRO.7.76.6.1806262329390.21419@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ATZrd362pGxeMEKVAhev21ez4vOvcuOVu0vkn8oWlqWmOoCtDfv
 ozcNq6Uy8QS/s+OzXlGmmxPUYuuBAzqy83ilbOQg9/4lZNlKn8I4PgFdfQ0iVmvX1L6yy6O
 ebeYMKTEFKgi1pnUy7W8W8BgdbS2AIAGSMqyV8rVafDcsq5wLmTr/KRR5oC55gDIBkK4bBx
 GIp/guaMBoFoEOjEtTteg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0YOBTQpjJMw=:cUT8bNITEkeF6XQd/wep02
 NMKGCB1KjlBNp4zMX3IqYbQ1EZ8lRdJb5xb0i4aEJnwPXVWl1YS+jpcfdTj8WyM4YyPrH7Fj5
 Hcsrv//mgacnSG4RWM2A+O5KsaYMmuKVUUf9UZAETT5fIKgFBIHLaSApqh0BCPY5zZx/VOCUQ
 aqkFwA+rZXqGYY//1WOUkKYbbY+w94gUnjrC3683aZ2D7K0KBTxxkqn2iT/8KVE2ijX/sKLr4
 F8MRTz4PooP7z5QE3JzIc8ra3CDn4cePzjdre86OvEwL1MtR8+iYpRuteF7adgJ95NrNLsgYr
 l0jeVAyQ5VeWIjvwe+hJKnqLvab1G/fi0bSHS7jhIxaw4VzdAY8SZt9b3B9tiC1MZOAvnjD8O
 lcYXiIEV+avmmpDvdx7WP/Z9yxt+UyEJ3wzramGsH/8X5BeRc7lpeko4z8+nHVk/9hc/5Z3L1
 xcq5Klv9PxqBlw/Bd2JsPfUtPysvp1NlipR2e9SXqSISiwpaIknoA4Y2rxifzELTNhBfGwzhZ
 7hb9C6iNykYc1E3IlJcvyTJGTOEU3a4KJHz2HjscNXC/1yc6yrgGJotFEVo5iOr1lqfWO6gWG
 c08IowsadXh4RHh6YNbU869BFw60YzoNMsRWN/VqJfPT/qL119O5dD/ETK10Ta/KF3kV04WUZ
 buAWFiWVRnbgxRRO5uIEQtsVyxE+u2M/37hAOJxQIyS/28Ub7LWzg5UNSx7jjziNcVWeUmpYd
 F3+vsxIpDOGQv4Hnyd0WFOdv/bG+OvFRUOSjr/PlGcVsf4Jee1dlZlkXYeteTpgFxb4ktxUmQ
 U4pjnG9VWi46eYP86i7iKw0fQkDZwzHw9npXXaMO3zYMnf8/GbzhFcYh6v/J+0JWnoE1ZYXh9
 m4B5CX0xw52ye7MOtW43pO9hjG4NAqD54f/F9F4mq0V+O/yeZHDiK/Ev8hsj4g5Jb+8xc4wV3
 a12101MpMbNe5mdaPPnpLS+0wHMKG2h4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

and now for the review...

On Tue, 26 Jun 2018, Johannes Schindelin wrote:

> On Tue, 26 Jun 2018, dana wrote:
> 
> > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> > index 299ded213..a31af6d4c 100644
> > --- a/git-rebase--interactive.sh
> > +++ b/git-rebase--interactive.sh
> > @@ -222,9 +222,9 @@ $comment_char $(eval_ngettext \
> >  EOF
> >  	append_todo_help
> >  	gettext "
> > -	However, if you remove everything, the rebase will be aborted.
> > +However, if you remove everything, the rebase will be aborted.
> >  
> > -	" | git stripspace --comment-lines >>"$todo"
> > +" | git stripspace --comment-lines >>"$todo"
> >  
> >  	if test -z "$keep_empty"
> >  	then

This does the job, and I am fine with this way of doing things, and there
seems to be a lot of precedent doing it this way e.g. in git-bisect.sh.

If my ACK is welcome, you hereby have it.

Ciao,
Johannes
