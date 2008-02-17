From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 17 Feb 2008 07:41:37 -0500
Message-ID: <20080217124137.GC26031@sigill.intra.peff.net>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org> <7vodavd9qw.fsf@gitster.siamese.dyndns.org> <7vbq6tset4.fsf@gitster.siamese.dyndns.org> <7vmyq9gk94.fsf@gitster.siamese.dyndns.org> <7vk5la4oxq.fsf@gitster.siamese.dyndns.org> <7vejbc44hu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 13:42:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQiqV-00053U-1A
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 13:42:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754971AbYBQMlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 07:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755225AbYBQMlk
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 07:41:40 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4835 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994AbYBQMlj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 07:41:39 -0500
Received: (qmail 24274 invoked by uid 111); 17 Feb 2008 12:41:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 17 Feb 2008 07:41:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Feb 2008 07:41:37 -0500
Content-Disposition: inline
In-Reply-To: <7vejbc44hu.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74124>

On Sat, Feb 16, 2008 at 07:59:57PM -0800, Junio C Hamano wrote: 
> * jk/empty-tree (Wed Feb 13 05:50:51 2008 -0500) 2 commits
>  + add--interactive: handle initial commit better
>  + hard-code the empty tree object
> 
> Jeff added code to deal with the initial commit case better in
> "git-add -i".  Personally I wonder why we bother (if it is an
> initial commit, the user _knows_ there is nothing to diff in the
> HEAD as there is no HEAD yet, heavens), but the code is already
> there so why not.

I was also tempted to just have it output "you can't do this, it's an
initial commit." But the change was fairly easy, and I think Kate's
point is valid: even though it's an unlikely corner case, new users are
likely to start exploring at that corner case, so it helps with new user
perception that we handle it gracefully.

-Peff
