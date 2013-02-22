From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH 2/2] format-patch: --inline-single
Date: Fri, 22 Feb 2013 15:32:09 +0000
Message-ID: <20130222153209.GF7860@pacific.linksys.moosehall>
References: <1361282783-1413-2-git-send-email-git@adamspiers.org>
 <7v1ucc6vgd.fsf@alter.siamese.dyndns.org>
 <CAOkDyE9VVuFn6B=Fe4XHxGCEW0MFgndx1X0+9hO36Soxb37YQw@mail.gmail.com>
 <7v1ucc5b7n.fsf_-_@alter.siamese.dyndns.org>
 <20130220020046.GC7860@pacific.linksys.moosehall>
 <7vppzv3dd8.fsf@alter.siamese.dyndns.org>
 <20130220104720.GD7860@pacific.linksys.moosehall>
 <7vehg9v2xj.fsf@alter.siamese.dyndns.org>
 <7v4nh5v2fl.fsf_-_@alter.siamese.dyndns.org>
 <20130221231328.GA19808@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 22 16:32:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8uc0-0000U3-97
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 16:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757259Ab3BVPcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 10:32:12 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:36591 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756894Ab3BVPcL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 10:32:11 -0500
Received: from localhost (2.2.4.e.5.6.e.2.e.c.5.5.b.c.d.e.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:edcb:55ce:2e65:e422])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 782D22E33A;
	Fri, 22 Feb 2013 15:32:10 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20130221231328.GA19808@sigill.intra.peff.net>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216836>

On Thu, Feb 21, 2013 at 06:13:28PM -0500, Jeff King wrote:
> On Thu, Feb 21, 2013 at 12:26:22PM -0800, Junio C Hamano wrote:
> 
> > Some people may find it convenient to append a simple patch at the
> > bottom of a discussion e-mail separated by a "scissors" mark, ready
> > to be applied with "git am -c".  Introduce "--inline-single" option
> > to format-patch to do so.  A typical usage example might be to start
> > 'F'ollow-up to a discussion, write your message, conclude with "a
> > patch to do so may look like this.", and
> > 
> >     \C-u M-! git format-patch --inline-single -1 HEAD <ENTER>
> > 
> > if you are an Emacs user.  Users of other MUA's may want to consult
> > their manuals to find equivalent command to append output from an
> > external command to the message being composed.
> 
> Interesting. I usually just do this by hand, but this could save a few
> keystrokes in my workflow.

Same here.  This is great; thanks a lot both for working on it!
