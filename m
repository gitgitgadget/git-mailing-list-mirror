From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix incorrect line number report for bad gitconfig
Date: Sun, 11 Mar 2012 22:55:34 -0700
Message-ID: <7vhaxuuzvt.fsf@alter.siamese.dyndns.org>
References: <20120309223014.GA6380@gnutiken.se>
 <7v8vj94c1a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
To: Martin Stenberg <martin@gnutiken.se>
X-From: git-owner@vger.kernel.org Mon Mar 12 06:55:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6yEY-0006LK-8g
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 06:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084Ab2CLFzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 01:55:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61159 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752982Ab2CLFzh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 01:55:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4A293822;
	Mon, 12 Mar 2012 01:55:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1vJNhO35BDG8cUkVrCSsn8KqXBY=; b=RHB0Pu
	o3NfnOQ1ifnaBidtQTLj2aEwbU5cFZHE/LHqhPddXeHop1TdNETy7goCQmxm5TRI
	q1JtKVc+0WjInZnWj9MwXtmrbu6dnazb5X6Vl0P25UWbYTK9zFfzr3pQF0SLvDM7
	IYeQrueInQAA10bJsTUp7KfvN9piuV3AdFNKc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DJXZQ5VXZhBar2SSCCR34S24kP7wAWjf
	+yUR2uJ9nckBzszMyjeQINQcy3EvZK99uWjf+DLiZ1ALXdvPe9fWK+SWGibCkxrG
	gN33nHyV3yKzrfFXwzDCXLebCgITPEynUfcxqN02R5jXF76TxWwU/zwQcoi+YJ3S
	i/mqe+rDmgg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A82D3821;
	Mon, 12 Mar 2012 01:55:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E36243820; Mon, 12 Mar 2012
 01:55:35 -0400 (EDT)
In-Reply-To: <7v8vj94c1a.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 09 Mar 2012 14:58:25 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FCC8F7BE-6C07-11E1-917B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192840>

Junio C Hamano <gitster@pobox.com> writes:

> Martin Stenberg <martin@gnutiken.se> writes:
>
>> From c88f00e06cb877f9d944fdec480f53a7a42dd990 Mon Sep 17 00:00:00 2001
>> From: Martin Stenberg <martin@gnutiken.se>
>> Date: Fri, 9 Mar 2012 22:57:54 +0100
>> Subject: [PATCH] fix incorrect line number report for bad gitconfig
>
> Please drop these four lines. The commit object name is no use to
> me, and the other lines duplicate what you have in the mail header.
> ...
> Please have a paragraph break before your S-o-b: line.
>
> Thanks. Review of the patch text follows.
> ...

Also could you add a couple of tests (you identified two cases in
your log message) to make sure this fix will not be broken in the
future, perhaps to t1300?

Thanks.
