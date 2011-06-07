From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2011, #01; Sun, 5)
Date: Tue, 07 Jun 2011 11:59:42 -0700
Message-ID: <7vlixd5uxt.fsf@alter.siamese.dyndns.org>
References: <7vsjrna2x2.fsf@alter.siamese.dyndns.org>
 <1307470885-4018-1-git-send-email-jamey@minilop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>
To: Jamey Sharp <jamey@minilop.net>
X-From: git-owner@vger.kernel.org Tue Jun 07 21:00:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU1Va-0003my-TV
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 21:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755137Ab1FGTAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 15:00:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61492 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754354Ab1FGTAC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 15:00:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B40805424;
	Tue,  7 Jun 2011 15:02:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C1f8lQo3CBHwAdVeG6bAdNEWZhw=; b=bEKGOU
	4eGpvGPFGMJRPPNbb2gC8gGvsGYHvkFuMzPIgXwe/mYqgO+cqaZ58/0sDxXU6/zy
	F1mPdYr5xIDL12/6cMT2PWsoh+acCJhvkIcPs+R+ZbUH/TfqMSmnTjh+AWKScvSv
	zHRyTzMnTZc6aA1guLvOa2i2CLB3eFHOEyb60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mqcvWGz0QoYsaC6so94ROvk4IECzK7fG
	fusD/ug0/WK0n/TizVJndeL6BXLXjNNxJxoWYV96sa/W8WDywNMzUmobT+3h/VnZ
	K9GvutoGPK3ccJFSEcv/Yjn3gviJ2c1/icbUO46YadyOUgLP5FgZLF58db/rg+wW
	6WpjF7DU9so=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3F240540A;
	Tue,  7 Jun 2011 15:02:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 018F95409; Tue,  7 Jun 2011
 15:01:53 -0400 (EDT)
In-Reply-To: <1307470885-4018-1-git-send-email-jamey@minilop.net> (Jamey
 Sharp's message of "Tue, 7 Jun 2011 11:21:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A1EB290C-9138-11E0-9C9D-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175250>

Jamey Sharp <jamey@minilop.net> writes:

> So, the suggested change to actually use "refs/" as a filter caused this
> failure.  Based on this, we'd tend to suggest that we should go back to
> the version which preserved the existing behavior, to avoid breaking
> assumptions like this; that seems preferable to tracking down all the
> places that would break due to this new ref filtering.  Adding that
> filtering and fixing all the resulting breakage seems like an entirely
> separate change.

Thanks, that makes sense.
