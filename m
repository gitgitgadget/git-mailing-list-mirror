From: "David Ho" <davidkwho@gmail.com>
Subject: Re: Moving a file back to an earlier revision.
Date: Fri, 31 Mar 2006 17:21:48 -0500
Message-ID: <4dd15d180603311421w7b48cfa4y80d3f9d565d4276f@mail.gmail.com>
References: <4dd15d180603311313t7781f2ebk616276e9134f6472@mail.gmail.com>
	 <4dd15d180603311332p60fa1867nc303bd92d515b4e0@mail.gmail.com>
	 <7vacb6thc7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 01 00:22:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPS0M-0007sh-0b
	for gcvg-git@gmane.org; Sat, 01 Apr 2006 00:22:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWCaWVu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Mar 2006 17:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWCaWVu
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Mar 2006 17:21:50 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:33902 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751445AbWCaWVt convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Mar 2006 17:21:49 -0500
Received: by zproxy.gmail.com with SMTP id k1so987916nzf
        for <git@vger.kernel.org>; Fri, 31 Mar 2006 14:21:48 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fLqNqpZrN4Ns0AWuXQvFRUQ6yI+w+4D/51QN072IslgaDs3e3F3W1FiD39gAq58d7/delwq/MrHrdNa2Q6HNkEGTLkNY5d5sGQ716bcs9h1cE0b5OfF3HNVVayHYDagnC0Y7oOylh+ZSfGqfb2pOSCjb26DqbN/4jgmLMib9nog=
Received: by 10.65.15.8 with SMTP id s8mr470387qbi;
        Fri, 31 Mar 2006 14:21:48 -0800 (PST)
Received: by 10.65.22.11 with HTTP; Fri, 31 Mar 2006 14:21:48 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vacb6thc7.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18238>

> Remember, a branch in git is very cheap, and is a powerful way
> to keep track of things while you decide which alternate
> universe to take.  And even after you decide, you could always
> look at and even build on the other universe.

I feel embarrassed to say this but in my branch there are commits to
the driver and other commits for the board so it looks more like

---0---D1---B1---B2---D2---B3---B4---

D* - driver changes
B* - board changes

So to go back to the 0 state I lose my board changes.  But I hope what
I did (in my reply to Linus) is very close to your idea of having
separate branches.

David
