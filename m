From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A new way to get a sha1?
Date: Mon, 30 Jul 2012 11:29:27 -0700
Message-ID: <7vboixqf08.fsf@alter.siamese.dyndns.org>
References: <jv5tln$96e$1@dough.gmane.org>
 <alpine.LNX.2.01.1207301426090.25013@frira.zrqbmnf.qr>
 <7vipd5s161.fsf@alter.siamese.dyndns.org>
 <CACPiFCKxYdF8G33myfjOXU31cDWrfrtedve8m89tH_tfOCZ4ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Engelhardt <jengelh@inai.de>,
	Thomas Badie <thomas.badie@gmail.com>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 20:30:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svuj6-00066d-MU
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 20:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664Ab2G3S3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 14:29:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34518 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754658Ab2G3S3a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 14:29:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0826A88D4;
	Mon, 30 Jul 2012 14:29:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5x+cGkfxIk4GvCygFAgCBH26gTY=; b=wdZkg5
	U1QKyjoKE6Hq/BdNgfHYMdphUsUtu6Ts04mlO/om1jhq4IDQuC4cvtZnWogGPEl2
	Mq86AIgLYYwbrOvTAKCMLLm/bWe7TepsmGoU5bIbaFByGNu7oWiI/3KtbvS4cMVH
	cCn1yoCv/QKrG3OjOr5Pf3JHrVTJo452IyQxk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YFeT3tI2r1d4Y9/Ux9htVS3nt5M8UT9u
	1ZedCeqYravYUabFF1SjFCwRArV2HW5QzhcN2fDQNZCMAsk1jdhs3Xp6kGUOofG2
	gGMTTy8VLNnFLaDFJxr08I9lQzdSD562rjte5o59tWa0tKV/S1BlN8xHY9aWTlD1
	XsbSr9OQhmw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA0AE88D3;
	Mon, 30 Jul 2012 14:29:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 67A0988D2; Mon, 30 Jul 2012
 14:29:29 -0400 (EDT)
In-Reply-To: <CACPiFCKxYdF8G33myfjOXU31cDWrfrtedve8m89tH_tfOCZ4ng@mail.gmail.com> (Martin
 Langhoff's message of "Mon, 30 Jul 2012 14:16:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7FE0C1CE-DA74-11E1-BBA3-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202602>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> On Mon, Jul 30, 2012 at 11:45 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>         git show -s ':/^t1100-.*: Fix an interm'
>
> That doesn't work for me (git 1.7.10.4 as per Fedora 18 rpms) in
> git.git. But the idea is sound -- git can give you the sha1 trivially.
> You don't need additional glue.

The idea was that you do not have to give abbreviated SHA-1 to Git
in the first place.

What doesn't work?  My copy of v1.7.10.1 seems to grok the above
just fine.
