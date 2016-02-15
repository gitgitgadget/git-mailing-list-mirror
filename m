From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2016, #04; Fri, 12)
Date: Sun, 14 Feb 2016 20:50:55 -0800
Message-ID: <xmqqy4amr2z4.fsf@gitster.mtv.corp.google.com>
References: <xmqqfuwxtrni.fsf@gitster.mtv.corp.google.com>
	<56C07182.1040804@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 15 05:51:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVB7u-0004Va-1H
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 05:51:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbcBOEvF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2016 23:51:05 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56855 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751724AbcBOEvE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Feb 2016 23:51:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A9AA9446E7;
	Sun, 14 Feb 2016 23:50:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PTTTay2pptLx
	/VMgsIqqYtE+Uyw=; b=YrWwLlS0PvLOwkif9SWOQ/Wsh/pnGysXFmh5E71AYQBn
	7pGwEpLTia49LXiyQ8ElDAeW4paovJeXK/4nbat/3nnsl8pNr0l4QCNbGM0RiEdH
	ivdfdgbfNbD5oc7Ldk9myL0LmUZLvTju2vTJlXzfACUhc78kmWK3Cg2/qii1t68=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rhLXxP
	ARIePBa1XFZAeIrV+t1InZmJwPgHnhcEAcUfNAexqX7TrY3hIbHqu5Fuk95BigcU
	VUKTZzeCIeRjk8ILu4++CdSq89IqHeOcKYfOs6NT9Ukufnzg/gImL0LsKwSEBYFe
	gdjEVACuKsZi6JlMG5EQh25Ls5TEO/36FN9ak=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A13C9446E6;
	Sun, 14 Feb 2016 23:50:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 251B1446E5;
	Sun, 14 Feb 2016 23:50:57 -0500 (EST)
In-Reply-To: <56C07182.1040804@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Sun, 14 Feb 2016 13:22:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B3A24A3C-D39F-11E5-9212-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286171>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> * tb/conversion (2016-02-10) 6 commits
>>   (merged to 'next' on 2016-02-12 at 6faf27b)
> Could we keep it in next for a while ?
>
> I found issues that needs to be fixed before going to master,
> updates follow soonish.

Hmph, I somehow thought that everything was a no-op clean-up.  Any
regressions I failed to spot?
