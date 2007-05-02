From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: problem using git on cygwin
Date: Wed, 2 May 2007 14:37:31 +0200
Message-ID: <81b0412b0705020537g485012ffr75d5ee2c7dc600f9@mail.gmail.com>
References: <ace3f33d0704292325t6ab16075rbdeac40a437920e8@mail.gmail.com>
	 <Pine.LNX.4.64.0704301343020.29859@racer.site>
	 <ace3f33d0705012104r3cf0b99ayb2ec2a69833e6ea1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "srinivas naga vutukuri" <srinivas.vutukuri@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 02 14:37:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjE5Q-0004Fr-Ei
	for gcvg-git@gmane.org; Wed, 02 May 2007 14:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755196AbXEBMhd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 08:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755116AbXEBMhd
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 08:37:33 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:53747 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754191AbXEBMhc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 08:37:32 -0400
Received: by an-out-0708.google.com with SMTP id b33so103665ana
        for <git@vger.kernel.org>; Wed, 02 May 2007 05:37:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qVxZ7fjKtr0kHEJjJMvd/rJFOWUc5YMC8eDz5G3NBCG4Q0+oyORa/o3A/p53CskwHoMqkwRAKUw0VNvPszmZpWZz29fQInr8Csa9PGiwZNsrl7aky6ykt/9o5/JGVAiEiNdjHEKzp7bVBIUyr742tVb8B2u2WGgA60mOIm5BL6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KQsh7GorHw+dVLfiUssFrWNx6VQ7yTrdSYJYxkwfJwDhtywVUqPOqORhgqpK/xJG4zBuI/Ufn530HlgF0bhBHtesIUJsQtu5YePbGkhz+gvt1IQO+V5YU5dfoB6X9xJPF8fDQHakG7qmMYxzoJ5JHGaDvQT8amOJc2CVO42Zc+E=
Received: by 10.100.58.4 with SMTP id g4mr440115ana.1178109451556;
        Wed, 02 May 2007 05:37:31 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Wed, 2 May 2007 05:37:31 -0700 (PDT)
In-Reply-To: <ace3f33d0705012104r3cf0b99ayb2ec2a69833e6ea1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46015>

On 5/2/07, srinivas naga vutukuri <srinivas.vutukuri@gmail.com> wrote:
> > On Mon, 30 Apr 2007, srinivas naga vutukuri wrote:
> >
> > > $ git add project/test.c
> > > error: bad index file sha1 signature
> > > fatal: index file corrupt
> >
> > I could imagine that you do not have "binary mode" default for opening
> > files.
> >
>        i do't think it is in binary mode when opening the files. I am
> used vim to create a new file and editing through that. And also am
> used file format (set ff=unix).

Johannes was referring to binary mode for writing files for _cygwin_
itself, not for files the git has to manage. See "Default Text File Type"
in cygwins setup.exe (maybe even follow the link "Read more...").
