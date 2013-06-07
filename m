From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/8] Rebase topology test
Date: Fri, 07 Jun 2013 09:43:31 -0700
Message-ID: <7vppvxub0s.fsf@alter.siamese.dyndns.org>
References: <1370292135-1236-1-git-send-email-martinvonz@gmail.com>
	<1370585503-11374-1-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 18:43:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkzlL-0001kb-5N
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 18:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769Ab3FGQne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 12:43:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41362 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753657Ab3FGQnd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 12:43:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09A48262A3;
	Fri,  7 Jun 2013 16:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kqiw2+e9jpZ9QD0Ke1J3uA041Vw=; b=UoR8fG
	RorKqNHlnz/U01+CGMT8bDtkVIRQG+NemUv2HsA9Gmg4JlX+J6wLCRINKAy0HTm9
	I4qG3RG9FQJ/zg+Z/dW3e3kXWzgAHSTW6ZpwJSiuQNOeCQHg7WQiP8w7es35ErR3
	n17ue8bK+nom4FwMU2DxjM2MPlhpUGm9yVFdg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MyeNYgHs2fFuYA9GLTKfh+HKDHZn9yyX
	eBGrnjQZPGVgULsTYv6sAKUBfZjwacxflC91tPu3X19kjBAA2zyLdPxR0QXGzrLz
	tMgjh5cl1792/77qn+k7uzi+MTzgZf4OqhB3CQk0wUC6ULLS6Ffri8JKNgUmM1AK
	f1Mlpn/sd84=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00738262A2;
	Fri,  7 Jun 2013 16:43:33 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C4732629F;
	Fri,  7 Jun 2013 16:43:32 +0000 (UTC)
In-Reply-To: <1370585503-11374-1-git-send-email-martinvonz@gmail.com> (Martin
	von Zweigbergk's message of "Thu, 6 Jun 2013 23:11:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 63BEE418-CF91-11E2-9379-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226646>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> Changes since v5:
>
>  * Improved test_linear_range
>  * Changed TODOs to be about consistency, not --topo-order

Thanks, looked sensible.
