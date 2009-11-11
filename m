From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: excerpts from tomorrow's "What's cooking" draft
Date: Wed, 11 Nov 2009 10:54:57 -0800 (PST)
Message-ID: <m3pr7osxgv.fsf@localhost.localdomain>
References: <7vbpj9s8vk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 19:55:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8ILe-0007GK-RN
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 19:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758457AbZKKSyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 13:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758375AbZKKSyz
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 13:54:55 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:56040 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758505AbZKKSyy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 13:54:54 -0500
Received: by fg-out-1718.google.com with SMTP id d23so1688800fga.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 10:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=OssqCloqjrI7Zijf1ezV6+wC/YRok5ci6dXyIR/G7Sg=;
        b=I4waqIIbNhkSDGTWfHtdOqfPoglGkza2MbPA3Rmv9Yx6iyPpXLupFYSPJz8Qh5K60j
         c877SsCC0s5gNyLOKM7IhcMlSSC+gQxN5rEVU8x/8tMOt6A+CXedQjvwrQsYaIpcSQkG
         huTQ0w5an+nkrUKBkogTcQ9OrpxBZKd9nWpUM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=iY2gDrVW4gRRKH9rY1cstkOhV/KCk7aS6E+9gHVwU4jPfEfO8en/VsIG76sQR1rHvf
         YdHvdP0i1svpPX+YBcXaCiqdHtEF4V+Z6jfI/sEP5nCZBBJhabFPYMb0N6uIBFzTl+6O
         EO90GQzowOKEcZGxObAEgyhOdbmVojqwYW2aE=
Received: by 10.87.62.10 with SMTP id p10mr1372818fgk.24.1257965699183;
        Wed, 11 Nov 2009 10:54:59 -0800 (PST)
Received: from localhost.localdomain (abwa45.neoplus.adsl.tpnet.pl [83.8.224.45])
        by mx.google.com with ESMTPS id d6sm11373057fga.25.2009.11.11.10.54.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 10:54:57 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nABItGfx032197;
	Wed, 11 Nov 2009 19:55:16 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nABItD06032194;
	Wed, 11 Nov 2009 19:55:13 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vbpj9s8vk.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132687>

Junio C Hamano <junio@pobox.com> writes:

> I'll do the full-list at the end of my git Wednesday, but here are the
> current highlights I am sending out to hear opinions from people.
> 
> Please note that I haven't caught up with the patches from past 12 hours
> or so.
> 
> ----------------------------------------------------------------

> * jn/gitweb-blame (2009-09-01) 5 commits.
>  - gitweb: Minify gitweb.js if JSMIN is defined
>  - gitweb: Create links leading to 'blame_incremental' using JavaScript
>   (merged to 'next' on 2009-10-11 at 73c4a83)
>  + gitweb: Colorize 'blame_incremental' view during processing
>  + ...
> 
> Ajax-y blame.  Any progress or RFH?

I have reordered two top commits (those that are only in 'pu'), but I
didn't improve "Create links..." commit.  Current version works, but
is suboptimal.
 
I wonder if Packy has any comments about 'blame_incremental' series...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
