From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2009, #02; Mon, 07)
Date: Thu, 10 Sep 2009 11:41:56 -0700
Message-ID: <7vk506abgr.fsf@alter.siamese.dyndns.org>
References: <7vtyzexnhm.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0909101206540.28290@iabervon.org>
 <alpine.DEB.1.00.0909101852080.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 10 20:42:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mlob0-0002qQ-RF
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 20:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865AbZIJSmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 14:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752414AbZIJSmF
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 14:42:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34281 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbZIJSmE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 14:42:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A4AB82D630;
	Thu, 10 Sep 2009 14:42:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8o3ewbwR3axGenzJQpCQkpf5o/E=; b=lLajdY
	Gq+Fuc0NVZ3LcU1hp/O7QgFSI02XGvvqTPDC4p9GmprKx+78OIzZc1++FRYX5EmY
	9s48MmUJ7sOlQEKWw1YOBQNZw1f7oagfuLFhSlZlTzo/Ca1pqDuj7IoOO6zQ2A9r
	trhxRyrZouHNMwB4I5mCzBRQtnfiWJt4UtTEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tTLeEFofgIRHgpVRAr+pwl3NpJT0USR1
	+zObU5QRFtr2HNySDPGMicWFLH4PA9a2wa0pMYLa9Co4wJ8i++/m4WZJZRWrfYqB
	4OX2G9kOHY7lLRIMSMxDxCZHEEb747yBnNnT4aIKqbw+Lan87neLr72XPBv26uAU
	d8NyEEUU4Dk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 767BE2D62A;
	Thu, 10 Sep 2009 14:42:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B92632D626; Thu, 10 Sep
 2009 14:41:58 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0909101852080.8306@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Thu\, 10 Sep 2009 18\:53\:34 +0200
 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A1EBA15A-9E39-11DE-827A-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128132>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> There is a reason why you call the series "foreign" vcs helpers.  And 
> that's because it would be very wrong to pretend that they are the rule, 
> and the current URL schemes the exception.  Very wrong, indeed.

I do not know what you mean by "very wrong".

If the name bothers you, you can think of the earlier part of the series
cleaning up the transport code so that it makes easier to choose which
transport, either internal or external, and ports the native transport
support to use the mechanism.  Then the rest of the series builds on it to
add further support for "foreign" vcs helpers.
