From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-fast-import.txt: improve documentation for
 quoted paths
Date: Sat, 01 Dec 2012 18:27:14 -0800
Message-ID: <7v8v9hmbnh.fsf@alter.siamese.dyndns.org>
References: <vpq624omjn4.fsf@grenoble-inp.fr>
 <1354208455-21228-1-git-send-email-Matthieu.Moy@imag.fr>
 <20121129181141.GA17309@sigill.intra.peff.net>
 <7vvccop6dv.fsf@alter.siamese.dyndns.org> <vpqvccnctvd.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Dec 02 03:27:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TezHJ-0006gG-Sc
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 03:27:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713Ab2LBC1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 21:27:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35582 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751573Ab2LBC1R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 21:27:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 181B0AAD1;
	Sat,  1 Dec 2012 21:27:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/adGhLVntwBolObfC/veAFkjseI=; b=PlwJvc
	HMMPB7WiSJjBD90sgktK2hhJsVctHw5+GUVanhB3dZhEfiB6Bt91EnfYvTpx+aq9
	/d8oaWeiAR+iYejF8bWUFJc1QqDlhs1t5r0iLILzdD//+yRk9BT1/FDwIs3sdPBq
	fsg8HUPLPUETAPE6XxjJdfgfaKZrj21WjH1Ok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l2OP/c10wXy7ZoShERL7QZq0aLqlsftV
	P7qT7bIZ/lx5zJMEGRK/aO7ET3M5BEuiXzzGIhaR5FyO5i4AtEstaGrxHeTevnZ/
	aQz5n5GseLIqhRztIJKWN+RogsYfO3FVShr6b53jyglYJYw9Yg37A3i2nmNlX19C
	MyTTmTKr0Ek=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05450AAD0;
	Sat,  1 Dec 2012 21:27:17 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 786B7AACF; Sat,  1 Dec 2012
 21:27:16 -0500 (EST)
In-Reply-To: <vpqvccnctvd.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Fri, 30 Nov 2012 10:39:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CA014AF2-3C27-11E2-9C35-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210993>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> That "shell-style" contradicts with what fast-import.c says, though.
>> It claims to grok \octal and described as C-style.
>
> As Peff mentionned, my last version is better, although still a bit
> incomplete. My new version documents things that _must_ be escaped, but
> not what _can_.

Yeah, I agree.
