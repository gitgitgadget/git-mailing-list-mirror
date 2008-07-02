From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [RFC] Single system account for multiple git users
Date: Wed, 2 Jul 2008 18:45:36 +0400
Message-ID: <20080702144536.GA1721@dpotapov.dyndns.org>
References: <20080630151113.GO5737@dpotapov.dyndns.org> <200807011055.51738@rk-nord.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Melchior FRANZ <melchior.franz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 16:47:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE3bd-0005CZ-VF
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 16:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054AbYGBOpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 10:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753701AbYGBOpq
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 10:45:46 -0400
Received: from mu-out-0910.google.com ([209.85.134.185]:63375 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110AbYGBOpo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 10:45:44 -0400
Received: by mu-out-0910.google.com with SMTP id w8so111157mue.1
        for <git@vger.kernel.org>; Wed, 02 Jul 2008 07:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=z5T7C6AiTfdOVaMwcaw8/GnjwsBFivmvuZxzbrP/HCg=;
        b=uBlehjak5F9z8689OKPu2d9hYnvjdXd0YTiSS3zfyQLLsajK4LbfmB5oqcRsAG/EGe
         3G02xo+O4/otpg1paUxLfN5aRXLD6nf40+hHkL2KLZjtAb5jXqwSz1T3hCHiaHoeQmEC
         kn6qRK8A5NXRTlhelMp58H77p+cslu6em1heA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TJInhJ40OhdoS7+ptuXwsG2fgfO9e9q5YdOsCffHXCPTQNHDgSblj7ZRFrMJLxYX3P
         CuaqSMtCIOPLIuvyT0WxmYInGUWonYz1NgcVz6RDmKF6XEMrrxj9rPrE+6J7nkWFkeUD
         VJrzw4NWzFPJ8U7bWZ/2uclLcBF0JpqH+Y6cQ=
Received: by 10.103.249.7 with SMTP id b7mr3631654mus.51.1215009941577;
        Wed, 02 Jul 2008 07:45:41 -0700 (PDT)
Received: from localhost ( [83.237.184.117])
        by mx.google.com with ESMTPS id y6sm34715751mug.15.2008.07.02.07.45.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Jul 2008 07:45:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200807011055.51738@rk-nord.at>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87146>

On Tue, Jul 01, 2008 at 10:55:50AM +0200, Melchior FRANZ wrote:
> 
> Indeed. This is AFAIK the main reason why git might not be used
> by a project where I'm contributor. gitosis could help here, but
> I guess that a built-in solution would be preferred. An external
> addon looks a bit like band-aid.  ;-)

Yes, and they impose some its own access control model, which is
different to what you normally have using git-shell. So, the purpose
of my patch was to provide the absolutely minimal change to git-shell
which allows to have a central Git server with multiple Git users under
one system account. I guess that most Git developers do not use Git in
this configuration, so they are not very interested in this patch. But
there are projects where having a central repo is strict requirement
(usually justified by having centralized place to backup all sources,
difficult exchanging patches by email especially in great volume, and
impossibility direct connection due to firewalls, etc...).

So, I believe that my patch (or something simple like that) could help
Git with wider adaptation.

Thanks,
Dmitry
