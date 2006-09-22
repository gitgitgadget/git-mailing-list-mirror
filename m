From: Santi <sbejar@gmail.com>
Subject: Re: Git user survey and `git pull`
Date: Fri, 22 Sep 2006 12:34:43 +0200
Message-ID: <8aa486160609220334w39a7d455s66f815f00ef6b6f6@mail.gmail.com>
References: <20060921162401.GD3934@spearce.org>
	 <20060921164048.GY8259@pasky.or.cz>
	 <Pine.LNX.4.64.0609211027440.4388@g5.osdl.org>
	 <7vu0305wh8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 22 12:35:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQiN6-0001Sf-PC
	for gcvg-git@gmane.org; Fri, 22 Sep 2006 12:35:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWIVKep (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 06:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWIVKep
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 06:34:45 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:11116 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750751AbWIVKeo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Sep 2006 06:34:44 -0400
Received: by wx-out-0506.google.com with SMTP id r21so1179215wxc
        for <git@vger.kernel.org>; Fri, 22 Sep 2006 03:34:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t0gmNmtF7mAESu5/a8p8ARU6hfaGKDC68LvW3tIwh3SqlYuC+cTz8Dt5ZV4/XLJqUVHsd2gSjTfDTUTb23e1CPK196+ZoXp1wZorFDnUcZrAujxB5Oq9grZRSY5Mk6GtjyhczxeSh/f2W0+KH2so2POO0iI8cwyLPSO7hi9LCjw=
Received: by 10.70.131.19 with SMTP id e19mr324714wxd;
        Fri, 22 Sep 2006 03:34:43 -0700 (PDT)
Received: by 10.70.19.6 with HTTP; Fri, 22 Sep 2006 03:34:43 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vu0305wh8.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27525>

2006/9/22, Junio C Hamano <junkio@cox.net>:
> I am actually in favor of adding config mechanism that lets you
> say things like:
>
>   When on branch 'foo':
>
>   - pull without any argument shall use .git/remotes/$that,
>     instead of the usual .git/remotes/origin;
>
>   - pull without pathspec arguments shall use the named
>     .git/remotes/ file to learn from which URL to fetch from,
>     which remote branches to fetch and which local branches to
>     store them, but merge $this_and_that remote heads regardless
>     of what .git/remotes/ file says;
>

Something like
http://marc.theaimsgroup.com/?l=git&m=115398815111209&w=2
?

  Santi
