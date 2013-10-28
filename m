From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-parse --parseopt: add the --sticked-long mode
Date: Mon, 28 Oct 2013 08:47:47 -0700
Message-ID: <xmqqa9htgzx8.fsf@gitster.dls.corp.google.com>
References: <20131016223306.GN9464@google.com>
	<1382732291-5701-1-git-send-email-boklm@mars-attacks.org>
	<xmqq1u39j9hw.fsf@gitster.dls.corp.google.com>
	<20131025225222.GL4589@mars-attacks.org>
	<xmqqsivphsel.fsf@gitster.dls.corp.google.com>
	<7B64920A599843F9A122740DFA7A402A@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Nicolas Vigier" <boklm@mars-attacks.org>, <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Oct 28 16:47:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vap2p-00071F-JR
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 16:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756790Ab3J1Prw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 11:47:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62908 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756006Ab3J1Prv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 11:47:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 914564EFED;
	Mon, 28 Oct 2013 15:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9l4SOUkd5MvhKWSwVgmOVC5JsnY=; b=hR/dii
	NGOsygXjE+FAH0O4r6tmogUOnGCsgtmigESvucDoGwisoO+54omjFGZT6lJ2gSRl
	AiGhyw/pmdGDlcdjohEE7q+ZT6hHyWqT7yoRJpSaMDbMacwHj4hlrU0EiukbYXHW
	pQgiLVViKiogp/OGq4sWOJsxYsuVYfMyDQKEc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vijLES7J2iFCi7Sg8X7lz1svpqumclaN
	hUSL0l3a+290CRdA4hx5pKt5B7FyZN422o+yPwkC9PndwZuJflxNJDASK+hjCr/8
	Zn2HyZzTySTKQXFpmOAOXU+gtY6FOX0TA3a5xJTEd3Ed1yHSenlJS7TjwM59yVKn
	oP+Q0vxlYTo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 797024EFEB;
	Mon, 28 Oct 2013 15:47:49 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C4EA74EFE4;
	Mon, 28 Oct 2013 15:47:48 +0000 (UTC)
In-Reply-To: <7B64920A599843F9A122740DFA7A402A@PhilipOakley> (Philip Oakley's
	message of "Sat, 26 Oct 2013 22:55:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4BD045B4-3FE8-11E3-B285-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236835>

"Philip Oakley" <philipoakley@iee.org> writes:

> Isn't the origin of the description that it looks like a stick (cane),
> and 'sticked' is a modern verbing of that form? That's what I'd
> assumed anyway.
>
> Googleing "Sticked option" only linked back to Git.

I know web is not the authoritative source of information ;-) but it
seems that looking for "sticked vs stuck" seems to give me many
explanations that boils down to what this says:

    http://en.wiktionary.org/wiki/Talk:sticked

and http://en.wiktionary.org/wiki/stick#English lists "sticked" as
"archaic" when the word is used for "To glue; to attach; to adhere".
