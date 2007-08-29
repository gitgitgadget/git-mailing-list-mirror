From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: cloning/pulling hooks
Date: Wed, 29 Aug 2007 15:28:30 +0100
Message-ID: <200708291528.31599.andyparkins@gmail.com>
References: <1188319608.6106.63.camel@beauty> <200708291356.33126.andyparkins@gmail.com> <Pine.LNX.4.64.0708291421060.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>, Josh England <jjengla@sandia.gov>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 29 16:28:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQOXG-0001gZ-Ix
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 16:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbXH2O2k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 10:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbXH2O2k
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 10:28:40 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:58476 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbXH2O2j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 10:28:39 -0400
Received: by an-out-0708.google.com with SMTP id d31so40810and
        for <git@vger.kernel.org>; Wed, 29 Aug 2007 07:28:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=G22WaJKeT6p2zDSCgtLh8/pDUao4FlAAWhKxirD3xB0HNgmuCYvvRAFt1J/buAIRY+kqj6Ez0Xf+/GEscK4t41QD3g86cOh45v+xpTnW6ukSxaVofTrlzPeZo2FHx6pLwinUxfr7f6VYhKiy+obtUbzX5tnR0P5lIHAt4VfirVE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VqgT7X4rYH42BPy6ERWDdhulNHz1ro6Sw2u805OD7+9vlQgINg6mLFuBh06ogg99ZyaQEN4zpFAfs9HOP0Kuoi13O71KdQLhw0btK2UFUjef4nfVMiPk0Skaw3eBKT+XnPTJMGzUp1lN/orIGwK3pa8Ga4t1kDFI5xnQOA5jCuU=
Received: by 10.100.96.9 with SMTP id t9mr574186anb.1188397716000;
        Wed, 29 Aug 2007 07:28:36 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id d24sm8783738and.2007.08.29.07.28.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 29 Aug 2007 07:28:35 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <Pine.LNX.4.64.0708291421060.28586@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56956>

On Wednesday 2007 August 29, Johannes Schindelin wrote:

> > 1) Start a new project
> > 2) Install a pre-commit hook that checks that every patch meets some
> >    arbitrary coding standard
> > 3) Clone to laptop
> > 4) Kick self the first time you make a commit that doesn't adhere to
> > coding standards that would have been enforced by the hook script.
>
> For me it is
>
> 4) put the check into the Makefile where it belongs.

I suppose you are right, the reason I pick the hook is because I don't mind 
having untidy code in the working tree but don't want it in the repository. 

Also, it was given as an example hook so I enabled it :-)


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
