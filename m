From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3 v4] diff --stat: use the full terminal width
Date: Tue, 14 Feb 2012 16:07:35 -0800
Message-ID: <7vr4xx3qns.fsf@alter.siamese.dyndns.org>
References: <7vsjie9q77.fsf@alter.siamese.dyndns.org>
 <1329263146-19215-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	pclouds@gmail.com
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Wed Feb 15 01:07:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxSPQ-0004lP-02
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 01:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757275Ab2BOAHj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 19:07:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51300 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755543Ab2BOAHi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2012 19:07:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E60FE581F;
	Tue, 14 Feb 2012 19:07:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vkCLxK8V2UWX
	yTa2a8Bl2WEsGqI=; b=Ui6Ivf+oO/lunaZH4ucfg7iOTWnuGWWtW5KBiCkwNdqg
	2ZKXt7Uf4O3HSS8YTsMk5d+gow0+9/Ls5E3Pt4ik0uCPjfkBjBuG4G3PFGbwoD2f
	YWD07QxWWXxcFsdlvcKPxw8j0b/FMFGl4SLUtfKID15bM23u0XIi1fJjlurnRkk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=w/wPgk
	6siHSkpDNbvnHvGRU/V/5tY953a7KBVs5aGT8ohWEJzKrxojmKOGv6iXnw+fZipa
	RGgDHbzD6/HZqlI8DqNMLRCz3hedvHz9+insgZxZFrvaf+Y7MyYNa1X8kYVSJMrq
	81b0BMWDdSrTrjU3SCa24GFknpv82MACtnFAM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCEAC581E;
	Tue, 14 Feb 2012 19:07:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5BAAA581C; Tue, 14 Feb 2012
 19:07:37 -0500 (EST)
In-Reply-To: <1329263146-19215-1-git-send-email-zbyszek@in.waw.pl> ("Zbigniew
 =?utf-8?Q?J=C4=99drzejewski-Szmek=22's?= message of "Wed, 15 Feb 2012
 00:45:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1174B918-5769-11E1-AA91-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190804>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> I've added 'v4' to the other two patches in this series like to this
> one, despite them beeing new. I hope that this is proper form.

Yeah, we usually say [PATCH v4 1/3] to mean that this is the fourth
incarnation of the whole series (it is an instruction to reviewers to
discard anything labeled without v$N and $N smaller than 4, and read on=
ly
the ones marked with "v4") and it often happens that the earlier round =
did
not have three patches, so that is perfectly fine.
