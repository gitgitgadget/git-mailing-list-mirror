From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/7] i18n for git-am, git-rebase and git-merge
Date: Sun, 22 Jul 2012 12:47:19 -0700
Message-ID: <7vmx2rr320.fsf@alter.siamese.dyndns.org>
References: <cover.1342920089.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 21:47:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St27k-000643-GF
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 21:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548Ab2GVTrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 15:47:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58110 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752429Ab2GVTrX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 15:47:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6EE108ABE;
	Sun, 22 Jul 2012 15:47:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=ELVrtbGDMhRO2alj9T0txi3m0Uk=; b=BkSTt0wV9t9/Po8uyfND
	k3GS3IMZrbydejU4zB69WzWa2hvGV8fs5aMmFVxXrsDwF3oHlq5doeiWqYa7hVUA
	/evnh+eAtsHAfa43KB//gxfGLgiu4OCZa1NlmetL6+GdlXAFpxOnkUgySuxggwlJ
	l/Wwg2Me+FstLqoTZejdDAE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=UPd9oBzM7iyxwpDtuLCmuknGL/acGCeB007QZw044HcTuu
	fbVdNzgCs427pNzn1gxVVy/nAJJdmBQKR3uP+ImkBZsAcDt1MeH6qFEZLZ+pXu+m
	0PbluhmeH7iFuN2uT4+DrmvWmhq5AyVsYAW2eKHULInFFsCapJHziAEv9XSkY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D6218ABD;
	Sun, 22 Jul 2012 15:47:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A1F7A8ABC; Sun, 22 Jul 2012
 15:47:21 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0D71E828-D436-11E1-A86D-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201858>

Jiang Xin <worldhello.net@gmail.com> writes:

> Mark strings in git-am, git-rebase, and git-merge for translation.
> And contain fixes for shell gettext extraction and xgettext workaround.
>
> Jiang Xin (7):
>   i18n: New keywords for xgettext extraction from sh
>   i18n: rebase: mark strings for translation
>   i18n: Rewrite gettext messages start with dash
>   Remove obsolete LONG_USAGE which breaks xgettext
>   i18n: am: mark more strings for translation
>   Remove unused and bad gettext block from git-am
>   i18n: merge-recursive: mark strings for translation

I do not understand why many of these have Stefano's S-o-b in them.
If you are relaying what Stefano originally wrote, then the author
(i.e. "From: ") and the first S-o-b would say Stefano, and your
S-o-b will follow it, but that is probably not the case.

I'll drop the S-o-b lines for now.

By the way, is there any existing test that needs to gain GETTEXT_POISON
or test_i18ncmp with this change?
