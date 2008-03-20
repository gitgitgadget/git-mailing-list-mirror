From: "Alex Bennee" <kernel-hacker@bennee.com>
Subject: Re: Importing all modules in a CVS repo with git-cvsimport
Date: Thu, 20 Mar 2008 08:30:02 +0000
Message-ID: <b2cdc9f30803200130w11669e51o5b273ee5eba7458@mail.gmail.com>
References: <1205951736.24610.3.camel@pitcairn.cambridgebroadband.com>
	 <alpine.LNX.1.00.0803191602110.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Mar 20 09:31:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcGAh-0006xc-Hs
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 09:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151AbYCTIaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 04:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753175AbYCTIaG
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 04:30:06 -0400
Received: from rv-out-0910.google.com ([209.85.198.191]:20801 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789AbYCTIaE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 04:30:04 -0400
Received: by rv-out-0910.google.com with SMTP id k20so434273rvb.1
        for <git@vger.kernel.org>; Thu, 20 Mar 2008 01:30:02 -0700 (PDT)
Received: by 10.140.127.20 with SMTP id z20mr589171rvc.77.1206001802579;
        Thu, 20 Mar 2008 01:30:02 -0700 (PDT)
Received: by 10.140.161.13 with HTTP; Thu, 20 Mar 2008 01:30:02 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.00.0803191602110.19665@iabervon.org>
Content-Disposition: inline
X-Google-Sender-Auth: f3cdb4c63e2a6a37
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77644>

On 3/19/08, Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Wed, 19 Mar 2008, Alex Bennee wrote:
>
>  > Hi,
>  >
>  > I'm wanting to import the entirety of a CVS repository into git rather
>  > than an individual module. However every approach I've tried to do this
>  > fails as the underlying cvsps tool seems to only be able to deal with
>  > modules rather than the whole project.
>  >
>  > Is there any invocation I could do that would do the whole import?
>
>
> A for loop? I don't think it's possible to treat the modules as just
>  subdirectories, but you can loop over the modules, importing each of them
>  into a separate git repository and then, if you want, merge each of them
>  into a new master repository with the "subdirectory" strategy.

Unfortunately the repository is treated as one big ode dump place so I
don't want to loose the information about changes across many
dirs/modules. I shall try the "fakeing up" approach mentioned
elsewhere and see where that gets me.


-- 
Alex, homepage: http://www.bennee.com/~alex/
Hire me? http://www.bennee.com/~alex/cv.php
