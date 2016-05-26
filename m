From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 16/22] i18n: rebase-interactive: mark comments of squash for translation
Date: Thu, 26 May 2016 15:35:21 -0700
Message-ID: <xmqqwpmgtpli.fsf@gitster.mtv.corp.google.com>
References: <1464031661-18988-1-git-send-email-vascomalmeida@sapo.pt>
	<1464031661-18988-17-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Fri May 27 00:35:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b63sH-00011R-Fm
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 00:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755306AbcEZWfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 18:35:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55483 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754857AbcEZWfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 18:35:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C9AF1F4D1;
	Thu, 26 May 2016 18:35:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iiPqYGsU3QCQq65KenCPoyfOPTI=; b=YmRyNe
	sq1OwlMFsQ3Z6M4E3RzSv4A3QVNHEYVqkNXbSESoeUg/M4OnpE7p44ahDcSrDQFU
	d113hXDOIbcUDagq91foADQ8Zoqz9OYZgGEna6QoyEeREQeordQBHgytpFnmaj+O
	0O24YWMgbpAwX9GIbDTUL8p+6WnQUVSh1l2iM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lpP7qvPqIe1t5ZuYzaiP33FiWdeq3KFP
	W4VwScg8D5tdFiN784gALuBZnXxSRBgsytsuwxzJZd9KgvlxFJC42yzkDGbvC8Hi
	hy/C6h0LB0buRdtzHKRLBPBV9zWx46P7OVV4SKhNT3yobfcMZ/qk53lucuXByBcd
	Z4TWhQOyaYk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 314351F4D0;
	Thu, 26 May 2016 18:35:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 95CC61F4CF;
	Thu, 26 May 2016 18:35:23 -0400 (EDT)
In-Reply-To: <1464031661-18988-17-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Mon, 23 May 2016 19:27:35 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 22C51024-2392-11E6-9533-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295700>

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> Helper functions this_nth_commit_message and skip_nth_commit_message
> replace the previous method of making the comment messages (such as
> "This is the 2nd commit message:") aided by nth_string helper function.
> This step was taken as a workaround to enabled translation of entire
> sentences. However, doesn't change any text seen in English by the user,
> except for string "The first commit's message is:" which was changed to
> match the style of other instances.

If only the original were written as "This is the commit message
$N", you didn't have to do a lot of work like this, but such is
life.  Thanks for working on this.
