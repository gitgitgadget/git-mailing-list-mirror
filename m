From: josh@joshtriplett.org
Subject: Re: co-authoring commits
Date: Wed, 17 Jun 2015 14:17:49 -0700
Message-ID: <20150617211749.GA24306@cloud>
References: <CAOvwQ4i_HL7XGnxZrVu3oSnsbnTyxbg8Vh6vzi4c1isSrrexYQ@mail.gmail.com>
 <xmqq4mm66r99.fsf@gitster.dls.corp.google.com>
 <CAOvwQ4j2bjR1jnLVyZbw1OCE=xQxbCEFGKcK1bpuv1K3s_Y2EQ@mail.gmail.com>
 <xmqqmvzy59zr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tuncer Ayaz <tuncer.ayaz@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 23:17:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Kib-0007WG-Rz
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 23:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbbFQVRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 17:17:54 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:43440 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195AbbFQVRx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 17:17:53 -0400
Received: from cloud (joshtriplett.org [IPv6:2604:3400:dc1:41:216:3eff:fe9f:2070])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id E2AFBA80CA;
	Wed, 17 Jun 2015 23:17:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <xmqqmvzy59zr.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271915>

On Wed, Jun 17, 2015 at 01:57:12PM -0700, Junio C Hamano wrote:
> Tuncer Ayaz <tuncer.ayaz@gmail.com> writes:
> 
> > On Wed, Jun 17, 2015 at 9:58 PM, Junio C Hamano wrote:
> >> Tuncer Ayaz <tuncer.ayaz@gmail.com> writes:
> >>
> >> > Is this something that breaks the design and would never be
> >> > implemented,
> >>
> >> Yes.
> >
> > Junio, thanks for the quick response.
> >
> > I suppose things have changed since Jonathan Nieder's response in [1]
> > (2010),...
> 
> I do not think there is anything changed.  Jonathan was being a bit
> more diplomatic and academic than I am.
> 
> "There is no reason in principle some faraway future version of Git
> could" is _always_ true as a mental masturbation without taking
> reality into account, aka "Sounds doable but a lot of trouble" means
> "it is doable but it is dubious that it is worth doing".

What happens in old versions of git if you try to look at a signed git
commit?  The same level of interoperability used there would work here,
with the additional property that this would be optional metadata so we
might be able to make read-only access work with older versions.

- Josh Triplett
