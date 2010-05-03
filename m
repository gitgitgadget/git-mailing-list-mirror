From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (May 2010, #01; Sun, 2)
Date: Mon, 03 May 2010 05:48:08 -0700 (PDT)
Message-ID: <m3sk69f8yw.fsf@localhost.localdomain>
References: <7v7hnmuvtv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 03 14:48:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8v4M-0005ke-Kv
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 14:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758671Ab0ECMsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 08:48:13 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:37105 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758565Ab0ECMsM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 08:48:12 -0400
Received: by bwz19 with SMTP id 19so1265279bwz.21
        for <git@vger.kernel.org>; Mon, 03 May 2010 05:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=ReFnjc33W0hDVBiwwP0YyqxfIz0H11P/C05DgNzss40=;
        b=Tvbk42+bk6h2fIqntdCzFAaqLkvjv/0uq1PFT2spDaX3x0IF2B/EWLMGlYrwTpnaF5
         bFhfxm/f0oKkoxN/zYNVUhTYQisqLsyyvFeL+/nS7ev2zHH+nTbxJhEu4LQnPt6xTM+Z
         7Rght5mXZfLAiYwyr/MkY1tdPLmuTPtxzMoz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=HNnuFbiELbLyH71gfpFf5hsxMBRH6Rr7HRRNO43t0ucsJYjtZaSeAcJpqxP2JVIBbQ
         nfwfvezgWBQvXLH+BvGkeejPCIaMtFbMqfVPqd95cRd4ujM/lNQnNbJOeoOl9EgKCXrB
         STFFyNkOX3y01fOehH6s5/Yp6dHvo3lIgW68w=
Received: by 10.204.84.5 with SMTP id h5mr642918bkl.164.1272890890383;
        Mon, 03 May 2010 05:48:10 -0700 (PDT)
Received: from localhost.localdomain (abvt225.neoplus.adsl.tpnet.pl [83.8.217.225])
        by mx.google.com with ESMTPS id 14sm1654709bwz.10.2010.05.03.05.48.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 May 2010 05:48:08 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o43ClZcR026203;
	Mon, 3 May 2010 14:47:46 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o43ClJ1n026193;
	Mon, 3 May 2010 14:47:19 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7v7hnmuvtv.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146231>

Junio C Hamano <gitster@pobox.com> writes:

> * jn/gitweb-caching-prep (2010-04-24) 5 commits
>  - gitweb: Move generating page title to separate subroutine
>  - gitweb: Add custom error handler using die_error
>  - gitweb: Use nonlocal jump instead of 'exit' in die_error

I'll try to check whether it is true what I think that using nonlocal
jump instead of 'exit' improves performance of gitweb when run from
mod_perl.

>  - gitweb: href(..., -path_info => 0|1)
>  - Export more test-related variables when running external tests
> 
> * jn/gitweb-install (2010-05-01) 2 commits
>  - gitweb: Create install target for gitweb in Makefile
>  - gitweb: Improve installation instructions in gitweb/INSTALL

I think it would be good to have install target for gitweb in Makefile
before gitweb output caching series.

> * jn/gitweb-our-squelch (2010-04-30) 1 commit
>  - gitweb: Silence 'Variable VAR may be unavailable' warnings

What about syntax hightlighting series?

     gitweb: Refactor syntax highlighting support
     gitweb: Syntax highlighting support

-- 
Jakub Narebski
Poland
ShadeHawk on #git
