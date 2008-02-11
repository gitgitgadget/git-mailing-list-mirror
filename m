From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: fatal: Entry 'xxx' not uptodate. Cannot merge.
Date: Mon, 11 Feb 2008 03:03:13 -0800 (PST)
Message-ID: <m37ihbg3h0.fsf@localhost.localdomain>
References: <30929dfe0802102248p1f1cca44q4cec26a3237a3f20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Donuvi Tanoga" <donuvitanoga@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 12:03:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOWRz-0001H2-SK
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 12:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526AbYBKLDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 06:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754318AbYBKLDR
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 06:03:17 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:61132 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753015AbYBKLDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 06:03:16 -0500
Received: by fg-out-1718.google.com with SMTP id e21so3766894fga.17
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 03:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=OYqkQWGMcsp4TQ9SGZ2U4Y0jqXt+8sNBdZrC8UeWVEI=;
        b=CWCDtBKn/1Xr5eNt7u3cwuge8BPu+WBK4Izoh9/2CEyUXIVdEhBep6DX5FtAj1/BO7yUX5+6ZuD2WtV+5tG+tC4T1sRKGx5jwIOTiBy1SU4qdZKMFJkAjE4tzJrPbi2QHZgBQSJ0/gjC09wXrAyLRo6NN02qxKKeagyPZrWhLl4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=L9q7HvcSfy+fyZW2ETNKFiLRMQeupnjnQQJDuaYFRo0WxDYD08B/ddgNbceBXzYHGVBBJrHheTehojDggwYCX7I4UZ4z1TNKPMwHcdtQV8YLVeEhZI3uvLHc7mNJQYFmIntuB1SetBBYLxqIm7lo0N339AWhBcAOryl/t5vSYrE=
Received: by 10.82.172.10 with SMTP id u10mr29276037bue.14.1202727794605;
        Mon, 11 Feb 2008 03:03:14 -0800 (PST)
Received: from localhost.localdomain ( [83.8.220.19])
        by mx.google.com with ESMTPS id g9sm19576359gvc.4.2008.02.11.03.03.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Feb 2008 03:03:13 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1BB39iA005191;
	Mon, 11 Feb 2008 12:03:09 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1BB38xS005188;
	Mon, 11 Feb 2008 12:03:08 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <30929dfe0802102248p1f1cca44q4cec26a3237a3f20@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73515>

"Donuvi Tanoga" <donuvitanoga@gmail.com> writes:

> I have a problem I don't know how to solve.
> 
> When I do git pull (on linus' tree), I get the following:
> 
> Updating 9b73e76..19af355
> fs/binfmt_elf.c: needs update
> fatal: Entry 'fs/binfmt_elf.c' not uptodate. Cannot merge.
> 
> This is 100% my fault, and not a bug (I probably
> accidentally changed it or something).
> 
> Can you please help me to fix it ?

http://git.or.cz/gitwiki/GitFaq#head-6f976e553404993ae6353d939a7fb3f3321208d8

Although I think that this error message could be improved.
This message from what I see is from the ancient times, before
even v0.99 (commit 02ede67ad45973f9f8d07db7).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
