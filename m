From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/technical/api-hashmap: Remove source highlighting
Date: Tue, 20 May 2014 10:31:29 -0700
Message-ID: <xmqqiop01hn2.fsf@gitster.dls.corp.google.com>
References: <alpine.DEB.2.02.1405170707260.44324@all-night-tool.MIT.EDU>
	<20140517152219.GA31912@hudson.localdomain>
	<alpine.DEB.2.02.1405172035160.44324@all-night-tool.MIT.EDU>
	<xmqq4n0l3dc7.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.2.02.1405191839230.44324@all-night-tool.MIT.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeremiah Mahler <jmmahler@gmail.com>, git@vger.kernel.org
To: Anders Kaseorg <andersk@MIT.EDU>
X-From: git-owner@vger.kernel.org Tue May 20 19:31:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmnt6-0001S2-PI
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 19:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075AbaETRbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 13:31:37 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52135 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266AbaETRbg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 13:31:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8CE8118013;
	Tue, 20 May 2014 13:31:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Zyrf3C/VUEEWa2PuPGHUah8QdSs=; b=hgSJLK
	LTlXzAfXWe1ng24tQNlKwAoTV2JKceVx70IyDXfPs3CGp2lY107Yzm+HceIXzZz4
	fArFT+fzdjYj3+UfudMM4wO6m5ZqhkPFixGRiAQkSDdnNSkeMhaEWGxigAvX1gt5
	EL4ctUpacZmqQroYnxvIQRyWt5iN166lVRfNg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kKTXkXwHs0q1cG63q8r2esN7n+w7yrix
	jUmxA+ZjDXdHxXjIjA+B6poFbi/PZH1gMVnM+xz265XI2x7SCQaurT0GYBDqYGHL
	6A6YT3xtG5FM4fCV7GTv80AhXI557OXgFcT2/kGROQKYPCfBLrFdp6vXMQ+b+f8V
	4jcMslZfayw=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7F7E618012;
	Tue, 20 May 2014 13:31:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8D9B01800F;
	Tue, 20 May 2014 13:31:31 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.02.1405191839230.44324@all-night-tool.MIT.EDU>
	(Anders Kaseorg's message of "Mon, 19 May 2014 19:40:35 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 952548DE-E044-11E3-B574-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249708>

Anders Kaseorg <andersk@MIT.EDU> writes:

>> How bad does the documentation look with the patch applied (I know how 
>> bad it looks without source-highlight installed)?  If it is not too bad, 
>> then it sounds like a sensible solution to drop the highlight markup 
>> unconditionally like the patch that started this thread does, taking the 
>> "common denominator" approach.  You seem to agree, and I do not object, 
>> either.
>
> Original version with syntax-highlight installed (pretty):
> http://web.mit.edu/andersk/Public/api-hashmap/old-highlight.html
>
> Original version with syntax-highlight missing (corrupted):
> http://web.mit.edu/andersk/Public/api-hashmap/old-no-highlight.html
>
> Patched version (boring but readable):
> http://web.mit.edu/andersk/Public/api-hashmap/patched.html

Thanks.  I've queued the patch for v2.0 and the comparison between
the first and the third clearly shows that it is the right thing to
do ;-).
