From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] grep: Colorize filename, line number, and separator
Date: Sun, 28 Feb 2010 11:29:44 -0800
Message-ID: <7vd3zp88gn.fsf@alter.siamese.dyndns.org>
References: <1267246670-19118-1-git-send-email-lodatom@gmail.com>
 <1267246670-19118-5-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 20:29:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nlopy-000113-TN
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 20:29:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936555Ab0B1T3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 14:29:53 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61682 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936578Ab0B1T3w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 14:29:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BFFB9EF5B;
	Sun, 28 Feb 2010 14:29:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=VFvwZNMJyLZusD23xVYL++2KLFk=; b=hHKWwLRKJzqa3KrYcLOKMxr
	QZ5apcJyCTYZ0iKXkK+MAghHyo1ct8ntgRG8tOMd9lLSxVsg9gz1j4gL+vW0bX1d
	kiUO/Kdl0+sSHg5pkjz1vPbaptK1HWjyRD+ClGLS8tiz7n6E8L2GdSffxfdtKbI6
	p/mhQtAtxQlrOS6S8tIk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=KaI9VZwRraC3UghfldwQ6gDgJ8VirwlzadhfA0Yvua9IaTbpn
	n+1oga1cOs/Cwa7MVRW4quaJDyi46oMrPVOlL6uW7WtSwS1ZOUq4f+Hd9rvsdiiI
	FyKdruvWRe+gw9IA8cY+9j34bisAiVVMt7Za29RC83Lju4ntWoYgyK4/QU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 26FE79EF59;
	Sun, 28 Feb 2010 14:29:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9198C9EF58; Sun, 28 Feb
 2010 14:29:46 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A2A1590E-249F-11DF-ABF8-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141261>

Mark Lodato <lodatom@gmail.com> writes:

> +color.grep.<slot>::
> +	Use customized color for grep colorization.  `<slot>` specifies which
> +	part of the line to use the specified color, and is one of
> ++
> +--
> +`filename`:::
> +	filename prefix (when not using `-h`)
> +`linenumber`:::

Why do I get a feeling that I already said something about three colons?

 ... goes and looks ...

Ah, it wasn't to you.  Please see:

  http://thread.gmane.org/gmane.comp.version-control.git/139014/focus=139343

BUT.

I tried the three-colons notation with AsciiDoc 8.2.7 and it seems to take
it as enumeration items that are nested a level deeper, so this might be
safe.

But the last sentence about color.branch.<slot> is indented as if it is a
part of description for "separator" slot, which you may want to fix
regardless.
