From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] format-patch: Update the `-3` example
Date: Sat, 21 Aug 2010 16:04:06 +0530
Message-ID: <20100821103404.GB31130@kytes>
References: <1282382819-25097-1-git-send-email-artagnon@gmail.com>
 <m3sk28nu24.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 21 12:36:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmlR3-0006Jl-R2
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 12:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773Ab0HUKgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 06:36:07 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55803 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459Ab0HUKgG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 06:36:06 -0400
Received: by pwi7 with SMTP id 7so1393675pwi.19
        for <git@vger.kernel.org>; Sat, 21 Aug 2010 03:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=iBMbFql0PQGJyhPxC5CvbxuOXBwqXHBGYkXW1lIW07Q=;
        b=YLpkJtPe2qIo6B6J6qmS8W9cQwCz/yMfgzJiyz2yxEoBv3cFNTb/0ACxYbn5n3KwUx
         q2E0PkcRXv2ds3I63GiaGK9UF3rE2zzaWoV6ea51LUyfIhD+AAeJqWR9VjWUmSofEpeD
         Zl5JOE2STuaEzqinxRp9MIB/GdcxZgZRZOLiI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=L7/KW2pW+GWRZVrjHaHbw5WGdKB9IAMYxwIf0Ev57jRfaBi28tcz0oCXO303BnEjee
         VAEqDact7/RbRYBvPtmjBRAA6lBlIsHzeP2xEUZMM9ScNstE1e4hEF+CkNWJXUOsWv0V
         s0ECrDsGFgqQ0ck+QfmN0rIIqK8pmjp0E0Yoo=
Received: by 10.142.215.21 with SMTP id n21mr2110909wfg.162.1282386965362;
        Sat, 21 Aug 2010 03:36:05 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id 33sm4686775wfg.21.2010.08.21.03.36.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Aug 2010 03:36:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m3sk28nu24.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154137>

Hi Jakub,

Jakub Narebski writes:
> Works for me:
> 
>   5031:[gitweb/split@git]# git format-patch -3
>   0001-gitweb-Prepare-for-splitting-gitweb.txt
>   0002-gitweb-Create-Gitweb-Git-module.txt
> 
>   5034:[gitweb/split@git]# git version
>   git version 1.7.2.1
> 
> 
> The -3 is git-log option:
> 
>   -<n>   Limits the number of commits to show.
> 
> and also git-format-patch option:
> 
>   -<n>   Limits the number of patches to prepare.

Hm, doesn't work on the `pu` Git, but works on `master` -- I'm
currently bisecting to find the problem. `git log -3` works
though.

-- Ram
