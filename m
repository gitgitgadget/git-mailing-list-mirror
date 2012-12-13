From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/7] remote-bzr: update working tree
Date: Thu, 13 Dec 2012 15:58:34 -0800
Message-ID: <7vhanpwllh.fsf@alter.siamese.dyndns.org>
References: <1352643598-8500-1-git-send-email-felipe.contreras@gmail.com>
 <1352643598-8500-5-git-send-email-felipe.contreras@gmail.com>
 <7vtxs9vda3.fsf@alter.siamese.dyndns.org>
 <CAMP44s1ZdMK+0_pP3qkZUepOvkfMaXeY2BV0MFu5YOSV=40Dcw@mail.gmail.com>
 <7vobhxwm3n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 00:58:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjIg3-0005xO-1V
	for gcvg-git-2@plane.gmane.org; Fri, 14 Dec 2012 00:58:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756307Ab2LMX6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 18:58:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59179 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755898Ab2LMX6h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 18:58:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 081C1A4B3;
	Thu, 13 Dec 2012 18:58:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7ewID3cbXIz8bPnf7R/EsoraHYY=; b=sUj6pg
	mWvNpfo3iyHh2TnF5GLlE07/dR+00zjuVtlwEh1WZIjZPj3FWG5o5NJY2obfJVL0
	XUZI01kL1264F4ZW+XPhsvT9Lbtb919aWq+bsf2Y8pXE4A+EWKQqyk63ZddT+Hbd
	Pr3lN080CdzvrCI9MSG7Mok/aLgDj6SWxSKTk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U/T1LlNLbrWmU03SUYlIb7aXNOHA2lrj
	KMfr6aKZ5tEeWIgl4kebrNlcFtUyY3dzXy7BE5e8LI2KSXpOnv6t4AcYFz7Q2D6k
	J36hoBwviGQaFZk3XkVGNit2nL4GJ4hoEu2hl18QbGMrmVD+Jexd3o5STlpARUzc
	8deqtXw9BCY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8B3FA4AE;
	Thu, 13 Dec 2012 18:58:36 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F73BA4AC; Thu, 13 Dec 2012
 18:58:36 -0500 (EST)
In-Reply-To: <7vobhxwm3n.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 13 Dec 2012 15:47:40 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0220C4BE-4581-11E2-80B7-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211480>

Junio C Hamano <gitster@pobox.com> writes:

>> Perhaps. It's not really clear if we should update the working tree at
>> all. A 'git push' doesn't update the working directory on the remote,
>> but a 'bzr push' does. I thought it was better to leave this
>> distinction clear, in case this becomes an issue later on.
> ...
> ...  I don't mind rephrasing that four lines and amend the
> log message of what I have in 'pu', if that is what you want.

... which may look like this.

    remote-bzr: update working tree upon pushing
    
    A 'git push' doesn't update the working directory on the remote, but
    a 'bzr push' does.  Teach the remote helper for bzr to update the
    working tree on the bzr side upon pushing via the "export" command.

Let me know if I grossly misinterpreted/misrepresented what you
wanted to do in this patch.

Thanks.
