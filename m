From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] Provide better guidance for submitting patches
 against upstream utilities
Date: Mon, 31 Dec 2012 15:39:16 -0800
Message-ID: <7vzk0tdc63.fsf@alter.siamese.dyndns.org>
References: <1356992375-11116-1-git-send-email-jason.k.holden.swdev@gmail.com>
 <1356992375-11116-3-git-send-email-jason.k.holden.swdev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, th.acker@arcor.de, paulus@samba.org,
	patthoyts@users.sourceforge.net, worldhello.net@gmail.com
To: Jason Holden <jason.k.holden.swdev@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 00:41:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tpoyr-0005VC-S6
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 00:41:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898Ab2LaXjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 18:39:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38523 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750774Ab2LaXjU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 18:39:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C68CB073;
	Mon, 31 Dec 2012 18:39:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ti5nzXV63OdnFx8WPV8DQBg1Hno=; b=bx4ZhO
	pvWr246UPf7qSMjvkcIWaO11A1aPL0DCpCepNuZlquMdGdDiLRx4zdoJEurpejPf
	XB5/8nwIEyRzZ5GV14ACzlm7iDNecy/41WUnWO9YtK4VcljUZ3H7nog1enmiKH9Q
	sktguiTwyxaz7tWAiK620bihYcmvOqip2C3Sc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BvLe0uHZcpJk/C/ZuUbpuYVAvJU1mMZn
	iwaYbQuK0Xiae96OFyYqpSYQQ9BnDiwrimK/Er5sHJss6I/zL51nU6xP5lyFyvKS
	L/pYqOvPc8cAHJsZt27BNemWVPQAY0Frshn4tA3U6z7aPpJ5ulGbdTR+LjON/TSz
	e9cCsDQtArE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CDADB072;
	Mon, 31 Dec 2012 18:39:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 66AD8B070; Mon, 31 Dec 2012
 18:39:18 -0500 (EST)
In-Reply-To: <1356992375-11116-3-git-send-email-jason.k.holden.swdev@gmail.com> (Jason
 Holden's message of "Mon, 31 Dec 2012 17:19:35 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4B661F18-53A3-11E2-B674-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212369>

Jason Holden <jason.k.holden.swdev@gmail.com> writes:

> git-gui, gitk, and git-po are maintained upstream of git.
> Document this, and the procedure for submitting patches to these tools
>
> Signed-off-by: Jason Holden <jason.k.holden.swdev@gmail.com>
> ---
>  Documentation/SubmittingPatches | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 75935d5..30b95a8 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -58,6 +58,17 @@ Checklist (and a short version for the impatient):
>  	  please test it first by sending email to yourself.
>  	- see below for instructions specific to your mailer
>  
> +	Improving upstream utilities (gitk, git-gui, git-po)
> +	- gitk, git-gui, and git-po are maintained upstream of Git
> +	  despite being included in Git's git repository
> +	- Patches should be made against the upstream gui repository,

GUI?

> +	  and not against the version in Git's git repository
> +	- The resulting patch should still be emailed for review
> +	  to the git mailing list (git@vger.kernel.org), cc'ing the
> +	  applicable gui maintainer
> +	- Please see the MAINTAINER's file for the gui maintainer's contact

GUI?

Perhaps "parts with sub-maintainers' with their own repositories".

In any case, I think it is probably much better not to add a new
file at the top of the tree only to hold twenty-or-so
lines. Instead, add the contents as a footnote to this file and
refer to it from here.
