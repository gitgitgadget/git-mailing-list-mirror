From: Junio C Hamano <gitster@pobox.com>
Subject: Re: document git blame --no-follow and git diff --no-follow
Date: Sun, 11 Aug 2013 23:23:46 -0700
Message-ID: <7v8v071l71.fsf@alter.siamese.dyndns.org>
References: <CAHtLG6Q=XRVEhLKxSZUi3JM6w638ZSCpM84peW3RqE9a_=tE=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 08:23:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8lXn-0001C4-7o
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 08:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755884Ab3HLGXv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Aug 2013 02:23:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47252 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755857Ab3HLGXv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Aug 2013 02:23:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C67D634F7C;
	Mon, 12 Aug 2013 06:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=UAyidfqzklcS
	HIZNTQAC/tjV7Hk=; b=ZdjYrdGQPJIWmED9hq3Ybl+rdQMcwMxKE8ixJz3vjy+n
	PyD+2AtKRXTM9zo34XQriL0+JQbD5iOz4PYNzjfmjQ93DUq9WMzXGHb5S1Lz4N7v
	poxYZ/x5Epp6bc6aopwmSQuiLrAGdY2MYXLi/KhYAV7Fa5r3EVOCIAY3rtNaEfw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bD6AOv
	ccQB59CAywuok5lCB3QY5eT8P7AG/G1o6Xds9WjujoaAIVCDIkOao0OhDmI8etWT
	FkkXEc8VvswneZe7OTgDZpDfDKG2iBjbjwU+7AkRal+U5IuUS+M8IM6hckqWjxm6
	l8sMyd08NbhaYTjcgnifalVfwNDXrBMiAckWI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA2B834F7B;
	Mon, 12 Aug 2013 06:23:49 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14F0934F74;
	Mon, 12 Aug 2013 06:23:48 +0000 (UTC)
In-Reply-To: <CAHtLG6Q=XRVEhLKxSZUi3JM6w638ZSCpM84peW3RqE9a_=tE=A@mail.gmail.com>
	(=?utf-8?B?IuS5memFuOmLsCIncw==?= message of "Sun, 11 Aug 2013 12:30:08
 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BFF5F85C-0317-11E3-B0B0-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232157>

=E4=B9=99=E9=85=B8=E9=8B=B0 <ch3cooli@gmail.com> writes:

> Please document git blame --no-follow and git diff --no-follow

I do not think these (and blame/diff --follow) make any sense.

The ideal would be to reject the nonsense optoin at the command
parser level.  The second best is not to document it.  The worst is
to document them as nonsense.
