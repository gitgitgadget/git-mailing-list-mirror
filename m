From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Group the default git help message by topic
Date: Wed, 02 Jun 2010 16:39:39 -0700
Message-ID: <7vwruh80n8.fsf@alter.siamese.dyndns.org>
References: <1274809430-36060-1-git-send-email-schacon@gmail.com>
 <AANLkTilWIRqnjjgGA3e9DDzw2MiHirjP2-W7PuPhonUs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 01:39:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJxXK-0001Zm-T5
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 01:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933331Ab0FBXjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 19:39:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54703 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933321Ab0FBXjp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 19:39:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 47966B736C;
	Wed,  2 Jun 2010 19:39:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=hhMlyz6FOr/1dTklhquTX+/UVsI=; b=csURnuqLljNE3drr/7voFdI
	KDMHVPQIxWwrmOJNMM9vVLvTlnmtJB75QP0u6UJee9IMPWVOD67AUB9ZfapFNv0V
	GWdLBbGNjm4CvbKawoGKEcQk/umEg0zjMkl2ZmocjqTn88NilrwxBoOcf7Hjs/Vw
	xDsgnSOzFE39Cag/iPGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=uZQcBvQBbXL6TRJt2uZ9qG0U5QR77OzJlbrE52xRpjuHs2mlQ
	c4FGq7bN1bVOKhWgxzfmF6BCkAk42IUFjoRB8fAXo6KU82n78QSjDDXKH2VfD1u2
	z/XJ7LqYc19mTv8WeNw46qDueEvisSByE45CtgwZaJ39XlPWXgRxCcprQc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 23462B736B;
	Wed,  2 Jun 2010 19:39:43 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77FB2B736A; Wed,  2 Jun
 2010 19:39:40 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1E91C874-6EA0-11DF-8443-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148286>

Scott Chacon <schacon@gmail.com> writes:

> Also removes the common-cmd.h generation process, including parts of the
> Makefile and the generate-cmdlist.sh file.

I think it is a good idea to change the presentation order from
alphabetical to logical grouping.  However, the approach the patch takes
encourages the command synopsis and its help message drift apart which is
somewhat worrysome.

I also sense a hidden agenda of deprecating the word 'index' and replacing
it with 'stage', but this is not a proper way to do so.  Please make it a
separate patch.  IOW, keep the current command description but change the
selection of commands and presentation order in one patch, and create
another patch that does your s/index/stage/ thing.

Thanks.
