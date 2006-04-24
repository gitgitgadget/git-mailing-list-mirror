From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: How do I quickly check what heads a particular commit is in?
Date: Mon, 24 Apr 2006 16:50:35 +1200
Message-ID: <46a038f90604232150y7c99ceb2sf8f6bf05d701b3d7@mail.gmail.com>
References: <46a038f90604232123r7f35660aufbb9da0f561f8ea@mail.gmail.com>
	 <7v4q0jd1sj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 24 06:50:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXt26-0001PT-QW
	for gcvg-git@gmane.org; Mon, 24 Apr 2006 06:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWDXEuh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Apr 2006 00:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbWDXEuh
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Apr 2006 00:50:37 -0400
Received: from wproxy.gmail.com ([64.233.184.226]:8590 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750710AbWDXEug convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Apr 2006 00:50:36 -0400
Received: by wproxy.gmail.com with SMTP id i2so302796wra
        for <git@vger.kernel.org>; Sun, 23 Apr 2006 21:50:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bsrZGKdHtBWenHzakgKt/v1Y7lnKd4qREU6eWZHM+luOLPI/aJGSnWP/GeGG4nlOyAG9/746sAtt4aZ0Fj7M6O2CyAYNjbvS+x3eXz8yk1BnoaRicZGf9dNG79fhiimtYIjN+/yeP9TzdMYiLggb7k6JA39moXTifB7ORFw5EJQ=
Received: by 10.54.117.20 with SMTP id p20mr434293wrc;
        Sun, 23 Apr 2006 21:50:35 -0700 (PDT)
Received: by 10.54.127.4 with HTTP; Sun, 23 Apr 2006 21:50:35 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v4q0jd1sj.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19088>

On 4/24/06, Junio C Hamano <junkio@cox.net> wrote:
> git merge-base $broken_commit "master"
>
> would show $broken_commit if "master" is a fast-forward of
> $broken_commit (i.e. "master" is a descendant).  I think that is
> what you are calling "$broken_commit is in master".

of course! Thanks! I'm in the middle of a somewhat nasty merge, and my
fingers got all tangled working up and down the history finding what
heads have this commit. I can now do a loop with bash calling all the
heads against it. Great!

 (hmmm. just had to decide to go back to basics and perform some
reverts before retrying the merge.)


m
