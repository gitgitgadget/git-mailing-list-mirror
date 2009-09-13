From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: Replace config --list with --get-regexp
Date: Sun, 13 Sep 2009 13:40:14 -0700
Message-ID: <7vws42poi9.fsf@alter.siamese.dyndns.org>
References: <a3b675320909100813i3e70ab3at66408aebb9952c7d@mail.gmail.com>
 <20090911133313.GF2582@inocybe.localdomain>
 <a3b675320909110700k7eb7286qc8cb5691aae214c7@mail.gmail.com>
 <20090911141730.GA384@coredump.intra.peff.net>
 <20090911143651.GE1033@spearce.org>
 <20090911150934.GB977@coredump.intra.peff.net>
 <20090911232344.GH2582@inocybe.localdomain>
 <20090912183139.GO1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Todd Zullinger <tmz@pobox.com>, Jeff King <peff@peff.net>,
	james bardin <jbardin@bu.edu>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Sep 13 22:40:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmvs8-0006Nm-3G
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 22:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754853AbZIMUkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 16:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754766AbZIMUkX
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 16:40:23 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60136 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbZIMUkX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 16:40:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 679AC3196B;
	Sun, 13 Sep 2009 16:40:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eWqk9356RuDvlaCTJd/qlna7Bd8=; b=NFaQQc
	m2qfz6w8pr74s+1Qckaq7j46aADFdYnRM/ImnpUbXJT0lJ18cnPKMthCSISRl5Jd
	sUOoT2OSt4CoOQ0emTHNkEagKFlD6G/VwQgzchguT3XEl4giwYc0V/wwtB1dAGqF
	qcdHB+zgXbwm3NCtmDL+MoGvC+Wdxg6bzWXxE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MTQYC9h/5SsXwSVW5o/AKvjUc4QAN2/E
	GUjx1xW3VdVhXmc0kpEEas3CxYkbo7pTDZbYc60TFyXYGRJ/bFLOquXe008LnwvP
	x9irTSfOFbJjMtCnYUge/lec5Lkg0fUvpPi468os3GOzRWSCshK4Zq4GDLkM435h
	p+Z0YfUtwvA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 26BEB3196A;
	Sun, 13 Sep 2009 16:40:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6692C31966; Sun, 13 Sep
 2009 16:40:15 -0400 (EDT)
In-Reply-To: <20090912183139.GO1033@spearce.org> (Shawn O. Pearce's message
 of "Sat\, 12 Sep 2009 11\:31\:39 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A7B3CE8C-A0A5-11DE-A046-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128409>

Thanks, everybody.  Will apply.
