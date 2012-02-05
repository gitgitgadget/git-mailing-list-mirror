From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Specifying revisions in the future
Date: Sun, 5 Feb 2012 04:07:55 +0100
Message-ID: <201202050407.56612.jnareb@gmail.com>
References: <jgjkk0$qrg$1@dough.gmane.org> <m3ipjmknhc.fsf@localhost.localdomain> <4F2DEF89.4030302@gmx.us>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonathan Paugh <jpaugh@gmx.us>
X-From: git-owner@vger.kernel.org Sun Feb 05 04:08:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtsSQ-0001Kp-OC
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 04:08:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754649Ab2BEDH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 22:07:58 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46180 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754614Ab2BEDH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 22:07:57 -0500
Received: by eaah12 with SMTP id h12so2004150eaa.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 19:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=AUtrtUegVYlXi7zZ7a0/U+BD0WhT67gImxMqTiJ6c68=;
        b=E7RN7Nlfv8rjvCQLnzUPIDq00QXgBx58HX4jj7X+B5V3e6A5f1wo6cFkDPj4mnALxJ
         PkaWi618GyO+sakG/cjz4sbRF2ThWqTZm+1x3z79eLaRtY8eFmASOT7qz4+/BqU4MuZv
         JvuZ5baiccASFE4de9awK2IamOzpvomqoUZ2c=
Received: by 10.213.17.198 with SMTP id t6mr2082091eba.13.1328411276620;
        Sat, 04 Feb 2012 19:07:56 -0800 (PST)
Received: from [192.168.1.13] (abwp204.neoplus.adsl.tpnet.pl. [83.8.239.204])
        by mx.google.com with ESMTPS id a58sm42539803eeb.8.2012.02.04.19.07.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 04 Feb 2012 19:07:55 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4F2DEF89.4030302@gmx.us>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189927>

Jonathan Paugh wrote:

> > You have XY problem.  You need to do X, and you think you can use Y to
> > do X, so you ask about how to do Y.
> > 
> > If you want to list all revsions between v1.0-a and master, use
> > 
> >   git rev-list v1.0a..master
> > 
> > or
> > 
> >   git rev-list --ancestry-path v1.0a..master
> Thanks. This Y' will take me to lot's of exciting destinations---and I
> must confess I haven't messed with the plumbing heretofore.

Of course you can also do

  git log --ancestry-path v1.0a..master 

-- 
Jakub Narebski
Poland
