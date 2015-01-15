From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] init-db: remove unused #includes
Date: Thu, 15 Jan 2015 12:36:00 -0800
Message-ID: <xmqqsifb6atr.fsf@gitster.dls.corp.google.com>
References: <1421258367-8483-1-git-send-email-kuleshovmail@gmail.com>
	<xmqq61c99o25.fsf@gitster.dls.corp.google.com>
	<xmqqwq4p86i6.fsf@gitster.dls.corp.google.com>
	<CANCZXo5UY80327pvjzYkJXroH_WZdW36LhSANK0O7GGVQLF=AA@mail.gmail.com>
	<20150115105558.GA13536@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 21:36:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBr9F-0002xt-4N
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 21:36:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592AbbAOUgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 15:36:04 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52744 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752941AbbAOUgC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 15:36:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 390CA2F9F7;
	Thu, 15 Jan 2015 15:36:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=URqjmCG73akTAsLH/InpYDeRI/w=; b=fm6HOE
	Vv7CZzmatMSBMd44SX6CnT+VQuEG+62JPRU/WMdqJ3d8/xne7JCmCfbVQwWv3uN6
	Xql8VOOrKLvIN3ACI1RHhPKULXduQzLXQ/K9fJ7Htre19rK2JdK7qmvjJfEGk7pL
	84vxJquMT7XEuMYYIxoyB6ENgiR7NsmffJd6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qocXGKB/Q16ySRflXimDj9dkLdq2ktL4
	89kRRjisSclYGz5+iPq28OEwvIXHX0SQtBklniLZ3P1KlbHgwJnWwFNhMkkttelW
	I4S8xVzfF9qfIlSLEwVOTzOzHhWcBVqrqVZ42w8k638PUmL8IYZdSphxSEbhRNET
	wlx2wgeYw+E=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C3902F9F6;
	Thu, 15 Jan 2015 15:36:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8E0A82F9F4;
	Thu, 15 Jan 2015 15:36:01 -0500 (EST)
In-Reply-To: <20150115105558.GA13536@peff.net> (Jeff King's message of "Thu,
	15 Jan 2015 05:55:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1E8662DE-9CF6-11E4-B99B-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262508>

Jeff King <peff@peff.net> writes:

> FWIW, the full set of CFLAGS I use (which I specify in config.mak) is:
>
>     CFLAGS += -Wall -Werror
>     CFLAGS += -Wno-format-zero-length
>     CFLAGS += -Wdeclaration-after-statement
>     CFLAGS += -Wpointer-arith
>     CFLAGS += -Wstrict-prototypes
>     CFLAGS += -Wold-style-declaration
>
> -Peff

I think I have no-pointer-to-int-cast, old-style-definition and vla
in addition to the above.
