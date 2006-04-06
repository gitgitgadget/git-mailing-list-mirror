From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: parsecvs tool now creates git repositories
Date: Fri, 7 Apr 2006 11:22:49 +1200
Message-ID: <46a038f90604061622s5a7bee4eq6666d9b3796f70f6@mail.gmail.com>
References: <20060405174247.GA29758@blackbean.org>
	 <1144262498.2303.231.camel@neko.keithp.com>
	 <20060406181502.GA15741@blackbean.org>
	 <1144354356.2303.270.camel@neko.keithp.com>
	 <46a038f90604061451m4522e3f3qceae2331751a307c@mail.gmail.com>
	 <1144361968.2303.288.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Jim Radford" <radford@blackbean.org>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 07 01:23:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRdoV-0005Kt-Im
	for gcvg-git@gmane.org; Fri, 07 Apr 2006 01:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWDFXWu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Apr 2006 19:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWDFXWu
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Apr 2006 19:22:50 -0400
Received: from wproxy.gmail.com ([64.233.184.239]:52772 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932208AbWDFXWu convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 6 Apr 2006 19:22:50 -0400
Received: by wproxy.gmail.com with SMTP id 57so256443wri
        for <git@vger.kernel.org>; Thu, 06 Apr 2006 16:22:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b091Gcpdnj15Rg+EZdhTUWUrvl/TxwHxAFfqu7iPsy0ctvlLgIAzHO7xKPjNzmLmRKYGezw0Xb81ffv804Wwtylpe1lw94M4Q89LqnQO+U9VSE+TWGgnb1SmHl9ennfQV9g5eOtRhiVw7VCEMS0pxFn4ubjQFJTGSXsYVW+Du2U=
Received: by 10.54.72.9 with SMTP id u9mr1528278wra;
        Thu, 06 Apr 2006 16:22:49 -0700 (PDT)
Received: by 10.54.72.7 with HTTP; Thu, 6 Apr 2006 16:22:49 -0700 (PDT)
To: "Keith Packard" <keithp@keithp.com>
In-Reply-To: <1144361968.2303.288.camel@neko.keithp.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18486>

On 4/7/06, Keith Packard <keithp@keithp.com> wrote:
> On Fri, 2006-04-07 at 09:51 +1200, Martin Langhoff wrote:
>
> >  - file additions were recorded with one-commit-per-file. I am not
> > sure how rcs is recording these, but hte user does enter a common
> > message at "commit" time. Perhaps the file addition action could be
> > ignored then?
>
> If the log message is identical, and the dates are in-range, parsecvs
> "should" put the adds in the same commit.

parsecvs is committing them with the "added file foo.x" message, not
the actual commit message.

> >  - some tags made on a branch show up in HEAD. This may be due to
> > partial-tree branches, but I am not sure.
>
> Finding branch points is not perfect; it's complicated by bizzarre
> behaviour when adding files and casual CVS changes which make precise
> branch points hard to detect. Can I get at this repository to play with?

I fetch it with something along the lines of...

while ( true ) ; do
     wget -qc http://cvs.sourceforge.net/cvstarballs/moodle-cvsroot.tar.bz2 &&
break
     sleep 5
done

and then import the "moodle" module.

cheers,


m
