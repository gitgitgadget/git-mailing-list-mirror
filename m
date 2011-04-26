From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] wt-status.c: Increase code readability.
Date: Tue, 26 Apr 2011 10:13:20 -0700
Message-ID: <7vei4pey1b.fsf@alter.siamese.dyndns.org>
References: <1303817198-23347-1-git-send-email-henrik@fiktivkod.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Henrik Hautakoski <henrik@fiktivkod.org>
X-From: git-owner@vger.kernel.org Tue Apr 26 19:13:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QElpP-0005Bv-U0
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 19:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757221Ab1DZRNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 13:13:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36451 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753863Ab1DZRNa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 13:13:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4B6C530D9;
	Tue, 26 Apr 2011 13:15:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mShVGKVvUgGrHJMzSZoq6FpHAGs=; b=eP+j+w
	lXAicMqzmNXwq3IT8Tsbkr+bUUpoUQi4bOLinqYEGIN7B1nN02trQ+ybEYNSOEge
	b/QMkmU95Y9fkLymoG6l6IDSLkivF7hW1+9/1+hxFEJbcdz/EItYMKhDkZpBto/m
	RvkfA5mZlUtydN3Vbm8ZsHgSVMBW8JH6/yjBc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J22vRdW/3LSxWG77orcNReB6ssMqL6SU
	LEwmQETHr4wbFiy8viY3A99kYizFuL7Yknc2rhV3YVFQ6bCOsaoqXMUmLWWgTZ2G
	+ue4zjS76Jr99cqImCkGuH7lvLurM3n7yRHtB0D83Uo5rut6fiRsp2jfCEHk4tBI
	GDmEMdxQ6C4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 28C9530D8;
	Tue, 26 Apr 2011 13:15:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4928030D7; Tue, 26 Apr 2011
 13:15:24 -0400 (EDT)
In-Reply-To: <1303817198-23347-1-git-send-email-henrik@fiktivkod.org> (Henrik
 Hautakoski's message of "Tue, 26 Apr 2011 13:26:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C799444E-7028-11E0-8FEA-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172110>

Henrik Hautakoski <henrik@fiktivkod.org> writes:

> Some if/else statements has braces on only some branches. Be consistent and make
> all branches have braces.
>
> Signed-off-by: Henrik Hautakoski <henrik@fiktivkod.org>

While I agree that this patch makes things consistent, and consistency may
be good, but "readable" is more subjective.

Perhaps retitle it to "Subject: wt-status.c: style fixes"?  That would be
more consistent (no pun intended) with the body of the message.

Please hold onto this patch, and make it the first one in the series of
whatever you are planning to do to wt-status.c that you mentioned.
