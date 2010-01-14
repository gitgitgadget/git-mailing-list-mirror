From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Gitignore matching "git add" wildcard prevents operation
Date: Thu, 14 Jan 2010 12:21:34 -0800
Message-ID: <7vljg0bfox.fsf@alter.siamese.dyndns.org>
References: <4B4F6000.4070005@sofistes.net>
 <20100114195234.GA26684@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marko Poutiainen <regs@sofistes.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 14 21:23:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVWCu-00052v-Mt
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 21:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757630Ab0ANUV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 15:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757626Ab0ANUVz
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 15:21:55 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41269 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756693Ab0ANUVr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 15:21:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 842959102E;
	Thu, 14 Jan 2010 15:21:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EEUFbHOzISzE3cJ0KEkdzfGWc1Y=; b=bYY0qs
	batZk6/MTlOrqP00Jj0kqLse8Fx7Q7yfuQvQVmPbNOHhzBLiz2lQ9zwPcPYTiaOq
	024s2uzx2ShvXQdLfKHA0dGom/DCV8XQ9TNfTJe4JZXeA6APqkavn8qnh6KN4v2s
	cTmYZYyBdhXLrWdQb/ZX/7VAzImIX654SvYds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h119iJ9IcN5AAKyBp1SD9SKH4gNLCMKT
	KSn/gTkRlpaaDeSgLVGoSnF12ua6q+iLsyR0VRkjRawfeKOiHXzBEeHk4tddK2IG
	ejjb6rob/2ZMmdXUThBYmoffW7JDwLR+2fZK45d8FZ9HhRyppBVs4TzY/3gb0woh
	ioaNrg8qkyk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F5609102D;
	Thu, 14 Jan 2010 15:21:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9759391026; Thu, 14 Jan
 2010 15:21:36 -0500 (EST)
In-Reply-To: <20100114195234.GA26684@coredump.intra.peff.net> (Jeff King's
 message of "Thu\, 14 Jan 2010 14\:52\:34 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6C7128DC-014A-11DF-A40C-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137020>

Jeff King <peff@peff.net> writes:

> ... But there is no way to
> use the shell wildcard and get the behavior you want (not even a "git
> add --really-ignore-my-ignores a.*").

Perhaps you want to run

	$ git add 'a.*'

Notice that the wildcard is protected from the shell.
