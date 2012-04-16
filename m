From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5570: forward git-daemon messages in a different way
Date: Mon, 16 Apr 2012 10:09:08 -0700
Message-ID: <7vmx6bwqmj.fsf@alter.siamese.dyndns.org>
References: <1334393070-7123-1-git-send-email-zbyszek@in.waw.pl>
 <20120414121358.GA26372@ecki> <20120414122127.GA31220@ecki>
 <4F8C3E0F.2040300@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Mon Apr 16 19:09:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJpQU-0000Dk-HW
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 19:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753682Ab2DPRJN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 13:09:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39154 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751674Ab2DPRJL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 13:09:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEDCA6969;
	Mon, 16 Apr 2012 13:09:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WkaMqE0Hlzcu
	C8Pcoe2RtlCNJXE=; b=h44/RHOeFbYmArizbQbAlUC2BiC+c7tvxJO5vTkwmqgO
	a4D9SNbcv2oxhFMWsTaBHiu2C7itnCVxAY8wCshHo9l5BpTWxaJiS4EooeFrSMLL
	VOQeN9/KYD3zrO0kAUErAjw2KCri1QK1nul2CGWDaTZuZwImj38rjLgBdfGEojo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VI+NFW
	tre/xkwtRLoToQFeCp6c1S3D5CfxZkGUziofi1R2rhTF6Euz4uzThseF8PyIiZAD
	Mx6Fspk9MYX2GT/uGrzvEJZE8KHHBwkEC5GoSuwXeQo6+I++y998Hvq0pdU5gJf2
	CgMTrhU4eI7Lm54OnphsS7T7BqO0BaKOktrS4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B50D86968;
	Mon, 16 Apr 2012 13:09:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B59E6967; Mon, 16 Apr 2012
 13:09:10 -0400 (EDT)
In-Reply-To: <4F8C3E0F.2040300@in.waw.pl> ("Zbigniew =?utf-8?Q?J=C4=99drze?=
 =?utf-8?Q?jewski-Szmek=22's?= message of "Mon, 16 Apr 2012 17:43:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E202D800-87E6-11E1-BCDD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195666>

Zbigniew J=C4=99drzejewski-Szmek  <zbyszek@in.waw.pl> writes:

> So my patch was totally bogus, it was just probably changing the timi=
ng.
>
> Now your patches (on top of next):
> 'git-daemon wrapper to wait until daemon is ready' fixes the problem,=
 thanks!
>
> (I now see that they are both in pu: pu runs fine too.)

Sorry, I think one of the "both" you mean is 7122c9e (git-daemon wrappe=
r
to wait until daemon is ready, 2012-04-15), but which one is "the other
one" (which I should discard)?
