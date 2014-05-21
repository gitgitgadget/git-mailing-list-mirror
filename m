From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v2.0.0-rc4
Date: Wed, 21 May 2014 14:48:38 -0700
Message-ID: <xmqqsio2olah.fsf@gitster.dls.corp.google.com>
References: <xmqqr43oq8q5.fsf@gitster.dls.corp.google.com>
	<537D1B05.6030209@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Wed May 21 23:48:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnENW-0003CF-Qp
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 23:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbaEUVsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 17:48:47 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50172 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753239AbaEUVso (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 17:48:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2CCB018510;
	Wed, 21 May 2014 17:48:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5Ir2vlcINxWk9VUH+r023dKZAys=; b=hrwq79
	9BsC2m562ZrpCLgFeMYmds9Z/11LWgjf6wNmOq3uOjyDP46QQlWeQB3dXlZsZGpF
	J8IlZ4x/D+ZPEd2uEE8bhWxkB2G69OBDgqa6pIWWjjsDYgyzc5xC8nqueutVzlgm
	jmtozDNSrl6/u1pNJhiucG9e1/QHKBw8R1+40=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dhbaEghc56An+33/ADguT79suAXvSj0v
	LLc/wjQJ2p15rodKih2NeruLfOZ6DdXBMuF1r6wNfSFSLeVApTczFxHK7R3dPl1Z
	c8pEHwCHYt9lg9uZnZTNHgy1QMRIFqq1RHj2D3A3CG54xA9SCa8sR14BVsA6Psx0
	H1MuyHqb87I=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 244B21850D;
	Wed, 21 May 2014 17:48:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8567A18503;
	Wed, 21 May 2014 17:48:40 -0400 (EDT)
In-Reply-To: <537D1B05.6030209@bbn.com> (Richard Hansen's message of "Wed, 21
	May 2014 17:30:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ABF0B9C0-E131-11E3-9157-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249839>

Richard Hansen <rhansen@bbn.com> writes:

>>  * The shell prompt script (in contrib/), when using the PROMPT_COMMAND
>>    interface, used an unsafe construct when showing the branch name in
>>    $PS1.
>>    (merge 8976500 rh/prompt-pcmode-avoid-eval-on-refname later to maint).
>
> That commit has been merged to maint and is in v1.9.3.
>
> Also, 1e4119c (git-prompt.sh: don't assume the shell expands the value
> of PS1) is a fix that is in v2.0.0-rc4 but not v1.9.x.  Maybe add
> something like:
>
>  * The shell prompt script (in contrib/), when using Zsh and the
>    precmd() interface, printed ${__git_ps1_branch_name} in the prompt
>    instead of the branch name (regression in v1.9.3).
>    (merge 1e4119c rh/prompt-pcmode-avoid-eval-on-refname later to
>    maint).

Yes, already done this morning but not yet ready to be pushed out.

Thanks.
