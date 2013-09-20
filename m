From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2013, #02; Mon, 9)
Date: Fri, 20 Sep 2013 15:29:38 -0700
Message-ID: <xmqqhadfp1nx.fsf@gitster.dls.corp.google.com>
References: <xmqqa9jl38ve.fsf@gitster.dls.corp.google.com>
	<522F486A.1000705@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 21 00:29:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VN9Cs-00063W-4W
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 00:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592Ab3ITW3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Sep 2013 18:29:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57011 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754521Ab3ITW3l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Sep 2013 18:29:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F876434FE;
	Fri, 20 Sep 2013 22:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S4ClDrPT643XeG0YxuVYHVj1VxQ=; b=fJ9/HM
	fWH1GJmUfgE++X+fjRK7UALOXiZKqzPfqJtkriBEFyeH1bxpEJuEL4UFLP69HMof
	kmBSCTqUlLg6QoZsYwSwIEWeviaLKWvFEOGNJb9eOkgW26ISP7SAAvHR4hy7cLS1
	CeKfp3ogJg4dlqADMAfJztfA3gRPeKhritGgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ND6J2MTzMQFbolCvkbpjnjazBX0v/2rM
	csUXw3uKmBwf7X8hW8KyJ/m9C2+JEYdfuMaLEiNYcu/IhCac67GuRqgsWx1rJIOu
	1m2dEaXkQuULKUEZ66cwsOOedE68QJ6XnVxYVgxVLxuoU4oWIAk0agpugjDXkZKT
	QzZV6eDbWeA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02D21434FD;
	Fri, 20 Sep 2013 22:29:41 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C8E4434FA;
	Fri, 20 Sep 2013 22:29:40 +0000 (UTC)
In-Reply-To: <522F486A.1000705@web.de> (Jens Lehmann's message of "Tue, 10 Sep
	2013 18:27:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 23B20610-2244-11E3-974B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235085>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 10.09.2013 00:53, schrieb Junio C Hamano:
>> * bc/submodule-status-ignored (2013-09-04) 2 commits
>>  - submodule: don't print status output with ignore=all
>>  - submodule: fix confusing variable name
>> 
>>  Originally merged to 'next' on 2013-08-22
>> 
>>  Will merge to 'next'.
>
> I propose to cook this some time in next to give submodule
> users who have configured ignore=all the opportunity to test
> and comment on that. And as Matthieu noticed the documentation
> is not terribly clear here, I'll prepare one or two patches to
> fix that which should go in together with these changes.

The patches are still in 'next' but I think with the documentation
update you and Matthieu did, it should be ready to be in 'master'
now, no?
