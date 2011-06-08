From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv8 1/4] Fix prefix handling in ref iteration functions
Date: Tue, 07 Jun 2011 17:17:56 -0700
Message-ID: <7v4o4141mz.fsf@alter.siamese.dyndns.org>
References: <1307487890-3915-1-git-send-email-jamey@minilop.net>
 <1307487890-3915-2-git-send-email-jamey@minilop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	Josh Triplett <josh@joshtriplett.org>
To: Jamey Sharp <jamey@minilop.net>
X-From: git-owner@vger.kernel.org Wed Jun 08 02:18:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU6Tp-0002AQ-TD
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 02:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400Ab1FHASd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 20:18:33 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40756 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756366Ab1FHASR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 20:18:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4CB0A6975;
	Tue,  7 Jun 2011 20:20:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J64ABOZnCcyQJBAFvLazsdnxUM4=; b=bfuhqT
	MjuYKsyOZkTHPFgog4V2J1hQpIyaCiS/vFohsDrq+Gxo7ura8z+XXnWTuSZCi0hh
	6xRuEpttf2IrH1lIS68QenlHAGEmyI5tF4Xy0QaaZoCRUUMVg8OIrXSxzeVKcNkR
	XVGFrBjGOikdVjvOKWFSzjZylq/MU0XNQQWQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=epM/tE3NO4wyveUD4tqOfaPUFtO1E0mR
	/5K+JG/4/yCMzkpIUUzJCD/m0n92lw1uqg8S1F0Rw/9N+FhpOQ7A0ONtEDo7Hrg6
	gZznQmkU/vE2idl/cb7CP6u2GpR5qIyCMOj2QKlCkHeoIDwCrUd9i8Vtoz8Czin2
	Ty8ZKlqEfKE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C0EBC6974;
	Tue,  7 Jun 2011 20:20:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 70FA96969; Tue,  7 Jun 2011
 20:20:07 -0400 (EDT)
In-Reply-To: <1307487890-3915-2-git-send-email-jamey@minilop.net> (Jamey
 Sharp's message of "Tue, 7 Jun 2011 16:04:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 10539D30-9165-11E0-BD17-85C8C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175289>

This round does fix the ".have" issues, but with the --namespace patch
later in the series, it seems to break the same test, by filtering .have
entries with "refs/" prefix.

> Commit by Josh Triplett and Jamey Sharp.

Didn't I ask you to remove this?

Please pick which one of you would be the primary contact for each patch.
I know you said you two did these commits sitting side-by-side, but the
thing is, we simply don't care, and "git shortlog" and the author list you
can see at http://www.git-scm.com/about don't, either.

It is somewhat irritating having to re-edit the log message (not just this
part, but what have been queued were retitled, reflowed and reworded to
match the style of other commits in the project better) over and over
again.
