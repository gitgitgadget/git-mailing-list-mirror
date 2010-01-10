From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to check new commit availability without full fetch?
Date: Sun, 10 Jan 2010 12:38:07 -0800
Message-ID: <7v8wc5itlc.fsf@alter.siamese.dyndns.org>
References: <ee2a733e1001100312j786108fct1b4c8abd0acc5afc@mail.gmail.com>
 <alpine.LFD.2.00.1001101501520.10143@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Leo Razoumov <slonik.az@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Jan 10 21:40:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NU4ad-00016D-0G
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 21:40:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752511Ab0AJUiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 15:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752144Ab0AJUiR
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 15:38:17 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41028 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108Ab0AJUiR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 15:38:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AC71B8FC2C;
	Sun, 10 Jan 2010 15:38:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K8LJyfG3NAM5p1ZAwnU+rRa4EuA=; b=cUOLkG
	GO9WaxCJ8gwRurGvMvcb9E8nyAxJDtLykisPY3R4YoxLz4XsYa7QHTQ2NVB/Sk6G
	al31G4Tscbx2Zviw45qv/5fHfNqG8pbDXnNFlqmFUA3mE+x4k/rzPOCBVIU+4fix
	vGcQ8IW1wZf1KUDi1O8vc0UVH/75XNLoz8nc0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MoCrxK3rUoGJsUQTxQaGfJ/SXxJhHs7B
	kTWIaT13mbxKxOUss0DpNNTAXVpPLS4JjxraETqTGFVMU7BPrbO/8UajVRhcEhdg
	vNotR/jr6t7whMMce/Us5SL+gv3rNQ5be5EjcbeCUwkQJxzPHj+peMne9IU8KtPB
	hENG50UJyxo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C6C58FC2B;
	Sun, 10 Jan 2010 15:38:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C208E8FC28; Sun, 10 Jan
 2010 15:38:08 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1001101501520.10143@xanadu.home> (Nicolas
 Pitre's message of "Sun\, 10 Jan 2010 15\:13\:49 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 122CB4E2-FE28-11DE-B4AE-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136588>

Nicolas Pitre <nico@fluxnic.net> writes:

>> I am sure I am not the only one with such an itch.
>
> Maybe you are. There is very little point knowing that the remote repo 
> has new commits if you're not going to fetch them, so I don't understand 
> why you need this.

A feel good factor is in play?  IOW, "I am short of time, so I won't be
able to really afford to 'git pull' and test the result of re-integrating
my changes to what happened on the other end.  If I can learn that there
is nothing happening over there, then I won't have to do anything and know
that I am up to date."
