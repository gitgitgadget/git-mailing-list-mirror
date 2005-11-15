From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: fix git-pack-redundant crashing sometimes
Date: Tue, 15 Nov 2005 17:11:17 +0100
Message-ID: <81b0412b0511150811w2a7a2c4ft9a2920ac4f030ee4@mail.gmail.com>
References: <81b0412b0511150749g5672158v7b39c02ffdf13e08@mail.gmail.com>
	 <20051115180848.561a6da5.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, lukass@etek.chalmers.se, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Nov 15 17:15:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec3P0-0000YW-9c
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 17:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbVKOQLT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 11:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbVKOQLT
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 11:11:19 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:37624 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964808AbVKOQLS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 11:11:18 -0500
Received: by nproxy.gmail.com with SMTP id c29so307371nfb
        for <git@vger.kernel.org>; Tue, 15 Nov 2005 08:11:17 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DnJeK1cpXrrfyUSP5E454VOlHWtHITAEIL8xBIixZXldgjF35rWUSTRZGirKshiMSrLWtUxaHZDJRHzb8wyjzv3Zd73z3YDV6pwqr9uCXjLeYypBflv+97ghnJJDC6CP1Wc3L6RbEGLCTmKX6GmASD0P8bksxmbjD5xbWT9rp1E=
Received: by 10.48.202.10 with SMTP id z10mr34415nff;
        Tue, 15 Nov 2005 08:11:17 -0800 (PST)
Received: by 10.48.247.3 with HTTP; Tue, 15 Nov 2005 08:11:17 -0800 (PST)
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20051115180848.561a6da5.tihirvon@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11914>

On 11/15/05, Timo Hirvonen <tihirvon@gmail.com> wrote:
> > The code could profit from double-linked lists greatly, IMHO.
>
> I use list.h from Linux when I need double-linked lists.  It is very
> easy to use, efficient and fast.
>

Yes, I had it in mind, too.
