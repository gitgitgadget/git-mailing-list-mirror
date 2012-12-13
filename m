From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2012, #03; Wed, 12)
Date: Thu, 13 Dec 2012 00:11:42 -0800
Message-ID: <7vvcc6z801.fsf@alter.siamese.dyndns.org>
References: <7vhanq257s.fsf@alter.siamese.dyndns.org>
 <CAMP44s2DAuhk5FkDm0-cYsikY0o6vuZ4FyAnXhbtsgqKQF1dpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 09:12:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tj3tk-0005bY-UU
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 09:12:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390Ab2LMILq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 03:11:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57867 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752958Ab2LMILp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 03:11:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B142E69AD;
	Thu, 13 Dec 2012 03:11:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=neJO7pyhssLZZjTrxAwbDL8WxUo=; b=fXLl3g
	8UFf7EMHbZhJhgsPx1VMyOKev+JhfTeJBkFKV6qrsJR0xPm7vFu9YT2Aaj7SxIpZ
	AUs4uydl5Hg3XfUMCQGQ5LBV6w/1VG07MQPNVhMjQKGup58hC6C2UGNkoSONPoNs
	+ZLIUSOeoEi/dVnef9Kc8AOPLzPKNUTFmuAqc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ozVKg+XyCRtdx3xokvu1rZmE0N5Cpmzn
	Xv0Qi4x7YO5uMjpn0ST7nLljSzZIrif4pH1rP4YZ5/wvnFJ8N4UyCtdfJTXhlsjF
	eTQKSN1un+pR6l8r931Aw2Lsime8nHmV9KlxgN3vHMF2jyTP23OvY7JXXrbqzpmm
	hQHBN9RwyDI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E62569AC;
	Thu, 13 Dec 2012 03:11:44 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1CA7669AB; Thu, 13 Dec 2012
 03:11:44 -0500 (EST)
In-Reply-To: <CAMP44s2DAuhk5FkDm0-cYsikY0o6vuZ4FyAnXhbtsgqKQF1dpg@mail.gmail.com> (Felipe
 Contreras's message of "Thu, 13 Dec 2012 00:08:48 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BB699E1C-44FC-11E2-9CC6-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211443>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Wed, Dec 12, 2012 at 5:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> [Stalled]
>>
>> * fc/remote-bzr (2012-11-28) 10 commits
>>  - (fixup) test-bzr.sh: fix multi-line string assignment
>>  - remote-bzr: detect local repositories
>>  - remote-bzr: add support for older versions of bzr
>>  - remote-bzr: add support to push special modes
>>  - remote-bzr: add support for fecthing special modes
>>  - remote-bzr: add simple tests
>>  - remote-bzr: update working tree
>>  - remote-bzr: add support for remote repositories
>>  - remote-bzr: add support for pushing
>>  - Add new remote-bzr transport helper
>>
>>  New remote helper for bzr (v3).  With minor fixes, this may be ready
>>  for 'next'.
>
> What minor fixes?

Lookng at the above (fixup), $gmane/210744 comes to mind, but there
may be others.  It is the responsibility of a contributor to keep
track of review comments others give to his or her patches and
reroll them, so I do not recall every minor details, sorry.
