From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] doc: git-foo was obsoleted several years ago
Date: Thu, 17 Oct 2013 12:44:16 -0700
Message-ID: <xmqqfvrz1y3z.fsf@gitster.dls.corp.google.com>
References: <1379763429-3443-1-git-send-email-felipe.contreras@gmail.com>
	<xmqq7gdc7v70.fsf@gitster.dls.corp.google.com>
	<525FC659.8020608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 17 21:44:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWtUe-0006Jv-9g
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 21:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758441Ab3JQToU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Oct 2013 15:44:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38516 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756787Ab3JQToU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Oct 2013 15:44:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 645A44A153;
	Thu, 17 Oct 2013 19:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=pz7uSyRmAZNvjbkLbiO7FCqPQ
	VY=; b=rlV52+7tbu94DHSpOTM8sXPBLoWWrg/RhWCOblcpZBXhptXYSz0drjtBW
	dkbQgA4qq5+UTIS04VmT9e+GSbXxSdcpcvwM4KOSa5ey4Lpcm/UAK0dQ2YQplOTO
	60CQkL2wv5kSCwhS60SJ681mqZXUS5jssiKfCHwpGy+cIDKrCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=lqbG8+4aG2C1AiuoMbt
	W2wqIhCE2STxzZi5NX2Zd7nKd09i6reFb9Prnemigb8okhulOhP2CNUbDXwMQHao
	vwcWhDrv6l6Hk1eAA9LXOaMYHUgobdjG7uOM7A+M5UqvkEo1DV37yBOPsi+7Gbuy
	TaNmnCctzuyu5fZeP6tlRl+g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55EFA4A14E;
	Thu, 17 Oct 2013 19:44:19 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95E134A140;
	Thu, 17 Oct 2013 19:44:18 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 830DAEAE-3764-11E3-B480-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236308>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> W dniu 2013-10-16 23:38, Junio C Hamano pisze:
>> I recall that I wanted to see this change happen myself long time
>> ago,...
>> In short, I personally do prefer to see dashless form at the top of
>> the manpage, if it does not break other things, and there may need
>> changes necessary to avoid breaking other things may to files other
>> than these documentation-proper source files.
>> ...
> I wonder if it wouldn't be better to leave as is, in dashed form,
> ...
> But change this, as we use this command as "git checkout", not
> as "git-checkout".

Yes, that is what I meant by "dashless form at the top of the
manpage, if it does not break other things". "man git-cat-file"
is one of "other things".
