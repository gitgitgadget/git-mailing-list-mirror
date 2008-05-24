From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PYRITE] Status update and call for information.
Date: Sat, 24 May 2008 23:57:53 +0400
Message-ID: <20080524195753.GB3745@dpotapov.dyndns.org>
References: <5d46db230805222318j25657c10t2955fbdf1aa5c003@mail.gmail.com> <m34p8o4ijg.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Govind Salinas <blix@sophiasuchtig.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 24 21:58:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzztG-0006tD-6n
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 21:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754578AbYEXT6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 15:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753751AbYEXT6A
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 15:58:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:5890 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693AbYEXT57 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 15:57:59 -0400
Received: by fg-out-1718.google.com with SMTP id 19so777238fgg.17
        for <git@vger.kernel.org>; Sat, 24 May 2008 12:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=x9LREE6mCk2rasrkhpPkdFxTD6R/CQjAcJSIfdD0nFg=;
        b=daMZupWS3lcp9FRQyBIJJL0317vo+esgnTvng8Kfy1F/Wk9oJ4Aqt8jCIR2YI42px8+xfFN2btYJqV3VGKw60Rn0vZB/kGeGn9MQ3wGEuNGXIFGGVO+xrX31dbZxSvBj13RPDypoNPa2zOs+ILycoJbmZM7XiaJTAIlSGW0sviE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=G4q3Jx9smmxkxqSkEMhuHbemxIgwkncWhBQ/3vjugiEUMFzgIqoXe3JXoj/jrbiYkrkHgTovlOzdoMLFD0pW2ScTDBnY2E4enTWLHnspN8CFk51nZlc36SM7spOXmASK8jp7dgeWVvuEdGOzEdnXAx+hNQPVS1yepftVWLFTOBo=
Received: by 10.86.78.4 with SMTP id a4mr2421903fgb.73.1211659078287;
        Sat, 24 May 2008 12:57:58 -0700 (PDT)
Received: from localhost ( [85.141.150.140])
        by mx.google.com with ESMTPS id l12sm8313986fgb.8.2008.05.24.12.57.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 May 2008 12:57:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m34p8o4ijg.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82824>

On Fri, May 23, 2008 at 06:07:34PM -0700, Jakub Narebski wrote:
> 
> On the other hand the a..b and a...b notation is matter of convenience
> (it is easier to use than "b ^a" or "a b --not $(git merge-base a
> b)"); perhaps allowing a..b and a...b notation for git-diff was an
> error... but it makes copy'n'paste easier...

I believe that the error was how these operations were defined for diff.
I would rather expect to 'git diff a..b' to produce the accumulative
patch of 'git log -p a..b', but currently 'git diff a..b' is equivalent
of 'git diff a b', and this is redundant and confusing. As to 'git diff
a...b', it would be nice if it showed three way diff. At least, it is
how I would define them if I were writing some front-end.

Dmitry
