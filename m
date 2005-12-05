From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: make gitfakemmap standalone to fix linking error in git.c
Date: Mon, 5 Dec 2005 16:43:57 +0100
Message-ID: <81b0412b0512050743i3084eadag7df00793a26ec3a9@mail.gmail.com>
References: <81b0412b0512050519k5ed80035x9eb4907f569e0a4b@mail.gmail.com>
	 <81b0412b0512050524w7b632651n93c836fda41a39d@mail.gmail.com>
	 <20051205141141.GF22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Dec 05 16:45:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjIVW-0005Hn-3T
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 16:44:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbVLEPn7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 10:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbVLEPn7
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 10:43:59 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:61979 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751375AbVLEPn6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 5 Dec 2005 10:43:58 -0500
Received: by nproxy.gmail.com with SMTP id m18so27202nfc
        for <git@vger.kernel.org>; Mon, 05 Dec 2005 07:43:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=obYAl872AxnzTdpFFXvZqQnct8D41j4Oj9gHf7I0SEMeGwLZTAvblUkKtul83YR5hBCgQ9QpF+L4873jrsWbXeCXxbsuH8o4udQqIwkmO+mnAgtLKreQAhAtcReChk8GU6OptK3s0vG7yAltmTQOCwz4SvoWOuysjedLtfermII=
Received: by 10.49.43.13 with SMTP id v13mr1603870nfj;
        Mon, 05 Dec 2005 07:43:57 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Mon, 5 Dec 2005 07:43:57 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051205141141.GF22159@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13216>

On 12/5/05, Petr Baudis <pasky@suse.cz> wrote:
> > The patch is to fix the error introduced by previous patch, which
> > inverted condition of checking for the supported case (start must be
> > NULL).
>
> Possibly not worth yet another patch submission now, but in general I
> believe it's better to send new revision of the original patch rather
> than another patch on top of the previous one.

Yes, of course. Sorry... I will not resend, it's trivial, but I
promise to get better.
