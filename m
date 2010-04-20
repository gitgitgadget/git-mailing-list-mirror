From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Getting 'git log' (or something else) to show me the relevant
 sub-graph?
Date: Tue, 20 Apr 2010 13:45:21 -0700
Message-ID: <7viq7lg8f2.fsf@alter.siamese.dyndns.org>
References: <201004201649.31084.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Apr 20 22:45:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4KK9-00067d-3X
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 22:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755195Ab0DTUpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 16:45:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51087 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755193Ab0DTUpa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 16:45:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F1EA6AAD43;
	Tue, 20 Apr 2010 16:45:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ixxcN7MlLqwIDdDfHlFZEdQGwFo=; b=lEwSFp
	hshyRTvNotCDIAcK7/+WSZKszKDuh33CEe4a2KQeJteacK4zIvJNxyLdsfM1OpY4
	Pz61aHV0NBk3sTnaUc4ZLa7E/X3newMZa2mGBW868akEVR8Alz6X4tGBIX7mL5Xo
	udgqbT12bp4p/4uwGuQNmmEPSoLCFe39VZCAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dD0DUW/U1WsLT2h8+DyzqZmSG8LcGdPV
	cBFBmIzUc4ci00DS8AaHmXTr3Mosgx0pDPigQDnmTResQk8pWNpN1p2YoLODU2aL
	xn5AYeXYLrZgeX9SELFyUyg0LFnbQ4dlYH6ewgmVnIGTyeVZZ+C5rGcTTnw7WuoO
	rIjCK0O3BVA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CAF9BAAD42;
	Tue, 20 Apr 2010 16:45:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB3A0AAD3B; Tue, 20 Apr
 2010 16:45:22 -0400 (EDT)
In-Reply-To: <201004201649.31084.johan@herland.net> (Johan Herland's message
 of "Tue\, 20 Apr 2010 16\:49\:30 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A5C34D54-4CBD-11DF-B57E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145395>

Johan Herland <johan@herland.net> writes:

> Now, assume that I have bisected my way through to 'A', and found that 
> it introduces some bug. Now, I'm interested in visualizing the path 
> that this bug "travelled" to get into "mainline", i.e. the following 
> sub-graph:
>
>                           --M2--H  <-- mainline
>                            /
>         --M1--D---E---F---G  <-- dev-branch
>          /
> A---B---C  <-- topic-branch

Interesting.  I am looking into it ;-)
