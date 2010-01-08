From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 9/9] rerere forget path: forget recorded resolution
Date: Fri, 08 Jan 2010 15:20:23 -0800
Message-ID: <7vpr5krxoo.fsf@alter.siamese.dyndns.org>
References: <1262122958-9378-1-git-send-email-gitster@pobox.com>
 <1262122958-9378-10-git-send-email-gitster@pobox.com>
 <201001082255.51499.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jan 09 00:20:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTO8E-0008D2-23
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 00:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754098Ab0AHXUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 18:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754069Ab0AHXUb
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 18:20:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51009 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754035Ab0AHXUa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 18:20:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BB9858FE05;
	Fri,  8 Jan 2010 18:20:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MPNyLaNG66/pcKRjR7lC9tPY2dU=; b=LCQxRL
	yDIa8MAohTK+2F/pZG9RxYAft3bJcP7WJtXRv3+piMi7Ubj9oVg1KMjJbjYhrT1b
	PMBvyS0XI1pci31USDHqto3ZCkynCeOfB7v79ecdgahRqsZRFlqW1hzw+dunyrzE
	uUv8q9gmvzA+pUK4esZqPE3ny/I+qtYatF33M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t7WUrFdg5n88eHVcv6aNdHqlaHISFz4A
	kOJEuygzNw8aTisLwesXcCdA/XyrdCho/8E628VjZNXW6Rr37qwYWbC5iM9W4Mu1
	8bAJLWvFXrx/nbAV2y7ioIpTYzLld4yPFDQZ3E9Hwj/JFsCsVYMUWVDG9hMRsBt+
	iRA7WTtkYW0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 981278FE04;
	Fri,  8 Jan 2010 18:20:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 052628FE03; Fri,  8 Jan
 2010 18:20:24 -0500 (EST)
In-Reply-To: <201001082255.51499.j6t@kdbg.org> (Johannes Sixt's message of
 "Fri\, 8 Jan 2010 22\:55\:51 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 67EE67FE-FCAC-11DE-B714-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136493>

Johannes Sixt <j6t@kdbg.org> writes:

> Your implementation forgets to re-insert the forgotten resolutions into
> MERGE_RR, therefore, the next 'git rerere' does not record the new
> resolution.
>
> In my implementation of 'rerere forget', I had the following tests.

Please filfre to roll a patch that adds the tests and code that inserts
necessary MERGE_RR entries, if the feature is pressing; unfortunately I
don't think I will have much git time during the coming weekend.
