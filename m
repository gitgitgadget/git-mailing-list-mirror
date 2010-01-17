From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-apply.c: Skip filenames without enough
 components
Date: Sat, 16 Jan 2010 18:22:10 -0800
Message-ID: <7vr5ppa2st.fsf@alter.siamese.dyndns.org>
References: <201001170305.10793.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Sun Jan 17 03:22:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWKmu-0004WQ-Go
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 03:22:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266Ab0AQCWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 21:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753256Ab0AQCWU
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 21:22:20 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42966 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216Ab0AQCWU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 21:22:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D257F9113C;
	Sat, 16 Jan 2010 21:22:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w+Bb1ldAKDilSUX+LnD3iJPQJQo=; b=sWIFdx
	jkWiKg+6ygI3UpaqAOmGQ0Ouk7utgR2Rw2NaMDaBNeNPi1mPDr9z3L8ZeXvy0h0G
	OVDkScrJTwZVll/4CilmBtXWBxKf7i05qoWdmVdzVy1fBvaJkKq//RCCec8OA+9A
	ZlUwm4waxJgoDGxpg9a9Z27JDFVSYI6lTQ6uA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yguM2QnxKHihJFZ+ZDpicvyyvrrUKvOq
	vCIbDNMyvCnmeVKRE3rKcg5tYScdbVnNbc6ZGkS0wOYR8+v92RcXSeeuyL4t39se
	A4/azSjDck1wd49p+xSi8ChmdcIelRfTgw0BZOkUtP4kIr7JMBBUvnIE3ZhER42b
	VlRbO4pq1QA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B146791137;
	Sat, 16 Jan 2010 21:22:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2257791133; Sat, 16 Jan
 2010 21:22:11 -0500 (EST)
In-Reply-To: <201001170305.10793.agruen@suse.de> (Andreas Gruenbacher's
 message of "Sun\, 17 Jan 2010 03\:05\:10 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 206036C4-030F-11DF-B132-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137269>

Tests?
