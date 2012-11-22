From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Remote hung up during `git fetch`
Date: Fri, 23 Nov 2012 10:21:35 +1100
Message-ID: <CAH5451mDb_rxT21sfQt3z15vQ7nKrp5NxwwbtpZHF-2WCOo1-w@mail.gmail.com>
References: <CAMvDr+R__wWRwm2xNC3-v0T1RVu_rKdjKUJhb8cHwEXvuX9OMQ@mail.gmail.com>
 <CAMvDr+QuMpfdTdkOMOiYyEnHvQjia2cDCt3sx2rQwwLcJiCVmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Yichao Yu <yyc1992@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 00:22:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbg61-0001YW-0J
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 00:22:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011Ab2KVXV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 18:21:58 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:56318 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993Ab2KVXV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 18:21:57 -0500
Received: by mail-qa0-f53.google.com with SMTP id k31so1230330qat.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 15:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=KuoOemY8o6SJtXaJeGq+rgPwWwStptwsX5eX9XJBHxQ=;
        b=YIzD9A2YM9FnXZMAtNHSsuq/biy51cJh2DNOGyO7ezq0WDpCjxmXH5VBAXjNOWP4/u
         SdDafu8BL1fAuchcI/J5EG+hi1dyxH+6tT4VckH98AyvxssvYXdZz+JgEQCHigfAC+rs
         NgFHKFpqVBwBnKJN1BPBdqyBvlSJ+GnvjhDOTRsQqk2X7oN6XS+TrLxCM9yLNhA+nn0P
         EcG36zUYcqlPFK+2M9bKLoJO2A1s4OxwdDJCAPV87FbBnmP0Z5AVA2F18QB1sBJV1vwc
         iBPVhgjj8hXbNDDubC4owISwBDGnhzYG0Os2aEKIgBdPrZlk2LzzPIzxzZOmxZ5I+Alq
         QW0Q==
Received: by 10.229.111.159 with SMTP id s31mr450641qcp.67.1353626516282; Thu,
 22 Nov 2012 15:21:56 -0800 (PST)
Received: by 10.49.119.65 with HTTP; Thu, 22 Nov 2012 15:21:35 -0800 (PST)
In-Reply-To: <CAMvDr+QuMpfdTdkOMOiYyEnHvQjia2cDCt3sx2rQwwLcJiCVmw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210225>

On 23 November 2012 05:39, Yichao Yu <yyc1992@gmail.com> wrote:
> Hi everyone,
>
> I sent this email yesterday to the git mailing list but I cannot find
> it in any archive so I decide to send it again.
> Does anyone know what has happened to the mailing list? I haven't
> receive any email from several kernel related busy mailing lists for
> several hours....
>
> Yichao Yu

Your original message just came through to me (I'm on GMail) so
obviously there was a delay somewhere in routing your message/s. Looks
like it was delayed by around 18 hours somewhere...
Looking at your delayed message more closely I can see that there was
a big delay just before vger.kernel.org got it.

From: Yichao Yu <yyc1992@gmail.com>
Date: Wed, 21 Nov 2012 23:18:34 -0500
Received: by 10.64.15.165 with HTTP; Wed, 21 Nov 2012 20:18:34 -0800 (PST)
Received: by 10.50.12.165 with SMTP id
z5mr1895031igb.17.1353557934382; Wed,  21 Nov 2012 20:18:54 -0800
(PST)
Received: by mail-ie0-f174.google.com with SMTP id k11so2625936iea.19
for <git@vger.kernel.org>; Thu, 22 Nov 2012 15:00:04 -0800 (PST)

Not sure if anyone else saw issues, but it is likely an issue with
your service provider (either gmail or gmail's SMTP routers). My other
gmail traffic has been fine over the period. Maybe somebody else knows
what happened :)

Regards,

Andrew Ardill
