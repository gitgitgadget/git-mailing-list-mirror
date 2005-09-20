From: Stefhen Hovland <stefhen.hovland@gmail.com>
Subject: Re: [PATCH][COGITO] Add .deb build support to Makefile
Date: Mon, 19 Sep 2005 19:48:50 -0500
Message-ID: <7c278d0c050919174831798c8d@mail.gmail.com>
References: <7c278d0c05091917232c79b909@mail.gmail.com>
	 <20050920003102.GB13537@pasky.or.cz>
Reply-To: stefhen.hovland@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 02:49:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHWJh-0006IR-Mu
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 02:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbVITAsz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 20:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbVITAsz
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 20:48:55 -0400
Received: from xproxy.gmail.com ([66.249.82.205]:43765 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964809AbVITAsy convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 20:48:54 -0400
Received: by xproxy.gmail.com with SMTP id i27so237080wxd
        for <git@vger.kernel.org>; Mon, 19 Sep 2005 17:48:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GnPIkaWLTLVHE+9zEMWfpbvU5DzZQjZBOrP0zxX8ckR85Rq1dvNVBbXmJoIPVR1Y6t80saJiYrycXpu95B9yhgUxDi97l6P98JaYwjr9mPveOmWVKkRIyKCVJzgaxtJxFRMvt4KNU0KGosjPcUxsK7ONwTNqepxSp0e4n16t9ps=
Received: by 10.70.48.16 with SMTP id v16mr1682001wxv;
        Mon, 19 Sep 2005 17:48:50 -0700 (PDT)
Received: by 10.70.12.11 with HTTP; Mon, 19 Sep 2005 17:48:50 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050920003102.GB13537@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8940>

On 9/19/05, Petr Baudis <pasky@ucw.cz> wrote:
> Dear diary, on Tue, Sep 20, 2005 at 02:23:56AM CEST, I got a letter
> where Stefhen Hovland <stefhen.hovland@gmail.com> told me that...
> > Attached is a simple patch adding support to cogito for "make deb".
> > Please use if useful or let me know if this patch is offbase..
> 
> Thanks, applied. I just changed it so that the temporary directory is
> removed after fakeroot completes successfully.
> 

Great thanks.


Also I noticed the variable $(GIT_TARNAME) in the Makefile, it looks
like it was probably just copied from the git Makefile. Wouldn't this
make more sense just from a non confusion/cleanliness standpoint to be
called $(COGITO_TARNAME), or is this not worth bothering with? If so I
can just submit a quick diff.

Thanks,
Stefhen
