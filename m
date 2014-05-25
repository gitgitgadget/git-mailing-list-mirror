From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH] wording fixes in the user manual and glossary
Date: Sun, 25 May 2014 01:37:20 -0700
Message-ID: <20140525083720.GA28739@hudson.localdomain>
References: <1400989841-2845-1-git-send-email-jmmahler@gmail.com>
 <5381A239.2060809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 25 10:37:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WoTvu-0002Bk-Dx
	for gcvg-git-2@plane.gmane.org; Sun, 25 May 2014 10:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbaEYIh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2014 04:37:26 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:46180 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbaEYIhY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2014 04:37:24 -0400
Received: by mail-pa0-f53.google.com with SMTP id kp14so6064362pab.26
        for <git@vger.kernel.org>; Sun, 25 May 2014 01:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=OmU5OAoFwZ5ryQ2UV8rLtYue4jZwv9R2DecCNrLHgsc=;
        b=sf5JKyrkmaqokV+zUorp1dyhA8pMHHPJSsEjYyFk5xTM9O/84WV9D/d7XVoX3g9lf1
         TSi+4tlZwD1mT2jnaHPS3+OgqEQz7O0c8sJaNOo2IvG4HuP4Gd9W7fs2kvp1UO/s1cdb
         fKNT6EwRCjd964oPAM4sKgMs1yzkKyqUJEG+iijIl5AW75BjqcGLtVqpkWurXrs6iY0e
         bFECO1LfVwtKdQQZ7zwaGNIzAgVcT2O5cbafoWCotKQn0CnXbDN0c9h0s2NT2cPyZDum
         6TaIpr9zgC91GiCNmiatptDenAUdjfF4twyuoXE4/gB4XUHQS4w1wxeGRK7QOCHDrzmF
         XTww==
X-Received: by 10.68.229.68 with SMTP id so4mr18786838pbc.110.1401007044426;
        Sun, 25 May 2014 01:37:24 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id nw13sm40426166pab.37.2014.05.25.01.37.21
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 25 May 2014 01:37:23 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Sun, 25 May 2014 01:37:20 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <5381A239.2060809@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250083>

On Sun, May 25, 2014 at 07:56:41PM +1200, Chris Packham wrote:
> On 25/05/14 15:50, Jeremiah Mahler wrote:
> > Some minor wording fixes in the user manual and glossary.
...
> >  
> > -Eventually the developer cloned from will do additional work in her
> > +Eventually the developer will do additional work in her cloned
> >  repository, creating new commits and advancing the branches to point
> >  at the new commits.
> 
> I agree that the original wording isn't clear but I'm not sure the new
> wording is any clearer. The paragraph is trying to explain how to fetch
> upstream changes when they happen. My initial thought was to say
> "Eventually the developer will do additional work in the upstream
> repository" but perhaps it is to early to start throwing around terms
> like upstream. Perhaps just saying "her repository" would be clearest.
> 

The "developer cloned from will do" didn't sound right to me.
But it sounds like my interpretation is not what you were trying to
convey.  I do like the "upstream" term, it helps describe the
local/remote aspect.

How about this:

  Eventually the upstream developer will do additional work in their
  repository.  Creating new commits and advancing the branches to point
  at the new commits.

Then in the next paragraph it will discuss how to use `git fetch`
to get these remote changes in to the local repository.

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
