From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] difftool/mergetool: make the form of yes/no questions
 consistent
Date: Tue, 12 Apr 2016 11:05:46 -0700
Message-ID: <20160412180546.GA27558@gmail.com>
References: <1460465982.3214.7.camel@redhat.com>
 <20160412132737.GB11013@serenity.lan>
 <1460469192.3214.17.camel@redhat.com>
 <20160412140119.GC11013@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nikola Forrrr <nforro@redhat.com>, git@vger.kernel.org,
	gitster@pobox.com
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Apr 12 20:05:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq2hJ-00012d-0N
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 20:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965259AbcDLSFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 14:05:53 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35923 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965083AbcDLSFw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 14:05:52 -0400
Received: by mail-pf0-f172.google.com with SMTP id e128so17906232pfe.3
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 11:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UjlU4EFSHLMk0QdAUiqASxw3Ou5T9g5zoYe+naEjptw=;
        b=n60PTlwvSgVtyoPbvqYULN8bEwKjpzkcMmd6eQPMxifwTmKKGNsH+kljwbdxqdkPix
         VZm97gKwYpZyoi98XClfs90pN0wsuoFB6QLC0u0R6doDj0ItMe4GAMnxmw06cvm77j48
         yI5rqEWSG2SJ7ejC1B8wvZE05zBgtN4/ZcQtJpIR4in8KDTFW8Pl/vyiXWMziyZviO3c
         pb6nownzpV2alyt7VNscrfhqAJZvote1PHBaqb05ZDrMyhBshNBjUw6Pnp6hIDRxzBPa
         fva1CanPHBZK7vy/96eHFh70qjsgvZLS9LsUdXTDHTNixSzng5OachVy9eBnIukwHReB
         eO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UjlU4EFSHLMk0QdAUiqASxw3Ou5T9g5zoYe+naEjptw=;
        b=atyE8Clv54CXAowT7qOwTJ/DdpjsJnDaVYvjJSiJZ5hUtMk7fc4aP55cVMgCiiSR92
         P6HHmysHJtX4xyLKKI7qrBBht33pMf4y5TaibmDshWi82cMWfCecYPfJ+4a6/xWmhEB/
         BXEfDsNquZWwi+ChQeUnKfy2RlTv0gbBaK0KPzOUl6fOfwLAelcGi5u1vxvxxLFIIu1y
         KzD+cApIQDXrWSCoFqZEV0Rnrk6wx1EUwSDLwa0I1o79dvD7T7YN84cvNF4TnK9ohg3X
         CXNldPHRi4OEeqmM8Ucs1FYhHzmmH8CelpXrX1VdLpdSTdxIeL7/4vmmW8hxFVfyyZiO
         dfkQ==
X-Gm-Message-State: AOPr4FWwPGcJ0n0lb7wT9kQfmQQYtF1jYwCxytvw6efGN7dyahLYuC36vJHf/0FZWskJ8A==
X-Received: by 10.98.12.153 with SMTP id 25mr6453713pfm.27.1460484350782;
        Tue, 12 Apr 2016 11:05:50 -0700 (PDT)
Received: from gmail.com (w.disneyanimation.com. [198.187.190.241])
        by smtp.gmail.com with ESMTPSA id x64sm45169157pfa.72.2016.04.12.11.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Apr 2016 11:05:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160412140119.GC11013@serenity.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291287>

On Tue, Apr 12, 2016 at 03:01:19PM +0100, John Keeping wrote:
> On Tue, Apr 12, 2016 at 03:53:12PM +0200, Nikola Forrrr wrote:
> > On Tue, 2016-04-12 at 14:27 +0100, John Keeping wrote:
> > > I think the case in these two is correct as-is.  The "Y" is capitalised
> > > because it is the default and will take effect if the user just presses
> > > ENTER.
> > 
> > Thanks John, I'm aware of that. That's why the patch doesn't change
> > the case. Maybe I should have mention that explicitly in the commit
> > message.
> 
> Sorry, I completely missed that.  Your patch does in fact look good, so:
> 
> 	Reviewed-by: John Keeping <john@keeping.me.uk>
> 
> I think I was taken in by the commit message saying 'i.e. "Question
> [y/n]? "' and didn't examine the patch carefully enough.  It might be
> better just to drop the example since it's obvious what the patch does.

Thanks for reviewing.

Acked-by: David Aguilar <davvid@gmail.com>


cheers,
-- 
David
