From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: reword --author error message
Date: Fri, 16 Jan 2015 04:32:21 -0500
Message-ID: <20150116093220.GA3006@peff.net>
References: <54B7CCCD.1070708@drmicha.warpmail.net>
 <84cf10a22858275d6e213311c93df7f6a5408f60.1421331608.git.git@drmicha.warpmail.net>
 <xmqq4mrs7x5h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Gunnar Wagner <gunnar.wagner@irisgermanica.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 10:32:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YC3GY-0003I8-1F
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 10:32:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbbAPJcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 04:32:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:35467 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751041AbbAPJcX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2015 04:32:23 -0500
Received: (qmail 4516 invoked by uid 102); 16 Jan 2015 09:32:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jan 2015 03:32:23 -0600
Received: (qmail 23687 invoked by uid 107); 16 Jan 2015 09:32:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jan 2015 04:32:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Jan 2015 04:32:21 -0500
Content-Disposition: inline
In-Reply-To: <xmqq4mrs7x5h.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262548>

On Thu, Jan 15, 2015 at 09:48:26AM -0800, Junio C Hamano wrote:

> > Rename the error message to make it clearer that the failure has two
> > reasons in this case:
> > "Bad --author parameter '%s': neither completely wellformed nor part of
> > an existing one"
> 
> You are trying to help a user who thought "Who www.where.com" was a
> valid thing to pass to --author; "it is not completely wellformed"
> is not very helpful without making her realize what in that bogus
> string is not "completely well-formed".
> 
> Perhaps
> 
>   "--author '%s' is not 'Name <email>' and no existing author matches that string"
> 
> or somesuch?

Yeah, I think that is OK. It is kind of clunky to read, but it contains
all of the necessary information to lead the user in the right
direction.

-Peff
