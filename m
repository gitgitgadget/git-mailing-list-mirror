From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] merge-one-file: remove empty directories
Date: Mon, 21 Nov 2005 15:22:59 +0100
Message-ID: <81b0412b0511210622v87ecab6y7dbe703cb4395dad@mail.gmail.com>
References: <17279.1674.22992.607091@cargo.ozlabs.ibm.com>
	 <20051119140736.GA24901@lst.de>
	 <Pine.LNX.4.64.0511190957320.13959@g5.osdl.org>
	 <7v4q683qhe.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0511200901450.13959@g5.osdl.org>
	 <4380BB97.7070407@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Christoph Hellwig <hch@lst.de>,
	Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
	Git Mailing List <git@vger.kernel.org>,
	Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Mon Nov 21 15:24:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeCZW-0000bu-Ls
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 15:23:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbVKUOXD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 09:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbVKUOXC
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 09:23:02 -0500
Received: from nproxy.gmail.com ([64.233.182.193]:27054 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932298AbVKUOXB convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 09:23:01 -0500
Received: by nproxy.gmail.com with SMTP id x4so91775nfb
        for <git@vger.kernel.org>; Mon, 21 Nov 2005 06:22:59 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OJebekmtX03ybdIeHXxLIxgGOzNvF1/8EGLhv0yqzKeS/Xl76L00V94NpKDvh/q8MyYceppFw3tjLJ6sVFf0MEiA7aMRril0mUhvWyuOBC3QBTzKX2ng4//V4S5zZ2WPlg9cdzKW5Jalj/6mOMtKR8mkILeKkTRyCKa03755LgU=
Received: by 10.49.5.19 with SMTP id h19mr267882nfi;
        Mon, 21 Nov 2005 06:22:59 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Mon, 21 Nov 2005 06:22:59 -0800 (PST)
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4380BB97.7070407@zytor.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12445>

On 11/20/05, H. Peter Anvin <hpa@zytor.com> wrote:
> Linus Torvalds wrote:
> >
> > Even VMS seems to have it (although if git is ever ported to VMS, I'll
> > just have to shoot myself. I used VMS in -88, and the scars are _still_
> > fresh).
> >
>
> Yeah, well, WinNT is basically the successor to VMS.  (I have heard from
> several ex-DECers that WNT was done on top of a stolen copy of what was
> supposed-to-have-been the successor to VMS.)

...and yes, the users of NT are almost ready to shoot themselves.
