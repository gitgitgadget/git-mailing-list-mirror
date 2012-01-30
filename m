From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] completion: be nicer with zsh
Date: Mon, 30 Jan 2012 10:07:27 -0800
Message-ID: <7vpqe1cbds.fsf@alter.siamese.dyndns.org>
References: <1327880479-25275-1-git-send-email-felipe.contreras@gmail.com>
 <1327880479-25275-2-git-send-email-felipe.contreras@gmail.com>
 <7v8vkperli.fsf@alter.siamese.dyndns.org>
 <CAMP44s0rp1EwruAwMpntcUzKS=Pbe44t7Eq0OcHdH8WF7OoUhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 19:07:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrvdg-0002Vd-1U
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 19:07:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555Ab2A3SHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 13:07:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49105 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751784Ab2A3SHa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 13:07:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87F1B6514;
	Mon, 30 Jan 2012 13:07:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=odY7JqxTSd6bHp8V9PQTfWACSXs=; b=bKO/kP
	fpcADcCmRdcfiqBPiL4Srb7fHrbSYpUqqID0PcNLKQGrDCh9Vx9akrer4iMjJIL0
	Y5Al9CX9o6So518CuyiQL5lhBnYvS2GRi1hVcmzJOtA+I+E+aveRbmfhnvy/12xl
	nMmihSxwATicdu9GSbC98t640sABXLKV5cdjc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UTZf2Ux+0h3ROFUj6wmC47gThpe8UXPx
	eeFPaaO+oF3ndIH7YBvgvL+7yWSJZhf6Jhu2Z+E8xJfUZ9WdhIg5m1WvMbj/2RZH
	5Mm07VUGiMk6a7FZlrBLUmdip7DI9xiPLVSIDuA48VNdU6HbgmZDkaOSq8MQqqMg
	eyXqW8I2r7s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DF976513;
	Mon, 30 Jan 2012 13:07:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 123B86512; Mon, 30 Jan 2012
 13:07:28 -0500 (EST)
In-Reply-To: <CAMP44s0rp1EwruAwMpntcUzKS=Pbe44t7Eq0OcHdH8WF7OoUhQ@mail.gmail.com> (Felipe
 Contreras's message of "Mon, 30 Jan 2012 12:35:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 45B537DC-4B6D-11E1-859C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189384>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> In any case, there's no need for ad hominem arguments; there is a
> problem when using zsh, that's a fact.

There was no ad-hominem argument at all.

Read your two lines I quoted "... the code is now actually understandable
(at least to me), while before it looked like voodoo", which was your
words.  What does it tell the reader?  The patch author (1) did not
understand existing code (voodoo) and (2) the change is a good thing as a
style/readability improvement.

I was saying that I did not want to see that in the justification, because
(2) is not true, while (1) may be.

The patch as-is is a good change that works around issues with zsh's POSIX
emulation, and that is sufficient-enough justification. IOW, we are in
agreement on the later half of your sentence.
