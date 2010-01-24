From: Junio C Hamano <gitster@pobox.com>
Subject: Re: basic question about push
Date: Sun, 24 Jan 2010 11:08:06 -0800
Organization: 
Message-ID: <7vzl43723t.fsf@alter.siamese.dyndns.org>
References: <loom.20100124T074722-510@post.gmane.org>
 <20100124081513.GA10700@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Russ Paielli <Russ.Paielli@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 24 20:08:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZ7ot-0004D1-1g
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 20:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727Ab0AXTIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 14:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621Ab0AXTIT
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 14:08:19 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54808 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517Ab0AXTIS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 14:08:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AA287933B6;
	Sun, 24 Jan 2010 14:08:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J5bwQTrFChBkpSZ1tfzlxOo/aPk=; b=er5yc0
	luc3GnEwStsEUGj2mGS3+2oRQN0wl06BGIkYZX39u9gCwdzDRCuR6OF+q9W8QiCy
	Dp8kpGvVkkmKjznDd2z0OIwLDQVmL1+tDUd4Yf3waLVyOd0Z6KqyZB+bA/CiLF1X
	3oitJrSzLH8q3DuKODA688pGuruJQNG/EBp/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N0n2wmeQ4Upg7Q+GB9uqbzixfLO9x3sS
	vI0/rfcolJJoxXSdeT1L030G88uOvHzg++qZ9ETTAm0fkNKZiQXQP/k/gkVbq7I0
	8UrpOWjuD3JJRW3Bsc9QgVO0CjvB+uly3bgzVfmzn09AY85FQqq4DQICFdjEFV2y
	qTndghDie0A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 76543933B4;
	Sun, 24 Jan 2010 14:08:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF107933B1; Sun, 24 Jan
 2010 14:08:07 -0500 (EST)
In-Reply-To: <20100124081513.GA10700@coredump.intra.peff.net> (Jeff King's
 message of "Sun\, 24 Jan 2010 03\:15\:14 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D0B27E94-091B-11DF-985A-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137911>

Jeff King <peff@peff.net> writes:

> On Sun, Jan 24, 2010 at 07:04:59AM +0000, Russ Paielli wrote:
>
>> warning: updating the current branch         
>> [...]
>> What does this mean in English? And what is the correct way to transfer my
>> revisions from my home computer to my work computer? Thanks.
>
> It means your workflow will cause problems as the pusher magically
> changes your repository's concept of "the latest commit" behind the
> pushee's back. The workflow you want is described here:
>
>   http://git.wiki.kernel.org/index.php/GitFaq#push-is-reverse-of-fetch

I saw somebody referred to this entry and refused to study the entry
immediately after seeing the word "firewalled", saying "my environment is
not firewalled", without trying to judge if the description applies to his
case.  This was understandable; the workflow will apply in non-firewalled
case just as well, even though "firewalled" case may be the easiest to see
why it is recommended.

Perhaps the title of the entry needs to be rewritten to clarify that this
is not _limited_ to a firewalled situation?
