From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] git-sh-i18n--envsubst: our own envsubst(1) for
 eval_gettext()
Date: Sat, 14 May 2011 20:30:31 -0700
Message-ID: <7v8vu8r67c.fsf@alter.siamese.dyndns.org>
References: <1305380865-21339-1-git-send-email-avarab@gmail.com>
 <1305380865-21339-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 15 05:30:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLS2X-0003Fy-Sw
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 05:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754242Ab1EODal convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 May 2011 23:30:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49318 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753683Ab1EODak convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2011 23:30:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5F6B55AF9;
	Sat, 14 May 2011 23:32:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=HZ0Dx8QN+Y/K
	+OLkT294elzZ0bQ=; b=wAg/O+ykBLcjAltkrdUCWbxpxl0dTIlrOa0WMjCXlEKi
	a4zH9VdgosIjdfPIJpjXJXeI7uAXsxudqUKscbkQEnXhuCLHJdbaoGhlnHz8rJlz
	CupP2/yQlZgSz0V6cHGxd5PTioCdwE7uiFO5E89OFxa7uAMpRzxWXJUd21C2hJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pCdeaT
	q5h09vjQWdabzz0gJk3hSY06TQ52zmLKydh2hDIUeysrcIbVCaIrumBftogpcWBY
	nHMFCczQPkpeX/BMQPiXxJyu1SKgmWQJx7ifCJdjXvZKaTF6T2YcyDTP+eB26dPG
	9A5hqziFF1WYnQio3gHquroZe3R5snacA5a8o=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2D74B5AF5;
	Sat, 14 May 2011 23:32:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2BA245AF1; Sat, 14 May 2011
 23:32:37 -0400 (EDT)
In-Reply-To: <1305380865-21339-2-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 14 May
 2011 13:47:42 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FDA0D848-7EA3-11E0-A811-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173616>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +static int
> +do_getc ()

do_getc (void)

> +/* Copies stdin to stdout, performing substitutions.  */
> +static void
> +subst_from_stdin ()

subst_from_stdin (void)

Will update these again and queue.
Thanks.
