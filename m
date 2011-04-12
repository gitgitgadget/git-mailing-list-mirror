From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/resend] Documentation: update to git-merge-base --octopus
Date: Tue, 12 Apr 2011 10:31:51 -0700
Message-ID: <7vaafvqsu0.fsf@alter.siamese.dyndns.org>
References: <4DA47A4D.80909@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Tue Apr 12 19:32:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9hRk-0002a0-Bj
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 19:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118Ab1DLRcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 13:32:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35539 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756255Ab1DLRcF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 13:32:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E0EDC4CA0;
	Tue, 12 Apr 2011 13:34:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SXfaf5BrKVIr586lDysrQB6wAi0=; b=aOuZqW
	12szEqHHoh/vTm7w1nQfqv58Xq6q4+iegeIogUUqlLSG0YOXpWUDyu2cIrPws7JP
	VcSd6XTPp8uy1qjGxudOd31zFo7mY+D09DpbEnZrMbVuDrOcLj1+oN9Z+sayoy1v
	n+1DMdXxm5h1ECIbBwAdvWBiYQZsxuyvbd2VA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q687Hl1Qma5JrpzflFrUQ2xIo8eze3ZL
	hseOZAx6Wjs5xgTgNYrRD25mQX9BzOp0BhRVDDyV5cRMu1Zqe0NmBax1QANnUgaZ
	YKQSS4N4sjyLgtElfKBHDsaOr8N3F2QAPn92MgxZsZmeF4mDNWQblLAQY3bHWmb2
	W9w0aeUPFRk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A5FF64C9F;
	Tue, 12 Apr 2011 13:33:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 77B204C9E; Tue, 12 Apr 2011
 13:33:51 -0400 (EDT)
In-Reply-To: <4DA47A4D.80909@lyx.org> (Vincent van Ravesteijn's message of
 "Tue, 12 Apr 2011 18:14:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0B1D64F6-652B-11E0-8BEA-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171405>

Vincent van Ravesteijn <vfr@lyx.org> writes:

> Sorry for the noise caused by the previous attempt(s). Apparently my attempts
> to let Thunderbird _not wrap_ the lines were counterproductive.

I was wondering what that was about.

> +When the option `--octopus` is given, the result of `git merge-base A B C`
> +will be '2', because '2' is the common ancestor of all branches.

Wouldn't it be easier to read if you had the option in the command line, i.e.

    The result of `git merge-base --octopus A B C` is '2' because...

without "When ... given" that now become noisewords?
