From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: add new zsh completion
Date: Mon, 30 Jan 2012 10:52:22 -0800
Message-ID: <7vy5spauqh.fsf@alter.siamese.dyndns.org>
References: <1327881699-25461-1-git-send-email-felipe.contreras@gmail.com>
 <vpqwr89d1p7.fsf@bauges.imag.fr> <4F267AC9.1080407@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jan 30 19:52:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrwL8-00019k-SO
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 19:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819Ab2A3Sw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 13:52:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35064 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751890Ab2A3SwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 13:52:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 280E66EC3;
	Mon, 30 Jan 2012 13:52:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=95hL7bOUQOp8fW8en41vQCR904o=; b=YcHXhx
	dQWjV7lyjGemvKnBBA9RdFXM6io1ueEeGo2v9QYI7+q6bcRLIVsXKL/iou8VR/FB
	+qrbXtIw8E0AUu3Ju4StUbDEmRWp/5sumG1E/BrsK3C3IYdMeCZXAz/kCfm7loVD
	4lXbvcr+PZaTH7QQBx0XR3zPjoNHA0B/GzNBc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fHUZ/C/fy2v/FzuH4N8FXpy5qdDSzOQu
	QdsrEbpuIvDWWfsN/iyi6oeJjig5+PIHpWkpZFUEmtrVE7+9kKrLwc46W+YQfnwT
	6Ow1trXKIl+WMBNZmJWQu1+hAmooC294HVVajBd7hJ+N4GBWPwjzIlsQA1JmUrdZ
	1GflnkElkmE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 172036EC2;
	Mon, 30 Jan 2012 13:52:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95CD66EBF; Mon, 30 Jan 2012
 13:52:24 -0500 (EST)
In-Reply-To: <4F267AC9.1080407@viscovery.net> (Johannes Sixt's message of
 "Mon, 30 Jan 2012 12:11:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C601C1E-4B73-11E1-AAE8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189395>

Johannes Sixt <j.sixt@viscovery.net> writes:

>> Something along the lines of
>> 
>> ZSH_VERSION='' . $(dirname ${funcsourcetrace[1]%:*})/git-completion.bash
>> 
>> should do it (mostly untested, and written by a non-ZSH expert).
>
> Moreover, if zsh is POSIX compliant, the value of ZSH_VERSION will be an
> empty string after this statement. That may or (more likely) may not be
> what you want.

As this split-file is about only zsh completion, it can be as non-POSIX as
it wants, and it appears that zsh is not striving to be POSIX compliant,
judging from Felipe's other messages.

Whatever works for zsh is just fine.
