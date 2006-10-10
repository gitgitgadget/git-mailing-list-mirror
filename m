From: "Dongsheng Song" <dongsheng.song@gmail.com>
Subject: Re: Why gitweb commitdiff NO diff output ?
Date: Tue, 10 Oct 2006 18:46:34 +0800
Message-ID: <4b3406f0610100346v16f1f2f6i305963bc1b398dac@mail.gmail.com>
References: <4b3406f0609280032y77cb5961i220b3cfd741ebfd4@mail.gmail.com>
	 <20061003095250.GJ2871@admingilde.org>
	 <7vwt7hnvsk.fsf@assigned-by-dhcp.cox.net>
	 <4b3406f0610080122r17a10ea4h2c71a399fb8398a@mail.gmail.com>
	 <7v64et9fjq.fsf@assigned-by-dhcp.cox.net>
	 <4b3406f0610091851i593f3e53v5d5fef891edb6d48@mail.gmail.com>
	 <7v1wpgapew.fsf@assigned-by-dhcp.cox.net>
	 <7viris9a6g.fsf@assigned-by-dhcp.cox.net>
	 <4b3406f0610092336v5ab58134i280f64223a272b0b@mail.gmail.com>
	 <7vy7ro64pq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 13:21:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXFg7-0002oh-BA
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 13:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbWJJLVj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 07:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933013AbWJJLVj
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 07:21:39 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:25478 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932629AbWJJLVi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 07:21:38 -0400
Received: by py-out-1112.google.com with SMTP id n25so2778507pyg
        for <git@vger.kernel.org>; Tue, 10 Oct 2006 04:21:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GDWgE5h0T9OSCbGvzT47xiAO0fyBqGPTiPujyHlpuIubcK3/4beeVAnCQxb/E5KUjOfVa0XRQnNMC/GRXdgzFLGJ7+s2uws2xxuVaIJUuQjWRKUD9Ebw+56WBY1123zvfUUbKh6KArbH5Ie7BmhxF1JmnCcL+6DgquvUpOZ/fEg=
Received: by 10.35.37.13 with SMTP id p13mr14887645pyj;
        Tue, 10 Oct 2006 03:46:35 -0700 (PDT)
Received: by 10.35.106.3 with HTTP; Tue, 10 Oct 2006 03:46:34 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vy7ro64pq.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28627>

Thanks, now that's OK.

>
> I am not sure what version of gitweb your distribution packages,
> but it used to be that commitdiff page wanted to create
> temporary file somewhere on the filesystem (the variable was
> $git_temp and by default it was set to "/tmp/gitweb", I think).
> Your other pages such as commit and log page seem to be working,
> so perhaps your gitweb has trouble writing there only on that
> machine?
>
