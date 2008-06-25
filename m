From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Ask for "git program" even against git-daemon
Date: Wed, 25 Jun 2008 16:36:16 -0700
Message-ID: <7viqvxw0i7.fsf@gitster.siamese.dyndns.org>
References: <20080625034538.GW11793@spearce.org>
 <7vk5ge6soc.fsf@gitster.siamese.dyndns.org>
 <20080625044409.GE11793@spearce.org>
 <7v8wwu6qxr.fsf@gitster.siamese.dyndns.org>
 <7v4p7i6qs1.fsf@gitster.siamese.dyndns.org>
 <7vy74u5bkk.fsf@gitster.siamese.dyndns.org>
 <20080625053848.GJ11793@spearce.org>
 <7v4p7hxhbd.fsf@gitster.siamese.dyndns.org>
 <7vvdzxw2eo.fsf_-_@gitster.siamese.dyndns.org>
 <7vr6alw28s.fsf_-_@gitster.siamese.dyndns.org>
 <20080625232727.GU11793@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@lavabit.com>, Miklos Vajna <vmiklos@frugalware.org>,
	pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 26 01:37:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBeYM-0001uW-Vu
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 01:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286AbYFYXgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 19:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbYFYXgf
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 19:36:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47010 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbYFYXge (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 19:36:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7E4A0AE34;
	Wed, 25 Jun 2008 19:36:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6851FAE33; Wed, 25 Jun 2008 19:36:22 -0400 (EDT)
In-Reply-To: <20080625232727.GU11793@spearce.org> (Shawn O. Pearce's message
 of "Wed, 25 Jun 2008 19:27:27 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8AE876B2-430F-11DD-9062-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86374>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
> ...
>>  * According to the roadmap we exchanged earlier, this should happen in a
>>    major release (that increments the second dewey-decimal digit from the
>>    left) that ships at least 6 months after 1.5.6.1 and 1.6.0 (which will
>>    have the "git daemon preparation" patch included) are released.
>
> Agreed about holding back.
>
> But I wonder if this patch is even worth it at some later point
> in time.  Are we also going to change git-daemon to stop accepting
> "git-" form?  Is it a worthwhile change?

This was merely responding to...

    From: "Shawn O. Pearce" <spearce@spearce.org>
    Subject: Re: [PATCH] Keep some git-* programs in $(bindir)
    Date: Wed, 25 Jun 2008 00:37:41 -0400
    Message-ID: <20080625043741.GD11793@spearce.org>

    Daniel Barkalow <barkalow@iabervon.org> wrote:
    > ...
    > Should they use "git upload-pack" or should they look for their helper 
    > programs in a libexec dir? I don't think that either of these programs is 
    > useful to run independantly, but I don't know if finding a program that 
    > doesn't go in $PATH on a remote machine is going to be any fun.

    IMHO they should in the future use "git upload-pack".


I do not mind not doing this at all.  Remember, I am the one with more
inertia than anybody else here (holding back backward incompatible
innovations is what maintainers do).

Oh, that inertia does not have much to do with actual body weight, if
anybody is wondering ;-)
