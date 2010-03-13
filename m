From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 09/12] docs: use <commit> instead of <commit-ish>
Date: Sat, 13 Mar 2010 14:05:59 -0800
Message-ID: <7vwrxf6fnc.fsf@alter.siamese.dyndns.org>
References: <1268455984-19061-1-git-send-email-lodatom@gmail.com>
 <1268455984-19061-10-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 13 23:06:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqZTS-00069k-37
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 23:06:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759327Ab0CMWGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Mar 2010 17:06:12 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56940 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754530Ab0CMWGG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 17:06:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 22FC9A1349;
	Sat, 13 Mar 2010 17:06:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/0chGpRcLGaYnoRzfAeu8UVVGxI=; b=nEjPNn
	xw63TDg/hanQl+yEgwuhkdONXXMqDva3PAVEN49ug4fOsGXt/UlDViFhYsk1g2Ec
	R8hlAc3E+NGv8zioH9CXPaAapDRV/n0wE87gRKXSHnzFVoXaFyJS+5aEUj2yEiNl
	KZiZuO7eMQciAEcBeVr/sYUvXqGpeySJiPBtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yv+dJjw/+Y4EiOxqr2wEAnjfET2PydYb
	oWXt1eURnwQxEjUgqYsf8NQrNCGi0V9lWKvSXBpMqPyL3bU2FGTEevLf2Uwni6nP
	nr47eefmLkdPFOj8RzXms4eQpA7OmC/2ZbGEQVgz3Lpp8rXCVCbVfwC2hHYmLhSD
	WT1j0XfylUw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 012D2A1346;
	Sat, 13 Mar 2010 17:06:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6959EA1345; Sat, 13 Mar
 2010 17:06:00 -0500 (EST)
In-Reply-To: <1268455984-19061-10-git-send-email-lodatom@gmail.com> (Mark
 Lodato's message of "Fri\, 12 Mar 2010 23\:53\:01 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9D3E9998-2EEC-11DF-945F-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142114>

Mark Lodato <lodatom@gmail.com> writes:

> There exist no commands that accept a <commit> but not a <commit-ish>,

I have one worry about this and [07/12].  The droppage of -ish would make
sense from the point of view of describing command line arguments,
i.e. what you can give to the commands, but it would make it impossible
for us to talk about places that _only_ tree not arbitrary tree-ish can
appear.  For example, don't we ever talk about something like this?

    A tree object is a sequence of records, each of which describes the
    type of entry, object name, and the name of the entry in the tree.
    When the type is "tree", the object name must name a tree, when the
    type is "gitlink", the object name must name a commit, ...

Other than that small worry, I think the series goes in the right
direction.
