From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: cygwin-latest: compile errors related to sockaddr_storage, dirent->d_type and dirent->d_ino
Date: Thu, 19 Jan 2006 16:07:49 +0100
Message-ID: <81b0412b0601190707g5613a755l7457d8b76039c0ea@mail.gmail.com>
References: <81b0412b0601180547q4a812c8xb632de6ab13a5e62@mail.gmail.com>
	 <20060119130009.GA28365@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jan 19 16:08:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzbOE-0005EC-9p
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 16:07:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161227AbWASPHw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 10:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161228AbWASPHw
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 10:07:52 -0500
Received: from uproxy.gmail.com ([66.249.92.198]:14864 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161227AbWASPHv convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2006 10:07:51 -0500
Received: by uproxy.gmail.com with SMTP id s2so257172uge
        for <git@vger.kernel.org>; Thu, 19 Jan 2006 07:07:50 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ucUuZWwgGmkp2coI2jIyo84g0FB3j5FGMZtC8yxL2zImH6XAb2zWKUpaPQfypncJJgiPojDRTeyY2ClQcAzvLlxeAoj377MXfBJd680Xmx7OgxrPFusa5Y9e/O+QuQnAZdztdYkZ68re+wAvzoCEnaQfGdpYX6OSzeg5PT1LRfo=
Received: by 10.48.232.8 with SMTP id e8mr47772nfh;
        Thu, 19 Jan 2006 07:07:49 -0800 (PST)
Received: by 10.49.14.20 with HTTP; Thu, 19 Jan 2006 07:07:49 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060119130009.GA28365@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14912>

On 1/19/06, Petr Baudis <pasky@suse.cz> wrote:
>   But of course when this goes on, soon the gcc commandline will get
> really awfully ugly. This is why something _like_ autoconf is a good
> thing - you can just detect if the system headers provide the type and
> #define it only when they don't.

not you. Someone has done the job of detecting things for you.
It's just a fair amount of hard work badly done.
