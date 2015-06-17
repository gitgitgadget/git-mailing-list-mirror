From: josh@joshtriplett.org
Subject: Re: co-authoring commits
Date: Wed, 17 Jun 2015 16:06:54 -0700
Message-ID: <20150617230654.GA27206@cloud>
References: <CAOvwQ4i_HL7XGnxZrVu3oSnsbnTyxbg8Vh6vzi4c1isSrrexYQ@mail.gmail.com>
 <xmqq4mm66r99.fsf@gitster.dls.corp.google.com>
 <CAOvwQ4j2bjR1jnLVyZbw1OCE=xQxbCEFGKcK1bpuv1K3s_Y2EQ@mail.gmail.com>
 <20150617225224.GF4076@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tuncer Ayaz <tuncer.ayaz@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 18 01:07:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5MQZ-0007vJ-EI
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 01:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741AbbFQXHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 19:07:01 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:54314 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484AbbFQXG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 19:06:58 -0400
Received: from cloud (joshtriplett.org [IPv6:2604:3400:dc1:41:216:3eff:fe9f:2070])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id BD3CD172070;
	Thu, 18 Jun 2015 01:06:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150617225224.GF4076@thunk.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271928>

On Wed, Jun 17, 2015 at 06:52:24PM -0400, Theodore Ts'o wrote:
> On Wed, Jun 17, 2015 at 10:26:32PM +0200, Tuncer Ayaz wrote:
> > 
> > By allowing multiple authors, you don't have to decide who's the
> > primary author, as in such situations usually there is no primary at
> > all. I sometimes deliberately override the author when committing and
> > add myself just as another co-author in the commit message, but as
> > others have noted it would be really great if we can just specify
> > multiple authors.
> 
> Just recently, there a major thread on the IETF mailing list where
> IETF working group had drafts where people were listed as co-authors
> without their permission, and were upset that the fact that their name
> was added made it seem as if they agreed with the end product.  (i.e.,
> that they were endorsing the I-D).  So while adding formal coauthor
> might solves (a few) problems, it can also introduce others.
> 
> Ultimately there is one person who can decide which parts of the
> changes to put in the commit that gets sent to the maintainer.  So
> there *is* someone who is the primary author; the person who takes the
> final pass on the patch and then hits the send key.

I've worked on many patches with another person in a shared screen
session, co-authoring a series of patches and commit messages in vim,
and writing an email in mutt.  There were, ultimately, two people
deciding what to put in a commit and send to the maintainer.  This is,
admittedly, unusual, but pair programming is not ridiculously uncommon.

> In that case, perhaps you could set the from field to a mailing list
> address.

The "From" field in email headers supports a list of comma-separated
addresses, just like To and Cc.  Speaking from experience, this
more-or-less works with all the mail software we tried it with, with the
occasional program only displaying the first or last entry.

- Josh Triplett
