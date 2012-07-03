From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How do I delete a remote branch with a period in the name?
Date: Mon, 02 Jul 2012 21:14:43 -0700
Message-ID: <7vsjd9wkek.fsf@alter.siamese.dyndns.org>
References: <CAKON4OwnUKQ6MT8HBNDyfhZLZS5xGKA2Ss1krY9OQGG1gaFhDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "jonsmirl\@gmail.com" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 06:14:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SluVn-00087z-OT
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 06:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627Ab2GCEOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 00:14:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38958 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735Ab2GCEOq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 00:14:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 399548F42;
	Tue,  3 Jul 2012 00:14:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cVLPEdpj8FkoklK46NyESnZCiSk=; b=R910hY
	Qs7NEECbFSjP0F2t2xK+7UPyDX/tm2SU4ND4EhiEaYdn46qMEYP0ac1UjM+DcLM5
	FwONaR55ewjSIVeIbgGNXMC9G5U9i88PS/5wp/Fru4VlnJ0o0kY3n3O1Px0jICYq
	USEHjoZu0D00ymMBsmPo4B6z7qTaul1ZLXd/g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xPjA3CaX/ahoQAYbmKvJUo/0tWvbzUU6
	Eqbqudj9mpiUtDTsQSXyJW4ZJTLwhN3kOHXt/1EXAknWfGtH3XA4x3e8VkKmBV6G
	1OLEBcP9fVzEp9h9qVYgrn+vx9zTTAfega306tGrbbm5dczdYaEymuCvwKANHD1+
	iGZux5CSLyg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F21E8F41;
	Tue,  3 Jul 2012 00:14:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA5D78F40; Tue,  3 Jul 2012
 00:14:44 -0400 (EDT)
In-Reply-To: <CAKON4OwnUKQ6MT8HBNDyfhZLZS5xGKA2Ss1krY9OQGG1gaFhDw@mail.gmail.com>
 (jonsmirl@gmail.com's message of "Mon, 2 Jul 2012 23:09:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9EAF9CF2-C4C5-11E1-A7B0-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200895>

"jonsmirl@gmail.com" <jonsmirl@gmail.com> writes:

> jonsmirl@smirl2:/home/apps/florida/lpc31xx$ git push origin :fl.stg
> error: unable to push to unqualified destination: fl.stg
> The destination refspec neither matches an existing ref on the remote nor
> begins with refs/, and we are unable to guess a prefix based on the source ref.

The message seems to be saying that fl.stg is not specific enough
perhaps?  What does "git ls-remote origin | grep fl.stg" say?  If it
says refs/smirl/fl.stg, for example, you can be specific as the
message suggests, e.g. "git push origin :refs/smirl/fl.stg" or
something like that?
