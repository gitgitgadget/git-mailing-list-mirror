From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/5] stash: introduce 'git stash store'
Date: Mon, 17 Jun 2013 11:43:43 -0700
Message-ID: <7vtxkwd1cw.fsf@alter.siamese.dyndns.org>
References: <1371302006-29775-1-git-send-email-artagnon@gmail.com>
	<1371302006-29775-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 20:43:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoeP8-0001UM-NH
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 20:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549Ab3FQSnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 14:43:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53642 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750903Ab3FQSnq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 14:43:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA01228386;
	Mon, 17 Jun 2013 18:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hRhSOteYQhBLlTNgd48IB2tK/B4=; b=CLWfGg
	79Yne2yjKcKtp+Yer6NUDwQwGuFsIvOdDEenDAQ3lbNXALe6pHxEYNjJjNByJz3I
	Zn+KLh9u7xSFKMDhblu7mMF7/EvwLXqA84Lqrjt02/9nIxDangGXodTf3BvQKY6Y
	STqUObfGA9L6ElUdf033GVjeFgWwXJEV127To=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bQcjUXmsJaVrZk4JtRLl7XtITf8g5wHx
	/mdYk4dWJ8FF2TnXObFTF3gg0OSJnMFsvYk4CiTp7GqYmIKCT8Ya+UGKO3eIxWqw
	8YoFuyjsz+ge0+SR61j2/cMfPfEJ3HdCuriQFgyPuvacyg1AXsKs+kutaWQzZGgT
	Ss/prwAsdHU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE94628385;
	Mon, 17 Jun 2013 18:43:45 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6311328384;
	Mon, 17 Jun 2013 18:43:45 +0000 (UTC)
In-Reply-To: <1371302006-29775-5-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Sat, 15 Jun 2013 18:43:25 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D7191778-D77D-11E2-A2EF-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228098>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> +	test $# == 1 ||

This is broken under POSIX shells.  No need to resend (will locally
patch up).
