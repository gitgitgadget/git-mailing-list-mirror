From: Jeff King <peff@peff.net>
Subject: Re: Git 1.7.12 installer blocked by Gatekeeper - needs signing with
 an Apple developer ID
Date: Sat, 22 Sep 2012 01:27:56 -0400
Message-ID: <20120922052756.GA5058@sigill.intra.peff.net>
References: <954DDAEA-30AF-4203-BD49-3AB163E4EF58@telenet.be>
 <7vr4pxhqb5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: timcharper@gmail.com, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Torsten Louland <torsten.louland@telenet.be>
X-From: git-owner@vger.kernel.org Sat Sep 22 07:28:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFIG9-0003wT-NJ
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 07:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152Ab2IVF2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2012 01:28:00 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54134 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752966Ab2IVF17 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2012 01:27:59 -0400
Received: (qmail 14508 invoked by uid 107); 22 Sep 2012 05:28:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 22 Sep 2012 01:28:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 22 Sep 2012 01:27:56 -0400
Content-Disposition: inline
In-Reply-To: <7vr4pxhqb5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206194>

On Wed, Sep 19, 2012 at 10:31:58AM -0700, Junio C Hamano wrote:

> Torsten Louland <torsten.louland@telenet.be> writes:
> 
> > Installing latest stable git on Mac OS X Mountain Lion is blocked
> > by Gatekeeper.
> >
> > Could you provide an installer for latest stable git that is
> > signed with an Apple issued developer ID so gatekeeper will let it
> > through?
> 
> I am assuming that this is about the mechanism to block installation
> or execution of binaries obtained from outside the Apple store, and
> anything built from the source are exempt.
> 
> If that assumption is mistaken, please correct/educate me and
> disregard the rest of the message.
> 
> I release only the source tarballs and no longer do any pre-built
> binaries (I used to do so only for RPM), and Torsten must be getting
> a(n unsigned) binary from somewhere; the request needs to be given
> to whoever is supplying a pre-built binary for MacOS, but I do not
> know who that entity is.
> 
> Whoever you are, please speak up and help Torsten and fellow MacOS
> folks.

The MacOS binary installer on git-scm.com is built by Tim Harper (cc'd).
It looks like there are both GitHub and Google Code repositories for it:

  https://github.com/timcharper/git_osx_installer

  https://code.google.com/p/git-osx-installer/

You might have luck submitting an issue there (I am not sure which one
is the primary, but it looks like the Google Code site).

-Peff
