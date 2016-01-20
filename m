From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv7 0/8] Expose submodule parallelism to the user
Date: Wed, 20 Jan 2016 12:53:58 -0800
Message-ID: <xmqqbn8g55w9.fsf@gitster.mtv.corp.google.com>
References: <1452541321-27810-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, jrnieder@gmail.com,
	Jens.Lehmann@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 21:54:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLzld-0000e9-2d
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 21:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173AbcATUyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 15:54:08 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60827 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752534AbcATUyF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 15:54:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E23AF3C7DC;
	Wed, 20 Jan 2016 15:53:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1tZGOnzwkbCNF61MMDiAmG1GRhI=; b=YxsRLc
	xTa3E3TpGGAfN+z0gxRPa4Ex2sWNeBPCDqqBUeCPbt9KjGHttPXBTjmYV81yuqJN
	sH9+1aOuH6UXje9I1RddNbMlA5qgS8+2tfYUkBE7ZI7cRPLe3OuooFj4cDAs8sQq
	FZSfqnVF0gJUhQk0Pvf2eARZI32oJAG7qJaW8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=elq0MvRLo1OUAfHvF7tFvpTy4iAQ490X
	fO3O/P+EF76tmvwuC/oKG/du2RW4VpvTfCHpDaH1aABWYQGdcdtHWKWvGAdNb4zm
	gpKfadOpM4CGqBNHMQLulrYlHcIKz4jv4lPbQoyMCVydOSqRuXlQYxTlsAgHbt7P
	pTbmXluI/SU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D7C0F3C7DB;
	Wed, 20 Jan 2016 15:53:59 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4D8173C7DA;
	Wed, 20 Jan 2016 15:53:59 -0500 (EST)
In-Reply-To: <1452541321-27810-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 11 Jan 2016 11:41:53 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EDBEDA88-BFB7-11E5-99B5-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284466>

Stefan Beller <sbeller@google.com> writes:

> This is a resend of sb/submodule-parallel-update and is available
> at github[1] as well.  It applies on top of
> sb/submodule-parallel-fetch
>
> What does it do?
> ---
> This series should finish the on going efforts of parallelizing
> submodule network traffic. The patches contain tests for
>   clone
>   fetch
>   submodule update
> to use the actual parallelism both via command line as well as a
> configured option. I decided to go with "submodule.fetchJobs" for
> all three for now.
>
> What changed to v5,6?
> ---
> No major changes, I just made it compile again as the order of parameters
> to the parallel processing engine changed.

This hasn't seen any reviews since it was posted.  Is anybody
interested in seeing this topic moving forward?
