From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] cg-diff fixed to work with BSD xargs
Date: Wed, 21 Sep 2005 22:56:12 +1200
Message-ID: <46a038f905092103561eac26a6@mail.gmail.com>
References: <11253960093915-git-send-email-martin@catalyst.net.nz>
	 <pan.2005.09.21.07.33.14.533314@smurf.noris.de>
Reply-To: martin.langhoff@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 12:56:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI2Gw-0002A6-Vc
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 12:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVIUK4Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 06:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbVIUK4Q
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 06:56:16 -0400
Received: from qproxy.gmail.com ([72.14.204.196]:14446 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750820AbVIUK4P convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2005 06:56:15 -0400
Received: by qproxy.gmail.com with SMTP id v40so330979qbe
        for <git@vger.kernel.org>; Wed, 21 Sep 2005 03:56:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g3yO5hscjHRuk8q2kZZ2FEH20BC5+jZyR9YZBNFLGzvBvwOqSil25e1LI4qAnp8VuiwvYgm7ZikrayA3n6HXIrOgGjmaiupc6pngtY2WF7mOqUDTzvc8juqRBqks/TlwUsKt19IrzDS10gp/xIFreBdkOvFmmdTZ7s3xh5dhrZo=
Received: by 10.65.20.14 with SMTP id x14mr113899qbi;
        Wed, 21 Sep 2005 03:56:12 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Wed, 21 Sep 2005 03:56:12 -0700 (PDT)
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.09.21.07.33.14.533314@smurf.noris.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9041>

On 9/21/05, Matthias Urlichs <smurf@smurf.noris.de> wrote:
> I don't know what drugs your shell was on when you tested this (assuming
> that you did ;-)  but this patch is wrong -- your test always succeeds,
> due to the vagaries of test / [ ] semantics.

I've submitted test-time and commit-time urine tests to the relevant
authorities. Both my shell and me are clean of forbidden substances
;-)

As Petr notes, the code is testing for a variable that we generated,
not random user input. Yes, perhaps we should test $TMPDIR for sanity,
but I think it's a bit overparanoid.

cheers,


martin
