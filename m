From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Getting rid of symlinks in .git?
Date: Tue, 15 Nov 2005 08:13:14 +0100
Message-ID: <81b0412b0511142313r9635121wb4fdfe12c3ec35fe@mail.gmail.com>
References: <20051110204543.GZ30496@pasky.or.cz> <43746118.30404@hogyros.de>
	 <81b0412b0511110443x48415032k8ca40d999071e8a9@mail.gmail.com>
	 <7vhdaevedu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Simon Richter <Simon.Richter@hogyros.de>
X-From: git-owner@vger.kernel.org Tue Nov 15 08:14:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ebv0W-0004Gk-WF
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 08:13:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbVKOHNQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 02:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbVKOHNQ
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 02:13:16 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:1553 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932317AbVKOHNQ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 02:13:16 -0500
Received: by nproxy.gmail.com with SMTP id q29so261976nfc
        for <git@vger.kernel.org>; Mon, 14 Nov 2005 23:13:14 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uTMTjeC3m/HLlosBgGTTBiQ6XFe+DtdsNJfa7cRq9Fk+ljbsimVhHVa9/pU9PaDp88s6Hr+dxdevXUH9ucrJpoAuH5got8N6fouUHMm2AyuHL2yYSBgdIH0nEgnMipQNTxTfiBKbkBxYzL4qOtN0fCrE1AsafqzRK9zNAzgkBI4=
Received: by 10.48.199.17 with SMTP id w17mr250210nff;
        Mon, 14 Nov 2005 23:13:14 -0800 (PST)
Received: by 10.48.247.3 with HTTP; Mon, 14 Nov 2005 23:13:14 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhdaevedu.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11880>

On 11/15/05, Junio C Hamano <junkio@cox.net> wrote:
> > But you shouldn't care if you have reasonably recent git everywhere:
> > symlinks and their absence already handled: .git/config created by
> > init-db contains the configuration parameter for filemode, which
> > decides whether it is safe to use the symlinks on the underlying
> > filesystem.
>
> No, no no nononononono....
>
> core.filemode is whether the executable bit is trustworthy and
> does not have anything to do with symlinked heads, although
> these two happen to become problematic on VFAT.

Of course! Silly me...
