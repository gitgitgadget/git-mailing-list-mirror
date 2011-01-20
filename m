From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Re: rebase -i: explain how to discard all commits
Date: Thu, 20 Jan 2011 13:28:03 -0800
Message-ID: <7vfwsnqn8c.fsf@alter.siamese.dyndns.org>
References: <vpq62ziv788.fsf@bauges.imag.fr>
 <20110120195726.GA11702@burratino> <20110120200827.GB14184@vidovic>
 <201101202134.41911.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, <git@vger.kernel.org>,
	<gitster@pobox.com>, Kevin Ballard <kevin@sb.org>,
	Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jan 20 22:29:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pg245-00088C-4v
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 22:29:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755260Ab1ATV2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 16:28:43 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41226 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754974Ab1ATV2c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 16:28:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F40E23E3F;
	Thu, 20 Jan 2011 16:29:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u809stSXSg1kAUhfervMKNIDx3s=; b=F8ytLf
	3ETHaTjJ9TTJ2LTZ/QKchJhzSswE6wE6ybE8ohP+eolZou9/Bacf2aQQcrEyCUVR
	5tTZajElhHIU20jWstbiU4lLHrNUgpGHGQxhLkL9Hs98+dm2jN5drDc6/bXT2fjb
	uwT2wVJJPl/9jNn9qa8GHtxFF+evqBuDMd6+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ow8U3Tbjm+NUO88W1dxi4jPJsyEm+YTJ
	Cst6bNov56OwiILK0br3pyAtFKOwHVG7woYpu9qvQnDRMSPLqPLpZPpe7wlPbvum
	3a695B24CvE39URyqZqf6YneaFnakoLS4O5U4G9iE64qzG2kU2bcTQPtBszkgZg8
	+VDUL71gAFQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 590DB3E3B;
	Thu, 20 Jan 2011 16:29:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BA42F3E2D; Thu, 20 Jan 2011
 16:28:52 -0500 (EST)
In-Reply-To: <201101202134.41911.trast@student.ethz.ch> (Thomas Rast's
 message of "Thu\, 20 Jan 2011 21\:34\:41 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4FEA1A14-24DC-11E0-BFCA-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165340>

Thomas Rast <trast@student.ethz.ch> writes:

> (I for one have never accepted such a rebase; if the TODO only
> consists of noop, that means I made a mistake.)

Wouldn't that suggest us that if we were to do anything to this message it
would be a good idea to teach the user to "reset --hard" the branch if no
commits truly needs to be replayed on top of the onto-commit?
