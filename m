From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] prepare deprecation of git-revert
Date: Fri, 31 Oct 2008 09:36:33 -0700 (PDT)
Message-ID: <m33aichgc1.fsf@localhost.localdomain>
References: <1225468527-29694-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 17:38:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvx0R-00034S-OZ
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 17:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbYJaQgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 12:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbYJaQgh
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 12:36:37 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:65384 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbYJaQgg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 12:36:36 -0400
Received: by ey-out-2122.google.com with SMTP id 6so483234eyi.37
        for <git@vger.kernel.org>; Fri, 31 Oct 2008 09:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=JjhmRmdLndlWXrbHKs4DF3mNI4Err669yHGvh5D9pzc=;
        b=Txeajs/LN8Df8hJfuWij4w5COmoTc46GSXfW4AOYjNqtwejppUTMTjlFdQjNaE5mun
         yPZTK30MdXG+Q4wqDnOiXHceFd8dBwLdsnPfRfsJnBOB4Ic4fmmJhtXTf63QPfSirPEQ
         pdyks9E07EtiNar98D1LUKAIUEhXiJ8CzrPjs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=pUfjSdeRD8UM8omvD+8L8yVPdTMe31sBjEHTM05ALXabtxk4TV7JOOnLJ7VpTrOqW/
         2rQQx3drHfSiXcdUPlt2zvoTE0DLh/7Uxnke3Rbf7SOsdNn/vJnRmvZb0j/3HdP7ZY0E
         NFi7h4YHh4s3I8OZaVFLT9bqPa5TKiLRG0oGM=
Received: by 10.210.144.3 with SMTP id r3mr9333118ebd.115.1225470994773;
        Fri, 31 Oct 2008 09:36:34 -0700 (PDT)
Received: from localhost.localdomain (abwk207.neoplus.adsl.tpnet.pl [83.8.234.207])
        by mx.google.com with ESMTPS id y34sm1390455iky.9.2008.10.31.09.36.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 31 Oct 2008 09:36:33 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m9VGaW9J027457;
	Fri, 31 Oct 2008 17:36:32 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m9VGaUH8027454;
	Fri, 31 Oct 2008 17:36:30 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1225468527-29694-1-git-send-email-madcoder@debian.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99599>

Pierre Habouzit <madcoder@debian.org> writes:

> * Rename builtin-revert.c into builtin-cherry-pick.c
> 
> * Add option -R/--revert to git-cherry-pick.
>   Document it by taking the current content of git-revert manpage for the
>   option.
> 
> * get rid of the no_replay initialization, just ignore it when we're in
>   the revert case, it makes really no sense to error out.
> 
> * put the warning of deprecation in cmd_revert, #if 0-ed out for now.

> +#if 0
> +	warning("git revert is deprecated, please use git cherry-pick --revert/-R instead");
> +#endif

By the way, Mercurial names this command IIRC 'hg backout'. 

But I think that adding '-R' option to git-cherry-pick is a good idea
even if we don't go deprecating git-revert.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
