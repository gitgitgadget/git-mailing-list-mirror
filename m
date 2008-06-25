From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Ask for "git program" when asking for "git-program" over
 SSH connection
Date: Wed, 25 Jun 2008 10:42:42 -0700
Message-ID: <7vlk0t1kdp.fsf@gitster.siamese.dyndns.org>
References: <7vk5ge8bm5.fsf@gitster.siamese.dyndns.org>
 <20080625120832.6117@nanako3.lavabit.com>
 <7v1w2m8ahi.fsf@gitster.siamese.dyndns.org>
 <7vprq66vqd.fsf_-_@gitster.siamese.dyndns.org>
 <20080625034538.GW11793@spearce.org>
 <7vk5ge6soc.fsf@gitster.siamese.dyndns.org>
 <20080625044409.GE11793@spearce.org>
 <7v8wwu6qxr.fsf@gitster.siamese.dyndns.org>
 <7v4p7i6qs1.fsf@gitster.siamese.dyndns.org>
 <7vy74u5bkk.fsf@gitster.siamese.dyndns.org> <20080625130646.GD20361@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	=?iso-2022-jp?B?GyRCJDcbKEI=?=
	 =?iso-2022-jp?B?GyRCJGkkJCQ3JEokSiQzGyhC?= <nanako3@lavabit.com>,
	Miklos Vajna <vmiklos@frugalware.org>, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 25 19:44:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBZ2D-0006S1-NU
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 19:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226AbYFYRnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 13:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752622AbYFYRnB
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 13:43:01 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55568 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbYFYRnA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 13:43:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C966E1AF66;
	Wed, 25 Jun 2008 13:42:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A4E1E1AF61; Wed, 25 Jun 2008 13:42:44 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 268FE028-42DE-11DD-A642-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86309>

Theodore Tso <tytso@mit.edu> writes:

> On Tue, Jun 24, 2008 at 10:27:07PM -0700, Junio C Hamano wrote:
> ...
>> The above 6 and 12 are yanked out of thin air and I am of course open to
>> tweaking them, but I think the above order of events would be workable.
>
> Is that really 6 and 12 months, or "6/12 months or at the next major
> release boundary, whichever is later".

Sigh... I thought you by now knew me better than that...

Yes, I didn't say it explicitly because I thought it was too obvious,
which was a mistake.  These except for the ones that are preparation (such
as "prepare daemon so that future clients can ask with non-dash forms")
need to happen at release boundaries, but these 6/12 months figures set
the minimums.  E.g. even if we had 6 week release cycles and 1.7.0 were to
be done 6 weeks after 1.6.0, that is still too early for the client side
to switch asking for "git program".
