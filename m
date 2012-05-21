From: Junio C Hamano <gitster@pobox.com>
Subject: Re: doc bug for git-patch-id ?
Date: Mon, 21 May 2012 15:15:24 -0700
Message-ID: <7vipfp6v0j.fsf@alter.siamese.dyndns.org>
References: <87zk911wpy.fsf@zancas.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: David Bremner <david@tethera.net>
X-From: git-owner@vger.kernel.org Tue May 22 00:15:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWat2-0006pu-QA
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 00:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409Ab2EUWP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 18:15:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51869 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752882Ab2EUWP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 18:15:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59F9C8DF3;
	Mon, 21 May 2012 18:15:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2yMgUGWl2s2Viy8lq38/BIGAsjk=; b=c891rH
	nGh5M4DhFRUEc8uk85DmRj6uj2ZtVoGgAEuxFHITbWzD/7sxw4r6RqEQ81Qk4dvX
	7pCKzWoHcws2Arqgf7YCRc3IVhCk1322cKRZIXpL6dvVrkrRm4D/TXao4AdvRRJ8
	Zdeo4yrNfoHsZ5yIUWsTXYDvxfmDZ2bwjlaAE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cnyAsz67DqMZTzpKSAeq/LUNJAjE1iwC
	+eANU1acUfh0c0fPH7up/5XZMWE0sjILgFjI2NQztZu9XW8Hra4GeBikhXoQtOpq
	N68wu9TuSGwCXgYuqJkjcXiet6m74Yxk4hTqFUIRcr54E9l1tE2pQPHbGCc98Hsu
	+S/u4vj4g38=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 518998DF2;
	Mon, 21 May 2012 18:15:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E05688DF1; Mon, 21 May 2012
 18:15:25 -0400 (EDT)
In-Reply-To: <87zk911wpy.fsf@zancas.localnet> (David Bremner's message of
 "Mon, 21 May 2012 10:37:29 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7743804C-A392-11E1-81AA-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198135>

David Bremner <david@tethera.net> writes:

> I just discovered that 
>   
>   git log -p $ref | git patch-id 
>
> works in place of a corresponding loop using git show | git patch-id

I think it has been designed to work that way from very early days.
Patches to clarify documentation, if the current one is lacking, is very
much welcomed.

Thanks.
