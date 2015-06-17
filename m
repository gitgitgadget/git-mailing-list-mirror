From: josh@joshtriplett.org
Subject: Re: co-authoring commits
Date: Wed, 17 Jun 2015 13:59:31 -0700
Message-ID: <20150617205931.GB24079@cloud>
References: <CAOvwQ4i_HL7XGnxZrVu3oSnsbnTyxbg8Vh6vzi4c1isSrrexYQ@mail.gmail.com>
 <xmqq4mm66r99.fsf@gitster.dls.corp.google.com>
 <CAOvwQ4j2bjR1jnLVyZbw1OCE=xQxbCEFGKcK1bpuv1K3s_Y2EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tuncer Ayaz <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 22:59:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5KQu-0007Gk-WE
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 22:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbbFQU7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 16:59:36 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:42581 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017AbbFQU7f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 16:59:35 -0400
Received: from cloud (joshtriplett.org [IPv6:2604:3400:dc1:41:216:3eff:fe9f:2070])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id A3D2817207C;
	Wed, 17 Jun 2015 22:59:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAOvwQ4j2bjR1jnLVyZbw1OCE=xQxbCEFGKcK1bpuv1K3s_Y2EQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271911>

On Wed, Jun 17, 2015 at 10:26:32PM +0200, Tuncer Ayaz wrote:
> On Wed, Jun 17, 2015 at 9:58 PM, Junio C Hamano wrote:
> > Tuncer Ayaz <tuncer.ayaz@gmail.com> writes:
> >
> > > Is this something that breaks the design and would never be
> > > implemented,
> >
> > Yes.
> 
> Junio, thanks for the quick response.
> 
> I suppose things have changed since Jonathan Nieder's response in [1]
> (2010), or I've read too much into the mini-thread between Jonathan
> and Josh. I was under the impression that this is generally possible
> without shaking up all underpinnings.
> 
> For what it's worth, here's why I would use the feature:
> 
> By allowing multiple authors, you don't have to decide who's the
> primary author, as in such situations usually there is no primary at
> all. I sometimes deliberately override the author when committing and
> add myself just as another co-author in the commit message, but as
> others have noted it would be really great if we can just specify
> multiple authors.

Having more than one author field in a commit would likely break things,
but having a coauthor field seems plausible these days.  Git added
support for signed commits, and the world didn't end, so it's possible
to extend the commit format.

- Josh Triplett
