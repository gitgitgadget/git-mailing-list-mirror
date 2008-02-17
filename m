From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add support for host aliases in config files
Date: Sun, 17 Feb 2008 10:48:51 -0800 (PST)
Message-ID: <m3zltza06r.fsf@localhost.localdomain>
References: <alpine.LNX.1.00.0802171337000.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Feb 17 19:49:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQoa8-0000SY-RT
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 19:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759AbYBQSs5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 13:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753718AbYBQSs5
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 13:48:57 -0500
Received: from mu-out-0910.google.com ([209.85.134.186]:37466 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329AbYBQSsx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 13:48:53 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1268259mue.5
        for <git@vger.kernel.org>; Sun, 17 Feb 2008 10:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=pvntl+2+boxtxyX7GeFu1Z2Kb2J0hRISl5c7DrFAlZg=;
        b=ItMVHQYIPEWx44D9pTumEo6OkArtxN4vYj59zBebnBv+NJP3Y7TKPUQspjPb1vIQaZODk3mkg77f+8HeVLkLrxZDs+CcwTBT3WXrCJhKMTQyrNNN6ZtGH5UluF5n1blZHxKSufK3hIQrfXFBRAtrkszvW9PGcF5mQjMgZ4dNMhI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=b4Jsm/0zyFbCzSseiAgKQBXUcJHCJWY0u/tkDFfS6DLw5na1f4VTav7GG6jVhKp/d53sbfujVIoxYUQXeQrcA/h1YcjXa3hhEBn2d3oVyC0jF2i+V8X+4ixc5W+89Lc3V9zC8aKk4/wS9ot1cJT41qs3nXeIGnybKuXJBauzmmM=
Received: by 10.78.129.16 with SMTP id b16mr7604278hud.3.1203274132105;
        Sun, 17 Feb 2008 10:48:52 -0800 (PST)
Received: from localhost.localdomain ( [83.8.248.52])
        by mx.google.com with ESMTPS id c5sm679020nfi.2.2008.02.17.10.48.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 17 Feb 2008 10:48:51 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1HImkgH030880;
	Sun, 17 Feb 2008 19:48:46 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1HImiUN030877;
	Sun, 17 Feb 2008 19:48:44 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LNX.1.00.0802171337000.5816@iabervon.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74163>

Daniel Barkalow <barkalow@iabervon.org> writes:

> +host.<name>.*::
> +	These options provide a way to rewrite URLs when there is a
> +	pattern of URLs with a common prefix which should be replaced
> +	with a different prefix. For every 'alias' prefix given, any

You menat 'rewritebase' prefix here, isn't it?

> +------------
> +	[host "<host>"]
> +		base = <actual url base>
> +		rewritebase = <other url base>
> +------------
[...]
> +		else if (!strcmp(subkey, ".rewritebase"))
> +			add_alias(host, xstrdup(value));
> +	}

-- 
Jakub Narebski
Poland
ShadeHawk on #git
