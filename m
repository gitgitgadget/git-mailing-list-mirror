From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] git-svn.perl: keep processing all commits in
 parents_exclude
Date: Sat, 18 Aug 2012 16:43:20 -0700
Message-ID: <7vipcfrckn.fsf@alter.siamese.dyndns.org>
References: <1344705265-10939-1-git-send-email-stevenrwalter@gmail.com>
 <1344705265-10939-2-git-send-email-stevenrwalter@gmail.com>
 <502FF250.6010402@vilain.net>
 <CAK8d-aKMsSQGMmLrUFDCr1VDbxGPVsPJFgR=Okd-=7BV3AjzOQ@mail.gmail.com>
 <50302736.9060404@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Walter <stevenrwalter@gmail.com>, normalperson@yhbt.net,
	avarab@gmail.com, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sun Aug 19 01:43:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2sfy-00014d-U8
	for gcvg-git-2@plane.gmane.org; Sun, 19 Aug 2012 01:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917Ab2HRXn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 19:43:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50302 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751026Ab2HRXnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2012 19:43:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6A069CB2;
	Sat, 18 Aug 2012 19:43:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5vCOBpY8IPJxQ4I62+tXZPSfIrE=; b=g0Px7J
	Un+y7ELJChnUDnLsivgbyngibvahudmKqd7RqPOwZHpA1T7dnKk+/f8KpzAsM7l/
	44HpewUfaw3z1GT1YiWmdsVixfNaw/G6oYxYBP1RCXcT3PtDpcR4g2GEpYFiDL2y
	gZWXzPWuTFner8rxhMbMcybSyjbkqV3EqxvIg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pvdgtBFFMsbzt5QCbF/odDLUO+r4UV4J
	DC9xlOveOST91GyFim/sQs+08OlmJYC8LblMhUJBX0/ES2FlyJElCvvzmMab+WK3
	+y9w93buTtefBkO+lo0d55iqoedXEigYn7zDtuncFqHcaSBCTUra8TBhJXvksJrI
	iKTjOgFahfg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 942FA9CB1;
	Sat, 18 Aug 2012 19:43:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D14F9CB0; Sat, 18 Aug 2012
 19:43:23 -0400 (EDT)
In-Reply-To: <50302736.9060404@vilain.net> (Sam Vilain's message of "Sat, 18
 Aug 2012 16:37:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 800A7450-E98E-11E1-8670-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203707>

Sam Vilain <sam@vilain.net> writes:

> On 08/18/2012 01:43 PM, Steven Walter wrote:
>  > How about a Signed-Off-By?
>
> Signed-Off-By: Sam Vilain <sam@vilain.net>

I think you meant reviewed-by or acked-by?
