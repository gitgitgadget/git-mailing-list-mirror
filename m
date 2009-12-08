From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/6] "git reset --merge" related improvements
Date: Tue, 08 Dec 2009 00:29:43 -0800
Message-ID: <7vk4wxkgw8.fsf@alter.siamese.dyndns.org>
References: <20091208075005.4475.26582.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Dec 08 09:34:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHvWl-0001fe-M2
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 09:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754756AbZLHIeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 03:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753522AbZLHIeY
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 03:34:24 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45445 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112AbZLHIeX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 03:34:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C87586CD8;
	Tue,  8 Dec 2009 03:34:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=th1k8hnhrO6N6r1apuZfx8qDcHY=; b=f6DgCH
	qIgtlA99eDvQoRzVfT96Bg1d4cvWvWmEEU1+TU/IUIahdy5avRKBibZvMX2+x5mW
	+lznyLjLNVApXHNl2IQp80Ajq5IYmefwwaE2SDSx/f9COtT0IrTFVlJOZdO/aiaK
	dEfZ/bO8oH5cY4CdQdturnb3lsprQE6l1fLvs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O0YJyfAx1ubkActP3HjaP0B3dfh1WwyH
	lcgCjd3fJ6fdubU22cjp7G98+SSxP+X2HaU2r3As1mS0aYiAG2M3U5b0JYyICUrX
	yC1KXemA15Y5FWg5DpdlBZpTmgdbC89kqeOhCXSCArOcAfeTJ8dz25m8IHn6b1Vd
	Eufpe5B0A4s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 815EC86CCE;
	Tue,  8 Dec 2009 03:34:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB10186C79; Tue,  8 Dec
 2009 03:29:45 -0500 (EST)
In-Reply-To: <20091208075005.4475.26582.chriscool@tuxfamily.org> (Christian
 Couder's message of "Tue\, 08 Dec 2009 08\:56\:09 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7A77DA68-E3D4-11DE-A28F-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134843>

Christian Couder <chriscool@tuxfamily.org> writes:

> The new option name is "--keep-local-changes" because that's what
> Junio used in the last email of the previous discussion, but my
> opinion is that it is a bit long and so I'd like to rename it "--keep"
> or another such short name.

I vaguely recall that I mentioned something like "I still don't know what
you are going to use this for, even though I think I am starting to
understand it a bit better than before. In any case, it sounds like 'keep
local changes' rather than 'safe'".

Please don't take that as a serious suggestion of a better name.

IOW, don't mind me---come up with a name that describes what you
are doing better.  But please don't blame me either ;-)
