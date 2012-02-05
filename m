From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Specifying revisions in the future
Date: Sun, 05 Feb 2012 13:59:33 -0800
Message-ID: <7v7h01eybe.fsf@alter.siamese.dyndns.org>
References: <jgjkk0$qrg$1@dough.gmane.org> <vpqipjlf309.fsf@bauges.imag.fr>
 <m21uq9x8q2.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, jpaugh@gmx.us,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Feb 05 22:59:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuA7Y-0004pJ-7t
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 22:59:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857Ab2BEV7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 16:59:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55168 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002Ab2BEV7f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 16:59:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE2F46045;
	Sun,  5 Feb 2012 16:59:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JAxMgXhVE2tkV76y4D6edYavUlY=; b=x1ev4w
	t50NveFpFYX2gX4MixR57yx22+1KMvYhMQewKOgsLuifrZdN8FisMFRCB3/oogiQ
	XyEWzocuA6J31W/s97ixtkaHd1LRdd95DNYGowSKsTdD9RZiJWBM/Xk36DVPAQ3n
	TIZo5ynKrvOOU4bWwnmnITHh2IpKoCSTiJYlg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EzIJM9ZEcvE3PsVSaHc2icr4Ai4mQzCg
	j1Us9qnVztrOapzbXS0KpFT29M00WHeLOGe6kJGRWwIuU+W9Jf4alzP0KuuOOySF
	Zs3XLOU1mH81r1sel9Hx+tfCfHhdm1Tbw/0dYBnh9C1vC/FJ4WfeFR/yI+OnOwEU
	iOjczE1v5dE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D498E6044;
	Sun,  5 Feb 2012 16:59:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C9736043; Sun,  5 Feb 2012
 16:59:34 -0500 (EST)
In-Reply-To: <m21uq9x8q2.fsf@igel.home> (Andreas Schwab's message of "Sun, 05
 Feb 2012 22:37:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B05AC058-5044-11E1-820C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189973>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> "the successor of <commit>", OTOH, is not well defined, since there can
>> be several successors, and one can't order them reliably (you can't
>> really know the set of successors, because they can exist in different
>> repositories).
>
> Yet it would be nice to have a concise notation for "the nth successor
> of <commit> towards <commit>" (using --first-parent ordering when
> ambiguous).

I thought that 47 different people can build on Linux v3.2 and when you
ask the children of v3.2^0, you would not know which ones to show in what
order, let alone "concise notation to pick one at random among them".

Did you mean --first-child?
