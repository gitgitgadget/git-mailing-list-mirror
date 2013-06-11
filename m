From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 07/28] git-remote-mediawiki: Rewrite unclear line of instructions
Date: Tue, 11 Jun 2013 11:09:48 -0700
Message-ID: <7vhah4bjtf.fsf@alter.siamese.dyndns.org>
References: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr>
	<1370816573-3808-8-git-send-email-celestin.matte@ensimag.fr>
	<7vsj0od6z5.fsf@alter.siamese.dyndns.org>
	<vpq1u8838rv.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?C=C3=A9lestin?= Matte <celestin.matte@ensimag.fr>,
	git@vger.kernel.org, benoit.person@ensimag.fr
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 11 20:09:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmT11-0007hx-GN
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 20:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755932Ab3FKSJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 14:09:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41622 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755600Ab3FKSJv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 14:09:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7343C26DB5;
	Tue, 11 Jun 2013 18:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rtko7WgNx1z6VOpWChRizugDVu4=; b=cHBhmn
	XqOm0Md8fswKbEKHwDGZu3LH8DWAz7wlH8ZyNOZ+XGvILe2jQJfQcMJYwG71aQYo
	cO6ID06rwC2pD/UM7atkUDmBF7loreBpv2HXDiAFV2RtxcxJvsl4BeJ0wkh7tPBU
	Qvet7AnGjpSV0XmlXYnFCV7HbQoEdzchFRAbw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gn87WHS5CZjx2dqWNgcSJiT+S63lFQSK
	LQi+U37MLgAMaYqrc/DiXjioS6S1DlHZzxupbakiUDR4qJcmLZXs/lAcdZqt9TVo
	eTrYcL8qN62AY/5VXhnkUJDZE5rIlyh5RIf7N8txkgn1CHMVs9QsPj4PN5ggeuPD
	1c8+Tw4fPjA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A58626DB4;
	Tue, 11 Jun 2013 18:09:50 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E7C5D26DAE;
	Tue, 11 Jun 2013 18:09:49 +0000 (UTC)
In-Reply-To: <vpq1u8838rv.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	11 Jun 2013 18:35:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B643356-D2C2-11E2-BAE9-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227481>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>>       my ($namespace) = @_;
>> 	my $namespace = shift;
>>
>> My impression has been that both are equally common,
>
> The second is the most common in git-remote-mediawiki (but I don't have
> any preference nor know what is recommended elsewhere).

I wasn't implying I prefer the former.  I was just being curious,
and if the latter is more prevalent in the code _and_ Perlcritique
does not have any issue with it, it is perfectly fine.

Thanks.
