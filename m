From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git-svnimport usage with different SVN repo layouts
Date: Thu, 15 Dec 2005 18:54:28 +1300
Message-ID: <46a038f90512142154h2ad47d62n2c26042ad35d2c23@mail.gmail.com>
References: <46a038f90512142047n1cf9c927ye26af2c7f77f9b63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Dec 15 06:55:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Emm4f-0005I8-Kx
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 06:54:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161136AbVLOFya (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 00:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161138AbVLOFya
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 00:54:30 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:60699 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161136AbVLOFy3 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 00:54:29 -0500
Received: by wproxy.gmail.com with SMTP id 57so287464wri
        for <git@vger.kernel.org>; Wed, 14 Dec 2005 21:54:28 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EA3pp8BSQVoSSZvj3ALMdsYGUDCT/X7F8nnaBCi617Q/GYHsmzMhceAJm9cWi4gcigl0jk9CChv0XyTvqRQu0H4/L99+ESD0/juMhayflYcruff9sCTOR+v82/DHrZbAOEobUrkeb2YvAdmU8y4vTGWkNWgH+KtST4lFstjBYx0=
Received: by 10.54.67.6 with SMTP id p6mr1798796wra;
        Wed, 14 Dec 2005 21:54:28 -0800 (PST)
Received: by 10.54.72.15 with HTTP; Wed, 14 Dec 2005 21:54:28 -0800 (PST)
To: Git Mailing List <git@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <46a038f90512142047n1cf9c927ye26af2c7f77f9b63@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13681>

On 12/15/05, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> Example:
>
>   # this gives me a small repo with 40 commits
>   svn co svn://elgg.net/devel
>
>   # but I could not get any of this to go
>   git-svnimport svn://elgg.net/devel

At last -- success with

  git-svnimport  -t releases -T devel  -b branches svn://elgg.net

and success (at least apparently) with

  git-svnimport -v -b branches svn://svn.berlios.de/rtnet

cheers.


martin
