From: Junio C Hamano <gitster@pobox.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 21:18:43 -0800
Message-ID: <7v7hr041cc.fsf@alter.siamese.dyndns.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <7vaavwh6yh.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001291833580.1681@xanadu.home>
 <7vy6jgcutb.fsf@alter.siamese.dyndns.org>
 <fabb9a1e1001291618m71f61209v4f26fb66c6ad99ae@mail.gmail.com>
 <7viqakcu56.fsf@alter.siamese.dyndns.org>
 <ca433831001291701m50b8c2b7p16bcc6fd4f3f3d55@mail.gmail.com>
 <alpine.LFD.2.00.1001292013150.1681@xanadu.home>
 <ron1-F006CF.18381129012010@news.gmane.org>
 <7vbpgc8fhb.fsf@alter.siamese.dyndns.org>
 <76718491001292052x7f46d479lfeff7b66121502c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ron Garret <ron1@flownet.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 06:19:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb5jW-0005rl-86
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 06:18:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140Ab0A3FSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 00:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133Ab0A3FSw
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 00:18:52 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53917 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894Ab0A3FSw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 00:18:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BD581951A7;
	Sat, 30 Jan 2010 00:18:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AFKzZKHt6mFxaZCeKJs2dKSM7vw=; b=ZlnYYy
	Pcak+QiOBii34FMK3p4HtcDnIsomm6ds9AKxHNDdsKCJMTQ/8vl+4rjutlyludDX
	6s+6n+h9W2CmhaqvS/ltvWdZGt+nvaY9HgJhrsJ/pEOxFPezASDl1bXdamVT3PMK
	qqVyaD4XpwwUoU2HuVJ5LGw0eA9Ri6K396dPU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZYGL6HxY24w2C4m7UswdBuX6/LScJ51V
	2Xr+w0nRJojG+uZ6gFla7R0gHQ62eCVPpyPn2IUnlrK2UK9LhK2/OWhvFo6s0uxo
	yp+19JcFyyFTSrWhzB6+1wWqUOqCe+NwEKylXYEorWniNOpMtpIEuj7AZ6AJX6ZO
	ys9xmBos8MM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C439951A1;
	Sat, 30 Jan 2010 00:18:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C0006951A0; Sat, 30 Jan
 2010 00:18:44 -0500 (EST)
In-Reply-To: <76718491001292052x7f46d479lfeff7b66121502c3@mail.gmail.com>
 (Jay Soffian's message of "Fri\, 29 Jan 2010 23\:52\:18 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F22B9866-0D5E-11DF-9B43-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138446>

Jay Soffian <jaysoffian@gmail.com> writes:

> So that was a really long explanation, but I hope it clears things up.
> I think the disconnect between you and Junio is that you're thinking
> of branches in the DAG sense of the word, while Junio is talking about
> them in the context of git.

Yeah, in short, a "branch" is a point, not a line (or lines) of
development that leads to a point, as I said in the beginning.
