From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add test case for ls-files --with-head
Date: Wed, 03 Oct 2007 12:29:40 -0700
Message-ID: <7vlkakdmjf.fsf@gitster.siamese.dyndns.org>
References: <1191390255.16292.2.camel@koto.keithp.com>
	<7vtzp8g2s2.fsf@gitster.siamese.dyndns.org>
	<87y7ekr86e.wl%cworth@cworth.org> <47038669.30302@viscovery.net>
	<Pine.LNX.4.64.0710031634300.28395@racer.site>
	<87myv0qj2u.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Keith Packard <keithp@keithp.com>,
	Git Mailing List <git@vger.kernel.org>
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 21:30:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id9ux-0004b7-4k
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 21:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700AbXJCT3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 15:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754550AbXJCT3u
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 15:29:50 -0400
Received: from rune.pobox.com ([208.210.124.79]:51996 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752649AbXJCT3t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 15:29:49 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 4515214073F;
	Wed,  3 Oct 2007 15:30:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 1D6EE13FCAE;
	Wed,  3 Oct 2007 15:30:03 -0400 (EDT)
In-Reply-To: <87myv0qj2u.wl%cworth@cworth.org> (Carl Worth's message of "Wed,
	03 Oct 2007 09:06:01 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59870>

Carl Worth <cworth@cworth.org> writes:

> On Wed, 3 Oct 2007 16:36:13 +0100 (BST), Johannes Schindelin wrote:
>> Or as
>>
>> 	i=1
>> 	while test $i -le 50
>> 	do
> ...
>> 		i=$(($i+1))
>> 	done
>
> /me steps aside to let the shell-script wizards finish the job

I've already pushed out a rewritten one.  Thanks.

The bug makes 1.5.3.3 a dud, and 1.5.3.4 owes credits to Keith
and you for fixing it.
