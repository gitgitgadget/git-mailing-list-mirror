From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (resend)] gitweb: Fix 'history' view for deleted files with history
Date: Sat, 19 Apr 2008 01:17:54 -0700 (PDT)
Message-ID: <m31w52s1g7.fsf@localhost.localdomain>
References: <20080413121018.3951.45328.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 17:59:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jn8HY-0001BB-Qi
	for gcvg-git-2@gmane.org; Sat, 19 Apr 2008 10:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753137AbYDSISB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 04:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752922AbYDSISB
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 04:18:01 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:4227 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbYDSIR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 04:17:59 -0400
Received: by fg-out-1718.google.com with SMTP id l27so858457fgb.17
        for <git@vger.kernel.org>; Sat, 19 Apr 2008 01:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=tJPX5lBWxNswjIpIlZvd+gks8b4W9Me4PclASYlnL14=;
        b=cPMrW/fzz2kgdXDFACYkWHdRSHS9J1rGcdBAlro12y/E1AV+kUwJATAzzYJ0IYxclOWhNBBLAXqNb83PBVUhsXTFRMS+NCdjM5ZgjfPRNfMyQ2DUmX/bxTaiKKMLFFJOvgXd99gbSJYp8YrvPcrbejDKFc15K8wzXg3i6zfqktU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=seLyhP/zRt2EX07QSH565B9KHqRzyl0mMBU9XKL9KzCQF8Ya5h1mpA59gJEEQHp149zdKZF2klqdI2ZxrjuqHgDY5gtvbTq4jt3GefwHER7lFB1we6KWKUhp8tMM9Dki4fDBNZeVCNukoYVEueHibIsmL/UesrEpxNAl2E3jtJw=
Received: by 10.82.111.8 with SMTP id j8mr6338256buc.43.1208593078077;
        Sat, 19 Apr 2008 01:17:58 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.208.125])
        by mx.google.com with ESMTPS id g12sm1382800nfb.27.2008.04.19.01.17.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Apr 2008 01:17:54 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m3J8HlaY011394;
	Sat, 19 Apr 2008 10:17:50 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m3J8HiQl011391;
	Sat, 19 Apr 2008 10:17:44 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080413121018.3951.45328.stgit@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79897>

What about this patch?  Was it simply overlooked, or does it need some
corrections either in patch itself, or in commit message (commit
description)?

I have added test which shows this bug, and information when can it
occur (besides handcrafting gitweb URLs).
-- 
Jakub Narebski
Poland
ShadeHawk on #git
