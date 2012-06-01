From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please pull git-l10n updates on maint branch
Date: Fri, 01 Jun 2012 13:01:23 -0700
Message-ID: <7vmx4m244s.fsf@alter.siamese.dyndns.org>
References: <CANYiYbF6aiiYMQbGM0L64yw35GOx=zNvniJrPkjs5bWmud-Y9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Peter Krefting <peter@softwolves.pp.se>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 22:01:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaY2N-0007ET-1B
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 22:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759352Ab2FAUB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 16:01:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48970 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759236Ab2FAUB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 16:01:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CEA849291;
	Fri,  1 Jun 2012 16:01:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SR8DGwc0gSYi2PWsoAm9QYqdWu4=; b=bGLTAQ
	msYf7J28k9OXUnZGc6Z67zB1k0Qtef9kjXOJ0uKhfiTvjcMxgoynwMJRPXF36+Af
	LL97jZxNYIdmeIEXOIEwSN/t/adZdcl5yYAwUCBiGSFbz/FZzpYKIVmmh4Vsk6WV
	2h94rd85PT6dYoJyP1338fnoCWYp8NIJaXx/g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NMgE1N+I9jgtISbYZkiY3PK9Y7G4KLdM
	XOVsZ4cLlbDWHZX8UW/Y+WVnOzv9uWm4unMRuUA/BHb2etxEYONLuxhyxdl59srq
	yNfe8UzH/HwmlHt6mUcECsxVSHX5p0CYiWWnJ+SNyoA4jqX3N+oTRrgfA32RZQxL
	yURBAFF5CjY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C52D49290;
	Fri,  1 Jun 2012 16:01:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5850E928F; Fri,  1 Jun 2012
 16:01:25 -0400 (EDT)
In-Reply-To: <CANYiYbF6aiiYMQbGM0L64yw35GOx=zNvniJrPkjs5bWmud-Y9A@mail.gmail.com> (Jiang
 Xin's message of "Fri, 1 Jun 2012 18:04:21 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 91432DC2-AC24-11E1-B486-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199018>

Jiang Xin <worldhello.net@gmail.com> writes:

> The following changes since commit 042e9f94a71977b471e230f0c637699b0a7ca3d3:
>
>   l10n: de.po: translate 3 new messages (2012-05-15 19:09:02 +0200)
>
> are available in the git repository at:
>
>   https://github.com/git-l10n/git-po/ maint
>
> for you to fetch changes up to 3f0812f68d7d4b7f11a850d4c895b168b9490b7c:
>
>   Update Swedish translation (728t0f0u) (2012-05-29 09:28:34 +0100)
>
> ----------------------------------------------------------------
> Peter Krefting (1):
>       Update Swedish translation (728t0f0u)
>
>  po/sv.po | 536 ++++++++++++++++++++++++++++++++++-----------------------------
>  1 file changed, 289 insertions(+), 247 deletions(-)

Just a nit; could you give me git:// URL not https:// the next time
around?  I could work it around with url.*.insteadOf, but I tend to
trust git:// more (as thers is one less component to break) and it
is more efficient.
