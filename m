From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] rebase -i: reword in-editor documentation of "exec"
Date: Tue, 18 Jan 2011 07:05:41 -0800
Message-ID: <7vwrm2l0ai.fsf@alter.siamese.dyndns.org>
References: <vpq62ziv788.fsf@bauges.imag.fr>
 <1281453472-29835-1-git-send-email-Matthieu.Moy@imag.fr>
 <20110116015941.GA28137@burratino> <20110116020132.GB28137@burratino>
 <vpq39otrvmk.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Kevin Ballard <kevin@sb.org>,
	Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jan 18 16:06:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfD8H-0003qO-Gq
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 16:06:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489Ab1ARPGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jan 2011 10:06:00 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62157 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312Ab1ARPF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 10:05:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7205F29EB;
	Tue, 18 Jan 2011 10:06:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hecLKpybWQyrvVHVRmrbTgPuYjg=; b=lmES6G
	6B9cB4z6SmtZbUlYf9DmNr7LcmM/y76m4w+qAg42NvXsaR1hCyGvmWxr+/BeQIZh
	vTnKhI2Tf8t2KiIxwNkQXw/J+lv1E1rOeDHXasuxzX9E+OYfH+UjYue8tKVqAnAv
	6x3waV6z+uQZMjbBJ0qgtAiZjN+xjveiXW0Cg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ttrRcBBe4HBjKaeK9cNigEgca1ZEf00S
	eDIgCnDHpKyqeIrCKe2L7U6gxpKF2vBuIzGINWtW8lsvJjlr3L1PPq37EXtwv6wn
	XNyKWOSCnBkHQHkZQ41pLoeQEbn4spbjvUE0eny/tQbJRcy5tlLKB9A+AVDGwhK+
	tkVAS5FbwcA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 10D9629E2;
	Tue, 18 Jan 2011 10:06:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 11B8E29DB; Tue, 18 Jan 2011
 10:06:27 -0500 (EST)
In-Reply-To: <vpq39otrvmk.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Sun\, 16 Jan 2011 11\:27\:47 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8BA5124E-2314-11E0-839A-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165200>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> -#  x <cmd>, exec <cmd> = Run a shell command <cmd>, and stop if it fails
>> +#  x, exec = run command using shell, and stop if it fails
>
> I don't think this is a good change to remove the <cmd> part. All
> other commands are used with
>
> <command> <sha1> <subject line>
>
> and I don't think the user would be able to guess that exec is
> different without a hint.

I tend to agree with you here.
