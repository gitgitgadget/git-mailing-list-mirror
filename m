From: =?ISO-8859-1?Q?Ed=E9sio_Costa_e_Silva?= <edesiocs@gmail.com>
Subject: Re: [Gnu-arch-users] Re: [GNU-arch-dev] [ANNOUNCEMENT] /Arch/ embraces `git'
Date: Fri, 22 Apr 2005 14:39:17 -0300
Message-ID: <1073a5540504221039332e712@mail.gmail.com>
References: <200504202304.QAA17069@emf.net>
	 <1114069758.5886.9.camel@perun.redhat.usu>
	 <Pine.LNX.4.58.0504220844390.2344@ppc970.osdl.org>
Reply-To: =?ISO-8859-1?Q?Ed=E9sio_Costa_e_Silva?= <edesiocs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 19:37:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP24F-0006Mi-42
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 19:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbVDVRjj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 13:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbVDVRjd
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 13:39:33 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:61997 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262079AbVDVRj0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 13:39:26 -0400
Received: by wproxy.gmail.com with SMTP id 49so425822wri
        for <git@vger.kernel.org>; Fri, 22 Apr 2005 10:39:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L9QLxTQmSItOH4ZGDmlYsn5wE6CuFpSX8eX6V3zsN87bSfh99wyzq80JxRdufKrDVp5R/5mxEftdnC9qHmhbKuMGGeh2V10Z6MGQVtH2DFbxPaoG39SKqKzcdf//+VhkQq1qXlpd6RacK4A5u8v62Ktce/Vp33a4BixFW7PtVl4=
Received: by 10.54.19.75 with SMTP id 75mr78034wrs;
        Fri, 22 Apr 2005 10:39:17 -0700 (PDT)
Received: by 10.54.20.14 with HTTP; Fri, 22 Apr 2005 10:39:17 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.58.0504220844390.2344@ppc970.osdl.org>
Content-Disposition: inline
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 4/22/05, Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
> On Thu, 21 Apr 2005, Tomas Mraz wrote:
> >
> > However you're right that the original structure proposed by Linus is
> > too flat.
> 
> You're wrong.
> 
> The thing is, having 256 sybdirectories already eats one _megabyte_ of
> diskspace on common filessystems. If you expand that to be either deeper
> (ie subdirectories within subdirectories), or use more than 8 bits for the
> first level, you'll be using much more.
> 
> A megabyte of diskspace is peanuts for a project like Linux, but I think
> it matters for small projects. I want git to work reasonably even for
> really trivial stuff.
> 
> For example, if you just expand the fan-out to use 12 bits instead of 8,
> you're now using 16MB of diskspace just for the directory structure, even
> for a trivially small project. I just think that sucks.

What if the directory structure is sparse?
