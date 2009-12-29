From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Wrap completions in `type git' conditional statement.
Date: Tue, 29 Dec 2009 08:58:35 -0800
Message-ID: <7vpr5xg1j8.fsf@alter.siamese.dyndns.org>
References: <44A6FDEB-71B6-42E1-99E3-D6A595FF1B58@metablu.com>
 <20091229200530.6117@nanako3.lavabit.com> <20091229150217.GB6152@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sung Pae <sung@metablu.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 29 17:59:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPfPP-0004je-70
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 17:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbZL2Q6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 11:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752218AbZL2Q6t
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 11:58:49 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51680 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbZL2Q6s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 11:58:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 113B9ABF76;
	Tue, 29 Dec 2009 11:58:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=nsJrVmTeFKERW/FYML3dM9nOTXs=; b=C9OgS7N+HGNBp4Tt04UFZ8T
	mIIRSiRkPdVp5udNizpZwEMbn+dcyWcuHY9xiYmHEkXaofUiY9RjpyJcQUkbdCAG
	V6Gcw2K+X4rZpT36kpCx11qAR3sagskosZjqlYZ9yeksb2kiJFvd+ZOT/lyi6X22
	ynj/mn3Z4OpKL0L8iIIM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=F0H4yh+a0kyz1wB0EFFZyYMspZArRT7gblcMXNdTFoAMATf+i
	PxiaTxdI9Ykp75VI8IuYPYmQad3/Mqq3NeQjiFV6EhTB8hOEyWDTOIPDxJf/YreU
	hDMoWN4BHQGwuyeqia2q5ZZwmtWreitojANAg0vL6dU9r3YG4PePsgWt0k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C4809ABF74;
	Tue, 29 Dec 2009 11:58:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3A358ABF73; Tue, 29 Dec 2009
 11:58:36 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6C0DF69C-F49B-11DE-8DCE-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135814>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Nanako Shiraishi <nanako3@lavabit.com> wrote:
>> Junio, could you tell us what happened to this thread?
>> 
>> The patch avoids failing completion script when git is not there.
>> No discussion.
>
> Actually, that's probably my fault.  I never sent an ack or nak,
> or anything else really, on this thread.
>
> Originally this was because the completion was trying to run git
> as it loaded.  In 1.6.6 this is no longer true, the completion list
> is generated lazily on demand during the first completion attempt.
>
> With the lazy loading, I didn't see a reason to add this ugly block
> around the entire script.

Thanks, both.
