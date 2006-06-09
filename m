From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Figured out how to get Mozilla into git
Date: Thu, 8 Jun 2006 23:28:30 -0400
Message-ID: <9e4733910606082028k37f6d915m26009e0d5011808b@mail.gmail.com>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
	 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 09 05:28:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoXfx-0000QD-RH
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 05:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbWFID2c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 23:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965117AbWFID2c
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 23:28:32 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:48742 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965116AbWFID2b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 23:28:31 -0400
Received: by nz-out-0102.google.com with SMTP id s18so961179nze
        for <git@vger.kernel.org>; Thu, 08 Jun 2006 20:28:30 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nXJJUzYShempc5jLUW23c9NPtvRO6A5p2G7usAEqefCR4hmVW4A7N+Cj4fZ6C/WiloA1ZTGCEw8GCCuK78WGHZ1iMRa6FujLiefvZUqUdHCGfSzzXljH+j+SBIlV9G9UTsYEEG3slq5Zvm7pDovYtQigcKBjHG3hnz7DhmQXpJE=
Received: by 10.36.148.16 with SMTP id v16mr625020nzd;
        Thu, 08 Jun 2006 20:28:30 -0700 (PDT)
Received: by 10.36.37.15 with HTTP; Thu, 8 Jun 2006 20:28:30 -0700 (PDT)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21525>

On 6/8/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> Jon,
>
> oh, I went back to a cvsimport that I started a couple days ago.
> Completed with no problems...

I am using cvsps-2.1-3.fc5, the last time I tried it died in the
middle of the import. I don't remember why it died. Which cvsps are
you using? You're saying that it can handle the whole Mozilla CVS now,
right? I will build a new cvsps from CVS and start it running tonight.

> If you use git-cvsimport, you can safely re-run it on a cronjob to
> keep it in sync. Not too sure about the cvs2svn => git-svnimport,
> though git-svnimport does support incremental imports.

I would much rather get a direct CVS import working so that I can do
incremental updates. I went the SVN route because it was the only
thing I could get working.

> > Any advice on how to pack this to make it run faster?
>
> git-repack -a -d but it OOMs on my 2GB+2GBswap machine :(

We are all having problems getting this to run on 32 bit machines with
the 3-4GB process size limitations.

-- 
Jon Smirl
jonsmirl@gmail.com
