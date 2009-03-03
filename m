From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2009, #01; Tue, 03)
Date: Tue, 03 Mar 2009 01:21:35 -0800 (PST)
Message-ID: <m3r61ft10q.fsf@localhost.localdomain>
References: <7vprgzdlom.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 10:23:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeQqC-0005zs-JW
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 10:23:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752787AbZCCJVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 04:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbZCCJVk
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 04:21:40 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:59938 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbZCCJVi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 04:21:38 -0500
Received: by fxm24 with SMTP id 24so2342897fxm.37
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 01:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=LAH78FLORzHhK+CZc+XuBeJ63WPZQmcNR7e9mTPCYxE=;
        b=ps2/HEphaCr+wiRkodhXgnYeBs+xLoBMF28IPeQT/uz+PcXqmHVvnYAJc3+KnpVhwX
         WfNxZBxKrKxmBdal78ow/u60GolpvPfnd/9cWP/LSOnysLrX9NHewRGnuQvYCl/6gwpL
         4BJm6WPRlNK4rAuc2HNvRdZglKwxzuhu8UON8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=BPrg35fs5LNAwABWYD6UhdN4TcWVKQ7Kcz7Ry1cXOmUgv6QUWcdZ5tXtXsbuvDWaus
         ayGJNY8JxURiBVU/aeDtipxxoBlXKS5XpgKa75aTI+lceHORAAGNK2VlctVhBRWG1ljh
         hlgyRf5DjM3Je8T/yE8q5PP7oJ6PbTa/lKNFI=
Received: by 10.86.71.1 with SMTP id t1mr4793346fga.18.1236072095771;
        Tue, 03 Mar 2009 01:21:35 -0800 (PST)
Received: from localhost.localdomain (abwq47.neoplus.adsl.tpnet.pl [83.8.240.47])
        by mx.google.com with ESMTPS id e11sm363132fga.50.2009.03.03.01.21.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Mar 2009 01:21:35 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n239LTYi018594;
	Tue, 3 Mar 2009 10:21:31 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n239LP8G018591;
	Tue, 3 Mar 2009 10:21:25 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vprgzdlom.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112040>

Junio C Hamano <gitster@pobox.com> writes:

> ----------------------------------------------------------------
> [Stalled and may need help and prodding to go forward]
> 
> * gb/gitweb-base (Sun Feb 15 10:18:36 2009 +0100) 1 commit
>  - gitweb: fix wrong base URL when non-root DirectoryIndex

Errrr... isn't this already in 'master' as v1.6.2-rc1-3-g81d3fe9 ?

> * jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
>  + blame: show "previous" information in --porcelain/--incremental
>    format
>  + git-blame: refactor code to emit "porcelain format" output
> 
> This gives Porcelains (like gitweb) the information on the commit _before_
> the one that the final blame is laid on, which should save them one
> rev-parse to dig further.  The line number in the "previous" information
> may need refining, and sanity checking code for reference counting may
> need to be resurrected before this can move forward.
> 
> I thought recent tig discussion may blow new life into it, but is this
> unneeded?  If so I'd rather revert it (or discard after 1.6.2).

This would be nice to have for gitweb.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
