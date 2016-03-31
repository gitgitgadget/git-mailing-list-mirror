From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problem with Integrated Vim Editor on Win 10
Date: Thu, 31 Mar 2016 11:59:00 -0700
Message-ID: <xmqqtwjmmq2z.fsf@gitster.mtv.corp.google.com>
References: <CAAErz9i1=EOemq2qNijRwgY6MNmPJRhV+mFfeD1FZa5uPwvCJw@mail.gmail.com>
	<CAAErz9jeLPU+QocSKNssknoJdZoi4Sq0YfZiNnpf4wD70JKQUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Zachary Turner <zturner@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 20:59:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alhoF-0000TT-Pv
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 20:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758356AbcCaS7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 14:59:06 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54185 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757899AbcCaS7E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 14:59:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E58005151F;
	Thu, 31 Mar 2016 14:59:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+KVQdTFEXOu/x4xxZ7pNmsGnbM0=; b=QUvU9x
	5hF+tYy4/GcIlcQOQXyr3d/DEkeEx85/HKx5d8y6lc70Y+yHcOOX312au/eKnILG
	ZgYdw9xFS5NNyfDVL9QFLwQLZqFIhzHXT7eEoHYt40Bo2Zkdtydk56LOuUbFUHsx
	zcSLaxRYUMr+Lky4b4U18REmDZxR7Y2UL4/fM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qm4LuakKTlqUAjPCc6CYCXd6IpRcxGt3
	UOUng+le5W4pCA8CNi0fOEQNNWPsTNAcYpMB0S/YJEbK66dzUt+f3FYxtypySVUI
	w/3Guo7/9hYedBDmEvD6NQ75KRRJB5ycajYV44VKuUmlMnx9Y8jSJYHl1+dA4QVz
	SO7iqkJLSLM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DA7845151C;
	Thu, 31 Mar 2016 14:59:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1128651519;
	Thu, 31 Mar 2016 14:59:01 -0400 (EDT)
In-Reply-To: <CAAErz9jeLPU+QocSKNssknoJdZoi4Sq0YfZiNnpf4wD70JKQUQ@mail.gmail.com>
	(Zachary Turner's message of "Thu, 31 Mar 2016 10:20:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A1FF27EA-F772-11E5-8E20-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290447>

Zachary Turner <zturner@google.com> writes:

> I'm not terribly active in the Git community so I don't know what the
> procedure is for things like this, but this seems like a fairly
> serious regression.  Suggestions on how to proceed?

While the git-for-windows folks do read this list, git-for-windows
specific issues should be reported in its issue tracker on GitHub.

It looks like this issue has been reported already:
https://github.com/git-for-windows/git/issues/711
