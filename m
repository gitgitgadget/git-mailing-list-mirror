From: Jeff King <peff@peff.net>
Subject: Re: How to commit changes if remote repository changed directory
	structure?
Date: Fri, 20 Mar 2009 03:13:19 -0400
Message-ID: <20090320071319.GF27008@coredump.intra.peff.net>
References: <22612715.post@talk.nabble.com> <20090320060926.GC27008@coredump.intra.peff.net> <7vljr04qnw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "J. Bruce Fields" <bfields@citi.umich.edu>,
	andholt <andholt@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 08:15:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkYwa-0008WO-IE
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 08:15:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbZCTHNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 03:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751807AbZCTHNa
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 03:13:30 -0400
Received: from peff.net ([208.65.91.99]:54053 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751689AbZCTHN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 03:13:29 -0400
Received: (qmail 7100 invoked by uid 107); 20 Mar 2009 07:13:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 20 Mar 2009 03:13:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2009 03:13:19 -0400
Content-Disposition: inline
In-Reply-To: <7vljr04qnw.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113907>

On Fri, Mar 20, 2009 at 12:08:51AM -0700, Junio C Hamano wrote:

> > First, commit your changes. Then merge the other developer's changes. :)
> 
> We should probably point out to new people that "first commit and then
> worry about merges after your changes are safely committed" is always how
> people would "go about" anything.

Yes, absolutely.

Most of the current documentation focuses on being a reference to
particular commands or tasks. But this is more of a "philosophy of
working with git" item. I guess it should go in the user manual
somewhere. Cc'ing Bruce, who may have some comments.

-Peff
