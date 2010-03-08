From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Some information that git diff saves and that git status does
 not
Date: Mon, 08 Mar 2010 13:38:15 -0800
Message-ID: <7vpr3emr3s.fsf@alter.siamese.dyndns.org>
References: <loom.20100308T111146-322@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergio <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 08 22:38:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nokek-0007R5-Fj
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 22:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755746Ab0CHViZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 16:38:25 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49632 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755252Ab0CHViX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 16:38:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 73796A09A4;
	Mon,  8 Mar 2010 16:38:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8ikAOE9vNgJQJC42xhGU6S4I188=; b=WRDXL2
	WnlJxVzx9wASjPrqN97zfctgMItzu0jcSLmu1+nks9QHzO5dd39xfaIfiLBM8YOe
	iSB44Wml81jPn8UfWk42SdsJL0vq7hbcAik8GLk5QF7c7qPX4WqqyZQnNOtZJV/v
	UYcYI61GaOLdwurv0OFoKqPyipNUNEC/gGVvs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fvL5bBKuEvcJuewGg62hMpzxyllyilj/
	sp/hL1NQSjlCSgohpe+zPdfcrot1EbD1NP/Bo+UAbE8LK/+xUCv+h9Ufe3vX777q
	ZJyfnDPo2LodV1xisFICZ5MzdgEwSIFNrBJR4CgvpvtMNfSuyTa89sDTqfSbqdcq
	zLPCGdVA/Lk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 27B0AA09A1;
	Mon,  8 Mar 2010 16:38:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62DD9A099C; Mon,  8 Mar
 2010 16:38:17 -0500 (EST)
In-Reply-To: <loom.20100308T111146-322@post.gmane.org> (Sergio's message of
 "Mon\, 8 Mar 2010 10\:46\:51 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EA0CBBCE-2AFA-11DF-951D-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141789>

I didn't fully read what you wrote but after you copy a repository from
one to another outside git (be it done with unison or rsync), you should
run "update-index --refresh".
