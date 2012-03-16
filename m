From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] rebase -i: inform the user they can re-order commits
Date: Fri, 16 Mar 2012 06:36:04 -0700 (PDT)
Message-ID: <m3pqccllbt.fsf@localhost.localdomain>
References: <4F63205A.6000202@seap.minhap.es> <vpqlin0n8w5.fsf@bauges.imag.fr>
	<4F632543.50402@seap.minhap.es> <vpq7gyklq3i.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Mar 16 14:36:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8XKL-0004Qp-DV
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 14:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030721Ab2CPNgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 09:36:09 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:43930 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030398Ab2CPNgG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 09:36:06 -0400
Received: by wejx9 with SMTP id x9so3915945wej.19
        for <git@vger.kernel.org>; Fri, 16 Mar 2012 06:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=QGXS/sJjvvrFxzhHlMjy7jbAyMnnGjb5svuG9IhQ+DM=;
        b=w1qpojqhJNbaSC+wSeO+bQljtTbqkvwCoiaqAJtBVLJkrcws4vDNW9FcP94TmyDEnc
         AMX42RWd0M27Co6nEgUVqUzNmq54aWtV1RCyY/vcxbBo8rGPgH+cdsvat9Pfzrn6WQhq
         aNwVRswEp4J1Et69irA1j8M3PpapMfzHjeRhAVLebe2/NofKJTpqqbok4YGoZAYNuQQK
         P/ZLEVOj9crR8lxK66apy8RhW8Ai6Iko6BEj0LIroRKcVaaIudvF6ZdV7F/hBeIVix6L
         riHaLepbIqH4pTLRYHaVNvvHyIQeLke3XldBkMNUx8ucqdG8mtl2NE1ayoD7XwJZ8Y9W
         Xp1w==
Received: by 10.180.97.41 with SMTP id dx9mr35593577wib.9.1331904965549;
        Fri, 16 Mar 2012 06:36:05 -0700 (PDT)
Received: from localhost.localdomain (abvr225.neoplus.adsl.tpnet.pl. [83.8.215.225])
        by mx.google.com with ESMTPS id j3sm22490385wiw.1.2012.03.16.06.36.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Mar 2012 06:36:04 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q2GDa73C031648;
	Fri, 16 Mar 2012 14:36:08 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q2GDa6B2031645;
	Fri, 16 Mar 2012 14:36:06 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <vpq7gyklq3i.fsf@bauges.imag.fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193259>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:
> 
> > >   You can re-order the lines to change the order of commits in history.
> >
> > I like it but the word 'history' seems a bit too technical for me, and may
> > scare the normal user,, what about:
> >
> > You can re-order the lines to change the order the commits are applied.
> 
> Perfect. "are applied" says more than my "in history", since rebase -i
> is all about various ways to apply commits.

Nitpick: shouldn't it be s/the commits/commits/

    You can re-order the lines to change the order commits are applied.

-- 
Jakub Narebski
