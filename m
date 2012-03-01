From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7a 6/9] diff --stat: use a maximum of 5/8 for the
 filename part
Date: Thu, 01 Mar 2012 09:18:35 -0800
Message-ID: <7vfwdsnst0.fsf@alter.siamese.dyndns.org>
References: <7vfwdts6wj.fsf@alter.siamese.dyndns.org>
 <1330604806-30288-1-git-send-email-zbyszek@in.waw.pl>
 <1330604806-30288-6-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com, j.sixt@viscovery.net
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Thu Mar 01 18:19:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S39es-00052a-6Z
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 18:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755256Ab2CARSy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Mar 2012 12:18:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53375 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754648Ab2CARSh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Mar 2012 12:18:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35C0B6FF6;
	Thu,  1 Mar 2012 12:18:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=GFBCi2fpvpln
	l9zUhiCWTI0ThnE=; b=HVQbkTh23r2DhmDd9d/7b6KNcBJuuN8MC7QZuiFiAooh
	70Bl1hDp57/J84l+1GpariudOzO0GvEJdw00ZcOioEpkyVr4QeajJs9crO6ZfOSM
	GEoSLO5+5Xix6SypVuO63zwtL1utMeOMobm3DZQNb1cnyDh5pSs1sTNtBgWczj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Itsa0O
	5fWNuEo87HR+AaUVyPyYXgvS2XhlvQlNg+e9R1++xIxgvHetlfOWFWBPPkSA5h99
	moItpcpwygxS5ebdCtwsJqsW+XFUEm6GAEc6E2/0gL/0aHXQa9ZHkdSSykjV7ryP
	ieFfTuWhhJmE17X9mb1Y5b58jlhmLnwq+Zbl4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C9E06FF5;
	Thu,  1 Mar 2012 12:18:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B74986FF1; Thu,  1 Mar 2012
 12:18:36 -0500 (EST)
In-Reply-To: <1330604806-30288-6-git-send-email-zbyszek@in.waw.pl> ("Zbigniew
 =?utf-8?Q?J=C4=99drzejewski-Szmek=22's?= message of "Thu, 1 Mar 2012 13:26:43
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 94B6917E-63C2-11E1-9380-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191948>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> The effect of this change is visible in the patch to the test vector
> in t4014; with a small change with long filename, it stops truncating
> the name part too short, and also allocates a bit more columns to the
> graph for larger changes.  t4052 shows a similar change.

I replaced 4014 with 4052 in the first sentence, and dropped the last
sentence and re-queued the whole series.

Thanks for cleaning it up.  Very much appreciated.
