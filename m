From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.10-rc0
Date: Thu, 08 Mar 2012 11:55:38 -0800
Message-ID: <7vlinadg05.fsf@alter.siamese.dyndns.org>
References: <7v7gyvkh84.fsf@alter.siamese.dyndns.org>
 <20120308063054.GD7643@sigill.intra.peff.net>
 <7vk42vfv3c.fsf@alter.siamese.dyndns.org>
 <20120308065306.GA8799@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 08 20:55:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5jRC-0001EU-10
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 20:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757545Ab2CHTzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 14:55:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35354 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752905Ab2CHTzl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 14:55:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD8EB7E6A;
	Thu,  8 Mar 2012 14:55:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4/ALEAIVJwkmAE2e+wfNthao13c=; b=m4ljnL
	NDDfnq8JLVzrjaHe13wJZ5E2dBc199opBtvsNHvRcFp1D8/tZ8HINREa1CwNbOsq
	RZ7R9veDH3m3KSbGRL/MqNFRZWbPtvMSfXHSjjZfvd7WtHZ1dWjofEojwnnnu8sS
	4u4jrDVkCL0waohnTeF+OdxkiT95hqUsoPbmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H1LwrCVEH5af9weadakSQ9uTMSupU41U
	gMDWlzasTPj14z2VpJSZISDIzleBQK2CNxQUxBrgbHGvqCZviqCwMm7NjOC2Hrl0
	XujAF2F9fHQ4m1S6c/sFVH/MXsQwpvOWqHKuto5vM8KoQe0h9q/tKNt+UsceoXwZ
	ctHMBP6Fb3I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B506E7E69;
	Thu,  8 Mar 2012 14:55:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4ACE27E68; Thu,  8 Mar 2012
 14:55:40 -0500 (EST)
In-Reply-To: <20120308065306.GA8799@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 8 Mar 2012 01:53:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AE7B3768-6958-11E1-80BD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192639>

Jeff King <peff@peff.net> writes:

> Though as a minor nit, the thing I had trouble parsing originally was
> "...that matches the given pattern ignoring the case". I think "...ignores
> the case when finding patch hunks that introduce..." is a little easier
> to read.

Thanks, will do.
