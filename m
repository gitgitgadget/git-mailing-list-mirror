From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 5/7] i18n: am: mark more strings for translation
Date: Wed, 25 Jul 2012 10:18:29 -0700
Message-ID: <7v8ve7daje.fsf@alter.siamese.dyndns.org>
References: <cover.1343227806.git.worldhello.net@gmail.com>
 <9f7ba1a0ce85184cc410bf7c2e8c3133f46f0237.1343227806.git.worldhello.net@gmail.com> <051a48c40cd144e36c4cd5798376d56bdc4705bf.1343227806.git.worldhello.net@gmail.com> <0aa19c8238587fc04616b67bc6dfa9c926fcfb5f.1343227806.git.worldhello.net@gmail.com> <6326c11afd7b4077f2aba27101fd9acc8e2f8b6a.1343227806.git.worldhello.net@gmail.com> <cover.1343227806.git.worldhello.net@gmail.com> <7483bb4c75600ac3ffd4f740040a4256ff70821f.1343227806.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 19:18:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su5EM-0005Ac-SF
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 19:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867Ab2GYRSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 13:18:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56742 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750766Ab2GYRSd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 13:18:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D84886B7;
	Wed, 25 Jul 2012 13:18:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CGDDId+TbWd9kFXjfTCNW63d/uU=; b=ifv2PC
	wXkHXy3ZycvO6xJakE9Baouff0mS17d0MEfMJCZ+XUtW0bmm87U2t5JExwOudE+l
	ACZ44v00Ugtvj54Aha0okDDK8gWdQEmG1tkhcSz2rOXfqJcycZgmCgDSqAnfLa7+
	+JoqxfOieIW8QY8FZpMK5C/ZZSyv6yWK2hJlw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IlurZAkzdW2L0k5N9vSayEpQ0RFz4okk
	1j90ddCqmJIhNItfY0aRRzo2asq5xVw0U2l4gUOupFPZesx1s8dsTDRqOnk68awW
	Fb+6YBOhFsAAdPNOsVhbLqHkB/kKah0Mbzd+oxNA5S+6HRsWnMHMmLbpfDQaZS8H
	flcURKfq4RU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE0CC86B6;
	Wed, 25 Jul 2012 13:18:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5AA5886B0; Wed, 25 Jul 2012
 13:18:31 -0400 (EDT)
In-Reply-To: <7483bb4c75600ac3ffd4f740040a4256ff70821f.1343227806.git.worldhello.net@gmail.com> (Jiang Xin's message of "Wed, 25 Jul 2012 22:53:11 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C1D30674-D67C-11E1-B28C-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202178>

Jiang Xin <worldhello.net@gmail.com> writes:

> Mark strings in 'git-am.sh' for translation. In the last chunk, I
> changed '$1' to '-b/--binary' for this reason:
>
>  * First, if there is a variable in the l10n message, we could not use
>    gettext. Because the variable will be expanded (evaluated) and will
>    never match the entry in the po file.
>
>  * Second, if there is a positional parameter ($1, $2,...) in the
>    message, we could not use eval_gettext either. Because eval_gettext
>    may be a wapper for gettext, and the positional parameter would
>    lose its original context.
>
> Also reduce one indentation level for one gettextln clause introduced
> in commit de88c1c.
>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> Reviewed-by: Stefano Lattarini <stefano.lattarini@gmail.com>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks. I've reworded the rationale for -b/--binary, though, as the
above sounds as if we are clueless as to how to i18n this message
properly even if we wanted to, which is not the case.

    Mark strings in 'git-am.sh' for translation. In the last chunk,
    change '$1' to '-b/--binary', as it is not worth turning this
    message to "The %s option has been..." and using printf on it.
