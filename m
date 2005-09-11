From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: bogus merges
Date: Sun, 11 Sep 2005 23:48:10 +1200
Message-ID: <46a038f905091104483cc01a11@mail.gmail.com>
References: <59a6e58305090507387d412b3d@mail.gmail.com>
	 <Pine.LNX.4.58.0509050853080.3568@evo.osdl.org>
	 <20050911112130.A7510@flint.arm.linux.org.uk>
Reply-To: martin.langhoff@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, Wayne Scott <wsc9tt@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 13:49:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEQJl-00037l-Eo
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 13:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbVIKLsO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 07:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbVIKLsO
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 07:48:14 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:33047 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932440AbVIKLsN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 07:48:13 -0400
Received: by rproxy.gmail.com with SMTP id i8so250885rne
        for <git@vger.kernel.org>; Sun, 11 Sep 2005 04:48:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YQB+C2OJzZ3PIGC7XFcoJnZKWVTS68I9c6w7z6zbt194lA1+NfTglam24bbZ+nWSKOKvwxbiwyzDTcS1uJrbWg1i6Iv4P96kcpOo5hQiAe5zYUVr+rMJ+3UyqXXEg+Cppn8ynVjfMklm2/u3by7AU64QTBmb10tH4gCFu1FiUCQ=
Received: by 10.38.209.4 with SMTP id h4mr198050rng;
        Sun, 11 Sep 2005 04:48:10 -0700 (PDT)
Received: by 10.38.101.53 with HTTP; Sun, 11 Sep 2005 04:48:10 -0700 (PDT)
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050911112130.A7510@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8293>

On 9/11/05, Russell King <rmk@arm.linux.org.uk> wrote:
> On Mon, Sep 05, 2005 at 09:01:32AM -0700, Linus Torvalds wrote:
> > I suspect rmk is using cogito-0.13
> 
> Correct, and rmk will probably be extremely nervous about upgrading when
> 0.14 appears.

Well, *actually* cogito-0.13 didn't include git-core, so we have to
look for the reasons elsewhere. Could be the leftover MERGE_HEAD
Daniel mentions.

Russel, can you confirm what git-core version you are/were running?

cheers,.


martin
