From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch: Export variable `workdir' for
 --commit-filter
Date: Mon, 08 Aug 2011 12:11:09 -0700
Message-ID: <7vzkjjwvuk.fsf@alter.siamese.dyndns.org>
References: <f06dd070abcc485e98c054ec3ee298f9-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 08 21:23:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqVQY-000557-IG
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 21:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066Ab1HHTXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 15:23:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63625 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751408Ab1HHTXt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 15:23:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4F163ACD;
	Mon,  8 Aug 2011 15:23:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=FUXB+fA/mOHQvetWHoej662I9jo=; b=PycCwbfKxuQDK1kEep2o
	uwhntEgOU34zzNIaviCdixuKa91CJhcb2fKfIZwKPgzm85l5XUpJCDkvxvTXi3dt
	EuEcrA9XOecJ2woXoP1Lq4BJOoUV62wwRn9OAnfmD7UN3MqGsh2yJ4nxuN143jfE
	NYyzZSvB/bDPHm9p4EO6NuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=As8JnxwvS3aZrbumivYmzoz+1XFD0HH0cwciV7osG85zAL
	qrfq9n84E6fWbON+ZOyGMhDlqTGp0luBMSpGU5UQF5JOW2noUeCYOEWFduuprWrc
	QPkDxSS2+YACIaxk4MwKzkM6WE6K8V7PzSihih3b4U77L9V3fOL3C2FJsn1E8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCB4E3ACC;
	Mon,  8 Aug 2011 15:23:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 708613ACB; Mon,  8 Aug 2011
 15:23:48 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0F1EC02-C1F3-11E0-B13A-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178975>

Michael Witten <mfwitten@gmail.com> writes:

> According to `git help filter-branch':
>
>        --commit-filter <command>
>            ...
>            You can use the _map_ convenience function in this filter,
>            and other convenience functions, too...
>            ...
>
> However, it turns out that `map' hasn't been usable because it depends
> on the variable `workdir', which is not propogated to the environment
> of the shell that runs the commit-filter <command>...

Thanks.
