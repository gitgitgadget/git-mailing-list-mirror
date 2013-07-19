From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Clone Parameter
Date: Fri, 19 Jul 2013 08:02:46 -0700
Message-ID: <7vzjtiy4mh.fsf@alter.siamese.dyndns.org>
References: <FB572366-0B1D-4053-9255-979CB213B160@gmail.com>
	<51E94025.3090802@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Allan Acheampong <allanadjei@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jul 19 17:02:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0CCq-0006OW-UC
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 17:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244Ab3GSPCt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 11:02:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49300 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752066Ab3GSPCs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 11:02:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36E543013B;
	Fri, 19 Jul 2013 15:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hmzm5y1s+ue0dJWZZx6l77jZsLU=; b=cGJqYv
	1D+wlN9wFpt9zYVwLFehwR9uBpj2GD9Fk/5KZ2awEAHR4CG5UKRdJUEM6KrRyc5I
	cBZx4Nq96qmQ+mFBFRArl6U/lr0qMZYFAYrJQxTITm5S5JRlSgLvLZrhbhcfrPHb
	k5kxART1gnLsNeYQ76BVzQ7XZOyxRVEv2aAk8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BftdNw9AVL9/olNHHrDdB1I1hjq9u36D
	R8NdgvyMYfyQQBi7CqythVqSNDJeenSKJs7V9BfMNPgl8vbN19AjTcmYRn75dTE5
	Nq+5OnPIbtvbL+/e8TrBUnf7/ytGTRCTXc3EJlwVDJpoUSqqLwY3uL0tiPhGVLMh
	EzhIQR7Rsnc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D7423013A;
	Fri, 19 Jul 2013 15:02:48 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 817ED30139;
	Fri, 19 Jul 2013 15:02:47 +0000 (UTC)
In-Reply-To: <51E94025.3090802@viscovery.net> (Johannes Sixt's message of
	"Fri, 19 Jul 2013 15:33:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 460221A6-F084-11E2-BA7E-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230813>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 7/19/2013 11:21, schrieb Allan Acheampong:
>> Something like 'git clone <theRepo> -createLocalBranchesForAllBranches'
>
> Perhaps:
>
> $ git clone theRepo
> $ git fetch origin refs/heads/*:refs/heads/*
>
> (untested). There may be ways to write the same shorter, but I've lost
> track of what is and what is not possible in refspec.

That would overwrite your local branch and would not give you any
tracking, no?
