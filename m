From: Jeff King <peff@peff.net>
Subject: Re: Git v1.8.4.2 test failure in ./t5570-git-daemon.sh
Date: Wed, 30 Oct 2013 03:00:16 -0400
Message-ID: <20131030070016.GD11317@sigill.intra.peff.net>
References: <20131029005430.GA23920@ruderich.org>
 <20131029013024.GA11861@sigill.intra.peff.net>
 <xmqqr4b3d0it.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Simon Ruderich <simon@ruderich.org>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 08:00:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbPlT-0007O9-JW
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 08:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165Ab3J3HAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 03:00:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:58235 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753103Ab3J3HAT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 03:00:19 -0400
Received: (qmail 14443 invoked by uid 102); 30 Oct 2013 07:00:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Oct 2013 02:00:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Oct 2013 03:00:16 -0400
Content-Disposition: inline
In-Reply-To: <xmqqr4b3d0it.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236990>

On Tue, Oct 29, 2013 at 06:12:58PM -0700, Junio C Hamano wrote:

> > I think it was just a simple mixup caused by Brian sending two fixups to
> > t5570 as series, when they are really fixups for two different topics.
> > Not worth an immediate v1.8.4.3, I think, but you may want to
> > cherry-pick 360a326 onto maint if there is another release before
> > v1.8.5.
> 
> I am torn on this, actually.  I've been hoping that the other topic
> that fixes a long-standing bug will also be a part of maintenance
> track.

That is fine, too. Mainly I just did not want it to get forgotten. :)

-Peff
