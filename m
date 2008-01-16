From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] git-submodule: rename shell functions for consistency
Date: Wed, 16 Jan 2008 12:08:59 -0800
Message-ID: <7vbq7lpm78.fsf@gitster.siamese.dyndns.org>
References: <1200280956-19920-1-git-send-email-imyousuf@gmail.com>
	<7vzlv7flb5.fsf@gitster.siamese.dyndns.org>
	<7vy7are3qo.fsf_-_@gitster.siamese.dyndns.org>
	<7bfdc29a0801151826u2218f825ga8100b1cc9fa8b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Imran M Yousuf" <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 21:10:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFEaA-0000sQ-It
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 21:09:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbYAPUJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 15:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbYAPUJR
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 15:09:17 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64087 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbYAPUJR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 15:09:17 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D31445DA;
	Wed, 16 Jan 2008 15:09:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 80C2F45D7;
	Wed, 16 Jan 2008 15:09:11 -0500 (EST)
In-Reply-To: <7bfdc29a0801151826u2218f825ga8100b1cc9fa8b2@mail.gmail.com>
	(Imran M. Yousuf's message of "Wed, 16 Jan 2008 08:26:29 +0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70735>

"Imran M Yousuf" <imyousuf@gmail.com> writes:

> Thanks Junio for showing how it should be done. Due to some
> pre-scheduled appointment I was unavailable yesterday evening and thus
> was neither able to reply nor resubmit the changes.

Well, I did not show how it _should_ be done.  That series was
merely an illustration of how I _think_ it should look like.  I
did not test it, I do not know if it introduced new bugs, and
most importantly I do not know if it fulfills what you intended
to achieve with your patch.

In other words, I just tried to turn the table around.  Instead
of me and others commenting on your patch saying "I do not like
this" piecemeal, now you have something you can comment on.  You
can say the whole range of things from "I tested this and it is
what I want", "I like the general concept but I found this and
that bug and here is a fix", to "This is much worse than what I
proposed and here is why."
