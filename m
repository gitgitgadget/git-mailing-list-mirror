From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: cleanup push rules comment
Date: Wed, 28 Nov 2012 08:58:36 -0800
Message-ID: <7vip8phdfn.fsf@alter.siamese.dyndns.org>
References: <7v7gp7nf5e.fsf@alter.siamese.dyndns.org>
 <1354079933-2488-1-git-send-email-chris@rorvick.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 17:59:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdkyM-0000RF-Ql
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 17:58:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867Ab2K1Q6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 11:58:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50080 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754481Ab2K1Q6j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 11:58:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 071B19E7A;
	Wed, 28 Nov 2012 11:58:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NN5U8MJLm1RUlEAuhSWIwYXb1pI=; b=wF80yu
	mwmDNnUUoj2wP2s6HlE+QEkV8wdntWR7AeyY0tgIP/oV5H+jNDdOJnrVPV87kMP5
	qE/XBJfofB0eWZKOFmhJPq+pg441SN9bLSz+AEKavudolCp3aQAcl+XIGI5a7Id+
	FAuHPlAOarg92TdWHU9DRu7oEpu3pBvyL8634=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E03+rDY31uct8mm2VCqw0pFiM9E2O5lg
	Qd6Tw6enXVsWCEXEwraL3TR2xF0fQfRKWkjvZTaH/fGA+SPpTCyh8JC49XeyVZNx
	h6azPFTPOyUeOl7R0zykz5zgoBi3QwHbTGECNbHng4PqkKvB+/UJr86F7yHbZKnC
	FPAisCkQ4Ic=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4C479E79;
	Wed, 28 Nov 2012 11:58:38 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 584139E77; Wed, 28 Nov 2012
 11:58:38 -0500 (EST)
In-Reply-To: <1354079933-2488-1-git-send-email-chris@rorvick.com> (Chris
 Rorvick's message of "Tue, 27 Nov 2012 23:18:53 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DACAE760-397C-11E2-997B-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210742>

Chris Rorvick <chris@rorvick.com> writes:

> ---
>
> I ended up rewriting most of the comment.  The new version removes
> inter-rule dependencies (e.g., rule 5 overrides rule 3) which I think
> makes it more readable.

Nice; thanks.
