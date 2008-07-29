From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make it clear that push can take multiple refspecs
Date: Tue, 29 Jul 2008 15:06:57 -0700
Message-ID: <7viquobb0e.fsf@gitster.siamese.dyndns.org>
References: <1217362159-25440-1-git-send-email-ams@toroid.org>
 <7vbq0gcsxg.fsf@gitster.siamese.dyndns.org>
 <20080729212808.GA27076@toroid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Abhijit Menon-Sen <ams@toroid.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 00:08:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNxMi-00040A-Mb
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 00:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759290AbYG2WHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 18:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758762AbYG2WHG
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 18:07:06 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40886 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759290AbYG2WHE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 18:07:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C08B3414F7;
	Tue, 29 Jul 2008 18:07:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 21B93414F5; Tue, 29 Jul 2008 18:07:00 -0400 (EDT)
In-Reply-To: <20080729212808.GA27076@toroid.org> (Abhijit Menon-Sen's message
 of "Wed, 30 Jul 2008 02:58:08 +0530")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ACF18530-5DBA-11DD-9526-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90690>

Abhijit Menon-Sen <ams@toroid.org> writes:

> At 2008-07-29 13:54:35 -0700, gitster@pobox.com wrote:
>>
>> Doesn't this already say you can have zero or more refspecs?
>
> It does, of course, but I've seen more than one question about how to do
> it now, even from people who looked at the manpage, and it seemed to me
> that adding an example wouldn't hurt.

Adding an example would help to certain point, but beyond that certain
point it becomes unnecessary noise that talks the obvious.  If you saw the
question asked many times in the real world, that would be a good
indication that this patch falls into the "helpful" category, not "noise".
Will queue.

I wonder if there are other manual pages with <thing>... notation that
benefits from similar changes, though.

Thanks.
