From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: Re: More detailed error message for 403 forbidden.
Date: Sun, 31 Mar 2013 18:17:50 +0900
Message-ID: <CAFT+Tg-fvp-3s70y5UQH86pp_nu=HRNFye_kbRa7VJSQuv=iLg@mail.gmail.com>
References: <CAFT+Tg_PwAS__AYCwQQZjy4LVvAMZFJuJ+ediDJpRnxx73qMMg@mail.gmail.com>
	<20130328183601.GA11914@sigill.intra.peff.net>
	<20130328184120.GQ28148@google.com>
	<20130328184530.GA14691@sigill.intra.peff.net>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 31 11:18:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMEP9-00083n-6c
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 11:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755870Ab3CaJRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Mar 2013 05:17:51 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:62384 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755564Ab3CaJRv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 05:17:51 -0400
Received: by mail-ie0-f174.google.com with SMTP id aq17so1584131iec.19
        for <git@vger.kernel.org>; Sun, 31 Mar 2013 02:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:reply-to:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=n57dj6vgbqXuqd83FN825XMXbqu6J+5RQNhWOXLoCvg=;
        b=szw6+GGc0wZ70f5qDcKtAxqrkrEjMrkPTGfykUlMbCxr9stws2HDSeChed0wibqqZj
         Agu8qomMzV9tG1P/i6LGtedzENultosP8I9lXvORorFheR1EzIZtbyqcYSLq6x/wMXOH
         ssPQvRHGmMHUbO2ibReWLYkCJKxdRE6Dcd0hC7a5Bey+XbaVp15QQkAJa9WtiEYz3fGR
         JCRhkrcdfibfdisFp0Vnkx0aZMdQiTmhYuRaaq7a/UwjwDTgQlCIMScXD0o4PNP0OclX
         t8vtPzm9cW583AQhGYZMayzngf3SxaqU+wy782dWmsqF4Y3Nj0G1FWCpH9mN7T+nV8J8
         wj5A==
X-Received: by 10.50.7.242 with SMTP id m18mr1977677iga.53.1364721470726; Sun,
 31 Mar 2013 02:17:50 -0700 (PDT)
Received: by 10.50.89.229 with HTTP; Sun, 31 Mar 2013 02:17:50 -0700 (PDT)
In-Reply-To: <20130328184530.GA14691@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219609>

>
> Maybe. But I would worry somewhat about sites which provide a useless
> and verbose text/plain message. Ideally an x-git-error-message would be
> no more than few lines, suitable for the error message of a terminal
> program. I would not want a site-branded "Your page cannot be found.
> Here's a complete navigation bar" page to be spewed to the terminal.
> Those tend to be text/html, though, so we may be safe. It's just that
> we're gambling on what random servers do, and if we show useless spew
> even some of the time, that would be a regression.
>
> -Peff

I completely agree with you.

And should git client need to add x-git-error-message in Accept header
and/or perhaps language preference in Accept-Language header?

    Accept: x-git-error-message, */*;q=0.8
    Accept-Language: ko,en;q=0.8
