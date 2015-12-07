From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Dec 2015, #02; Fri, 4)
Date: Mon, 7 Dec 2015 15:46:30 -0500
Message-ID: <20151207204630.GD30203@sigill.intra.peff.net>
References: <xmqqa8pprej5.fsf@gitster.mtv.corp.google.com>
 <CAOc6etZBnB6EKiD3xD-zp-QJz20ueQzdtdJMSZz6wOH_HFZXxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 21:46:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a62gB-0005LO-36
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 21:46:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933074AbbLGUqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 15:46:34 -0500
Received: from cloud.peff.net ([50.56.180.127]:38496 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932988AbbLGUqd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 15:46:33 -0500
Received: (qmail 16417 invoked by uid 102); 7 Dec 2015 20:46:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Dec 2015 14:46:32 -0600
Received: (qmail 23169 invoked by uid 107); 7 Dec 2015 20:46:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Dec 2015 15:46:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Dec 2015 15:46:30 -0500
Content-Disposition: inline
In-Reply-To: <CAOc6etZBnB6EKiD3xD-zp-QJz20ueQzdtdJMSZz6wOH_HFZXxw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282120>

On Sun, Dec 06, 2015 at 10:12:18AM -0600, Edmundo Carmona Antoranz wrote:

> Hi, Junio, Jeff!
> 
> On Fri, Dec 4, 2015 at 5:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > * ec/annotate-deleted (2015-11-20) 1 commit
> >  - annotate: skip checking working tree if a revision is provided
> >
> >  Usability fix for annotate-specific "<file> <rev>" syntax with deleted
> >  files.
> >
> >  Waiting for review.
> 
> Is there something I have to do about it?

A gentle ping is sometimes helpful. :)

I did not see anything wrong with it, but I think Junio would be a good
person to give it a look, as he knows all of the sordid history of blame
versus annotate, and the intended allowed command-line orderings.

-Peff
