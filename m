From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: add extra safetly in address sanitazion
Date: Sun, 05 Feb 2012 17:48:50 -0800
Message-ID: <7vy5sgbukd.fsf@alter.siamese.dyndns.org>
References: <1328373162-25188-1-git-send-email-felipe.contreras@gmail.com>
 <87sjipxe5u.fsf@thomas.inf.ethz.ch>
 <CAMP44s1wqmT4mavsXrEhB-OquOtQrYnnoSoX9G7X4wzFoMD29A@mail.gmail.com>
 <877h01rlsr.fsf@thomas.inf.ethz.ch>
 <CAMP44s30VmJasMLJxs-JFwksvPEPpG1LB3Gr_pA2+hpE1AnwXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 02:49:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuDht-000618-60
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 02:49:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145Ab2BFBsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 20:48:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60399 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753436Ab2BFBsw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 20:48:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56BF97F0A;
	Sun,  5 Feb 2012 20:48:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NKWEPZNgY3iCLkYiRJ2vKKJfEPA=; b=Zt0f3d
	U7pfBWa+Z3NdAaq9udAuCRd5bHNqmNr1SZkwfTbN7md7oz+r1cKWQ45gSJM1ES6a
	0J2PQt31KfOOOx/GnFqd7YkBANmPN2TDEQg/iXvuPTCkQgrX9UeNarJio93GddHe
	2ia1I2th6z57JxU8/2qQ3muQkRPd2WsiiGzI8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dRK07/ZYf6njn4skbDaAur2Qf8KErsh5
	qmDcoNfmaIVvh4OZDplTtNELyZQX01bg34Fw0sZvvUb6nhCQUEr74Y0tlpCtGfUA
	AQhr+pgIVDg9QZT19+qtgX8qNd3esofflY6d7toVE0n3aJoF085hNUmFIHtr0Yf/
	7dgvPLWFDS4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C8D87F09;
	Sun,  5 Feb 2012 20:48:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C129C7F06; Sun,  5 Feb 2012
 20:48:51 -0500 (EST)
In-Reply-To: <CAMP44s30VmJasMLJxs-JFwksvPEPpG1LB3Gr_pA2+hpE1AnwXg@mail.gmail.com> (Felipe
 Contreras's message of "Mon, 6 Feb 2012 03:27:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B867264A-5064-11E1-B6EB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189997>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Anyway, it seems people don't care if 'git send-email' attempts to
> send random garbage regardless, so I'm not going to pursue this patch.

I actually think people _do_ care, and that is the _only_ reason you are
getting review comments.
