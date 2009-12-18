From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] read-tree: at least one tree-ish argument is required
Date: Fri, 18 Dec 2009 14:17:15 -0800 (PST)
Message-ID: <m3d42cc4i8.fsf@localhost.localdomain>
References: <4B274BDE.8000504@viscovery.net>
	<fabb9a1e0912181137t1265f86cs9e02019da136a0a@mail.gmail.com>
	<7veimsvz8a.fsf@alter.siamese.dyndns.org>
	<200912182304.27656.j.sixt@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Dec 18 23:17:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLl8t-0003Mz-Je
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 23:17:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbZLRWRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 17:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbZLRWRS
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 17:17:18 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:44127 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbZLRWRR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 17:17:17 -0500
Received: by fxm21 with SMTP id 21so3257378fxm.21
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 14:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=AJtqG0Lq2CpciSHSjF2/gec9tPNBCL+ZjKle+ZOQfgk=;
        b=FNohgZg1EKsRvYfQs6gIl5ZS3fF0mMIiK0BPKVWfxLaDDxWTRLn5vwAdt+GEvSppHy
         5nQeTNiw96LcuZoFkF3AwaXe4Fx+z6YHCxhFwoGxX3WG+aeN4m5ZpAz6siGcxJGvnL4p
         5YdoFQxrMlDP38DlKS56KSOUvtyWkdRS9u5zo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=FG6fvdFckOoUEgiXaVq0qYGAr6IsKKasyIXkIj0jt+Q+apzDA+2nhjs/Si5sNbDdTb
         XNDRryePuj6mvAIUMgb0j5lpF+idNendmkWvZy9XDmF+x648I1BJ7LZHN8aV/sw1VNjJ
         nQzSxbunbbt/MzZlXwgU/5uZON6nov2AzjAyI=
Received: by 10.223.17.65 with SMTP id r1mr6059654faa.5.1261174636364;
        Fri, 18 Dec 2009 14:17:16 -0800 (PST)
Received: from localhost.localdomain (abwt9.neoplus.adsl.tpnet.pl [83.8.243.9])
        by mx.google.com with ESMTPS id 26sm5584541fks.50.2009.12.18.14.17.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Dec 2009 14:17:15 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nBIMGdrP015070;
	Fri, 18 Dec 2009 23:16:49 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nBIMGGou015056;
	Fri, 18 Dec 2009 23:16:16 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <200912182304.27656.j.sixt@viscovery.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135444>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Running read-tree without any arguments purges the index, but this is not
> documented. This behavior is dubious at best because contrary to many
> other commands, it does not use HEAD if nothing else is specified.
> 
> If one really wants to clear the index, this can be achieved with
> 'git rm --cached .' or 'rm -f .git/index' in a more explicit way.

One can (I think) also always use "git read-tree <empty tree>",
where <empty tree> = 4b825dc642cb6eb9a060e54bf8d69288fbee4904

-- 
Jakub Narebski
Poland
ShadeHawk on #git
