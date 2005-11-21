From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: Diffs "from" working directory
Date: Mon, 21 Nov 2005 21:45:49 +0000
Message-ID: <b0943d9e0511211345p41fcca6eu@mail.gmail.com>
References: <200511201817.15780.blaisorblade@yahoo.it>
	 <20051120174359.GA24177@fieldses.org>
	 <Pine.LNX.4.64.0511201010490.13959@g5.osdl.org>
	 <20051120205855.GA30346@fieldses.org>
	 <4381287F.5080402@citi.umich.edu>
	 <b0943d9e0511211328j7c062c07s@mail.gmail.com>
	 <7vhda5of1r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 22:48:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeJU2-0002qQ-3v
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 22:45:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbVKUVpv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 16:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbVKUVpv
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 16:45:51 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:37539 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751069AbVKUVpu convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 16:45:50 -0500
Received: by xproxy.gmail.com with SMTP id i30so736605wxd
        for <git@vger.kernel.org>; Mon, 21 Nov 2005 13:45:49 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P5sklcN3ggI8xb8bkcfFD4lUK2/YgR0agRGKYsnFlCIy3LR/NlTheWTiJa2SBbxJFtQp2oLmGW82HhDvaLG5EY3EUhXcjXvp0lF5Snoukg2L9rP5JNETcETktojTivEzw1z+SV2h2FDjby/teJQxtLfnFyw87tD7zvio0FmIt9w=
Received: by 10.70.54.9 with SMTP id c9mr2688273wxa;
        Mon, 21 Nov 2005 13:45:49 -0800 (PST)
Received: by 10.70.27.12 with HTTP; Mon, 21 Nov 2005 13:45:49 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhda5of1r.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12492>

On 21/11/05, Junio C Hamano <junkio@cox.net> wrote:
> Catalin Marinas <catalin.marinas@gmail.com> writes:
>
> > My import command sets the author to the e-mail sender, which was you.
> > Maybe this should be changed but I don't know which option is better.
> > In the meantime, you can change the default e-mail template to set the
> > From: line with to the author of the patch and maybe add a Reply-to:
> > with your address.
>
> ... and Sender: perhaps?

Yes.

> The first lines in the commit log message sent over e-mail can
> have "Subject: " (or "[PATCH] "), "From: ", and "Date: " to
> override what is slurped from e-mail headers if you use mailinfo,
> so that might be a better alternative to suggest.

Thanks for the suggestion. It is indeed a good idea to parse the
commit log and override the information from the headers.

--
Catalin
