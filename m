From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: [PATCH] Verbose git-daemon logging
Date: Fri, 23 Sep 2005 08:08:02 -0400
Message-ID: <118833cc05092305083757bd9b@mail.gmail.com>
References: <20050921213933.GB10575@pasky.or.cz>
Reply-To: Morten Welinder <mwelinder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 14:10:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EImLk-0001GX-A6
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 14:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbVIWMIF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 08:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbVIWMIF
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 08:08:05 -0400
Received: from qproxy.gmail.com ([72.14.204.203]:52494 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750900AbVIWMIE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 08:08:04 -0400
Received: by qproxy.gmail.com with SMTP id f11so181851qba
        for <git@vger.kernel.org>; Fri, 23 Sep 2005 05:08:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FZyokZLw4njoJNxBa2x+wzdVVr0DgZhyAT4De4IpvdmcUBCLP9Nf8qS5t967tgAJhrj6YbQnehj+6jl7e3VmIXq9LA9C82OlbRYMx/8NdxoyBx8y3uJ8xQJHus0rLD05doXSn3wLpiXtdmEDp6uquIYGmcZXN4jNxYuyYtf6uRM=
Received: by 10.65.100.12 with SMTP id c12mr231370qbm;
        Fri, 23 Sep 2005 05:08:02 -0700 (PDT)
Received: by 10.65.107.8 with HTTP; Fri, 23 Sep 2005 05:08:02 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050921213933.GB10575@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9179>

> +       buflen = snprintf(buf, 1024, "[%d] ", getpid());

pid_t is not int.

Please cast it to int, or use %ld and cast it to long int.

Morten
