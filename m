From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: Gitignore matching "git add" wildcard prevents operation
Date: Fri, 15 Jan 2010 16:39:36 +0100
Message-ID: <20100115153936.GB12982@vidovic>
References: <4B4F6000.4070005@sofistes.net> <20100114195234.GA26684@coredump.intra.peff.net> <4B4F87A0.2090301@sofistes.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Marko Poutiainen <regs@sofistes.net>
X-From: git-owner@vger.kernel.org Fri Jan 15 16:39:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVoH6-0004Im-RR
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 16:39:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273Ab0AOPjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 10:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752780Ab0AOPjm
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 10:39:42 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:39997 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113Ab0AOPjm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 10:39:42 -0500
Received: by ewy1 with SMTP id 1so150295ewy.28
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 07:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=+tfIdBWiYKJTNH4AusdWFKiHKKfVicuYafcG80Aij6c=;
        b=VIvh9zR9E4JCwsrO5w6CPjUCzHkUCWIbMm9jWJHRlCfiTfulyMb+Dg4n3z8lyS1vVC
         fxVhkHA8q7UtV2GYbarysAPQsD0v9hKfHLoOxi6gP79d77td7qx9/eWfaUZXWlqAxU0n
         68BJWtfrcR93qYWmges5zSsQI/XH7O4PmYw3s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=p/VxRi8ltQ9qvB/TqZtNTO8GZCmxgJ3gxn9Ax3Kyxw+KAFEbpO8a52jzxBB+i4KvR/
         RM8lR02Bo+4ZkM1iiyDaAl+RKYab0S0nBdSgX+AQcfOVm5Gj9mZR8HZh0H2EzXPMbALf
         QjKs36wFl8B8IMzRC8PmIy403xQIBi9yvu8LQ=
Received: by 10.213.103.11 with SMTP id i11mr2525646ebo.63.1263569979980;
        Fri, 15 Jan 2010 07:39:39 -0800 (PST)
Received: from @ (91-165-137-43.rev.libertysurf.net [91.165.137.43])
        by mx.google.com with ESMTPS id 23sm2433380eya.3.2010.01.15.07.39.38
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 07:39:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B4F87A0.2090301@sofistes.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137075>

The 14/01/10, Marko Poutiainen wrote:
> 
> Well, it then the interface just isn't consistent,

But it is...

> Well, it then the interface just isn't consistent, because if that's the
> reason, then why does
> 
> $git add .
> 
> then work in this case? . is still just a type of wildcard, so it fail
> in a similar way, shouldn't it?

...because the dot isn't a wildcard. It's a path.

So, we expect 'git add' to recusively work and resolve ignored paths
from .gitignore and so.

-- 
Nicolas Sebrecht
