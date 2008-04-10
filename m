From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Friendly refspecs (Was: Re: git annoyances)
Date: Thu, 10 Apr 2008 09:58:56 +0200
Message-ID: <bd6139dc0804100058r44488432ke19c27432b561561@mail.gmail.com>
References: <20080409101428.GA2637@elte.hu>
	 <20080409145758.GB20874@sigill.intra.peff.net>
	 <20080409200836.GA19248@mithlond>
	 <20080409203453.GA10370@sigill.intra.peff.net>
	 <20080409222500.GB19248@mithlond>
	 <20080409225112.GB12103@sigill.intra.peff.net>
	 <bd6139dc0804091616k53f4e0c1sf75aa9585c5a54c5@mail.gmail.com>
	 <20080410003352.GA14057@sigill.intra.peff.net>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 10 09:59:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjrh9-0000W9-QS
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 09:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754524AbYDJH65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 03:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754328AbYDJH65
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 03:58:57 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:26992 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753931AbYDJH64 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 03:58:56 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2935446wff.4
        for <git@vger.kernel.org>; Thu, 10 Apr 2008 00:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=cIVUkFKj41adWRm4hewGXlFD9bti6BbK5tIHCZ8tLYQ=;
        b=EplNJFXfvhTKmB3nLIs6M3soa6015XFLToeK0SJZcd/1ao0577d9cKwSM7p+BDaE2m0auPEooI1NZ3cj53kM+nbb1UP0Yi6rynnY0EUbBiEHyd2LWtPyKG6117rZu8Zl92Xcwbcy29NRIcRedvk8DYExsLVn2GgEawcC86htw6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QdYjWmR++bcEiNkIRwlFVhe/wBqbYvYqpttLjnFdXPwiY6pn7iZ+uCXOhmk+vXFtfXzw0Aah8z5dl/i+WOt0h8KUfKVFzXfG+8bQcYRYNXJ28WJi+of7XZhZq6aXKnYiPGOxnBSUK4jKzyvHjQ+1KrkP/HCKKRqGGOnVjU63PLI=
Received: by 10.143.3.4 with SMTP id f4mr340593wfi.343.1207814336216;
        Thu, 10 Apr 2008 00:58:56 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Thu, 10 Apr 2008 00:58:56 -0700 (PDT)
In-Reply-To: <20080410003352.GA14057@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79191>

On Thu, Apr 10, 2008 at 2:33 AM, Jeff King <peff@peff.net> wrote:
> [Your message didn't go to the list, but I think it was supposed to, so
>  I am re-adding the list].

Yes, it was supposed to go to the list, my bad for hitting 'reply'
instead of 'reply to all'.

>  On Thu, Apr 10, 2008 at 01:16:57AM +0200, Sverre Rabbelier wrote:
>  > >  I wonder if people like Linus who do a lot of one-off pulls would find
>  > >  that too cluttery. I guess we can post a patch and see. ;)
>  >
>  > Maybe a 'newbie' configuration option could be added?
>  > We can then, if that option is set, provide this kind of information
>  > to the user.
>  > Then, later on, when the user is more confident, they can unset the option.
>  > I reckon it should be set to default-off but that we should provide an
>  > easy way to turn it on.
>  > (That is, 'git config newbie on', is easy enough, as long as it is
>  > mentioned in a/the newbie guide)
>
>  This has been discussed before, and I think the general consensus was
>  that it's a bad idea to separate the "newbie" and "expert" experience
>  too much. It makes it harder to provide advice and documentation that
>  works for everyone.

I would agree here, not only will it make it hard to provide
consequent advice and documentation, it will also make it more
difficult to switch to "expert" mode if the "newbie" mode is a lot
different.

>  Now that argument generally applies to _behavior_ changes, not verbosity
>  of messages. But in this case, I think it is easy enough to find a
>  "right" behavior for everyone: show the message on fetch, which would
>  otherwise be a very confusing command, but suppress it on "pull", where
>  the fetching is mostly a side effect.

This makes sense, but I think that if it is made default behavior it
would be nice to add a way to make it quiet. Perhaps 'quiet' can be
used (I recall seeing used it elsewhere), either through a config
option or a command line argument. Then again, if everybody agrees
that this added verbosity is good, there'd be no reason to go through
that trouble.

Cheers,

Sverre Rabbelier
