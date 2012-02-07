From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/4] Deprecate "not allow as-is commit with i-t-a
 entries"
Date: Tue, 07 Feb 2012 08:41:58 -0800
Message-ID: <7v8vke38a1.fsf@alter.siamese.dyndns.org>
References: <1328618804-31796-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 17:42:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ruo7M-00020h-Hj
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 17:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754407Ab2BGQmD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Feb 2012 11:42:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34969 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753791Ab2BGQmB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2012 11:42:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C69DF7DDF;
	Tue,  7 Feb 2012 11:42:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Ch7qpWICz7u+
	PqgZ+zwCO0EGeXY=; b=cXWkoqHkiGd2RCKe6fmcJqi/AlwqeAAU89sHMRYlB8ze
	BOwSaBz86ozek85BqhSWCXXHy8EnZ82DFv0+wDigVvx9JGKa7tiUo7EOpPHaBAXf
	pBCuEPOptJBhEhUmC8PFzEUYfNov0cD0PXhy0T8YfDBv/tzvfKTjoEFwAWGYXOk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=uAEu6c
	Ws1eB5Heh+HyiFgESmDVjTQUcGOG2fa6acccQrFA+u59N9PuN/wxOwEkyUQnANE0
	EOD9cuDbTH704kwn+OUO11Ldi77km2pcM70WwDwofLB8GYg25Kq4uCpxdPxYsXgr
	q0fUEwjk3j6GtBJPZPWQAtvs/ovPFpHgBS0Jk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC1807DDE;
	Tue,  7 Feb 2012 11:42:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 251BE7DDD; Tue,  7 Feb 2012
 11:42:00 -0500 (EST)
In-Reply-To: <1328618804-31796-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 7 Feb
 2012 19:46:40 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7EFE3C8-51AA-11E1-9519-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190182>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

>  - git-add.txt changes are removed. In the end all kinds of commit
>    behave the same way, not worth putting more explanation during the
>    transition.
>
>  - reword config text and warning text (or more precisely copy/paste
>    from Junio/Jonathan's words)
>
>  - Hard coded release numbers are removed. Now it's simply "in future=
".
>
>  - Step 2 may be too annoying. Users are warned on every commit if
>    commit.ignoreIntentToAdd is set. I think it's good because it keep=
s
>    config file clean, but people may think otherwise.

Ahh, thanks.

But when I said "let's admit that this is just fixing an UI mistake, no
configuration, no options", I really meant it.  Without the backward
compatiblity "For now please do not fix this bug for me and keep being
buggy until I get used to the non-buggy behaviour" fuss, which we never=
 do
to any bugfix.

That is how we are planning to handle "git merge" update to spawn edito=
r
in interactive session in the next release. There is no "Please keep th=
e
buggy behaviour" option; only an environment variable to help when we
mistake a scripted use as interactive, whose support is not going away
because it is not about "until I get used to the new behaviour".
