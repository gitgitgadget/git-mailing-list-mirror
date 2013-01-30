From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-remote-helpers.txt: should it be gitremote-helpers.txt?
Date: Wed, 30 Jan 2013 12:28:49 -0800
Message-ID: <7vfw1ijtz2.fsf@alter.siamese.dyndns.org>
References: <20130130201102.GM1342@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jan 30 21:29:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0eHT-0003Q4-Hd
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 21:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753021Ab3A3U2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 15:28:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38270 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978Ab3A3U2x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 15:28:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DAA6B432;
	Wed, 30 Jan 2013 15:28:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qHln2+LphaV2ni+xITx7mJHbkQc=; b=WEPhJt
	AtieMEKb4qkf4qAV+issrxzfLrg4qxOT9KJIxyk5rypHADlM8PAe6xyefMJN25XE
	R8OYa9pCR+O4MjaBAJgYXx/ZCB7T0flsVAFMk9jpzmYAc89fBOirIZsuVTqkiNZe
	KSmhWeD1AzqsWdjQPA7UUwOqU+w01yJ8r1yZo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RrEAnJXPvBZbGda1q/hB/AvX61MDYP3d
	truCNR0ebF0xbN0YnaUsSSuKAIchbBngewURSPxwxCOVohVmVO1qApUJxtsE0Nts
	LnDNZGPV1XlylAwI7kRyZuCiwYSG4g00ZaMKNjEfFVFPrYisJ6J6HVDYk48RteKE
	m/Pv2PZ5KFE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 234C0B430;
	Wed, 30 Jan 2013 15:28:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97F17B42F; Wed, 30 Jan 2013
 15:28:51 -0500 (EST)
In-Reply-To: <20130130201102.GM1342@serenity.lan> (John Keeping's message of
 "Wed, 30 Jan 2013 20:11:02 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A8E34B0E-6B1B-11E2-9103-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215071>

John Keeping <john@keeping.me.uk> writes:

> Max Horn's email today prompted me to try reading the git-remote-helpers
> man page, so I tried:
>
>     $ git help remote-helpers
>     No manual entry for gitremote-helpers
>
> But "man git-remote-helpers" does work.
>
> It turns out that "builtin/help.c" maps its argument to a page by
> prepending "git-" if given the name of a Git command and "git"
> otherwise.
>
> Does this mean that "git-remote-helpers.txt" should lose the first
> hyphen or is help.c not being clever enough in some way?

I think it is the former.  "git help tutorial" works exactly the
same way.
