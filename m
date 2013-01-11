From: Jeff King <peff@peff.net>
Subject: Re: git send-email should not allow 'y' for in-reply-to
Date: Fri, 11 Jan 2013 13:54:17 -0500
Message-ID: <20130111185417.GA12852@sigill.intra.peff.net>
References: <1357885869-20815-1-git-send-email-cyliu@suse.com>
 <50EFD066.60501@redhat.com>
 <50F0402A.1000108@redhat.com>
 <20130111164730.GA7921@sigill.intra.peff.net>
 <CAE1pOi0zc+d6d9Y4KViX24qHgc1WL9atmRuyygorX_DQMj69Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Blake <eblake@redhat.com>, git@vger.kernel.org,
	libvir-list@redhat.com
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 19:54:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ttjkb-0003uO-E1
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 19:54:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755405Ab3AKSyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 13:54:20 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57610 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753377Ab3AKSyT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 13:54:19 -0500
Received: (qmail 22400 invoked by uid 107); 11 Jan 2013 18:55:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Jan 2013 13:55:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jan 2013 13:54:17 -0500
Content-Disposition: inline
In-Reply-To: <CAE1pOi0zc+d6d9Y4KViX24qHgc1WL9atmRuyygorX_DQMj69Hg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213233>

On Fri, Jan 11, 2013 at 10:43:39AM -0800, Hilco Wijbenga wrote:

> >   People answer 'y' to "Who should the emails appear to be from?"  and
> >   'n' to "Message-ID to be used as In-Reply-To for the first email?"
> >   for some unknown reason.  While it is possible that your local
> >   username really is "y" and you are sending the mail to your local
> >   colleagues, it is possible, and some might even say it is likely,
> >   that it is a user error.
> 
> I have never used Git's email support so this doesn't affect me one
> way or another but it seems that checking the results is fixing the
> symptoms, not the problem? I apologize if this was already discussed
> but I couldn't find such a discussion.

It depends on who you are. If you are the person running send-email,
then the symptom is your confusion. If you are somebody else, the
symptom is somebody else sending out a bogus email. That patch fixes
only the latter. :)

More seriously, I agree that re-wording the question is a reasonable
thing to do. I do not use send-email, either, so I don't have a strong
opinion on it. The suggestions you made:

> How about "What Message-ID to use as In-Reply-To for the first email?"
> or "Provide the Message-ID to use as In-Reply-To for the first
> email:".

seem fine to me. Maybe somebody who has been confused by it can offer
more. At any rate, patches welcome.

-Peff
