From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2011, #06; Mon, 25)
Date: Tue, 26 Apr 2011 14:03:46 -0700
Message-ID: <7vliywd8st.fsf@alter.siamese.dyndns.org>
References: <7v39l6hqog.fsf@alter.siamese.dyndns.org>
 <BANLkTik+roEa_A1Zh=DTDGzP0ouJVReK1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 23:04:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEpQR-00036W-64
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 23:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758206Ab1DZVD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 17:03:58 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51711 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754071Ab1DZVD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 17:03:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3D2A24EF5;
	Tue, 26 Apr 2011 17:05:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W5w+ivk7gl2SHYgMqiJEX+YI0Os=; b=nKqCCh
	235cvmKwjx1KoyaQWYgYgFVHubM0cIIw6B1COpKUQE/Q/YC5o3z0ZpKCpw55KUKK
	eumOP22EYpRXElGbeG7219dMuKv9tteAoanRh8T6FKt8b9Q2C0q7V0rJ3ItUqByp
	kvDwF29xootelVH61KjC4R40S9TrOQurXEGIg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yNHOEBGzWubzV1D35t9ouMt6nI3kIUqZ
	Hr9ec9qI/a078omU41d5Ofx2CHVU2qanaEbsQOp+pQeqTNybLt1hBlwCPeRn0I++
	GXNM1INCK+nnSy9GVDl/VavZS3uQv1hfJA9CpokI9PWCYv566Y0td4Q/8BMKJ5Tn
	21DuZHy5nHs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 187F94EEF;
	Tue, 26 Apr 2011 17:05:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2E8854EED; Tue, 26 Apr 2011
 17:05:49 -0400 (EDT)
In-Reply-To: <BANLkTik+roEa_A1Zh=DTDGzP0ouJVReK1g@mail.gmail.com> (Sverre
 Rabbelier's message of "Tue, 26 Apr 2011 07:56:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F87D6250-7048-11E0-8F27-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172127>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Tue, Apr 26, 2011 at 01:11, Junio C Hamano <gitster@pobox.com> wrote:
>> The main part of this cycle is expected to run thru May, aiming for a
>> feature freeze in early June. We are at the beginning of week #1 of this
>> cycle and week #2 starts on May 2nd.
>
> I like the week annotations in this "What's cooking", in particular
> the ones indicating when something will be merged, it gives a better
> picture of what still needs cooking and what's just waiting for the
> "let's all focus on making sure 1.7.5 isn't broken" window to end.

The topics that were leftover from the previous cycle have already been
well cooked, and because there are too many of them, I just wanted to
leave a note on them for my own use ;-).

The first batch should be on 'master' perhaps starting tomorrow.
