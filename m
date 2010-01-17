From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-parse --namespace
Date: Sun, 17 Jan 2010 11:28:06 -0800
Message-ID: <7v4omkzg3d.fsf@alter.siamese.dyndns.org>
References: <1263735931-20227-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <20100117162712.GB7153@sigill.intra.peff.net>
 <20100117164057.GA20554@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sun Jan 17 20:28:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWanN-0006ye-OJ
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 20:28:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510Ab0AQT2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 14:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754325Ab0AQT2R
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 14:28:17 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60814 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911Ab0AQT2R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 14:28:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B0E9291B79;
	Sun, 17 Jan 2010 14:28:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Skr9Ptjikq9XPi5w27BloB+XLPs=; b=SM/2Ad
	FJZi4eShs8sEM2OaCDBx5Yt5IB+XNHwoiObNjE/kRyVWrsMGkFnL/fFOsJngfcjp
	sfG0sFw5ktwuyjPV2mpYT2P8n42kuakge7wdX2S3ylcM61dqMMrElIAv+ww1wz2p
	C2g821BmTivIeYAHfJ4RaXieDfzDH1RtNfngo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fmiTEnAVrqfUhL0Cj/D5I+PXJbVlbDvz
	bX6zNxorZnMBTqqmi3Ji8xw20py+AAnzq/n7wBRQXXaw0/p2zLLeg7k1nFIO4PKL
	TBokqYSIrJbyibnoRuHFOJy8CfAKoi6TNJOeEVlQvFLaocszN8Kh+AtELboOhEsV
	YLYHX0GTTPQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7331491B77;
	Sun, 17 Jan 2010 14:28:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF09091B73; Sun, 17 Jan
 2010 14:28:07 -0500 (EST)
In-Reply-To: <20100117164057.GA20554@Knoppix> (Ilari Liusvaara's message of
 "Sun\, 17 Jan 2010 18\:40\:57 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 730E31AC-039E-11DF-8605-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137311>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> 'git log --branches --not --namespace=remotes/origin' 

This sounds sensible; it essentially is a natural extention of the
existing --branches, --tags and --remotes options.  While I don't care too
much, people may want to have an even shorter name (perhaps --under=heads
or even --in=tags.

In any case, we would want to have your "log" command line above both in
the proposed commit log message and the documentation in the Examples
section, given that this is not immediately obvious to even veterans like
Peff and I; it didn't "click" for me until I saw the follow-up exchange
between you two.
