From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] config includes, take 2
Date: Tue, 07 Feb 2012 11:16:47 -0800 (PST)
Message-ID: <m31uq63143.fsf@localhost.localdomain>
References: <20120206062713.GA9699@sigill.intra.peff.net>
	<CAJDDKr6A2UvB3D-Dapw7WCEzWfzLoLd0E8MSDjT0RtdxFeWZAQ@mail.gmail.com>
	<20120207051719.GA11598@sigill.intra.peff.net>
	<CAJDDKr5yiKvNnpVV29jFK1Z1yuUnA-=dn0yMB8iW9y53vRGDHQ@mail.gmail.com>
	<20120207173025.GA22225@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 07 20:16:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuqX9-0002WQ-2E
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 20:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756413Ab2BGTQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 14:16:51 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:65471 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756144Ab2BGTQu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 14:16:50 -0500
Received: by eekc14 with SMTP id c14so2649726eek.19
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 11:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=PzDB3pCT+Utrl/kpDwgKeMWfqpYiE2QPdzaJ3nt9qu8=;
        b=gDib1MFFD7fOw82Y1bLle5tQOnL3cB1eXFXmTaZJJmFhZ1BIwRkF8qOvPjz7EltGm+
         4ZlSLtJu+i2dHJGyEZgFQUS+6Smuk5SapnBGiJEKm1EjuOg58ZrJ2kKAw2AaYVHCE/58
         EJ0ifwR7AmYIb1UOfv4R7OwhesL27uCKmTMJg=
Received: by 10.213.108.145 with SMTP id f17mr3787807ebp.113.1328642208173;
        Tue, 07 Feb 2012 11:16:48 -0800 (PST)
Received: from localhost.localdomain (abwl246.neoplus.adsl.tpnet.pl. [83.8.235.246])
        by mx.google.com with ESMTPS id e12sm76555983eea.5.2012.02.07.11.16.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Feb 2012 11:16:47 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q17JGjoT007986;
	Tue, 7 Feb 2012 20:16:45 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q17JGi6p007983;
	Tue, 7 Feb 2012 20:16:44 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20120207173025.GA22225@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190201>

Jeff King <peff@peff.net> writes:

[...]
> Git-config could potentially help with that (and even simplify the
> current code) by allowing something like:
> 
>   $ git config --list-with-sources
>   /home/peff/.gitconfig user.name=Jeff King
>   /home/peff/.gitconfig user.email=peff@peff.net
>   .git/config core.repositoryformatversion=0
>   .git/config core.bare=false
>   [etc]
> 
> (you would use the "-z" form, of course, and the filenames would be
> NUL-separated, but I made up a human-readable output format above for
> illustration purposes).

That would be _very_ nice to have (even without includes support).

Filenames would be git-quoted like in ls-tree / diff-tree output without -z,
isn't it?  And is that TAB or SPC as a separator?
-- 
Jakub Narebski
