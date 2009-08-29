From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove unused t/t8005/iso8859-5.txt file
Date: Sat, 29 Aug 2009 00:48:32 -0700
Message-ID: <7vy6p3giwf.fsf@alter.siamese.dyndns.org>
References: <20090829161637.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sat Aug 29 09:51:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhIij-00081e-Pp
	for gcvg-git-2@lo.gmane.org; Sat, 29 Aug 2009 09:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbZH2Hsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2009 03:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbZH2Hsq
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Aug 2009 03:48:46 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63757 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbZH2Hsp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2009 03:48:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4AA1A3B01E;
	Sat, 29 Aug 2009 03:48:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Oi6sROjmS81PG0xeKT1ZmHX4Uo0=; b=sV26oj
	9D6jFNfz5dxikfjHz8AHV6aRfqBhg6XVMsKixxTfWa4CKboRoPTh5UN7oMAj+EZR
	jkGt7tgjuP0m7cNh7UmFgVdrzAxUdybIAxQ86cOKJt5fM4fhmkbP/STxr4H5QG1k
	7UA27rTSIYZgdGfWRbofsKtcEpKETlnUmntPg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ezMi8VuhisIMv6Ir63R4uJCW+ha1RS5O
	mkQflu7vVlK9wFGd/SzcSX1ukCBid+k5p6bpB2nSaLzsIDCeS4uLklIjSu3LDqkX
	nP/pBcl8jci6fbaVKB3Gj2yU/2VoHc3KgvSd2uKQxI87eUzY7nQvisfg5KM3wEXd
	miCqWZWxDAE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2F0D33B01D;
	Sat, 29 Aug 2009 03:48:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1EC933B01C; Sat, 29 Aug 2009
 03:48:34 -0400 (EDT)
In-Reply-To: <20090829161637.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Sat\, 29 Aug 2009 16\:16\:37 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 605A53A8-9470-11DE-BA9D-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127375>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> This file is no longer used since commit 54bc13c.

Hmm, the patch is grossly encoding damaged, so I'll hand apply.
Out of curiosity, how did you find this?
