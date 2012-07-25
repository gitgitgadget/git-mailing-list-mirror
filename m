From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 4/7] Remove obsolete LONG_USAGE which breaks xgettext
Date: Wed, 25 Jul 2012 10:13:33 -0700
Message-ID: <7vd33jdarm.fsf@alter.siamese.dyndns.org>
References: <cover.1343227806.git.worldhello.net@gmail.com>
 <9f7ba1a0ce85184cc410bf7c2e8c3133f46f0237.1343227806.git.worldhello.net@gmail.com> <051a48c40cd144e36c4cd5798376d56bdc4705bf.1343227806.git.worldhello.net@gmail.com> <0aa19c8238587fc04616b67bc6dfa9c926fcfb5f.1343227806.git.worldhello.net@gmail.com> <cover.1343227806.git.worldhello.net@gmail.com> <6326c11afd7b4077f2aba27101fd9acc8e2f8b6a.1343227806.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 19:13:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su59e-0001C0-Sg
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 19:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618Ab2GYRNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 13:13:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54541 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751565Ab2GYRNj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 13:13:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7784D8540;
	Wed, 25 Jul 2012 13:13:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YAnIXlo0IIJFC3SZC2zv9DV5Q2s=; b=EQorFY
	nsUA/AnfeTRnPvR/ZbW4m4TIUu+4K0NMPqILrJrNXxQJcmFTox+vl5vafmupYcvo
	2vO9yjvVVTH7L/54TkFXO3S7AxshRn8PRhcE/+DQqDbf5sBVemZ+tv6LQLeg/az8
	jVgSIe+BMsL3RjB/RjqdJlkGiDGmoBptU/VFs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V3B5YKshuD0F1zjQoY/rdlvZouU07tVZ
	0HHH3vMskouoCuCQkyhptTKSFyRLSQ9sJrZz43URFA7SCsbzmFSAWmjjNkfZDBHE
	9vbSweOjlkwAvk92o0StOWJMjamtHUVWPinll7ZgwgwlQJa8Jq5dkXHXyBF1CbPs
	m9ff5dASc04=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64325853F;
	Wed, 25 Jul 2012 13:13:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 33EA6853C; Wed, 25 Jul 2012
 13:13:35 -0400 (EDT)
In-Reply-To: <6326c11afd7b4077f2aba27101fd9acc8e2f8b6a.1343227806.git.worldhello.net@gmail.com> (Jiang Xin's message of "Wed, 25 Jul 2012 22:53:10 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 114CF1C0-D67C-11E1-BD6C-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202177>

Jiang Xin <worldhello.net@gmail.com> writes:

> The obsolete LONG_USAGE variable has the following message in it:
>
>     A'\''--B'\''--C'\''
>
> And such complex LONG_USAGE message will break xgettext when
> extracting l10n messages. But if single quotes are removed from
> the message, xgettext works fine on 'git-rebase.sh'.
>
> Since there is a modern OPTIONS_SPEC variable in use in this
> script, it's safe to remove the obsolete USAGE and LONG_USAGE
> variables.
>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> Reviewed-by: Stefano Lattarini <stefano.lattarini@gmail.com>

I've retitled it and swapped the paragraphs around when queuing
this.  LONG_USAGE and USAGE are not just "obsolete" but completely
unused, so they should be removed, even if xgettext did not have a
bug to choke on their contents.

Thanks.
