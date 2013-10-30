From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] for-each-ref: avoid loading objects to print %(objectname)
Date: Wed, 30 Oct 2013 10:34:40 -0700
Message-ID: <xmqqa9hqd5n3.fsf@gitster.dls.corp.google.com>
References: <20131024084638.GA761@sigill.intra.peff.net>
	<877gd0pgze.fsf@linux-k42r.v.cablecom.net>
	<20131030065016.GB11317@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <tr@thomasrast.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 30 18:34:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbZfN-00056k-AL
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 18:34:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854Ab3J3Rep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 13:34:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61912 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751055Ab3J3Rep (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 13:34:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FDA24DDA5;
	Wed, 30 Oct 2013 13:34:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TsdzPwQaj4sFL8wUAtJb9TK5bfs=; b=MTSFj2
	cfQRdKKCr5vl2So6v5q17Q9ej035IwfSgCQlBOXzGWvgEsMEp7CZ+27pMMiIbeHv
	6xx7LXda+XO9q45TRhRyshX0FdRQksWiXdy8/7fi+SGbrqmbnaLBHNV7H+6qqKTD
	ec2KBGit7u5jRPP3boryq7/hcuenk8144d7so=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vWSocwSSiAkBUJh2TwiU5mnY5O9RH8RC
	vo1QgJ4SOp9IAMtAKjST5LgE1SKDsVKacoXUAmuQl8KNAMrg9oOvqBPAWPuT/7bl
	ITE3W2MgTn4Eb56WMTT9svdqZqBIvexGr42fe/swRzSjKC1RqtE/HzgJTGTJ5lhD
	4+jSrck4ln8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82A604DDA4;
	Wed, 30 Oct 2013 13:34:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CCD244DDA3;
	Wed, 30 Oct 2013 13:34:43 -0400 (EDT)
In-Reply-To: <20131030065016.GB11317@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 30 Oct 2013 02:50:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 904C69B4-4189-11E3-A5D5-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237043>

Jeff King <peff@peff.net> writes:

> On Sat, Oct 26, 2013 at 10:35:17AM +0200, Thomas Rast wrote:
> ...
>> Can you quote the *?  I may have become somewhat paranoid, but still.
>> This is the first use of the *<field> syntax, and test_atom seems
>> written to correctly quote its arguments, so why risk it? :-)
>
> Yeah, that is a very reasonable suggestion. And the patch is still in
> pu, so it's not too late to squash.
>
> Junio, here is a resend with the asterisks quoted, to replace what's in
> jk/for-each-ref-skip-parsing.  I also double-checked that test_atom
> keeps them properly quoted (it does).

Thanks, both, for being careful.
