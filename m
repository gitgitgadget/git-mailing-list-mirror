From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] push: Alias pushurl from push rewrites
Date: Thu, 28 Mar 2013 09:40:38 -0700
Message-ID: <20130328164038.GE16034@leaf>
References: <20130327122216.5de0c336@hoelz.ro>
 <20130327182345.GD28148@google.com>
 <20130327211554.GH28148@google.com>
 <7vsj3gjy3t.fsf@alter.siamese.dyndns.org>
 <20130327174845.5e3081d1@hoelz.ro>
 <20130327230943.GA5204@jtriplet-mobl1>
 <20130327231819.GL28148@google.com>
 <20130328160104.GC16034@leaf>
 <7vy5d7v71o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Rob Hoelz <rob@hoelz.ro>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 17:41:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULFt3-00005u-55
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 17:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756546Ab3C1Qkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 12:40:45 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:47128 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756388Ab3C1Qkp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 12:40:45 -0400
Received: from mfilter23-d.gandi.net (mfilter23-d.gandi.net [217.70.178.151])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id B29AFA80B5;
	Thu, 28 Mar 2013 17:40:43 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter23-d.gandi.net
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
	by mfilter23-d.gandi.net (mfilter23-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id jjBaHuAi1N-a; Thu, 28 Mar 2013 17:40:42 +0100 (CET)
X-Originating-IP: 50.43.39.152
Received: from leaf (static-50-43-39-152.bvtn.or.frontiernet.net [50.43.39.152])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id E609DA80ED;
	Thu, 28 Mar 2013 17:40:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vy5d7v71o.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219426>

On Thu, Mar 28, 2013 at 09:10:59AM -0700, Junio C Hamano wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
> 
> > OK, I take it back.  I *can* imagine configurations that this change
> > would break, since it does change intentional and documented behavior,
> > but I don't have any such configuration.  The only such configuration I
> > can imagine involves directly counting on the non-rewriting of pushUrl,
> > by using pushInsteadOf to rewrite urls and then sometimes using pushUrl
> > to override that and point back at the un-rewritten URL.  And while
> > supported, that does seem *odd*.
> >
> > Objection withdrawn; if nobody can come up with a sensible configuration
> > that relies on the documented behavior, I don't particularly care if it
> > changes.
> 
> I actually do.
> 
> Given the popularity of the system, "people involved in this thread
> cannot imagine a case that existing people may get hurt" is very
> different from "this is not a regression".  After merging this
> change when people start complaining, you and Rob can hide and
> ignore them, but we collectively as the Git project have to have a
> way to help them when it happens.

I entirely agree that it represents a regression from documented
behavior; I just mean that it no longer matches a specific use case I
had in mind with the original change.  I agree that we should hesitate
to change that documented behavior.

- Josh Triplett
