From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unhelpful "branch.master.remote = <nickname>" advice?
Date: Wed, 11 Nov 2009 11:54:45 -0800
Message-ID: <7vvdhgon0a.fsf@alter.siamese.dyndns.org>
References: <1257945756.26362.79.camel@heerbeest>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Nov 11 20:54:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8JHO-0003n3-Lc
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 20:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758803AbZKKTyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 14:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758633AbZKKTyr
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 14:54:47 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758520AbZKKTyq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 14:54:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 024DB981D5;
	Wed, 11 Nov 2009 14:54:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5DXJAwdqroPOyh/L4o9YJsqleJw=; b=pIYJAQ
	wquI/wMqiiJcHoJ0PtBuAzCDSGkmIabZXQ2iLMBluhhxZ5IG2BTusXwTIOZZg/bF
	H8bFp3X3UGZ4Jn3N+K3ZZ5C/VJKB+bJgUGlPgXLtmqGh8IMOJVKl43i9+vrixvhA
	n4enl3JV08t/xzjIYYzDi3ifF88ASr1LkH7rc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YLmOFvMX+PnnQSthKfKbjBxLDqVLWeyM
	gKAIzljs9uAFO1HGbWzKHgcQCKR/9HB5W8V15h9vk0DMyqv8IR/ORTbdBuYaoU6f
	vddXLPhKmAbLKbZiotlMwBx64TZb4NDix7MaKLuABtPtryG75JiYWAdgOfhLWR03
	KL30GzrV2ls=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D5DAD981D4;
	Wed, 11 Nov 2009 14:54:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D2504981D2; Wed, 11 Nov 2009
 14:54:46 -0500 (EST)
In-Reply-To: <1257945756.26362.79.camel@heerbeest> (Jan Nieuwenhuizen's
 message of "Wed\, 11 Nov 2009 14\:22\:36 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1217B430-CEFC-11DE-938A-B888BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132694>

Jan Nieuwenhuizen <janneke-list@xs4all.nl> writes:

> *) I've been wondering why GIT lacks a "update", ie
>    pull-without-merge command.  You almost never want
>    to git pull /without/ -r?

"You almost never want to git pull w/o --rebase" is incorrect, and you
cannot draw any conclusion from that statement.

I never want to run "git pull --rebase" myself, not in this project, nor
at work.  On the other hand, I always run "git pull --rebase" while
working on another OSS project that I am only following (I'm holding onto
a few private patches until they get applied).

So even the same person never uses --rebase or always uses --rebase,
depending on how he interacts with the repository on the other side,
