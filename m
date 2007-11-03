From: "Ronald Landheer-Cieslak" <ronald@landheer-cieslak.com>
Subject: Re: [PATCH] New script: git-changelog.perl - revised
Date: Sat, 3 Nov 2007 09:46:27 -0400
Message-ID: <67837cd60711030646p6d7dc8e3t8a5f5f336e8bbad6@mail.gmail.com>
References: <67837cd60711021303q488e0873lea363b93fc90d591@mail.gmail.com>
	 <472C3309.70109@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Sat Nov 03 14:46:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoJKp-00018d-E6
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 14:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084AbXKCNqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 09:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753964AbXKCNqb
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 09:46:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:21184 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920AbXKCNqa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 09:46:30 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1022004nfb
        for <git@vger.kernel.org>; Sat, 03 Nov 2007 06:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=ESIls7OHbUlnb4MfdW66VzGVbzYQwIF9nng/e9zM6h8=;
        b=Ri82SUvA4kbFJHy8VxkYaede1qAH1Do+OTCdyeHojQtPyZVDRRW3CEKmbsCllAIWVOKDO1SIWUe1qReXvhU4hdcohplkQeAc21QsPp49+8jJjhlqOk3lxi2uUM5uOoqXqg2JWxM/RI2g0cNfLonj5Ik+/HAZ29HDQM7GptRC5z0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Xw8QGWpKLuFSGnGz6VPd8d0njIKrw0d/Or5yf/Th4Hl1AM8QgWv/V+0TPBYsc44fhHF13JgVIy3ygbCL0cTJRXYtLoxzx8y8h+0QZ1F7IaHk/XQX7ZYnfD+nS0ToT5LLgZvxe0X8WVj9OzrOOk6r8EJYtncmX0PAbS6v1CmPmII=
Received: by 10.78.131.8 with SMTP id e8mr2113262hud.1194097587992;
        Sat, 03 Nov 2007 06:46:27 -0700 (PDT)
Received: by 10.78.39.14 with HTTP; Sat, 3 Nov 2007 06:46:27 -0700 (PDT)
In-Reply-To: <472C3309.70109@op5.se>
Content-Disposition: inline
X-Google-Sender-Auth: 60926ffc8dd70b7a
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63268>

On Nov 3, 2007 4:36 AM, Andreas Ericsson <ae@op5.se> wrote:
> Ronald Landheer-Cieslak wrote:
> >
> > This is also available through git at
> > git://vlinder.landheer-cieslak.com/git/git.git#topic/git-log-changelog
> >
>
> This mode of specifying a repository + branch was just thoroughly shot
> down in a list discussion, and git certainly doesn't grok it. I'd be a
> happier fella if you didn't use it.
>
Is there a canonical way to specify both the location and the branch
in one shot, then? I must admit that this is the way I've always seen
it specified, so I assumed that this is the way it was done
"canonically". If it isn't, please forgive my ignorance.

rlc


-- 
Ronald Landheer-Cieslak
Software Architect
http://www.landheer-cieslak.com/
New White Paper: "Three Good Reasons to Plan Ahead"
