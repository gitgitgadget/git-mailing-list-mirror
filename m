From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] README: Git is released under the GPLv2, not just "the
 GPL"
Date: Sat, 15 Dec 2012 10:07:55 -0800
Message-ID: <7vhanntchw.fsf@alter.siamese.dyndns.org>
References: <966a27bab02e7deb41ad2268800bfd4a53279a8f.1355499408.git.stefano.lattarini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 19:08:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tjw9n-0002Zt-Ub
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 19:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640Ab2LOSH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 13:07:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57117 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795Ab2LOSH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 13:07:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7C72A3BB;
	Sat, 15 Dec 2012 13:07:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WXDDhB5W3MCOXxIY8sv3iTgBui4=; b=Hs3T+H
	ynAXoDRTS/B0EtN0pLbTpPwXf8fLNjjUjxRoX1iT700AQ8WOgUJSs+/wepemZLwv
	KsMU/4x+Klm2EZCXmjITpPldF6f9/Vt+zC+CEki790GnKDhasWKNPlacARXmu/7l
	heVZ6PNSltI2pbAZh8soSKD0ODXHpsP38vAZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oc3uFmAt+DDTcbT4BmYU8T1kA7+Vx+N+
	p1SG3OaCWObXfgmgEUE/32LFzhr8X5OtVIrI6nhRsA8gVOrzmTuzhWtfb3FH2lOn
	vvhByRVuDMFL1FWAvuvXynYa79IlA0AztWSn6GGILEwEI3kx6sn9sXYICFOHX66A
	sPVPZxokWAo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B359EA3BA;
	Sat, 15 Dec 2012 13:07:57 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 194FAA3B7; Sat, 15 Dec 2012
 13:07:57 -0500 (EST)
In-Reply-To: <966a27bab02e7deb41ad2268800bfd4a53279a8f.1355499408.git.stefano.lattarini@gmail.com> (Stefano Lattarini's message of "Fri, 14 Dec 2012 16:37:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A999FC8-46E2-11E2-BDC2-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211552>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

> And this is clearly stressed by Linus in the COPYING file.  So make it
> clear in the README as well, to avoid possible misunderstandings.
>
> Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
> ---

I have nothing against this patch, but I am curious if you saw any
misunderstandings in the real world, or if you are merely trying to
avoid "possible" ones.

>  README | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/README b/README
> index d2690ec..c50e6f4 100644
> --- a/README
> +++ b/README
> @@ -19,9 +19,10 @@ Git is a fast, scalable, distributed revision control system with an
>  unusually rich command set that provides both high-level operations
>  and full access to internals.
>  
> -Git is an Open Source project covered by the GNU General Public License.
> -It was originally written by Linus Torvalds with help of a group of
> -hackers around the net. It is currently maintained by Junio C Hamano.
> +Git is an Open Source project covered by the GNU General Public License
> +(version 2).  It was originally written by Linus Torvalds with help
> +of a group of hackers around the net. It is currently maintained by
> +Junio C Hamano.
>  
>  Please read the file INSTALL for installation instructions.
