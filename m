From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] default "git merge" without argument to "git merge @{u}"
Date: Mon, 31 Jan 2011 12:17:23 -0800
Message-ID: <7vaaig6d64.fsf@alter.siamese.dyndns.org>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <7vsjw957fq.fsf_-_@alter.siamese.dyndns.org>
 <20110131201419.GA9070@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Miles Bader <miles@gnu.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 31 21:17:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk0C2-0004Dh-Df
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 21:17:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754196Ab1AaURe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 15:17:34 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62996 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753997Ab1AaURd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 15:17:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8A5B73CC5;
	Mon, 31 Jan 2011 15:18:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H9C3U9H+Ad+YED8vZGHpkNh2qok=; b=NbxI52
	In7jV8/Fe7/VGc1F0MI7cPCePr0ztXn8RojVhd++6DzpmT24PCLXUcKADC9UHz48
	zJB5LpHE4ieoTtt7Ad78sV4VwYFLGJS+MV+SeLfwJuEeZiJ6F2LW0Ft2UGNpBXpy
	GrwRb555kswJ2N9zFhawCmv+o2q+/fLBKMOIM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YT8/bp3QmOmUZmxDR8m9ny5uSBeMJWMr
	nVQRY8kVGpZpZ3jUVyzLNucUSEusP8aoaSXm4+AAWpibwYZ95lmmdJTnQbmgnbYT
	jhBqy9hpKmZJDSiL6I3Rg0FLnWowPELKaM4SH3EOnl9uCFQExlt9M71D3DAoFc0l
	36Mx5C0aS78=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 58C583CC1;
	Mon, 31 Jan 2011 15:18:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1C6F73CBF; Mon, 31 Jan 2011
 15:18:16 -0500 (EST)
In-Reply-To: <20110131201419.GA9070@sigill.intra.peff.net> (Jeff King's
 message of "Mon\, 31 Jan 2011 15\:14\:19 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 403D89E0-2D77-11E0-B3AB-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165746>

Jeff King <peff@peff.net> writes:

>> In 1.8.0, flip the default for merge.defaultUpstream to true.
>
> Other than that, I think the proposal and migration plan are fine.

Heh, thanks.

It's not my proposal though ;-).  It is just an illustration of how I see
an item from people's wishlist should look like to make it easier to
discuss them.
