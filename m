From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase-interactive: silence warning when no commits
 rewritten
Date: Sun, 18 Apr 2010 11:42:59 -0700
Message-ID: <7vfx2swqj0.fsf@alter.siamese.dyndns.org>
References: <20100418120145.GA14872@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 18 20:43:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3ZSe-000649-Kp
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 20:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757439Ab0DRSnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 14:43:11 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57690 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011Ab0DRSnK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 14:43:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D3911AC7E7;
	Sun, 18 Apr 2010 14:43:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vFmnlsTn3zJ3SzxLw+YXd/Y85yc=; b=tYCZxs
	e0pc8pJ0CyVgwfcAMJChDBlCk0x6xXOKZg0R+9bhesZdKTsGXX12kxREDMi6T94z
	srE5rp0vV5ot0G7WTDoHRonQ5XPOK4/a4Tgp3ZBOAZfYyNXbG7RyBHYUUgm6M8oy
	q9L32IT6S/oWjPfT9UsplygUYC0KQx0/00JIo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CEXl0E0hFxLErtCr/QVHWl5TAT8oObvu
	xfLIvOC7aLiXrNLy6eN1x9TNXA1Bb3Eyj/LQPgXoC6GPUvrYudC7SU2hRmaDjMHk
	//h88LB36sVXv8fNEv8iKUTlc6Y3pN7I2MK6gId9jstp50soRCaZoXDP0bqtyorV
	LBgKJVWUQA8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 54187AC7E4;
	Sun, 18 Apr 2010 14:43:04 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A80FFAC7E1; Sun, 18 Apr
 2010 14:43:00 -0400 (EDT)
In-Reply-To: <20100418120145.GA14872@coredump.intra.peff.net> (Jeff King's
 message of "Sun\, 18 Apr 2010 08\:01\:45 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 391295CE-4B1A-11DF-BC31-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145234>

Thanks; I stumbled upon this the other day and was annoyed myself.
