From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push not resolving commit-ish?
Date: Thu, 23 May 2013 14:21:25 -0700
Message-ID: <7vy5b5crze.fsf@alter.siamese.dyndns.org>
References: <20130523105310.GA17361@redhat.com>
	<CAMP44s18KCYEZaMTn_S2znocyr-WDCT5ciuzLoYaSHPQFc4XCw@mail.gmail.com>
	<7v4ndtftyf.fsf@alter.siamese.dyndns.org>
	<20130523211647.GC31421@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu May 23 23:21:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufcx2-00037j-Jx
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 23:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759066Ab3EWVV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 17:21:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38964 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758563Ab3EWVV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 17:21:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C111B22F21;
	Thu, 23 May 2013 21:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y40SZNfRX+FEtLQHwtoVXV7yWPk=; b=C6h6l4
	T8fKiLJ+mHXBqPDZ2NfD+LRBNpVjmrPw4M4yuvasbyoIW7oa9fXNkjBuxXvWgj6M
	a8SGBH4uXN+2CKD/XaXGl1oUClkU9oF4SIMZTYBuBVlEgj1ke0yZObgkI2f2NZS+
	rg5h3WHJa5EAMnwGZPXSroVxFxu+bfUiUp63U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s70FezIePSTs1NoWFVHBuLbL5DMgNl4o
	XMcHMzUzdnttFLcyjQa0ourrtwxbtUskqQCMt8XR3snORNZ6Lta3MdqRztdmYp9w
	YoAC5YRLoIXKDKpcJhIDdPwnzyAsXGXE6nKH06FV+9eojXmKEMy1miT5sJaNjvUQ
	ocwSg2HMtHk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B00DA22F20;
	Thu, 23 May 2013 21:21:27 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B79122F1F;
	Thu, 23 May 2013 21:21:27 +0000 (UTC)
In-Reply-To: <20130523211647.GC31421@redhat.com> (Michael S. Tsirkin's message
	of "Fri, 24 May 2013 00:16:47 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BA651E1C-C3EE-11E2-AE59-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225299>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> It's a tag and not a branch since I need to sign the tag.
> I push to a branch and not just the tag since this way
> people can track it and do downstream development on top.
> So pushing the tag to branch would save me some churn.

It seems our messages crossed.

Everything you said before the last sentence makes sense to me, and
if the last sentence were "pushing the commit that is tagged to
branch", it also makes sense to me.
