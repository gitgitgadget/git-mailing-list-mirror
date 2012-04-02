From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t7800-difftool.sh failure on pu
Date: Mon, 02 Apr 2012 11:33:22 -0700
Message-ID: <7vvclif0gd.fsf@alter.siamese.dyndns.org>
References: <4F74A604.3040402@ramsay1.demon.co.uk>
 <7v7gy3qesv.fsf@alter.siamese.dyndns.org>
 <CAJDDKr50oDwih2fyb5iuFqYDsXSD3EXje4vZJwO=1_JBvuMYsA@mail.gmail.com>
 <CAFouetg2ME6f7=p191qPq=YC7Z7ZeBpm23tgb_wDmsEmwV7etw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 20:33:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEm4I-00053I-HT
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 20:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287Ab2DBSdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 14:33:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43349 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212Ab2DBSdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 14:33:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A83E573DE;
	Mon,  2 Apr 2012 14:33:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mM4MldjxkyChciEhgp6LRkILhF4=; b=Tz2jtV
	6qdPZkXUob1TNWBV7/jnbu8JE1TuiQHa/2DGc/WPlik4WQe3p6+9bOGIV9PBMEoV
	nup7V2gmdoI6Hroh7QH7dNrFIdU+vc3nKM4xPIirg1hR5UWoP2o8Qmemb3SmvEnZ
	VEOooE0zMeCf1hBs1xY/mTzh9pZLrT6fc+L/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lf25Mp8t4gfMmP3kNkYjL0U373T+AdJm
	GRIoeA/+F37GeiVwS6qEMUY4gh0SVyS0mHKsF6NS3FnL04nuRd2fCj5erkXg7Ht3
	EDn8zv0a7L0vlRkM3q9AYsyFZIvpazbXi/5yKiLiquLMGViSNH+37wkupxIEWu9h
	geCrKoEUSrE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0CAF73DD;
	Mon,  2 Apr 2012 14:33:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 36DF273DC; Mon,  2 Apr 2012
 14:33:24 -0400 (EDT)
In-Reply-To: <CAFouetg2ME6f7=p191qPq=YC7Z7ZeBpm23tgb_wDmsEmwV7etw@mail.gmail.com> (Tim
 Henigan's message of "Mon, 2 Apr 2012 13:19:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 54ACCFA0-7CF2-11E1-BC87-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194547>

Tim Henigan <tim.henigan@gmail.com> writes:

> This change will involve:
>   - Dropping 7/9 from the series
>   - Editing 8/9 to replace 'git_cmd_try' with simple system calls
>
> Would it be better to resend the entire series or just edit and resend 8/9?

As long as you know I have the right "previous round" in my tree, it would
be sufficient to just send an updated 8/9 and tell me clearly what to do,
i.e. "drop 0440ed7 and replace 6fbdb7b with this patch, leaving everything
else intact.", after "---" line in it (if you were resending many patches
with an updated cover letter, the insn to me will be in 0/n instead).

Thanks.
