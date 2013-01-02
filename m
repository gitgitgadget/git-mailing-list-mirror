From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] SubmittingPatches: mention subsystems with dedicated
 repositories
Date: Tue, 01 Jan 2013 18:14:19 -0800
Message-ID: <7vsj6k5o1w.fsf@alter.siamese.dyndns.org>
References: <1357082695-29713-1-git-send-email-gitster@pobox.com>
 <1357082695-29713-3-git-send-email-gitster@pobox.com>
 <20130102015233.GA25288@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jason Holden <jason.k.holden.swdev@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 03:19:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqDvQ-0007kB-0K
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 03:19:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413Ab3ABCOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 21:14:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64711 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752271Ab3ABCOX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 21:14:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CD19A9DA;
	Tue,  1 Jan 2013 21:14:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1Yp3quwW/9Q+i8MZKqMVoCRNT0U=; b=MOil40
	ZUouXs6sKz9T8ocLZ7Mllp0sa/cqZm1RpknIz3A0TXTAfRi8kXldElU0rYdOIQJf
	iZcFyjUu4x9NtHpQYtWPORe3Wn8vdKgUmBoMhSc9hgQejBtqewIereCdZrvtIGZa
	UZTSgYMcbv5HbrHGktJBcYqtTpQC04TgoFib4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R/hqghXgDCQcYd/FBoI5du3esYrtG5hq
	IrioR0yLkF+RBPD5PYPIuz4ypGBtLepxq96oLxD8p7s8lysxD0djU2iaONZKLNbl
	G8OXZBJdRWkwGYKdcrb+AxoQw7BUEQrXmgYmX07mTtcp66zmhnM9mnBCBVcJiTbN
	Pw9TzdVNcpc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F533A9D9;
	Tue,  1 Jan 2013 21:14:22 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A33CA9D8; Tue,  1 Jan 2013
 21:14:21 -0500 (EST)
In-Reply-To: <20130102015233.GA25288@gmail.com> (Jason Holden's message of
 "Tue, 1 Jan 2013 20:52:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1EE0EDF8-5482-11E2-AB16-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212486>

Jason Holden <jason.k.holden.swdev@gmail.com> writes:

> Any reason to leave out the maintainers email addresses?

Nothing particular, other than that I did not find anywhere in the
file that does not break the flow.

> My only other suggestion for this series might be to augment the file with 
> a patch submittal example(s).  I found the best example to be in 
> git-send-email's man page,...

I'd feel better to avoid copying and pasting.  If send-email has
good examples, shouldn't it be sufficient to refer to them?

> -----------------------------------------------------------
> Example of sending patches for a new feature:
>
> Create the patches:
>  $ git format-patch --cover-letter -M origin/master -o outgoing/
>  $ edit outgoing/0000-*
>
> To send your completed patches for initial consideration:
>  $ git send-email outgoing/* -to git@vger.kernel.org -cc gitster@pobox.com

This is ambiguous; it makes it look as if you are CC'ing the
maintainer, but for the initial round, it is likely that you are
sending it to me only because I have been involved in the area the
patch touches.

> To send your reviewed patches for inclusion:
>  $ git send-email outgoing/* -to gitster@pobox.com -cc git@vger.kernel.org

This is fine, but we would probably want to see it CC'ed to people
who reviewed the initial submission, too.
