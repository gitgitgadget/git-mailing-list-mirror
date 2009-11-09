From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] Add explicit Cygwin check to guard WIN32 header
 inclusion
Date: Mon, 09 Nov 2009 12:30:21 -0800
Message-ID: <7vocnbsaoy.fsf@alter.siamese.dyndns.org>
References: <4AF5D6F8.40608@ramsay1.demon.co.uk>
 <4AF86CDB.6030200@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Nov 09 21:30:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7aso-0000dl-Qb
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 21:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754417AbZKIUa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 15:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754238AbZKIUa2
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 15:30:28 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37332 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753990AbZKIUa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 15:30:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C1C57A1D7;
	Mon,  9 Nov 2009 15:30:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7dGMoBCPPTGafBBd4/yGdbfqb8A=; b=RTbQy+
	ZxY3qVQh+H1LkT+gyIXD7AD1HrYAyj2/jtGQwiRVhF3swwKE5iybv3ZEEaFR6ESE
	xZ77tv3h4V3lGznU2gFgCmjfGyRkwxiUwXL+0/V1hsIuzh0P5uNbIC+wWCXM72P5
	WGDkPg6vZ6PkzDa1MgHyaYldlAnLLBTkYxW5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Oq7KVDVXETLNo4ZMvvZJSWs7oK7X/ci3
	g/bZrFRmq1aI4RPFv8k7sbZsglqkbEcX/Khmj8h8dLuHgebRhmFmd2/+ox4lHuNa
	zqf3kSGIqnLYbqJ2bmMHn4beBq4xkbDuN2L18o2c9XluxSO7ATdrs6dK0tnaFScq
	y4ulrm1gu/s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D69747A1CE;
	Mon,  9 Nov 2009 15:30:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F1F8A7A1CC; Mon,  9 Nov
 2009 15:30:22 -0500 (EST)
In-Reply-To: <4AF86CDB.6030200@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Mon\, 09 Nov 2009 19\:26\:19 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B79FF4EC-CD6E-11DE-9A66-7B3EEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132520>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Ramsay Jones wrote:
>> diff --git a/git-compat-util.h b/git-compat-util.h
>>...
>
> Arrgghhh.
>
> Sorry, Junio, I meant to change this before sending it out. :(
>
> I had intended to remove the added indentation (which I don't even remember
> doing!), since it obscures the "real change", which simply consists of the
> new expression in the #if preprocessor line.
>
> I'll send a new version of this patch.

Thanks for a notice.

The only reason I queue patches to 'pu' is to give them (slightly) wider
exposure than merely being in the mailing list archive, and I do not
expect myself merging this series to 'next' before seeing Acks from
Windows stakeholders, as I do not build anything on that platform myself.

I saw a comment on substance not form of this patch from J6t, and I
suspect that it was a more important issue.  You can de-indent while
sending your updated patch to address that issue.

Thanks.
