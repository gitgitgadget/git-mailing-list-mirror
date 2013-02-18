From: Jeff King <peff@peff.net>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Mon, 18 Feb 2013 15:55:32 -0500
Message-ID: <20130218205532.GB27308@sigill.intra.peff.net>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
 <20130218174239.GB22832@sigill.intra.peff.net>
 <20130218193424.GC3234@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 21:56:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Xkk-00048Y-KX
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 21:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755178Ab3BRUzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 15:55:36 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52262 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755232Ab3BRUze (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 15:55:34 -0500
Received: (qmail 24426 invoked by uid 107); 18 Feb 2013 20:57:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Feb 2013 15:57:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Feb 2013 15:55:32 -0500
Content-Disposition: inline
In-Reply-To: <20130218193424.GC3234@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216520>

On Mon, Feb 18, 2013 at 11:34:24AM -0800, Jonathan Nieder wrote:

> Some potential projects (unfiltered --- please take them with a grain
> of salt):
> [...]
>  - collaborative notes editing: fix the default notes refspec,
>    make sure the "notes pull" workflow works well and is documented
>    well, offer an easy way to hide private notes after the fact
>    without disrupting public history

I know you said a grain of salt, so please don't feel like I'm beating
up on your idea. I'm picking this one because I think it has some
characteristics of projects that have not gone well in the past, so it's
a good illustrative example.

IMHO, this is the type of project that is likely to fail, because most
of the work is not technical at all, but political. Changing the default
refspecs is a few lines of code. But the hard part is figuring out where
they should go, the implications of doing so, and how people are going
to react. And it's intimately tied to how we have considered refactoring
the default ref namespaces, which is a messy discussion with a lot of
different options (and implications, and backwards compatibility issues,
etc). Plans need to be laid for deprecating old things, and handling the
transition to the new thing. Lines need to be drawn about what is in the
project and what isn't.

Bringing a project like that to completion is going to involve a lot of
community involvement. And that's the thing students are historically
the worst at it. I think it's _also_ the most valuable thing they can
learn. But I think it doesn't make for a very gentle introduction to
open source.

Again, just my two cents. I don't want to dissuade anybody from this
project in particular, or this style of project. I'm more trying to
bring up discussion on how and why projects fail.

-Peff
