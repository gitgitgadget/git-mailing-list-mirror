From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: warn if git authorship won't be retained
Date: Tue, 10 May 2011 16:38:08 -0700
Message-ID: <7vei46gm8v.fsf@alter.siamese.dyndns.org>
References: <1305055653-5133-1-git-send-email-luke@diamand.org>
 <1305055653-5133-2-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed May 11 01:38:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJwVT-0006UQ-D4
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 01:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480Ab1EJXiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 19:38:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37356 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752980Ab1EJXiR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 19:38:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ADCA94E04;
	Tue, 10 May 2011 19:40:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=6fmkBjzKY26w6gzlN0gTg6oq3IY=; b=mZt2F2zDXBv3W/F/e+u5
	/bakFrU6v1PM+taJgVIPhc7NUCHglfuvoy9H7M+O8FWfPJ1SCHjedZBoFNcDir9I
	/bmraTeLNPyRA93BfJ2VHiUpequW5gBgXG84u1jiTuYUnqhm3YwlMsEt/wb+LorL
	H0ddFzXIyOu9GjrJT/Oq2Fk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=csUQpqFvNjJMtlCpTai1Zo304A/zVKS6r8IzOgP95bDPal
	DLW9b3hySoFHaEJTjUAONpssS52lPZe16Zp9mO5eNdNwJr6cPvUZ8eEA7g+39BMk
	GRg115RaLLdftaP0Iux4PR76DLMD+Qh+3ZUlDC9M00PHHIyLK2mUkkBWY7BXQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7B8C94E03;
	Tue, 10 May 2011 19:40:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 679564E02; Tue, 10 May 2011
 19:40:15 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DD77AB48-7B5E-11E0-B12C-B44DF9BAD297-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173384>

Luke Diamand <luke@diamand.org> writes:

> If the git commits you are submitting contain changes made by
> other people, the authorship will not be retained. Change git-p4
> to warn of this and to note that --preserve-user can be used
> to solve the problem (if you have suitable permissions).
> The warning can be disabled.
>
> Add a test case and update documentation.
>
> Requested-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Pete Wyckoff <pw@padd.com>
> Signed-off-by: Luke Diamand <luke@diamand.org>

Heh, I didn't really "request" it; I am not a git-p4 user and am in no
position to judge if such a feature is useful.  If you felt it is a good
thing to do, please take full the credit (no need to resend; I am not
complaining).

Thanks.
