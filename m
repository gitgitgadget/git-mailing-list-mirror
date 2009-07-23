From: "Carlos R. Mafra" <crmafra2@gmail.com>
Subject: Re: Performance issue of 'git branch'
Date: Thu, 23 Jul 2009 05:40:05 +0200
Message-ID: <20090723034005.GA11463@Pilar.aei.mpg.de>
References: <20090722235914.GA13150@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <20090723012207.GA9368@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain> <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain> <20090723031843.GA9152@Pilar.aei.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 23 05:41:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTpBU-0000Yj-Ke
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 05:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206AbZGWDlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 23:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752988AbZGWDlY
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 23:41:24 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:35652 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbZGWDlX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 23:41:23 -0400
Received: by fxm18 with SMTP id 18so574791fxm.37
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 20:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=R9WiSM1qhpv8qo5GqFQ+KgCZiSQ+rBh7N3M/sbIpJbc=;
        b=d5lLW+r8bVxEQazoR+8TWQNUIfIVtVjetkeZZ/1TcbrTxy1TTxZk8d9NUdqNrLcy1w
         oyg7L1DY/BHf9F4dOo85GEfxKyWlreEhSqAhAcDHsO0SLCXsrAkNpP+G7NjsYzkyWLug
         7ZhU4wpWUBw4yv9+hCZeda3vQYQOIAkiXcTkw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=b+IUIJC78ClEv+czbg0OaKddNlaJdf3IwXMRrZAZvmtUIL3/B9IK/vIR0oS0KrrpBN
         5yGkc1H8laIPfNYWj8HuO3jdtZ6V5PLlB+8Fk+aMAJHA7M/w5jBdzSQZ0k66234c43f9
         Ubd2Yr3r7/r9MU6QVqvTGbRwIsxT3Ahk2SE/g=
Received: by 10.86.99.12 with SMTP id w12mr1390894fgb.77.1248320482768;
        Wed, 22 Jul 2009 20:41:22 -0700 (PDT)
Received: from Pilar.aei.mpg.de ([82.113.121.18])
        by mx.google.com with ESMTPS id e20sm18212876fga.5.2009.07.22.20.41.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Jul 2009 20:41:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090723031843.GA9152@Pilar.aei.mpg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123830>

On Thu 23.Jul'09 at  5:18:44 +0200, Carlos R. Mafra wrote:

> 0.00user 0.01system 0:01.50elapsed 1%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (42major+757minor)pagefaults 0swaps
> 
> 01.50 is not that good, but it doesn't "feel" terrible as 4 seconds.
> [ It is incredible how 4 secs feels really bad while 2 is acceptable... ]

I need to sleep, as the number 4 seconds got stuck in my head. In my original
report it was much worse

0.00user 0.05system 0:05.73elapsed

So now it was a 75% improvement!
