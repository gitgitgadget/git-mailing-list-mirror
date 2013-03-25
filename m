From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git ate my home directory :-(
Date: Mon, 25 Mar 2013 15:02:07 -0700
Message-ID: <7vfvzjw334.fsf@alter.siamese.dyndns.org>
References: <5150C3EC.6010608@nod.at> <20130325214343.GF1414@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Weinberger <richard@nod.at>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 23:02:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKFTf-0000Ka-NW
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 23:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758961Ab3CYWCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 18:02:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60781 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752022Ab3CYWCX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 18:02:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4472B55C;
	Mon, 25 Mar 2013 18:02:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b3cqL1qtUj99JHhJONViPzJft8k=; b=t1zp3v
	+N53Ak9Z6mNEUfLIaqnLgqOdKr/teBkw7bF4qi1D4JM+yciBsN/smU9Qu3RyJwwa
	Nxy52hbudUHbcbN2eai1gRUjur2x39pmSCQGYtN9q9TeD7RNP1hzCXHHUj0++seo
	lzMoIlpwu85HBb2wqj4d0Tx/aU0DZVBlQAydQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iGkvxVDn7K/kU0H9Qgfq+omyKrSoJVHx
	3632FHFq6oq7M63mkUAaiSWb2oZpR0ouvI4FgkF6+KAgp0/7tevYB0VIZBLlt8xU
	o+s/imJCzquuOaYigDktfV+ZuDl7hRiCkCueVDtHIZWiUpPTN2H7hrAzVMTPgz7I
	qaYDE13xLGE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A705FB55A;
	Mon, 25 Mar 2013 18:02:09 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 224A9B559; Mon, 25 Mar 2013
 18:02:09 -0400 (EDT)
In-Reply-To: <20130325214343.GF1414@google.com> (Jonathan Nieder's message of
 "Mon, 25 Mar 2013 14:43:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A3937CFE-9597-11E2-8413-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219104>

Jonathan Nieder <jrnieder@gmail.com> writes:

> In git versions including the patch 2cd83d10bb6b (setup: suppress
> implicit "." work-tree for bare repos, 2013-03-08, currently in "next"
> but not "master"), you can set GIT_IMPLICIT_WORK_TREE=0 to avoid this
> behavior.

WAT?
