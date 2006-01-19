From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: cygwin-latest: compile errors related to sockaddr_storage, dirent->d_type and dirent->d_ino
Date: Thu, 19 Jan 2006 16:04:26 +0100
Message-ID: <81b0412b0601190704j617205c4g8a66a55638b5a6c4@mail.gmail.com>
References: <81b0412b0601180547q4a812c8xb632de6ab13a5e62@mail.gmail.com>
	 <20060119125155.GZ28365@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jan 19 16:05:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzbKw-0004Nk-W5
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 16:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161220AbWASPE2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 10:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161226AbWASPE2
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 10:04:28 -0500
Received: from uproxy.gmail.com ([66.249.92.205]:17252 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161220AbWASPE1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2006 10:04:27 -0500
Received: by uproxy.gmail.com with SMTP id s2so255694uge
        for <git@vger.kernel.org>; Thu, 19 Jan 2006 07:04:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oxlqhKGoQwPI/2ThgTm0x+kn5kCuOz21WC7orLiRk+NgmQBHRnsakOXiG9pAacbkxl5P6PiCyVI7onaMOwJbs9gQXMWe7vq8w/5mWfuJQ8bSu1Xw8lzsyemn15zTGFEO2+yZbomrDL7UC6ve3x3MaKrI0YJRHpPZPUTBzynKNaI=
Received: by 10.49.39.19 with SMTP id r19mr48713nfj;
        Thu, 19 Jan 2006 07:04:26 -0800 (PST)
Received: by 10.49.14.20 with HTTP; Thu, 19 Jan 2006 07:04:26 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060119125155.GZ28365@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14911>

On 1/19/06, Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Wed, Jan 18, 2006 at 02:47:00PM CET, I got a letter
> where Alex Riesen <raa.lkml@gmail.com> said that...
> > For reasons unknown, cygwin decided to use our sockaddr_storage.
> > As it is redefined to sockaddr_in it'd cause compilation errors in
> > cygwin headers. Fixed by first patch, which uses a more git-related
> > name (can we claim rights for the symbol, being first to use it? :-)
>
> Huh? "Our"? See RFC 2553 and e.g.:
>
>         http://www.opengroup.org/onlinepubs/009695399/basedefs/sys/socket.h.html
>
> You have no business meddling with this identifier except working around
> platforms which do not support it, but then do not complain that things
> break when the platforms actually start supporting it. ;-)

That will remind me to consult the specs first.
