From: Jeff King <peff@peff.net>
Subject: Re: Redirect "git" subcommand to itself?
Date: Thu, 28 May 2015 01:22:27 -0400
Message-ID: <20150528052227.GA24895@peff.net>
References: <CAGZ79kZHa9wUrRsWfHgGdSdx+cN9VAirAAfu3YLVTuSmggcehg@mail.gmail.com>
 <xmqqoal5ii21.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 28 07:22:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxqH5-0001IC-C3
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 07:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbbE1FWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 01:22:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:37063 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751264AbbE1FWa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 01:22:30 -0400
Received: (qmail 8666 invoked by uid 102); 28 May 2015 05:22:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 May 2015 00:22:30 -0500
Received: (qmail 13478 invoked by uid 107); 28 May 2015 05:22:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 May 2015 01:22:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 May 2015 01:22:27 -0400
Content-Disposition: inline
In-Reply-To: <xmqqoal5ii21.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270124>

On Wed, May 27, 2015 at 06:53:26PM -0700, Junio C Hamano wrote:

> > I wonder if we want to make a "git" subcommand, which behaves exactly
> > the same as git itself?
> > Then "git git git status" would just return the same as "git status".
> 
> A few unrelated thoughts.
> 
>  * Perhaps we should omit 'git' from these advice-texts?  E.g.
> 
>      use "revert --abort" to cancel
> 
>    I dunno.

Please don't. You help the set of people who type "git" and then paste
the rest of the command at the expense of people who just  paste the
whole command. We don't know the relative numbers of those people, but
we know there is at least 1 in each group. ;)

-Peff
