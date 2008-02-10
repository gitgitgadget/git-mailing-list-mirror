From: Junio C Hamano <gitster@pobox.com>
Subject: 'next' will be rewound and rebuilt after feature releases.
Date: Sun, 10 Feb 2008 02:51:45 -0800
Message-ID: <7vfxw1gk3i.fsf@gitster.siamese.dyndns.org>
References: <20080205211044.GP26392@lavos.net>
	<7vodatqu6w.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0802062327350.2732@xanadu.home>
	<7vy79xnnfq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Brian Downing <bdowning@lavos.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 10 11:52:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO9nj-0002i2-QR
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 11:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756601AbYBJKwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 05:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755773AbYBJKwL
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 05:52:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55271 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755748AbYBJKwK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 05:52:10 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 471631510;
	Sun, 10 Feb 2008 05:52:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C7BE150F;
	Sun, 10 Feb 2008 05:52:02 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73333>

Junio C Hamano <gitster@pobox.com> writes:

> Nicolas Pitre <nico@cam.org> writes:
>
>> On Wed, 6 Feb 2008, Junio C Hamano wrote:
>>
>>> ...
>>> It already is part of 'next', and we have the policy of not
>>> rewinding 'next', so the record of this mistake will
>>> unfortunately be with us forever.  Sorry, Brian, Dscho and
>>> Steffen.
>>
>> Maybe you can make an exception for this time?  A single
>
> That's very tempting.
> ...
> People who follow 'next' hopefully know what goes on the list,
> so perhaps we could revise the "never rewind" rule to read "it
> will not rewind during the regular cycle, but it will be rebuilt
> once each feature release, immediately after release."

I am almost committed to this idea, and this is an advance
notice that 'next' will be rebuilt on the tip of 'master' soon.

When that happens, I'll announce the commit object name for the
old 'next' and the corresponding new one, to make rebasing
easier for people who have been following and building on top of
it.

For tonight's tree, the tip of 'next' is at 547b1cb (Merge
branch 'master' into next) and its tree matches 26f14cc (Merge
branch 'js/reflog-delete' into next) that is part of 'pu'.
