From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 5/8] reflog: rearrange the manpage
Date: Tue, 10 Feb 2015 15:42:18 -0800
Message-ID: <CAGZ79kY+AN6fmbBfCBdkUXiBSgJusFa7Jv2OS=n=EPXBpzp8EQ@mail.gmail.com>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
	<1423473164-6011-6-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 11 00:42:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLKRk-0000Ye-Un
	for gcvg-git-2@plane.gmane.org; Wed, 11 Feb 2015 00:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbbBJXmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 18:42:19 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:38279 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273AbbBJXmT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 18:42:19 -0500
Received: by iecrd18 with SMTP id rd18so240306iec.5
        for <git@vger.kernel.org>; Tue, 10 Feb 2015 15:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zY3p6MFm5kPM5XvaxR9y5o5SNyoBRYeB3jDpwFYTp40=;
        b=BQDwfbmN/lv3Aqd5T7o3691Ie7FILreJL8Pc64CQNPVyjaRpZ2OGaga5OshN/EsJy+
         Q2/JoskKp79uweEQe0qvYD6WT49syKOLxV9hyqAhww9qtJUvWyjvKVFHnh2JEPt+9AWB
         uixIDYn495yVCVxU1JAX1Zd/0s9th6Hk9EQMsLW3ykzW1rPG0bjxbTRl/I0uouTt/etR
         4hi9TRxmhIecM62jciz3erZjiBYtmeQkZKTCG7u4nhesfh0Hd84Z8+ApP9SFGrWn9Boi
         arJ3kjVzK2eBBb46AdTJiGAfxvuwbrIwtpkKOJF8seS4s81H6yadsjB00jyUBYIzNeEd
         prBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=zY3p6MFm5kPM5XvaxR9y5o5SNyoBRYeB3jDpwFYTp40=;
        b=mhnPuhxQm6jYfdFHe7HJHj0xbioGDHbJFThFW2Zua8fPVELDOmHdeGv9MoW7ZUyNbt
         y6aOnHUDXz+ptL4FI5RtM2GgeuB9EU4mOzvzEsJ0j/tx7xkex0Fz00vSJWm/VZLP9vlo
         PNGDHeuK7lILg5H3vB5QIiUtGyVuLSiyPLKjrc0t//vcs+9xo5avM6euQknuXEE5S2v6
         sCLwFwPi13SFcBzHUCzdn2qLzIf7Dc3aL9Hn16vfP5pUBrzvg30/+UByF11kvoL4e6cJ
         uC29Z2Frqe6iis6wWQ67YLc2kRV9WYMOfgV5NXewEy9NAL00SSdrOuRfcXAqdCNEYEOc
         ustA==
X-Gm-Message-State: ALoCoQnhUMSJ0Jyz+cqbaXvi8YCzs7tC/dL0ktTW6DdZjAf9524yGGKgjQYc+nyKh/c4MU4Ec5Ev
X-Received: by 10.107.18.148 with SMTP id 20mr7659918ios.34.1423611738421;
 Tue, 10 Feb 2015 15:42:18 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Tue, 10 Feb 2015 15:42:18 -0800 (PST)
In-Reply-To: <1423473164-6011-6-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263661>

On Mon, Feb 9, 2015 at 1:12 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> ---all::
> -       Instead of listing <refs> explicitly, prune all refs.
> +--stale-fix::
> +       This revamps the logic -- the definition of "broken commit"
> +       becomes: a commit that is not reachable from any of the refs and
> +       there is a missing object among the commit, tree, or blob
> +       objects reachable from it that is not reachable from any of the
> +       refs.

--stale-fix becomes more and more irrelevant over time,
so why not put in at the very end even after --all ?

Thinking out loud:
(--expire=,--expire-unreachable= and --stale-fix) look like a group
and (--updateref --rewrite --verbose and --all) also feel like a group,
so you wanted to keep --stale-fix after --expire-unreachable= ?

While talking about this man page, we should also add --dry-run?
