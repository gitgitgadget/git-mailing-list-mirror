From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Teach 'git-apply --whitespace=strip' to remove empty lines at the end of file
Date: Sun, 20 May 2007 22:44:27 +0200
Message-ID: <e5bfff550705201344r274ac9f4g9ca5e1fefe7c12cd@mail.gmail.com>
References: <e5bfff550705200251j3dd9b377je7ae5bafac988060@mail.gmail.com>
	 <7vabvzq0bb.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550705200334pef694cn1a7842c23e2672f5@mail.gmail.com>
	 <7vabvzoij8.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550705200545kcf1f7f9n4f3f6d7d25955e1@mail.gmail.com>
	 <7v1whbmjel.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550705201156m244e1cf0v7e6b3ab43fa3b47b@mail.gmail.com>
	 <20070520191718.GI4085@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Frank Lichtenheld" <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Sun May 20 22:44:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpsGa-0007GE-VO
	for gcvg-git@gmane.org; Sun, 20 May 2007 22:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756278AbXETUoa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 16:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756257AbXETUoa
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 16:44:30 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:34218 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756186AbXETUo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 16:44:29 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1252225wra
        for <git@vger.kernel.org>; Sun, 20 May 2007 13:44:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rztWRX74MYMKRECt8EgwoV0inie090OUQybGXpbc2LlibzPa881OY8FPivT+6xwPeMnnShpYY7YhwWbbDWF9JLFAAb/v6YLIOfqIAezitv75QATXpCrm8zvx59EOf9eYIDHFvq0FTUmCuP8pxOovwCBGorvt9q6oNqLi2GOYWaU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c2RVOAxE/aDBTEugOP8Hw9K+m0BSpmHKBFWn4FjdkRVfHTDu5qmfWb9QnO1rJ4gwACGENRPvzCRrCvKE6YIx/UmK8MIfZ1Lvo42sjQkcIrYDQFWvKNdfUuzWanYzQcYc6H/dz2h4u4O5q04QVZXRSJkSeu3XCu6FfxthIauWCBg=
Received: by 10.114.67.2 with SMTP id p2mr2270156waa.1179693867684;
        Sun, 20 May 2007 13:44:27 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sun, 20 May 2007 13:44:27 -0700 (PDT)
In-Reply-To: <20070520191718.GI4085@planck.djpig.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47910>

On 5/20/07, Frank Lichtenheld <frank@lichtenheld.de> wrote:
> > >
> > >But we have kept our sources -Wdeclaration-after-statement
> > >clean so far
> >
> > ??????
> >
> > Wie bitte?
>
> man gcc:
>
> -Wdeclaration-after-statement (C only)
>    Warn when a declaration is found after a statement in a block.
>

Just for my personal knowledge, what's the meaning of this apparently
non-sense kind of warning?

Thanks
Marco
