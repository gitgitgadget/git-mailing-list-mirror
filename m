From: Jared Hance <jaredhance@gmail.com>
Subject: Re: [1.8.0] Tracking empty directories
Date: Sat, 05 Feb 2011 17:37:13 -0500
Message-ID: <1296945433.3616.2.camel@localhost.localdomain>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
	 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
	 <m3zkqe8xc8.fsf_-_@localhost.localdomain>
	 <201102051931.10979.thomas@koch.ro>
	 <AANLkTikX5Y=TrXayXj-MCaR5p0=Tokc_5ihGqHFL9CQx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: thomas@koch.ro, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 05 23:37:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Plql2-0008N0-C9
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 23:37:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700Ab1BEWhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 17:37:22 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:39896 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664Ab1BEWhV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 17:37:21 -0500
Received: by vxb37 with SMTP id 37so1131043vxb.19
        for <git@vger.kernel.org>; Sat, 05 Feb 2011 14:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=DBDXyTZx7V2mXXCct5mEzqjvu0cnc64RmTDDYf4rWXI=;
        b=x1KHZRrPV10GHLvtT4f6uIOaHhzZhYMIhbvOfd0kB3Lf59+k/85TfxQXZMeY+PGk6M
         jvmR/rHjiL9vDX7H/e9vpL+hd4qwnOyuYAwBGe3JY5OpBjRz/zvZ2MAq0QvtEaPbRycB
         FpgeBKPyVFTs+Lq/twNJ8122a8VkGXgMuNWwY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=pDt8B5aAfvyAXUUhG2Vk+VjFiVNgzO9NLc93YR77m40zPLNhfa7bnGm01x0wfNDVys
         Jg/+m1uHI9Q6CZZiSzqXoJLxBBh55jTFizXbYbBCwyGhiwlaQArD6lYE1JWQSEmmqFVH
         n/F9bV0eA7hW8qWmiBMSg/hheRrbTFKZ0pRO4=
Received: by 10.220.192.133 with SMTP id dq5mr3576024vcb.202.1296945440933;
        Sat, 05 Feb 2011 14:37:20 -0800 (PST)
Received: from [192.168.1.100] (cpe-75-186-7-248.cinci.res.rr.com [75.186.7.248])
        by mx.google.com with ESMTPS id u14sm852634vcr.25.2011.02.05.14.37.19
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 05 Feb 2011 14:37:20 -0800 (PST)
In-Reply-To: <AANLkTikX5Y=TrXayXj-MCaR5p0=Tokc_5ihGqHFL9CQx@mail.gmail.com>
X-Mailer: Evolution 2.32.1 (2.32.1-1.fc14) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166119>

> > - Implement the possibility to checkin empty directories next year, but allow
> > it only, if the user knows that this breaks backwards compatibility of the
> > repo. (Generate warning and require --commit-empty-directories option)
> 
> I don't know about this part though.
> 

I would say that if we are going to require an option, it should be
core.emptyDirectory , which would default to false. It would be much
more annoying than having to supply an option every time. I also
disagree with warning for this.
