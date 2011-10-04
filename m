From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git checkout $tree path
Date: Tue, 04 Oct 2011 08:20:17 -0700
Message-ID: <7vk48kdbri.fsf@alter.siamese.dyndns.org>
References: <7vk48rq854.fsf@alter.siamese.dyndns.org>
 <20111003102647.GD16078@sigill.intra.peff.net>
 <7vmxdigirk.fsf@alter.siamese.dyndns.org>
 <20111004074212.GB7308@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 04 17:20:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB6nE-0005b3-4P
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 17:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932672Ab1JDPUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 11:20:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42314 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932494Ab1JDPUW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 11:20:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C5F749ED;
	Tue,  4 Oct 2011 11:20:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=00ESo82euCOCHeLA59p47Yl60a4=; b=qJrc4V
	PtI7L+adf7eZc5p1cRuHyDhocWn0eT65aG7RHIBHXd5NXzCyS11Q39EW/JtX7myR
	SXf/8G6fEdUy9WmccufY44m4FtE79hq7cWaegRm2uRftoFTV5B5FReYcJ7qPFC18
	VAMoWdGt0OBVgJHKTRWd+e974XDYhUfD9/emg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W8frM1OjMbdHWuOMsz3HIRhqXZzeokqz
	aAOnoP4mDjCI2ce8NBRQpFgvmZ2FhkWpfmGqt3SBbKQotoxDrMs+Kycs8vblFcLo
	lRYWDfctB/Fx1PJt6CACTE/SOo9tEz1Fy3VSV1h9mLxayRsFr5di5sAWHfg1AyFm
	YovO2/xVR5o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FD2A49EC;
	Tue,  4 Oct 2011 11:20:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2859149EB; Tue,  4 Oct 2011
 11:20:19 -0400 (EDT)
In-Reply-To: <20111004074212.GB7308@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 4 Oct 2011 03:42:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5EAC0D16-EE9C-11E0-BCD0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182774>

Jeff King <peff@peff.net> writes:

> This is sufficiently tricky and subtle that it is probably worth
> future-proofing with some tests (e.g., the example you gave in the
> commit message).

Yes, see t2022 in 'pu'.
