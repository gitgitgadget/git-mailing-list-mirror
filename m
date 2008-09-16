From: Jeff King <peff@peff.net>
Subject: Re: Submitting patches from unsubscribed authors?
Date: Tue, 16 Sep 2008 19:36:14 -0400
Message-ID: <20080916233613.GA14251@coredump.intra.peff.net>
References: <57518fd10809161624u3b2937dmd36e0fc962ea7a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 01:37:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfk6o-0003M6-TB
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 01:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362AbYIPXgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 19:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752354AbYIPXgT
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 19:36:19 -0400
Received: from peff.net ([208.65.91.99]:4688 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752259AbYIPXgS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 19:36:18 -0400
Received: (qmail 25353 invoked by uid 111); 16 Sep 2008 23:36:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 16 Sep 2008 19:36:15 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Sep 2008 19:36:14 -0400
Content-Disposition: inline
In-Reply-To: <57518fd10809161624u3b2937dmd36e0fc962ea7a7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96048>

On Wed, Sep 17, 2008 at 12:24:48AM +0100, Jonathan del Strother wrote:

> Is it possible to submit a patch to the mailing list, from an author
> that isn't subscribed?  Last time I submitted a patch I went via my

Yes. The list accepts mail from non-subscribers.

> throwaway email address, and so that was used as the commit author.
> It looks like "git am" is always going to just use the email address
> used to post to the mailing list as the email address, but I'm sure in
> the past that my patches have appeared under my real email.  Was that
> just manual intervention by the maintainer?

Yes, it pulls it from the From: header. However, you can override that
by including

  From: Your Real Name <yourrealaddress>

as the first line of the mail. git-send-email will do this for you
automagically if the commit author and your email sending address are
not the same.

Look at some of your previous patches to the list; they have this line.

-Peff
