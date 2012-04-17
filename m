From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5570: forward git-daemon messages in a different way
Date: Tue, 17 Apr 2012 08:43:30 -0700
Message-ID: <7vy5punz31.fsf@alter.siamese.dyndns.org>
References: <1334393070-7123-1-git-send-email-zbyszek@in.waw.pl>
 <20120414121358.GA26372@ecki> <20120414122127.GA31220@ecki>
 <4F8C3E0F.2040300@in.waw.pl> <7vmx6bwqmj.fsf@alter.siamese.dyndns.org>
 <20120416212215.GA5351@ecki> <4F8C9801.9030607@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Tue Apr 17 17:43:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKAZ8-0004Gc-Cu
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 17:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755324Ab2DQPnf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 11:43:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41838 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755194Ab2DQPnd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2012 11:43:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8B5F546A;
	Tue, 17 Apr 2012 11:43:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=NmWM6OnmYpEq
	0rM6o+9DWmyuJMo=; b=IlFoxsrZm4AZvX1NPknkDc1Ke8gdj30e2caN4IgjKaB+
	NiiZFimZilr/qy/MbAnD9CfgE+vnBO+kpeNnKiaMdkMbXPKyu5MXGiZAqItTxy/4
	qdggqKknGCENJO+lHjtj8IHpxvHuL6O0N/jOY8yGX0lPtX7CFNhklFcn0KVZYcI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=iAK8tn
	09XU/V4eQIWfCwkjNlbYI2GDIUq73T9xLF4CgTTk1jVVOos2Uav0RK3u0Zj3qZkN
	ZjM9LYsOtwodrm4G7/GsCA4w1OCX04/LtZPZvPGrbWulw4IMfXFhN8mai+JmlWfN
	0wuIy+sf6NQB5HpSZmebeC35PaOBpaOy2/R+Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFA915469;
	Tue, 17 Apr 2012 11:43:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5EFFE5468; Tue, 17 Apr 2012
 11:43:32 -0400 (EDT)
In-Reply-To: <4F8C9801.9030607@in.waw.pl> ("Zbigniew =?utf-8?Q?J=C4=99drze?=
 =?utf-8?Q?jewski-Szmek=22's?= message of "Tue, 17 Apr 2012 00:06:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 161042DC-88A4-11E1-BCA3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195766>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

>>> Sorry, I think one of the "both" you mean is 7122c9e (git-daemon wr=
apper
>>> to wait until daemon is ready, 2012-04-15), but which one is "the o=
ther
>>> one" (which I should discard)?
>>
>> I believe he is referring to 1bcb0ab4 (t5570: use explicit push
>> refspec), which is also necessary to run the tests on pu.
> Exactly.

Thanks both for clarifications..
