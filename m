From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] name-rev doc: rewrite --stdin paragraph
Date: Sun, 07 Jul 2013 11:04:27 -0700
Message-ID: <7vhag64578.fsf@alter.siamese.dyndns.org>
References: <1373200996-9753-1-git-send-email-artagnon@gmail.com>
	<1373200996-9753-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 07 20:04:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvtK8-00022g-93
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 20:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932Ab3GGSEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 14:04:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40296 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752530Ab3GGSEb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 14:04:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D2E72E590;
	Sun,  7 Jul 2013 18:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+NhwK0uBWsKI5lJ1805tC1JyH6E=; b=il2LPG
	M89T2sQVo0VVvpl6J8TvcnUVo5YjcShBwwalfpOQP4mKnF+gW8LeD0uCYl9jZq5g
	o+7pwxIq8eOvxEFku6Ngh0K0f43pMrQZdEkFRKxHqKHRPxzPnywIo+9i/nKtEaF0
	h87h9qXDEDDVzTtuSQJCKEV6NU6clcfgzyzUw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=efG6bWYl37vieiDlXflRKWyc4/PtBwK9
	ARElyhe3vdQj1M7Mb1SrRXJeoegVpr6FOQR4k8JDcu/e0S5yE5HV9F9sRv+E+TSQ
	uohHy2ZFk3wyNRnjOplDHBycB2sdEzMdib5FsWdT8dnmVwCPPikmbeYJKUfMNbga
	CUiN7d5VNKA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 121262E58F;
	Sun,  7 Jul 2013 18:04:29 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 882842E58C;
	Sun,  7 Jul 2013 18:04:28 +0000 (UTC)
In-Reply-To: <1373200996-9753-4-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Sun, 7 Jul 2013 18:13:16 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AA9183D6-E72F-11E2-895A-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229791>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/git-name-rev.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
> index 7cde4b3..94bded8 100644
> --- a/Documentation/git-name-rev.txt
> +++ b/Documentation/git-name-rev.txt
> @@ -32,8 +32,10 @@ OPTIONS
>  	List all commits reachable from all refs
>  
>  --stdin::
> -	Read from stdin, append "(<rev_name>)" to all sha1's of nameable
> -	commits, and pass to stdout
> +	Transform stdin by substituting all the 40-character SHA-1
> +	hexes (say $hex) with "$hex ($rev_name)".  When used with
> +	--name-only, substitute with "$rev_name", omitting $hex
> +	altogether.  Intended for the scripter's use.
>  
>  --name-only::
>  	Instead of printing both the SHA-1 and the name, print only

Looks obviously correct and more helpful description.

Thanks.
