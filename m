From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/9] add long forms for format placeholders
Date: Mon, 28 Mar 2011 17:28:15 -0700
Message-ID: <7vei5qvkgw.fsf@alter.siamese.dyndns.org>
References: <1301354251-23380-1-git-send-email-wmpalmer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 02:28:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4MnR-0008Af-B3
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 02:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754351Ab1C2A22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 20:28:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54485 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100Ab1C2A21 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 20:28:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 47663408C;
	Mon, 28 Mar 2011 20:30:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5bNSUFoFv/wzX1vgoGW/c1j9SWc=; b=qJfxsJ
	HnZAchSC9m8oVbdLzO+Ieyxmv6FRtwyLJVvCMrnANdS8tYQPu9jxCK9aXiKFJfAY
	3pJEoTN/f2OPmmgYhSBsXIG1GNdNk8E6Ekhktlst8cZIjYewep2iF2bfDwIlRt6z
	1Wu7c/CVn2k8PE6CkSd1TYpyd2vao+hR3PwiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LKuE25fZBXhK00WNgRyHFoyts4pr4UQF
	+HyzGy+swvfEF11uzzGWYo9J4XEl/cIaUUKxJY5EK9BvleV8YrDYnvsEU4u2tvL/
	pMKDaW4PoG3pdyvwov5zobLYyobUmoLqYCE+CXfGcoa3V/tb05Y/45QTYisO8OJV
	B2SzYDpFAjk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 13CD9408A;
	Mon, 28 Mar 2011 20:30:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F0F034089; Mon, 28 Mar 2011
 20:30:02 -0400 (EDT)
In-Reply-To: <1301354251-23380-1-git-send-email-wmpalmer@gmail.com> (Will
 Palmer's message of "Tue, 29 Mar 2011 00:17:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B275B3CA-599B-11E0-B34A-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170209>

Will Palmer <wmpalmer@gmail.com> writes:

> I've been kicking around this series for a while now as part of a larger
> effort of refactoring the pretty formats. A recent discussion on the
> list has lead me to believe that this smaller subset may be of use
> sooner, rather than later.
>
> This series attempts to add "long forms" for common format placeholders
> in the "git log" family of commands, making the way for yet more
> placeholders to be added without needing to worry too much about the
> increasingly limited set of available one-letter mnemonics. It also
> moves towards the possibility of eventual unification with the format
> options in for-each-ref.

I don't claim that I read 1300+ long [PATCH 5/9] carefully, but I like the
direction in which this topic is going very much.

Except that [PATCH 2/9] looked quite out of place---more like "I wanted to
sneak this feature in" than "this was needed to keep the resulting code
backward compatible" or anything like that.

Off the top of my head, I don't think of a reason to say that [PATCH 3/9]
is going in a wrong direction---is there a reason to make you worried in
the particular change?
