From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/10] doc: various spelling fixes
Date: Fri, 12 Apr 2013 12:12:35 -0700
Message-ID: <7vy5cnd0m4.fsf@alter.siamese.dyndns.org>
References: <CAPig+cSXC6cA8gc1T=byqeQF_gUYKpHTjpTt54Xog=jtfdgMwA@mail.gmail.com>
 <85f4e2b8e40efb234a7fc0d0ce0d40562690d001.1365719690.git.stefano.lattarini@gmail.com> <7v4nfch90r.fsf@alter.siamese.dyndns.org> <20130412064837.GA5710@elie.Belkin> <20130412064953.GB5710@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sunshine@sunshineco.com, git@vger.kernel.org,
	Jakub =?utf-8?Q?Nar?= =?utf-8?Q?=C4=99bski?= <jnareb@gmail.com>
To: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 21:12:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQjOu-0005Jk-Ia
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 21:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419Ab3DLTMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 15:12:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42364 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751504Ab3DLTMj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 15:12:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85F0116759;
	Fri, 12 Apr 2013 19:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v0OAKXRtJeUV/wuOPYYeU5FktUg=; b=BVgodm
	XTiiq4/aVSXkMkHanL58BX3jDx6a9CujZvxje8pfgKSTy7n1t9H2GhbT7rhkI8qg
	J+sYx1xxjki7QQyNDPKJO0XtVqFdKK2VHxpJwwIxLftgtCH6HDdNcn+gZRu1XT+I
	hF2kcqLSTY4Ju5BHz/ondeSWQe50Y0TPHQbnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vbfyKRD7PJbktUdY1rIKDD3SJUn5pFYt
	RBbeFlAizrqew7EXU7j+xwC+rRttkbqXZFato7WrodFrwMeuNdPFuQCV8TLBXM+7
	D1u4+hCcUNbWJ447+l1/6JbdFiz0v1ESYXVBr8et/ygzntANT0snDqTjpGw25A4e
	d76bq2HXRVQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78EBA16756;
	Fri, 12 Apr 2013 19:12:37 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D1B8716753; Fri, 12 Apr
 2013 19:12:36 +0000 (UTC)
In-Reply-To: <20130412064953.GB5710@elie.Belkin> (Jonathan Nieder's message
 of "Thu, 11 Apr 2013 23:49:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EFDC4274-A3A4-11E2-9476-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221016>

Jonathan Nieder <jrnieder@gmail.com> writes:

>    Note that if per-instance configuration file exists, then system-wide
> -  configuration is _not used at all_.  This is quite untypical and suprising
> +  configuration is _not used at all_.  This is quite untypical and surprising
>    behavior.  On the other hand changing current behavior would break backwards
>    compatibility and can lead to unexpected changes in gitweb behavior.
>    Therefore gitweb also looks for common system-wide configuration file,

Hmm, "atypical", isn't it?

The flow of the text is awkward.  "This is bad. Oh the other hand,
better is broken. Therefore ..." forces readers to make multiple
guesses while reading: "ok, bad, so you plan to change it and warn
us about upcoming change?  oh, not that, changing it is bad, so we
have to live with it?  oh, not that, there is another one that is
common and that is what we can use".

It may be a good idea to rewrite this paragraph to avoid such a
mental roller-coaster in the first place.

    The GITWEB_CONFIG_SYSTEM system-wide configuration file is only
    used for instances that lack per-instance configuration file.
    You can use GITWEB_CONFIG_COMMON file to keep common default
    settings that apply to all instances.

or something.

Not asking for a re-roll, but it may be a potential follow-up candidate.

Thanks.
