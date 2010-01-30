From: Junio C Hamano <gitster@pobox.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 21:21:23 -0800
Message-ID: <7v1vh8417w.fsf@alter.siamese.dyndns.org>
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
 <alpine.LFD.2.00.1001300011290.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, Ron Garret <ron1@flownet.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Jan 30 06:21:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb5mC-0006XB-CO
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 06:21:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174Ab0A3FVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 00:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040Ab0A3FVj
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 00:21:39 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55534 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919Ab0A3FVf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 00:21:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9044095216;
	Sat, 30 Jan 2010 00:21:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=F4O6q5ej/Olaf7X/IjcKpbVjubw=; b=FGgGUp
	eAnmNAKZYYgGf38BChC39iVY2vcDDH6grX5XvIFSiEOA36fVJ1XWQala7L7dy+Qc
	DYbmeAq5/uzLQt64+0P1FZ4B/pq49ZNnwEpI4JDD71Y1K33YgcfsfDO9J7K8RHc4
	XSOO4jEZ5ZBifHuHYInnzCTz4K2hfIa6Nhbh4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tQnpE5H4RsW3VQ8+nVRtj6Z6qd7UyzCG
	KCvmbbZiPiecnI9/sGH1z1bbwJYMbCeqUHGbFSCKpfsY+SxjFz6dzl0lTKnUP0QT
	YxqoUKNHlQ2XiUnCi3yMRQtdrnMvuLnWq6apUgf7USdobgta2OJjH35Qr1gN2+sU
	busraKXccqo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F36D951E1;
	Sat, 30 Jan 2010 00:21:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E682951E0; Sat, 30 Jan
 2010 00:21:25 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1001300011290.1681@xanadu.home> (Nicolas
 Pitre's message of "Sat\, 30 Jan 2010 00\:15\:06 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5294E4AA-0D5F-11DF-9B43-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138447>

Nicolas Pitre <nico@fluxnic.net> writes:

> Could you please take this really nice explanation and make it into a 
> patch adding a "Detached HEAD" section in the git-checkout.txt manual 
> page please?

Good suggestion.

I'd be happier if the description didn't say "SHA-1", but instead said
"object name".

Also it would be nicer (just a personal preference) if a picture that
forks only one branch forks it upwards, like this:

             o---o
            /    
    ---o---o---o

not downwards, like this:

    ---o---o---o
            \
             o---o
