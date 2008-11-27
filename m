From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Add / command in add --patch (feature request)
Date: Wed, 26 Nov 2008 22:41:26 -0800
Message-ID: <7v1vwxd621.fsf@gitster.siamese.dyndns.org>
References: <492DB6C8.7010205@gmail.com>
 <20081126223858.GB10786@coredump.intra.peff.net>
 <7vod02cd3p.fsf@gitster.siamese.dyndns.org> <492E3811.6050603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 27 07:49:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5agl-0001ji-30
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 07:49:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbYK0Gly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 01:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbYK0Gly
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 01:41:54 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40686 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbYK0Glx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 01:41:53 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 26E7817942;
	Thu, 27 Nov 2008 01:41:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B5BDC1793F; Thu,
 27 Nov 2008 01:41:28 -0500 (EST)
In-Reply-To: <492E3811.6050603@gmail.com> (William Pursell's message of "Thu,
 27 Nov 2008 06:02:57 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 783923BE-BC4E-11DD-A3AD-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101794>

William Pursell <bill.pursell@gmail.com> writes:

> Before working on patches, I'd like some ideas on
> functionality:
>
> 1) If a hunk doesn't match, should it be as if the user
>    selected 'n', or 'j'?

Is it an option to tell "nothing matched", stay at the same hunk and ask
the user to make the choice again?
