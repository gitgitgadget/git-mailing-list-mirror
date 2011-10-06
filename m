From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Bug report
Date: Wed, 05 Oct 2011 17:44:54 -0700
Message-ID: <7vobxv3q49.fsf@alter.siamese.dyndns.org>
References: <1317763443.17036.15.camel@skyplex>
 <20111005072235.GA12600@kolya> <7vlisz8jur.fsf@alter.siamese.dyndns.org>
 <20111006003318.GA9015@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Federico Lucifredi <federico@canonical.com>,
	git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Oct 06 02:45:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBc58-00055H-4M
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 02:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935609Ab1JFAo6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Oct 2011 20:44:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47861 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935275Ab1JFAo5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2011 20:44:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE3AD6C5A;
	Wed,  5 Oct 2011 20:44:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WTBibJzU2t0F
	8AxvnmXuRyBo35U=; b=oyv+CGibLnydcE1w4OsxafOosbx+KqWJkwwvwABFMnXP
	Q7yCWvy1ZoqTmN33x65LZTx7Y6Yl+yz2bHUdQjyd3tXTgo5KDRpW+FGupIXkWsgO
	5cRtEG6U7Sex+5v2rhJrrZQ8LmqfCtLcbfkEWzrahgnh9fb/V8rp5Ls59FyDAcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=n7xLTe
	nOg6XmhquryPOLoSOcpq2ejYT3K3VzhLaxoC3wroHGfdMXEj1ty1oi4XSL44zxEW
	ke3P4lOc6/6AA++kdW7LcmUNhz3HOb0LC1AF5SI4xf/RDRz+oytPNpwo72cuiZ+x
	6IXIFIsnwDY5wU2xsyd6h93Ei+qP/oHxltOwg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5E826C59;
	Wed,  5 Oct 2011 20:44:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E3976C58; Wed,  5 Oct 2011
 20:44:56 -0400 (EDT)
In-Reply-To: <20111006003318.GA9015@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1b?=
 =?utf-8?Q?or=22's?= message of "Thu, 6 Oct 2011 02:33:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6985B9BC-EFB4-11E0-9492-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182909>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> And what about unreadable .git files?

Having then inside a working tree is so sick that I do not think it
deserves consideration.

Please don't troll immediately after a big release.
