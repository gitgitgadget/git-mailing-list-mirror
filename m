From: "Cameron McBride" <cameron.mcbride@gmail.com>
Subject: Re: git-cvsserver wart?
Date: Thu, 25 May 2006 23:34:21 -0400
Message-ID: <dcedf5e20605252034y8171d32x57d9d8d575443612@mail.gmail.com>
References: <dcedf5e20605250942g6a7417dfh5f2f26df29842def@mail.gmail.com>
	 <46a038f90605251419kd45fbj419565eabdd63182@mail.gmail.com>
	 <dcedf5e20605252011v6738dc9dg3d4801144d3e9898@mail.gmail.com>
	 <dcedf5e20605252024q5bf51486o7cbf6cc396b18b5d@mail.gmail.com>
	 <46a038f90605252028h556d0b2aob43f5c3dca8a5392@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri May 26 05:34:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjT5m-0001V6-0a
	for gcvg-git@gmane.org; Fri, 26 May 2006 05:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbWEZDeX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 23:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030267AbWEZDeX
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 23:34:23 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:22578 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030265AbWEZDeW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 23:34:22 -0400
Received: by wr-out-0506.google.com with SMTP id i34so1959649wra
        for <git@vger.kernel.org>; Thu, 25 May 2006 20:34:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HaC2UPqe5CCr+z484npHP56eztjln3jFRdIyZBWODrrudb6+cQ1ge9ewIxM0ZwnUTGcADw89+ChAu+UEmeHe+Cr+Lkhcw97vJoqimn6kCQ0iXRIUwTzZum9j+muB+WdRYKTg0f5ColGLOJZ7QrtolY4gUU64KZabrcvNL8qFIfE=
Received: by 10.65.114.10 with SMTP id r10mr78149qbm;
        Thu, 25 May 2006 20:34:21 -0700 (PDT)
Received: by 10.65.53.4 with HTTP; Thu, 25 May 2006 20:34:21 -0700 (PDT)
To: "Martin Langhoff" <martin.langhoff@gmail.com>, git@vger.kernel.org
In-Reply-To: <46a038f90605252028h556d0b2aob43f5c3dca8a5392@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20789>

On 5/25/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On 5/26/06, Cameron McBride <cameron.mcbride@gmail.com> wrote:
> > WARN  - file 'index' already exists in the git repository
>
> This warning means that you are running git-cvsserver off a repo where
> you also have a checkout. git-cvsserver really expects to be running
> off a 'naked' or 'bare' repo. For read only ops I think it kind-of
> works in a 'checkout' repo, but commits are a different story.

hmmm, it is supposed to be a bare repo.  perhaps I flubbed something
up.  Can I safely delete this index file?  It's in the repo.git
directory.  Perhaps it got created on the initial import from CVS
(using cvsimport and cvsps)?

Cameron
