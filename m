From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git add -p and unresolved conflicts
Date: Wed, 28 Mar 2012 10:17:18 -0700
Message-ID: <7vehscwspt.fsf@alter.siamese.dyndns.org>
References: <CABPQNSYVXMxS3kugu1j=62ArJ_1saYYfMjJdZvqhjgPFGN=Eqw@mail.gmail.com>
 <7vbongyd67.fsf@alter.siamese.dyndns.org>
 <CABPQNSYp7k82mjzNqZmBX+7Dh6R7rgjQ3ZNqikZyM71GshMqqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 28 19:17:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCwUw-0001Dm-46
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 19:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758319Ab2C1RRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 13:17:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45826 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751025Ab2C1RRU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 13:17:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28E06798B;
	Wed, 28 Mar 2012 13:17:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FARXGgF9CLaqvW9D48R2HRHC90k=; b=B7sjsl
	hCZbl2cydDLTpMgu23Rmlp+QDv363Tj4QYBJt/DF+eCU8kFay/TF7UVbYKt/z9wU
	eDXPW4yGFxoqc9FKkxx953I6PhquBz/zXdbM8QHEXEVanKHnYitN3fg3CRZaCpzi
	fM5Ke1khp71XMJ3aKcJAx7MdSES1wuw6y8+44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XX4do1sJfyU/BhshBgVfVh+c+1Y1FWxz
	VLXa41kPVZnEkwcTS2rt/woy6oerEwzUW/pwlyLaPuAahFlPIPW2OJYNyHhV88zv
	YbOcAEHWv17HgFxrSVfRJFu57JDOSpJEWkXLIwjCwRQDgRXUxvBsLg9LxMos4m3c
	bkukBqg3JWI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E404798A;
	Wed, 28 Mar 2012 13:17:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A7AC37988; Wed, 28 Mar 2012
 13:17:19 -0400 (EDT)
In-Reply-To: <CABPQNSYp7k82mjzNqZmBX+7Dh6R7rgjQ3ZNqikZyM71GshMqqg@mail.gmail.com> (Erik
 Faye-Lund's message of "Wed, 28 Mar 2012 17:33:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DFEEB59E-78F9-11E1-8409-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194146>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> So, the options are:
>  1) Keep the current behavior
>  2) Abort with an error immediately if one of the picked paths are in
> a conflicted state
>  3) Abort with an error when first encounter a path that is in a
> conflicted state
>  4) Warn and skip any paths that are in a conflicted state
>  5) Implement "git add -p" for conflicted files (if we can agree on a behavior)
>
> 1) and 3) makes little sense to me.

I do not think 1, 2, or 3 makes any sense to me if you are proposing to
change anything.  Why did you even bother to list them?

Given that you wrote "(if we can...)" for #5, in the short term, #4 is the
only sensible thing to do, I would think.
