From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unapplied patches reminder
Date: Sun, 18 Oct 2009 16:31:59 -0700
Message-ID: <7vzl7ogtxs.fsf@alter.siamese.dyndns.org>
References: <20091019052030.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: "Rolf Bjarne Kvinge" <RKvinge@novell.com>,
	Per Strandh <Per.Strandh@q-matic.se>
X-From: git-owner@vger.kernel.org Mon Oct 19 01:32:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzfEk-0005uX-8Z
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 01:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755586AbZJRXcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 19:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755579AbZJRXcG
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 19:32:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43342 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755575AbZJRXcF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 19:32:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D2CE5EC52;
	Sun, 18 Oct 2009 19:32:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=p8860X4oNX5Ad6HsnuLip43we8k=; b=slfazomVjDQl6H3p+hC36oe
	E02+qthSmHdR3yogP8YAVMr+U0LkQALlGkEop10NBFm5gdEG3qmwW7JIwokDqAIs
	Rd/ntMHogXPuHhnvBFDkN+p+gYkCVJU+qcJSXONK2eD0YbH+xesVaJIYhoo82kay
	GcogqphGvg8XlCLMqgBY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=C3K34Lp/0YJYOR2imbeGcw0WKOCKPjtuRh638SL0fEzfpDLNf
	5FZEeKftK94E8FowUyC+keR9sfHn9n7uud9WfWtVgKiJ0gU30gYb+nqQvVDsrnnv
	b01SXLpPr1hI2eOhcx7+XPT9k5OZ4JSUiOPmwH4yYhOCHcAECf4jSWZzO8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D9CB05EC4E;
	Sun, 18 Oct 2009 19:32:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 20A7B5EC4D; Sun, 18 Oct
 2009 19:32:01 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 72429710-BC3E-11DE-9E9A-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130623>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Junio, I saw these patches and thought what they try to do were 
> sensible, but I don't them in your tree. I didn't see much discussion 
> on most of them, either.
>
> Because I don't read C very well, I may have listed some patches 
> here that you may have discarded because the code was no good, and 
> if so I apologize for wasting your time, but I thought at least 
> some of them should be salvaged.
> ...
> From: "Rolf Bjarne Kvinge" <RKvinge@novell.com>
> Subject: git rev-list --pretty=raw strips empty lines
> Date: Tue, 06 Oct 2009 14:33:37 +0200
> Message-ID: <op.u1do6bq5k71drc@linux.lacasa>
>
>     It seems like the --pretty=raw format strips off empty newlines from
>     the beginning of log messages, while I'd expect the raw format to
>     not do any transformations (just as the documentation says: "The
>     'raw' format shows the entire commit exactly as stored in the commit
>     object").
>
>     The below changes works for me, not sure if I'm right about this
>     though (my first time here ;-)

I do not recall seeing this one; most likely it was lost in the noise,
especially because it did not look like a patch submission, without having
anything resembling a commit log message.

I think the change itself is an uncontroversial one, even though this
really changes the behaviour.

> From: Per Strandh <Per.Strandh@q-matic.se>
> Subject: [PATCH] git-p4: Fixed bug that didn't allow spaces in the depot
> Date: Tue, 13 Oct 2009 22:09:12 +0200
> Message-ID: <65D9329CA2AF94438F542D48F2A42E830F95F51514@GOT-SRV-005.QMATIC.local>
>
>     git-p4 clone (and sync) did not work if the specified depot path contained spaces.
>     Fixed by quoting the argument to the "p4 changes" and "p4 files" commands.

I do recall ignoring this one because (1) I never use git-p4 myself and
always rely on Acks from people who have been involved in it, and (2) the
message was mangled (perhaps it had two or three copies of patches as
attachments).
