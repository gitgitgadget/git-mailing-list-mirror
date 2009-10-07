From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] completion: update am, commit, and log
Date: Wed, 07 Oct 2009 12:45:22 -0700
Message-ID: <7vy6nnt2ct.fsf@alter.siamese.dyndns.org>
References: <1254905331-29516-1-git-send-email-bebarino@gmail.com>
 <1254905331-29516-2-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 07 21:49:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvcVg-0003VM-Au
	for gcvg-git-2@lo.gmane.org; Wed, 07 Oct 2009 21:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759920AbZJGTqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2009 15:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759917AbZJGTqQ
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Oct 2009 15:46:16 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64809 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755133AbZJGTqP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2009 15:46:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D3A850471;
	Wed,  7 Oct 2009 15:45:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d8amy/mzQ1jy3y6eSsHFu50rVh4=; b=JMNVjb
	TYS0ivKFMMpyvrExEcYJLaKaz0Ph+EldiFcOE4U8Y+1AbnD+19HxzByNHw2kvDxz
	GRVJd9m2T+CZuWd21Fv9CgjM0VMOq+Ppgi4Bz6I3XciP9SB9B+9H1nuHB37x82tO
	JNTa+neIEsqWD8Q6f/2Vc/iLrGetLWGEpVOZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dKyL4z4oJhM+EfwpSlvMhZ0MjGssWuHx
	P8OwdbLD/U365zE/jnT8Nh9JwUCQ0RgYQRNTzFWy2HiksXJt/yW0uM6v+PYtMsjB
	mQ7lA/zgVnc8KgaHLxYRDA7aLYRw4ErqkOPzExcxjTpSm6teICU3gGficTcgaSO1
	NF6icUtNZ6M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D7D4250470;
	Wed,  7 Oct 2009 15:45:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C38135046F; Wed,  7 Oct
 2009 15:45:23 -0400 (EDT)
In-Reply-To: <1254905331-29516-2-git-send-email-bebarino@gmail.com> (Stephen
 Boyd's message of "Wed\,  7 Oct 2009 01\:48\:50 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F744AC3C-B379-11DE-B562-E80E3AD9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129654>

Stephen Boyd <bebarino@gmail.com> writes:

> git am learned --scissors, git commit learned --dry-run and git log
> learned --decorate=long|short recently.
>
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>

No objection from me, but I am not a completion expert ;-)  
