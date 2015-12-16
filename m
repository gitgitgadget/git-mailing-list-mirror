From: Junio C Hamano <gitster@pobox.com>
Subject: Re: (unknown)
Date: Tue, 15 Dec 2015 21:57:50 -0800
Message-ID: <xmqqsi33djfl.fsf@gitster.mtv.corp.google.com>
References: <1450234966-28796-1-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, john@keeping.me.uk,
	sandals@crustytoothpaste.net, peff@peff.net
To: David Greene <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Wed Dec 16 06:57:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9566-0001Qx-AR
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 06:57:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbbLPF5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 00:57:53 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57017 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751398AbbLPF5w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 00:57:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 154B52E100;
	Wed, 16 Dec 2015 00:57:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y+I7crPoAIdcUD5hrVYMwqQHf+U=; b=VOQwcc
	yJ+/W6bkdFUGMxtsKRYqC9RlT/seJhUno9xdb396Vij9D75RY9MjbSNqgQfS2KVM
	0ET+F5aKcNA8HXN3Dz/ndi8b8EctceDJZIRYquxX3AqLQpf9BvlaUcAT7Lpt14a1
	VBqDdPyn+Kt739JkN1wOef/RbOs9Ofz6fv5qs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kKhwzjnJYKlamEYjD4pDBggWm5A3B6AP
	zx58gQGTVbqZ4h7yW3LSVEwZlguy42W6LQxjh+KtAU7ihAuUP+ySySwSix2Aa0GN
	2HVesTPIIUeL6nPi/6t2EwTzf0Et/L1keThGke6IP4/Yc6SdZ+v7a+uXMfJwpeXc
	ZqiSa5fP86E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0C70F2E0FF;
	Wed, 16 Dec 2015 00:57:52 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 805BC2E0F9;
	Wed, 16 Dec 2015 00:57:51 -0500 (EST)
In-Reply-To: <1450234966-28796-1-git-send-email-greened@obbligato.org> (David
	Greene's message of "Tue, 15 Dec 2015 21:02:45 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F12FCE6C-A3B9-11E5-A12E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282535>

David Greene <greened@obbligato.org> writes:

> - If new option --keep-redundant is specified, invoke cherry-pick with
>   --keep-redundant-commits.

This came up in the past several weeks, I think; you would need to
disable patch-equivalence based commit filtering if you really want
to do a --keep-redundant that is reproducible and/or reliable.
