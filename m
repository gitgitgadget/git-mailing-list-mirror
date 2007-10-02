From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problems setting up bare repository (git 1.5.3.3)
Date: Tue, 02 Oct 2007 12:09:10 -0700
Message-ID: <7vfy0tl4fd.fsf@gitster.siamese.dyndns.org>
References: <m3fy0u7bk3.fsf@barry_fishman.acm.org>
	<7vejgeqxd1.fsf@gitster.siamese.dyndns.org>
	<87bqbisae6.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0710021045430.28395@racer.site>
	<87641psey8.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0710021841300.28395@racer.site>
	<7vwsu5l6j8.fsf@gitster.siamese.dyndns.org>
	<BAYC1-PASMTP05AB6AE16E90C15710819EAEAE0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Carl Worth <cworth@cworth.org>,
	Barry Fishman <barry_fishman@acm.org>, git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Tue Oct 02 21:09:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icn7e-0000uy-R4
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 21:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701AbXJBTJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 15:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753569AbXJBTJ0
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 15:09:26 -0400
Received: from rune.pobox.com ([208.210.124.79]:53629 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753516AbXJBTJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 15:09:25 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 81C0E13F717;
	Tue,  2 Oct 2007 15:09:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 0D077140606;
	Tue,  2 Oct 2007 15:09:33 -0400 (EDT)
In-Reply-To: <BAYC1-PASMTP05AB6AE16E90C15710819EAEAE0@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Tue, 2 Oct 2007 14:55:56 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59712>

Sean <seanlkml@sympatico.ca> writes:

> On Tue, 02 Oct 2007 11:23:39 -0700
> Junio C Hamano <gitster@pobox.com> wrote:
>
>> If your push were "next~27^2:frotz", it becomes even less clear.
>> It may be that I am pushing out the tip of a topic branch I
>> usually do not push out, so it would be easier for some specific
>> person to build on top of.  Or maybe I am marking that place as
>> a lightweight tag.  They are equally likely.
>
> But you could pick a reasonable default in assuming that a new
> branch is desired with the above example.  If someone wants to
> push a tag, they can create the tag locally, and then push it.

I think you are on the same page.

We can pick _a_ default, and tell people that if they want a
non-default behaviour, they have to be explicit.  That goes
without saying.

The discussion between Johannes and I was about picking what
default is _reasonable_; Johannes made it sound like branches
are norm and tags are oddball.  I was merely pointing out that
it won't be so cut-and-dried.
