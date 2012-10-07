From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t4055 failure: see error
Date: Sun, 07 Oct 2012 15:37:11 -0700
Message-ID: <7v1uh9q57s.fsf@alter.siamese.dyndns.org>
References: <7667682A-3BDB-484F-A3E4-0E5826FD2076@cs.rochester.edu>
 <7vy5jo7l7r.fsf@alter.siamese.dyndns.org>
 <7vpq507ksy.fsf@alter.siamese.dyndns.org>
 <3C091712-6339-4B77-82D0-2A4C1CE447CD@cs.rochester.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Charles Gernhardt <gernhard@cs.rochester.edu>
X-From: git-owner@vger.kernel.org Mon Oct 08 00:37:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKzTS-0008T3-Di
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 00:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540Ab2JGWhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 18:37:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55177 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751051Ab2JGWhO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 18:37:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 535428DF7;
	Sun,  7 Oct 2012 18:37:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0d1HFQdFz/WcM7r6ugiXdoJ5ru4=; b=BP+CKo
	pesCdWFrKlUZjyamSCUmth86sglKfabxCOuN6SVG+fR70wdIOmSkKN/Fnwd3cHhB
	0KzCeyp6hjO4ugKFBkUemYrlZK3Il8Pr1yzLQsZ2ESw+ZKFpfJgGkFkINMyixQTx
	f14ZK/UeibALL4CrKGY38F7a6C8iy5msw1vgc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HFBEk2IpT8W4YBWXURw7vh84WWZgbsux
	ZH6TxqY8g9/vIHN+jAn8/R0EwCzo4Ydv6gMB/z2PJEwspLxehtPqR46LGXxm4T99
	JdwluSzD3CBVwxSgaOGzCa8s0udgbFTKuXutqx7ct5ElIwqN3UWKYz+cNJ4goZ4P
	esQ4O8JSKpg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41D0D8DF6;
	Sun,  7 Oct 2012 18:37:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A90B88DF4; Sun,  7 Oct 2012
 18:37:13 -0400 (EDT)
In-Reply-To: <3C091712-6339-4B77-82D0-2A4C1CE447CD@cs.rochester.edu> (Brian
 Charles Gernhardt's message of "Sun, 7 Oct 2012 11:43:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8A2CB0CA-10CF-11E2-99CF-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207208>

Brian Charles Gernhardt <gernhard@cs.rochester.edu> writes:

> On Oct 2, 2012, at 3:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> I'll find a brown paper bag big enough to hide in.  Please disregard
>> it.
>> 
>> -- >8 --
>> Subject: [PATCH] t4055: avoid use of sed 'a' command
>
> Sorry about being slow to respond.  The patch does work for me.  I
> see it's already been committed, but thought the confirmation
> would be nice.

Thanks.
