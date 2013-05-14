From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-bzr: update old organization
Date: Tue, 14 May 2013 15:05:39 -0700
Message-ID: <7vvc6lfc98.fsf@alter.siamese.dyndns.org>
References: <1368505227-16661-1-git-send-email-felipe.contreras@gmail.com>
	<7v1u99lb8w.fsf@alter.siamese.dyndns.org>
	<CAMP44s1rZmo3cQecGmYVMZ7KSq=z3_mfVnAK+so4QL_JfEe_uw@mail.gmail.com>
	<7v8v3hi9ix.fsf@alter.siamese.dyndns.org>
	<CAMP44s2B3bFWXZe0aL_GMXe_56MbhSZXf-65rT364nY3shYwUA@mail.gmail.com>
	<CAMP44s16VD+Rm5J=TXxQB+pKhpzHqoxBXSSwDvi0CVW2u2J=5g@mail.gmail.com>
	<7v4ne5i7lf.fsf@alter.siamese.dyndns.org>
	<CAMP44s0CgYs9s1ac1EEqhP8XusScj39zY6CcQyMxSnh6i-V6SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 15 00:05:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcNLu-0005WY-Lk
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 00:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758605Ab3ENWFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 18:05:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47535 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758584Ab3ENWFl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 18:05:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 248371FB27;
	Tue, 14 May 2013 22:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QfFjzrvKRdOKuyR/LV/qKSH3K1I=; b=EuLssI
	XnW9NkLy3wVeQzo5H5zSQIHx01eszvQLyYj/oKY1+icsihTU8TLnj3p6XUxaEfOn
	Ut5p4y+NMrISeGjE3fE2m2Kx2A34Twy9SBIYCFBVn3Ijm79/Lstt4eaO6o3Y9bC1
	A1a82OBaTcfE7LDqdMClwDP27HoMjCUMrsMAI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GUzK7irpkgcLPQBvHzFW8n62yj6RhJbH
	hl/0WsARAnwzQD4kZ4KEclunP5oiEBpl+eoOBBYMgXNaf6L2TNIz62s4+1LEqdIu
	dos4Blk4wUqRqfrqbtI6fnvyzXU16KjBdCzd/I4bjdOpZr7H2+iHC2aVKgD1ZjeS
	oWW8t2cPzmE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C8EC1FB26;
	Tue, 14 May 2013 22:05:41 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 957C21FB23;
	Tue, 14 May 2013 22:05:40 +0000 (UTC)
In-Reply-To: <CAMP44s0CgYs9s1ac1EEqhP8XusScj39zY6CcQyMxSnh6i-V6SA@mail.gmail.com>
	(Felipe Contreras's message of "Tue, 14 May 2013 16:38:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A470CDC-BCE2-11E2-829C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224354>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> And the clone would happen either way, with or without this patch,
> because 'hg/origin/master' doesn't exist, the only purpose 'hg/origin'
> serves is to block the new feature.

That is the answer I was trying to extract out of you (I take the hg
is a typo for bzr in the above, though).
