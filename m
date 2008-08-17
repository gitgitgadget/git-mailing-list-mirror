From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] Always provide a fallback when hardlinks fail
Date: Sun, 17 Aug 2008 10:51:44 -0700
Message-ID: <7vabfb5y33.fsf@gitster.siamese.dyndns.org>
References: <0EFF470D-341A-4619-910A-0F9C663D0B51@web.de>
 <7vljyv6gyo.fsf@gitster.siamese.dyndns.org>
 <06F58415-2F22-44BE-8F19-70460DDF7F35@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andreas =?utf-8?Q?F=C3=A4rber?= <andreas.faerber@web.de>
X-From: git-owner@vger.kernel.org Sun Aug 17 19:53:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUmRQ-0000YD-5H
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 19:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbYHQRvw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Aug 2008 13:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbYHQRvw
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 13:51:52 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49759 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbYHQRvw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Aug 2008 13:51:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BE4545C80F;
	Sun, 17 Aug 2008 13:51:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B94F95C80D; Sun, 17 Aug 2008 13:51:47 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2B86CB52-6C85-11DD-965C-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92616>

Andreas F=C3=A4rber <andreas.faerber@web.de> writes:

> Am 17.08.2008 um 13:03 schrieb Junio C Hamano:
>
>> Andreas F=C3=A4rber <andreas.faerber@web.de> writes:
>>
>>> BFS does not support hardlinks, so suppress the resulting error
>>> messages.
>>
>> Hmm, this is not specific to BFS.  I would have preferred if you
>> brought
>> up much earlier.
>
> Right, it isn't. Do you mean earlier in time, or would you like me to
> reorder it in my v2 series?

Sorry for being unclear.  I edited the message a few times and this par=
t
came out quite differently as I intended.  It should have read this way=
:

        Thanks for noticing (I would have preferred to hear about this =
a bit
        earlier, not before the release day).

Anyhow, thanks for the patch again.
