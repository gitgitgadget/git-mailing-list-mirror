From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-jump: ignore (custom) prefix in diff mode
Date: Mon, 17 Sep 2012 20:57:42 -0700
Message-ID: <7vsjagoudl.fsf@alter.siamese.dyndns.org>
References: <1347844915-4130-1-git-send-email-git@shiar.nl>
 <20120917030143.GA19986@pearl.mediadesign.nl>
 <7vy5k9w7eh.fsf@alter.siamese.dyndns.org>
 <20120918025229.GB19986@pearl.mediadesign.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Mischa POSLAWSKY <git@shiar.nl>
X-From: git-owner@vger.kernel.org Tue Sep 18 05:57:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDowb-0005tn-Q9
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 05:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932762Ab2IRD5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 23:57:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36985 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932728Ab2IRD5o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 23:57:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4830D87A0;
	Mon, 17 Sep 2012 23:57:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oAUyIfBz1zahuu7Wulxw7Wu19lc=; b=VUDZ2N
	LInhQjBfnossbOTyAVcd7ju8g7J/oJefpee+4fkKD9ZGmR9rUe3LYEDocsC3rW57
	tDTO9jHNFr/PmGl55kCPmg1Y8F0ndE+3oKous8d+wvw5njnp/FZexSCu8hr5Okx5
	CrLVDcUH+UyvtKbRzE3nDUV6mTsRX80KBZuFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=elS+v7fUeGmg0cq7zIAFaCQak0CFqVXB
	HCl7kz/0yNK7mw+Sla/F+Ol0Oy+4kNRwA7fUTsTMb0G64E6fYe+JvS5ZSkAQJC2G
	yvsso859f+1a5AC6Rj7WxE1xuJLs28//mlqqegafLk51V4wTaaRQTUnigzYn/ly2
	rPXgeYWjBpY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32699879F;
	Mon, 17 Sep 2012 23:57:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A01D4879E; Mon, 17 Sep 2012
 23:57:43 -0400 (EDT)
In-Reply-To: <20120918025229.GB19986@pearl.mediadesign.nl> (Mischa
 POSLAWSKY's message of "Tue, 18 Sep 2012 04:52:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FFDD5134-0144-11E2-87DB-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205787>

Mischa POSLAWSKY <git@shiar.nl> writes:

>> Perhaps you had configured your diff.noprefix in a wrong
>> configuration file?  This is primarily per-project choice, and your
>> clone of git.git should not have diff.noprefix set, neither your
>> $HOME/.gitconfig unless you always work on projects that want
>> diff.noprefix.
>
> Then I'm not using it as intended.

I would imagine that you could do

	(in ~/.gitconfig)
	[diff] noprefix

        (in ~/git.git/.git/config
        [diff] noprefix = false

or something.
