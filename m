From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: history of a renamed file
Date: Wed, 23 Apr 2008 06:25:19 -0700 (PDT)
Message-ID: <m3y774putc.fsf@localhost.localdomain>
References: <480F3369.5080203@melosgmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christoph Duelli <duelli@melosgmbh.de>
X-From: git-owner@vger.kernel.org Wed Apr 23 15:26:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoezG-0001Of-6i
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 15:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbYDWNZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 09:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752849AbYDWNZ2
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 09:25:28 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:7645 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154AbYDWNZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 09:25:27 -0400
Received: by nf-out-0910.google.com with SMTP id g13so996338nfb.21
        for <git@vger.kernel.org>; Wed, 23 Apr 2008 06:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=H3eYvM7L3jgCgL8Vf0pe0O01GDnZhhucqtdwuQSSjaM=;
        b=bZA9otoTy8HFzFcta4bn/w9G7uqnQx3/cz55/tgMa8LWxJ3fulHwT8BKPs6Ul5jfH1O+P9z1E5ZUayIm7Zs7AF1PMsaZskD8Pn+OwCNwb4x/TiN8oi+swYRaWjQ686pUYh3UUA+rDB/zR0QZfUe4PHxDnGd4hDIf46cS/V32oT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=iamgkRPSU0PxeeGwXOCvSxs/MdVbPtg7EDBYbpP/BvdcPw/e8Pi3jX/eXDFd7NJmrfKtozPUmJUH0ispMHBSMkOFbYdCQUh5PbamGaMOa0/HKlH4l5Gqz3oNDZdYiuOgqiqE1wZvUGZTZl2Eag7UoHHBWtUbV8MWSBTGa1hUY9I=
Received: by 10.78.137.14 with SMTP id k14mr1086743hud.9.1208957124846;
        Wed, 23 Apr 2008 06:25:24 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.240.211])
        by mx.google.com with ESMTPS id i3sm59597nfh.28.2008.04.23.06.25.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 Apr 2008 06:25:19 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m3NDPLRJ012245;
	Wed, 23 Apr 2008 15:25:21 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m3NDPJLg012242;
	Wed, 23 Apr 2008 15:25:19 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <480F3369.5080203@melosgmbh.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80216>

Christoph Duelli <duelli@melosgmbh.de> writes:

> Given a repo that contains a file x.c
> that got renamed from
>   some/path/x.c
> to
>   new/location/x.c
> 
> Is it possible (ideally with gitk) to view the complete history of
> what is now new/location/x.c *including* the history of changes that
> occurred when it stil was some/path/x.c?
> When I say "gitk new/location/x.c" I get just the changes made
> starting with the rename.
> When I call "gitk" and look for the changeset, the rename is detected,
> though. Therefore I hope that it is somehow possible to obtain the
> complete file-specific history without truncation at renames.
> 
> Any ideas?

Try --follow option, see git-log(1), although I'm not sure if gitk
supports it (it should).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
