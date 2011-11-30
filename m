From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] remote: add new sync command
Date: Wed, 30 Nov 2011 02:01:11 -0500
Message-ID: <20111130070111.GE5317@sigill.intra.peff.net>
References: <20111107210134.GA7380@sigill.intra.peff.net>
 <CAMP44s089xbEo4VT8rqgS=BJMUu=qsb8Hm5z8bTR2akU8-5QhA@mail.gmail.com>
 <20111108181442.GA17317@sigill.intra.peff.net>
 <CAMP44s2RjcFtdO2jft0Hg9RtqK-DRK47gX8By-dBFSBcSA+yFA@mail.gmail.com>
 <20111111181352.GA16055@sigill.intra.peff.net>
 <CAMP44s06p+KyJAu4ddiCa8CFRq5eogbqxxJU16Z-SUb3GSp67Q@mail.gmail.com>
 <20111114122556.GB19746@sigill.intra.peff.net>
 <CAMP44s1G9jJyiis7z7XbPvW925E-u=0_-h9jJKkj2wyPS9o5ig@mail.gmail.com>
 <20111121214450.GA20338@sigill.intra.peff.net>
 <CAMP44s3StLjb9KgBkRrG4nPqJD_ZjeSyFUwuP4A3b+mJKBgHWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 30 08:01:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVeAQ-00005J-Cf
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 08:01:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754674Ab1K3HBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 02:01:14 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56007
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753406Ab1K3HBN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 02:01:13 -0500
Received: (qmail 7883 invoked by uid 107); 30 Nov 2011 07:07:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Nov 2011 02:07:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Nov 2011 02:01:11 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s3StLjb9KgBkRrG4nPqJD_ZjeSyFUwuP4A3b+mJKBgHWQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186110>

On Tue, Nov 22, 2011 at 01:47:36AM +0200, Felipe Contreras wrote:

> > I didn't mean "you didn't define a mirror in your config". I meant "your
> > question is not well-defined, because you haven't defined the term
> > 'mirror'". IOW, I can't answer your question without knowing exactly
> > what you meant.
> 
> I wasn't the one that brought the mirror up, you did:

Yes, because that is the most related concept in current git. But I
thought you were asking from the perspective of a clueless user, and I
don't know what that clueless user meant by "mirror".

Anyway, I don't think it's important.

I read over your whole message, and I feel like our discussion isn't
really moving towards an actual goal. Junio and I both mentioned that in
the long-term, features like this should be part of "push", not
"remote". Do you want to try revising your patch in that direction?
That will give us something concrete to talk about (and hopefully
apply).

-Peff
