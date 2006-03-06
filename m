From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] annotate: Support annotation of files on other revisions.
Date: Mon, 6 Mar 2006 17:18:35 +1300
Message-ID: <46a038f90603052018n76d316eclf84b6921c9595f16@mail.gmail.com>
References: <20060305111334.GB23448@c165.ib.student.liu.se>
	 <440B751F.5000801@michonline.com>
	 <46a038f90603051629ke34a0a6u89dad995bbd777b0@mail.gmail.com>
	 <20060306024353.GA23001@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Fredrik Kuivinen" <freku045@student.liu.se>, git@vger.kernel.org,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Mar 06 05:18:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG7BN-0001HH-Kt
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 05:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWCFESj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 23:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWCFESj
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 23:18:39 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:10164 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750714AbWCFESi convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Mar 2006 23:18:38 -0500
Received: by wproxy.gmail.com with SMTP id 57so1063011wri
        for <git@vger.kernel.org>; Sun, 05 Mar 2006 20:18:36 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I/2SxEytxc2vmIdotctpGlAz4ky5GGiIlpBWxiTfd6UtfMmb4P4v52/a+h0jaRZCjC8ivLFH7wm0UCmEzDiim4rzciqSpIx1yT0ckOyquXuH4p0uOGNmCn3w5A/vdyD0kcgo7YHq9GenfxC+xPHQGwKkKc9YrsdHObhBetQvKCA=
Received: by 10.54.153.5 with SMTP id a5mr4730713wre;
        Sun, 05 Mar 2006 20:18:35 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Sun, 5 Mar 2006 20:18:35 -0800 (PST)
To: "Ryan Anderson" <ryan@michonline.com>
In-Reply-To: <20060306024353.GA23001@mythryan2.michonline.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17269>

On 3/6/06, Ryan Anderson <ryan@michonline.com> wrote:
> annotate was *trying* to handle that cleanly, but failed due to a silly

Great stuff, thanks! I'll let it hit master and then I'll drop the
messy part of req_annotate() in cvsserver.

> For annotate, the syntax I was using was:
>         git annotate Makefile headname
>
> I'm not married to it, so please, send a patch to change it if you want
> (Please fix up the test case I'm sending in this patch, as well.)

That's _perfect_. I was just making the syntax up.

cheers,


martin
