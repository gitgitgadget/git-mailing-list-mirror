From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2010, #05; Sat, 16)
Date: Sun, 17 Jan 2010 19:02:41 -0800 (PST)
Message-ID: <m38wbwcdzv.fsf@localhost.localdomain>
References: <7vljfxa1o6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 04:02:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWhtD-0003lT-Qi
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 04:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752968Ab0ARDCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 22:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358Ab0ARDCq
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 22:02:46 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:44913 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984Ab0ARDCp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 22:02:45 -0500
Received: by fxm25 with SMTP id 25so65513fxm.21
        for <git@vger.kernel.org>; Sun, 17 Jan 2010 19:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=63QQX6dpBLx3O/oB5HLYTU9H1yVYHGFsw7hOmgU0ftw=;
        b=QWWBt793DqPmCRVo8GztIpGEGF1aT9ci9rYr7EzrVsImqqNw59BKVmWYxGsZp9pJ4z
         tNrKVYvVOQCMCslYKrOdJszjo9s9knrJERPQnkTlGeH09rU8HtTIY4/ZtYn0Yk61FLTe
         LirGLhuYFhWUinN2neabQKCDHjyU5kpuaOfVM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Plllk3EHL8ZwpBHE07c4ZHMDbr4D0V1tvmPYEAND/w9pH3tHlYbnY+tTXYxmcoEY60
         wSjxcHJH96Ds85ce4VLAQzq1dC2wWDlskZNGgrn7GkaY5POCE2sRTEBc3Bm8WXdnFocX
         Je+/OXnC/AdWz1bIT3qwdLBRFg+pRvQDLR0RQ=
Received: by 10.102.207.40 with SMTP id e40mr2694207mug.86.1263783762935;
        Sun, 17 Jan 2010 19:02:42 -0800 (PST)
Received: from localhost.localdomain (abvv11.neoplus.adsl.tpnet.pl [83.8.219.11])
        by mx.google.com with ESMTPS id e8sm16028933muf.47.2010.01.17.19.02.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Jan 2010 19:02:41 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o0I32D7S022050;
	Mon, 18 Jan 2010 04:02:23 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o0I31v1Y021941;
	Mon, 18 Jan 2010 04:01:57 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vljfxa1o6.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137361>

Junio C Hamano <gitster@pobox.com> writes:

> * jh/gitweb-cached (2010-01-13) 9 commits

Those two I think are not close to be ready
>  - gitweb: File based caching layer (from git.kernel.org)
Large code dump.  I am working (slowly) on splitting it.

>  - gitweb: Convert output to using indirect file handle
Does not need two file handles.  Style should probably be "print $out <sth>"

Thos could probably be merged soon (after final round of corrections)
>  - gitweb: cleanup error message produced by undefined $site_header
It's not only $site_header

>  - gitweb: add a get function to compliment print_sort_th
>  - gitweb: add a get function to compliment print_local_time
O.K.

>  - gitweb: Makefile improvements
I think it is O.K.

>  - gitweb: Add option to force version match
Allow for version mismatch in test, add test for version match

>  - gitweb: change die_error to take "extra" argument for extended die information
Minor fixup (commit message, whitespace).  Otherwise O.K.

>  - gitweb: Load checking
O.K., but needs a fixup to 'blame_incremental' related code.  Some
assumptions can hold no longer

> 
> Replaced with a re-roll.  Update to t9500 is probably needed.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
