From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2011, #07; Wed, 24)
Date: Thu, 25 Aug 2011 15:27:35 -0700
Message-ID: <7vd3fti0tk.fsf@alter.siamese.dyndns.org>
References: <7vk4a2mjx6.fsf@alter.siamese.dyndns.org>
 <20110825215035.GB67523@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Aug 26 00:27:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwiOl-000791-1v
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 00:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755673Ab1HYW1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 18:27:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45855 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755591Ab1HYW1h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 18:27:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 448EC5527;
	Thu, 25 Aug 2011 18:27:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ymbDBHU3nJg0h7+22VDHaYQ4WWw=; b=qRkjcH
	C33qlbdPztk+PAmDhVAW44H0WY8S1PakhDq6ZyO0bXdFtaZ+EpV4MQNtwf1SJGAo
	/GKAG4s7yYud1nLu58btIjs30nALrEM/Z7JneK+XmzJWbtcX3duEU6slh+uROu6+
	txt68LZM8ERNs/B5fbXFQ89Veww984Zvm7KbE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KdspPNtgn7ZytP/S+Regeqnvk390Z6RS
	aXMr7oYjfIpeuUQ1Hd016T2fLgo5G0NyWhBJKbLu/g7LZI2340dc/IrJhZNeVjcr
	pKyqeKZAfTSXwyuNiW4K2/arfOUF7vUrblhU0kxT7Rr1eumEpQXnKa5F5cWHK0EQ
	POFfQjMgEuI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CBCC5526;
	Thu, 25 Aug 2011 18:27:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD3BD5525; Thu, 25 Aug 2011
 18:27:36 -0400 (EDT)
In-Reply-To: <20110825215035.GB67523@book.hvoigt.net> (Heiko Voigt's message
 of "Thu, 25 Aug 2011 23:50:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6F50D50E-CF69-11E0-BA16-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180131>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> Hi Junio,
>
> On Wed, Aug 24, 2011 at 05:09:09PM -0700, Junio C Hamano wrote:
>> * fg/submodule-ff-check-before-push (2011-08-20) 2 commits
>>   (merged to 'next' on 2011-08-24 at 398e764)
>>  + push: teach --recurse-submodules the on-demand option
>>  + push: Don't push a repository with unpushed submodules
>>  (this branch uses jc/combine-diff-callback.)
>> 
>> Will aim to merge to "master" by -rc1.
>
> Have you seen my fixes to the tests of this here:
>
> http://article.gmane.org/gmane.comp.version-control.git/179883

Not really. Please send it as a separate patch, as the new _failure
case by itself is worth a comment in the "git log" output.

Thanks.
